package com.dturanski.resume
import org.codehaus.groovy.grails.commons.metaclass.ConstructorInterceptor
import org.codehaus.groovy.grails.commons.metaclass.InvocationCallback
class Resume {

	static mapWith = "mongo"
	
	static belongsTo = [ownerProfile:Profile]
	
	static fetchMode = [ownerProfile:'eager']
	
	long ownerProfileId //work-around
	 
	String name
	String description
	String objectives
	String summary
	List<String> skills = []
	List<String> interests = []
	List<String> publications = []
	List<Employment> employment = []
	List<Education> education = []
	ContactOptions contactOptions = new ContactOptions()
	SectionOptions sectionOptions = new SectionOptions()

	static constraints = {
		name(blank:false)
	}

	static embedded = [
		'employment',
		'education',
		'contactOptions',
		'sectionOptions'
	]	
	
	 
}

 

 
	


