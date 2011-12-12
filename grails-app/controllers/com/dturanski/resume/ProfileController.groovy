package com.dturanski.resume
import grails.plugins.springsecurity.Secured
 
class ProfileController {
	
    def springSecurityService
    
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	@Secured(['ROLE_USER'])
    def index = {
	    if (springSecurityService.currentUser.authorities.contains('ROLE_ADMIN'))	{
			redirect(action: "list", params: params)
	    } else {
		  	def profileInstance = Profile.findByUserId(springSecurityService.currentUser.username);
			redirect(action: "edit", params: [id:profileInstance.id])
		}
    }
	
	@Secured(['ROLE_ADMIN'])
    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [profileInstanceList: Profile.list(params), profileInstanceTotal: Profile.count()]
    }
	 
	@Secured(['ROLE_USER'])
    def save = {
        def profileInstance = new Profile(params)
        if (profileInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'profile.label', default: 'profile'), profileInstance.id])}"
            redirect(action: "edit", id: profileInstance.id)
        }
        else {
            render(view: "create", model: [profileInstance: profileInstance])
        }
    }
 
	@Secured(["hasRole('ROLE_USER')"])
    def edit = {
        def profileInstance = Profile.get(params.id)
		if (springSecurityService.currentUser.username.equals(profileInstance.userId)){
        if (!profileInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'profile.label', default: 'profile'), params.id])}"
            redirect(action: "edit")
        }
        else {
            return [profileInstance: profileInstance]
        }
		} else { 
		 	redirect(controller:'login',action:'denied')
		}
    }
	@Secured(['ROLE_USER'])
    def update = {
		log.debug(params)
        def profileInstance = Profile.get(params.id)
        if (profileInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (profileInstance.version > version) {
                    
                    profileInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'profile.label', default: 'profile')] as Object[], "Another user has updated this profile while you were editing")
                    render(view: "edit", model: [profileInstance: profileInstance])
                    return
                }
            }
			
            profileInstance.properties = params
			
			log.debug("profile ${profileInstance.id} - primary phone ${profileInstance.primaryPhone.number}  ${profileInstance.primaryPhone.type}" )
			
            if (!profileInstance.hasErrors() && profileInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'profile.label', default: 'profile'), profileInstance.id])}"
                redirect(action: "edit", id: profileInstance.id)
            }
            else {
                render(view: "edit", model: [profileInstance: profileInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'profile.label', default: 'profile'), params.id])}"
            redirect(action: "list")
        }
    }
	
	@Secured(['ROLE_ADMIN'])
    def delete = {
        def profileInstance = Profile.get(params.id)
        if (profileInstance) {
            try {
                profileInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'profile.label', default: 'profile'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'profile.label', default: 'profile'), params.id])}"
                redirect(action: "edit", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'profile.label', default: 'profile'), params.id])}"
            redirect(action: "list")
        }
    }
}
