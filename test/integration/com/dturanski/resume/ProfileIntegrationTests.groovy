package com.dturanski.resume

import grails.test.*

class ProfileIntegrationTests extends GroovyTestCase {
	protected void setUp() {
		super.setUp()
	}

	protected void tearDown() {
		super.tearDown()
	}

	void testSomething() {
		if (!Profile.findByUserId('dturanski')){
			def address = new Address(
				address1:"546 Coldstream Drive",
				city:"Berwyn",state:"PA",country:"US",postalCode:"19312"
				)
			def person = new Profile(name:"David Turanski",userId:"dturanski",address:address)

			person.metaClass.methods.each {println it.name }

			person.validate()

			println person.errors
        
			person.save(failOnError:true,flush:true)
		}
		assertNotNull(Profile.get(1))
	}
}
