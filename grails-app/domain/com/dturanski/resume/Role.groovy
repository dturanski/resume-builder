package com.dturanski.resume

class Role {

	String authority
	
	static mapWith = 'mongo'
	static mapping = {
		cache true
	}

	static constraints = {
		authority blank: false, unique: true
	}
}
