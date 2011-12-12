<html>
<head>
<meta name='layout' content='main' />
<title><g:message code="springSecurity.login.title" /></title>

</head>

<body>
	<div id='login'>
		<div class='inner'>
			<h1>
				<g:message code="springSecurity.login.header" />
			</h1>

			<g:if test='${flash.message}'>
				<div class='login_message'>
					${flash.message}
				</div>
			</g:if>


			<form action='${postUrl}' method='POST' id='loginForm'
				class='cssform' autocomplete='off'>
				<table>
					<tbody>
						<tr class="prop">
							<td valign="top" class="name"><label for='username'><g:message
										code="springSecurity.login.username.label" /></label></td>
							<td valign="top" class="value"><input type='text'
								class='text_' name='j_username' id='username' /></td>
						</tr>
						<tr class="prop">
							<td valign="top" class="name"><label for='password'><g:message
										code="springSecurity.login.password.label" /></label></td>
							<td valign="top" class="value"><input type='password'
								class='text_' name='j_password' id='password' /></td>
						</tr>
						<tr id="remember_me_holder">
							<td colspan=2><input type='checkbox' class='chk'
								name='${rememberMeParameter}' id='remember_me'
								<g:if test='${hasCookie}'>checked='checked'</g:if> /> <label
								for='remember_me'><g:message
										code="springSecurity.login.remember.me.label" /></label></td>
						</tr>
						<tr>
							<td><input type='submit' id="submit"
								value='${message(code: "springSecurity.login.button")}' /></td>
						</tr>
					</tbody>
				</table>



				<g:link controller="register">Need to register?</g:link>
				 
			</form>

		</div>
	</div>
	<script type='text/javascript'>	(function() {
		document.forms['loginForm'].elements['j_username'].focus();
	})();
	</script>

</body>
</html>
