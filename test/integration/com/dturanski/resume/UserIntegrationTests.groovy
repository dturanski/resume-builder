package com.dturanski.resume

import grails.test.*

class UserIntegrationTests extends GroovyTestCase {
	protected void setUp() {
		super.setUp()
	}

	protected void tearDown() {
		super.tearDown()
	}

	void testSomething() {
		 def user = User.findByUsername('dturanski')
		 assert user != null
		 def userRole =  Role.findByAuthority('ROLE_USER')
		 assert userRole != null
		 
		 println (user.authorities.size())
		 
		 def x = user.authorities

		 println (user.authorities.contains(userRole))
		 println (x.contains(userRole))
		 user.authorities.each {
			 println ("${it.authority} ${it.equals(userRole)}")
		 }
	}
}
