package com.dturanski.resume

class IndexController {
	def springSecurityService
    def index = { 
		log.debug("in index controller")
		if (springSecurityService.isLoggedIn()){
		/*	
			Profile.list().each {p ->
				log.debug p.userId
			}
	
			
			def profileInstance = Profile.findByUserId(springSecurityService.currentUser.username);
			if (!profileInstance) {
				log.error("cannot find profile for ${springSecurityService.currentUser.username}")
				flash.message= "cannot find profile for ${springSecurityService.currentUser.username}"
			} else {
		    	[profileInstance:profileInstance]
			}
		 */
		  redirect(controller:'resume')	
		}
	}
}
