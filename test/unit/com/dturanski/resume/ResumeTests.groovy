package com.dturanski.resume

 
 
import com.sun.org.apache.xml.internal.resolver.helpers.BootstrapResolver;

import grails.test.*

class ResumeTests extends GrailsUnitTestCase {
	protected void setUp() {
		super.setUp()
	}

	protected void tearDown() {
		super.tearDown()
	}
	
	void testConstructor() {
	def address = new Address(
			id:0,address1:"546 Coldstream Drive",
			city:"Berwyn",state:"PA",country:"US",postalCode:"19312"
			)
		
		def owner = new Profile(name:"David Turanski",userId:"dturanski",address:address)
		def params = [ name:'resume', 
				  
				   owner:owner]
		
	    println params	
				
		
		def resume = new Resume(params)
		
		resume.employment <<  new Employment([jobTitle:"Chief"])
		resume.employment << new Employment([jobTitle:"Indian"])
		
		assertNotNull(resume.employment)
		
		assert (resume.employment[0] instanceof Employment)
		
		assertEquals('Chief', resume.employment[0].jobTitle)
			
	}
	
	

	void testSomething() {
		def testInstances = []
	//	mockDomain(Resume,testInstances)
	//	Resume.count();
	} 
	
}
