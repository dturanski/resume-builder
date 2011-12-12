package com.dturanski.resume
import grails.plugins.springsecurity.Secured
import grails.converters.*
import grails.web.JSONBuilder

@Secured(['ROLE_USER','ROLE_ADMIN'])
class ResumeController {
	def springSecurityService
	static allowedMethods = [save: ["POST"], update: "POST", delete: "POST" ]

	def index = {
		redirect(action: "list", params: params)
	}

	def list = {
		def profileInstance = Profile.findByUserId(springSecurityService.currentUser.username)
		if (!profileInstance) {
			log.error("cannot find profile for ${springSecurityService.currentUser.username}")
			flash.message= "cannot find profile for ${springSecurityService.currentUser.username}"
		} else {
			
	
			params.max = Math.min(params.max ? params.int('max') : 10, 100)
			def list = Resume.findAllByOwnerProfileId(profileInstance.id,params)	
			log.debug("${list.size()} ${profileInstance.id}")
			[profileInstance:profileInstance, resumeInstanceList: list, resumeInstanceTotal: list? list.size():0]
		}
	}


	def create = {
		
		def profileInstance = Profile.findByUserId(springSecurityService.currentUser.username);
		if (!profileInstance) {
			log.error("cannot find profile for ${springSecurityService.currentUser.username}"  )
		}
		def resumeInstance = new Resume()
		resumeInstance.properties = params
		resumeInstance.ownerProfileId = profileInstance.id
		render(view: "edit", model: [resumeInstance: resumeInstance, profileInstance:profileInstance, mode:'create'])
	}
	/*
	 * 	
	 */
	def save = {
		log.debug("save **********************\n $params \n*************************")
		def ownerProfile = Profile.findByUserId(springSecurityService.currentUser.username);

		assert ownerProfile != null
		
		log.debug("profile id = ${ownerProfile.id}")
		

		def resume = resumeFromParams(new Resume(),params)

		resume.ownerProfile = ownerProfile

		resume.ownerProfileId = ownerProfile.id
		
		if (resume.save(flush: true)) {
			flash.message = "${message(code: 'default.created.message', args: [message(code: 'resume.label', default: 'Resume'), resume.id])}"
			redirect(action: "show", id: resume.id)
		}
		else {
			render(view: "edit", model: [resumeInstance: resume,profileInstance:ownerProfile,mode:'create'])
		}
	}

