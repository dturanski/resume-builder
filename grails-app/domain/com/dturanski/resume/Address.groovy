package com.dturanski.resume
 
class Address {

	String address1
	String address2
	String city
	String state
	String postalCode
	String country
	
	static constraints = {
		address2(nullable:true)
		country(nullable:true)
	}}
