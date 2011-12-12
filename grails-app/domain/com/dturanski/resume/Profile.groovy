package com.dturanski.resume

class Profile {
	static mapWith = "mongo"
	String name
	String userId
	Phone primaryPhone
	Phone secondaryPhone
	String primaryEmail
	String secondaryEmail
	String instantMessage
	String webSite
	
	Address address
	
	static embedded = ['address','primaryPhone','secondaryPhone']
	
    static constraints = {
		name(nullable:true)
		primaryPhone(nullable:true)
		secondaryPhone(nullable:true)
		primaryEmail(nullable:true)
		secondaryEmail(nullable:true)
		instantMessage(nullable:true)
		webSite(nullable:true)
		address(nullable:true)
		
    }
	

}