	def show = {
		def resumeInstance = Resume.get(params.id)
		if (!resumeInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'resume.label', default: 'Resume'), params.id])}"
			redirect(action: "list")
		}
		else {
		
			//[resumeInstance: toJSON(resumeInstance)]
			
			resumeInstance.ownerProfile = Profile.get(resumeInstance.ownerProfileId)
			log.debug("owner:" + resumeInstance.ownerProfile.name)
			response.contentType="text/json"
			//render resumeInstance as JSON
			render resumeInstance.encodeAsJSON()
		}
	}

	def edit = {
		def resumeInstance = Resume.get(params.id)
		log.debug("before: ${resumeInstance.education.school[0]}");
	 
		def profileInstance = Profile.findByUserId(springSecurityService.currentUser.username);
		if (!resumeInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'resume.label', default: 'Resume'), params.id])}"
			redirect(action: "list")
		}
		else {
			log.debug("edit id: ${resumeInstance.id}")
			if (profileInstance.userId.equals(springSecurityService.currentUser.username)) {
				
				return [resumeInstance: resumeInstance, profileInstance:profileInstance, mode:'edit']
			} else {
				redirect(controller:'login',action:'denied')
			}
		}
	}

	def update = {
		log.debug("update **********************\n $params \n*************************")
		log.debug("id=$params.id")
		def resumeInstance = Resume.get(params.id)
		log.debug("profile = ${resumeInstance.ownerProfile}")
		if (resumeInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (resumeInstance.version > version) {

					resumeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [
						message(code: 'resume.label', default: 'Resume')]
					as Object[], "Another user has updated this Resume while you were editing")
					render(view: "edit", model: [resumeInstance: resumeInstance])
					return
				}
			}
			resumeInstance = resumeFromParams(resumeInstance,params)
		

			if (!resumeInstance.hasErrors() && resumeInstance.save(flush: true)) {
				flash.message = "${message(code: 'default.updated.message', args: [message(code: 'resume.label', default: 'Resume'), resumeInstance.id])}"

				redirect(action: "edit", id: resumeInstance.id)
			}
			else {
				log.error("resume $resumeInstance.id NOT updated")
				render(view: "edit", model: [resumeInstance: resumeInstance, profileInstance:resumeInstance.ownerProfile])
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'resume.label', default: 'Resume'), params.id])}"
			redirect(action: "list")
		}
	}

	def delete = {
		def resumeInstance = Resume.get(params.id)
		if (resumeInstance) {
			try {
				resumeInstance.delete(flush: true)
				flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'resume.label', default: 'Resume'), params.id])}"
				redirect(action: "list")
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'resume.label', default: 'Resume'), params.id])}"
				redirect(action: "show", id: params.id)
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'resume.label', default: 'Resume'), params.id])}"
			redirect(action: "list")
		}
	}
    /*
     * Pivot parameters from mapOfLists to listOfMaps
     * [education_degree:[BA Math, MSCS], education_location:[Beloit, WI, Richardson, Tx], education_year:[1977, 1985], education_school:[Beloit College, UT Dallas]]
     *  should end up with
	 * [[degree:'BA Math',location:'Beloit, WI',year:'1977',school:'Beloit College'],[degree:'MSCS',location:'Richardson, Tx',year:'1985',school:'UT Dallas']]		
	 * 
	 * first remove prefix:
	 * [degree:[BA Math, MSCS], location:[Beloit, WI, Richardson, Tx], year:[1977, 1985], school:[Beloit College, UT Dallas]]	
	 * 
	 * If list is one element it will be a String
	 * 
	 * then pivot	
     */
	static mapParamsToObjectProperties(mapOfLists, prefix,clazz) {
		// Remove prefix on all keys
		if (!mapOfLists) {
			return null
		}
		
		
		
		def newMap  = [:]
		
		mapOfLists.each {k,v ->
			def key = k.replace(prefix+'_','')
				newMap[key] = (v instanceof String)?[v]:v
		}

		/* create a list of properties used for object constructor */
		
		def resultSize = (newMap.values() as List)[0].size()
		def result = []
	  		
		(0..resultSize-1).each { i->
			def properties = [:]
			newMap.each {k,list ->
				properties[k] =  (list as List)[i]
			}
			result  << clazz.newInstance(properties)
		}

		result
	}
	
	static sanitizeOptionsMap(map) {
		def sanitizedMap = [:] 
		map.each {k,v->
			def key = k.replace("_","")
			def val =(v?.length() > 0)
			sanitizedMap[key] || (sanitizedMap[key]=val)			
		}
		sanitizedMap
	}

	/*
	 * 
	 */
	static resumeFromParams(resume, params) {
	 
		def contactOptions = new ContactOptions(sanitizeOptionsMap(params.contactOptions))
		def sectionOptions = new SectionOptions(sanitizeOptionsMap(params.sectionOptions))

		params.remove('contactOptions')
		params.remove('sectionOptions')

		resume.properties = params

		resume.contactOptions = contactOptions
		resume.sectionOptions = sectionOptions


		def educationParams = params.findAll {k,v-> k.startsWith('education_')}
		def employmentParams = params.findAll {k,v-> k.startsWith('employment_')}
		println("======================\n$educationParams")
		println("======================\n$employmentParams")
		def edProps = mapParamsToObjectProperties(educationParams,'education',Education)
		def emProps = mapParamsToObjectProperties(employmentParams,'employment',Employment)
		
		println("======================\n$edProps")
		println("======================\n$emProps")
		 
		resume.employment = emProps
		resume.education = edProps
		
		resume

	}
}
