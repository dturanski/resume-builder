package com.dturanski.resume

class SectionOptions {

    static constraints = {
    }
	
	boolean displayObjectives 
	boolean displaySummary  
	boolean displaySkills  
	boolean displayInterests  
	boolean displayPublications  
	
	def SectionOptions() {
		displayObjectives = true
		displaySummary = true
		displaySkills = true
		displayInterests = false
		displayPublications = false
    }
}
