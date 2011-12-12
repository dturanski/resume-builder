<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<title>Register</title>
</head>
<body>
	<div class="nav">
		<span class="menuButton"><a class="home"
			href="${createLink(uri: '/')}"><g:message
					code="default.home.label" /></a></span>
	</div>
	<div class="body">
		<h1>Register New User</h1>
		<g:if test="${flash.message}">
			<div class="message">
				${flash.message}
			</div>
		</g:if>
		<g:hasErrors bean="${command}">
			<div class="errors">
				<g:renderErrors bean="${command}" as="list" />
			</div>
		</g:hasErrors>

		<g:form action='register' name='registerForm'>

			<div class="dialog">
				<table>
					<tbody>
						<tr class="prop">
							<td valign="top" class="name"><label for="username"><g:message
										code="register.username.label" default="Username" /></label></td>
							<td valign="top"
								class="value ${hasErrors(bean: command, field: 'username', 'errors')}">
								<g:textField name="username"
									value="${command?.username}" size='40'" />
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name"><label for="password"><g:message
										code="register.password.label" default="Password" /></label></td>
							<td valign="top"
								class="value ${hasErrors(bean: command, field: 'password', 'errors')}">
								<g:passwordField name="password"
									value="${command?.password}" size='40'" />
							</td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name"><label for="password"><g:message
										code="register.passwordConfirm.label"
										default="Confirm Password" /></label></td>
							<td valign="top"
								class="value ${hasErrors(bean: command, field: 'passwordConfirm', 'errors')}">
								<g:passwordField name="passwordConfirm"
									value="${command?.passwordConfirm}" size='40'" />
							</td>
						</tr>
						
					</tbody>
				</table>
			</div>
		
		<div class="buttons">
			<span class="button"><g:actionSubmit action="register"
					value="${message(code: 'default.button.register.label', default: 'Register')}" /></span>
		</div>
		</g:form>
	</div>
	<script>
			$(document).ready(function() {
				$('#username').focus();
			});
		</script>
</body>
</html>
