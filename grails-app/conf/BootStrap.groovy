import com.dturanski.resume.*
import grails.converters.JSON

class BootStrap {
	def springSecurityService

	def init = { servletContext ->
		//Create roles if necessary
		def userRole =  Role.findByAuthority('ROLE_USER') ?: new Role(authority: 'ROLE_USER').save(failOnError: true,flush:true)
		def adminRole = Role.findByAuthority('ROLE_ADMIN') ?: new Role(authority: 'ROLE_ADMIN').save(failOnError: true,flush:true)


		def normalUser = User.findByUsername('dturanski') ?: new User(
				username: 'dturanski',
				password: 'catal1na',
				enabled: true
				)
				.save(failOnError: true,flush:true)

//	if (!normalUser.authorities.contains(userRole)) {
//			println ("creating user role for ${normalUser.username} ${normalUser.authorities}")
//			UserRole.create(normalUser,userRole,true)
//		}

		def adminUser = User.findByUsername('admin') ?: new User(
				username: 'admin',
				password:'admin',
				enabled: true
				)
				.save(failOnError: true,flush:true)
//
//		if (!adminUser.authorities.contains(adminRole)) {
//			UserRole.create(adminUser,adminRole,true)
//		}


		//assert User.count() == 2
		assert Role.count() == 2
		//assert UserRole.count() == 2

		JSON.registerObjectMarshaller(new MyDomainClassMarshaller())

	}
	def destroy = {
	}


}
