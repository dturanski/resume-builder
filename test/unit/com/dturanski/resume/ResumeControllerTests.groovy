package com.dturanski.resume

import grails.test.*

class ResumeControllerTests extends ControllerUnitTestCase {
	protected void setUp() {
		super.setUp()
	}

	protected void tearDown() {
		super.tearDown()
	}

	void testSanitizeOptionsMap() {

		def params = ['_displaySkills':'',
					_displayObjectives:'',
					displayObjectives:'on',
					displayInterests:'on',
					displaySummary:'on',
					displaySkills:'on',
					_displayPublications:'',
					_displaySummary:'',
					displayPublications:'on',
					_displayInterests:'']

		def sanitized = ResumeController.sanitizeOptionsMap(params)

		sanitized.each { k,v ->
			println "============== $k=$v  ${k.class.name},${v.class.name}"
		}
		assertTrue ("sanitized wrong values",
				sanitized.displayObjectives  &&
				sanitized.displayInterests &&
				sanitized.displayPublications &&
				sanitized.displaySkills &&
				sanitized.displaySummary
				)

		params = ['_displaySkills':'',
					_displayObjectives:'',
					displaySummary:'on',
					displaySkills:'on',
					_displayPublications:'',
					_displaySummary:'',
					displayPublications:'on',
					_displayInterests:'']

		sanitized = ResumeController.sanitizeOptionsMap(params)
		assertTrue ("sanitized wrong values",
				!sanitized.displayObjectives  &&
				!sanitized.displayInterests &&
				sanitized.displayPublications &&
				sanitized.displaySkills &&
				sanitized.displaySummary
				)
	}

	void testMapParamsToObject() {
		def edparams = [
					education_degree:['d', 'dd'],
					education_location:['l', 'll'],
					education_year:['y', 'yy'],
					education_school:['s', 'ss']]

		def list = ResumeController.mapParamsToObjectProperties(edparams,'education',Education)

	 
		list.eachWithIndex {ed, i->
			assert ed.school == 's'*(i+1)
			assert ed.location == 'l'*(i+1)
			assert ed.degree == 'd'*(i+1)
			assert ed.year == 'y'*(i+1)
		}
		
		/*
		 * test with single items 
		 */
		edparams = [
			education_degree:'d',
			education_location:'l',
			education_year:'y',
			education_school:'s']
		list = ResumeController.mapParamsToObjectProperties(edparams,'education',Education)
		 
	}

	void testCreateResume() {
		def params =
				[
					"summary":"Have done it all including:\r\n* achieved world peace\r\n* ended all famine\r\n* saved the global economy",
					"employment_jobTitle":["Chief", "Indian"],
					"education_degree":[
						"BA Mathematics",
						"MSCS - completed first year"
					],
					"employment_from":["June, 2000", "June, 1999"],
					"description":"",
					"name":"dturanski\'s Resume",
					"employment_location":[
						"Walla Walla, WA",
						"Rancho Cucagmanga"
					],
					"employment_jobDescription":[
						"Did everything",
						"Did everything at boss's bidding, but mostly loafed"
					],
					"employment_employer":[
						"Software, Inc",
						"Another Software, Inc"
					],
					"education_location":[
						"Beloit, WI",
						"Richardson, TX"
					],
					"education_year":["1978", "1985"],
					"objectives":"Objectives\r\n*world peace\r\n*end famine\r\n*save US economy",
					"skills":["software", "development"],
					"education_school":[
						"Beloit College",
						"University of Texas at Dallas"
					],
					"_action_add":"Save",
					"employment_to":["June, 2001", "June, 2000"],
					"action":"save", "controller":"resume",
					"_sectionOptions.displayPublications":"",
					"sectionOptions":["_displayPublications":"", "_displaySkills":"", "_displaySummary":"", "_displayObjectives":"", "displayObjectives":"on", "_displayInterests":"", "displaySummary":"on", "displaySkills":"on"],
					"_contactOptions.displayInstantMessage":"",
					"contactOptions":["_displayInstantMessage":"",
						"_displayWebSite":"",
						"displayPrimaryEmail":"on",
						"_displaySecondaryEmail":"",
						"_displayPrimaryEmail":"",
						"_displayPrimaryPhone":"",
						"_displayAddress":"",
						"_displaySecondaryPhone":"",
						"displayAddress":"on",
						"displayPrimaryPhone":"on"],

					"_sectionOptions.displaySkills":"",
					"_sectionOptions.displaySummary":"",
					"_contactOptions.displayWebSite":"",
					"contactOptions.displayPrimaryEmail":"on",
					"_sectionOptions.displayObjectives":"",
					"_contactOptions.displaySecondaryEmail":"",
					"sectionOptions.displayObjectives":"on",
					"_contactOptions.displayPrimaryEmail":"",
					"_contactOptions.displayPrimaryPhone":"",
					"_sectionOptions.displayInterests":"",
					"_contactOptions.displayAddress":"",
					"_contactOptions.displaySecondaryPhone":"" ]


		def ed = params.findAll {k,v-> k.startsWith('_education')}
		def em = params.findAll {k,v-> k.startsWith('_employment')}

		def edProps = ResumeController.mapParamsToObjectProperties(ed,'education',Education)
		def emProps = ResumeController.mapParamsToObjectProperties(em,'employment',Employment)
		println edProps
		println emProps

		params
		//params = params.findAll {k,v -> !k.startsWith("_") }



		def address = new Address(
				id:0,address1:"546 Coldstream Drive",
				city:"Berwyn",state:"PA",country:"US",postalCode:"19312"
				)

		def ownerProfile = new Profile(name:"David Turanski",userId:"dturanski",address:address)

		params << [ownerProfile:ownerProfile]
		println params






	}
}
