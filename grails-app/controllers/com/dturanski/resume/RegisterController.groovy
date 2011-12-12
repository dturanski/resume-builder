package com.dturanski.resume

class RegisterController {
	def index = {
		[command:new RegisterCommand()]
	}

	def register = { RegisterCommand command ->

		if (command.hasErrors()) {
			render view: 'index', model: [command: command]
			return
		}
        User.withTransaction { status ->
			def userRole =  Role.findByAuthority('ROLE_USER')
			def user = new User(
				username: command.username,
				password: command.password,
				enabled: true)
			user.save(failOnError: true,flush:true)
			UserRole.create(user,userRole,true)
			/*
			 * Create an empty profile for the username
			 */
			log.warn("creating profile for username:" + user.username)
			def profile = new Profile(userId:user.username)
			.save(failOnError: true,flush:true)
        }
		
		redirect(controller:"login")
	  
	}
	
	static final passwordValidator = { String password, command ->
		if (command.username && command.username.equals(password)) {
			return 'registerCommand.password.error.username'
		}

		if (!checkPasswordMinLength(password, command) ||
			!checkPasswordMaxLength(password, command) ||
			!checkPasswordRegex(password, command)) {
			return 'registerCommand.password.error.strength'
		}
	}

	static boolean checkPasswordMinLength(String password, command) {
		int minLength =  6
		password && password.length() >= minLength
	}

	static boolean checkPasswordMaxLength(String password, command) {
		int maxLength = 64
		password && password.length() <= maxLength
	}

	static boolean checkPasswordRegex(String password, command) {
		String passValidationRegex = '.*'

		password && password.matches(passValidationRegex)
	}

	static final passwordConfirmValidator = { value, command ->
		if (command.password != command.passwordConfirm) {
			return 'registerCommand.password2.error.mismatch'
		}
	}
}
class RegisterCommand {
	String username
	String password
	String passwordConfirm
 
	static constraints = {
		username blank: false, validator: { value, command ->
			if (value) {
				if (User.findByUsername(value)) {
					return 'registerCommand.username.unique'
				}
			}
		}
	
		password blank: false, validator: RegisterController.passwordValidator
		passwordConfirm validator: RegisterController.passwordConfirmValidator
	}
}
