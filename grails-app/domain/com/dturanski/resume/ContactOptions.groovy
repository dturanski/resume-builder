package com.dturanski.resume

class ContactOptions {

	static constraints = {
	}

	boolean displayPrimaryEmail 
	boolean displaySecondaryEmail  
	boolean displayAddress  
	boolean displayPrimaryPhone  
	boolean displaySecondaryPhone 
	boolean displayInstantMessage 
	boolean displayWebSite  
	
	def ContactOptions() {
		 displayPrimaryEmail = true;
		 displaySecondaryEmail = false;
		 displayAddress = true;
		 displayPrimaryPhone = true;
		 displaySecondaryPhone = false;
		 displayInstantMessage = false;
		 displayWebSite = false;
	}
}
