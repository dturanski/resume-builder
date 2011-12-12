

<%@ page import="com.dturanski.resume.Profile"%>
<%@ page import="com.dturanski.resume.Phone"%>
<%@ page import="com.dturanski.resume.Address"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<g:set var="entityName"
	value="${message(code: 'profile.label', default: 'profile')}" />
<title><g:message code="default.edit.label" args="[entityName]" /></title>
</head>
<body>
	<div class="nav">
		<span class="menuButton"><a class="home"
			href="${createLink(uri: '/')}"><g:message
					code="default.home.label" /></a></span>
		<sec:ifAnyGranted roles="ROLE_ADMIN">
			<span class="menuButton"><g:link class="list" action="list">
					<g:message code="default.list.label" args="[entityName]" />
				</g:link></span>
			<span class="menuButton"><g:link class="create"
					action="create">
					<g:message code="default.new.label" args="[entityName]" />
				</g:link></span>
		</sec:ifAnyGranted>
	</div>
	<div class="body">
		<h1>
			<g:message code="default.edit.label" args="[entityName]" />
		</h1>
		<g:if test="${flash.message}">
			<div class="message">
				${flash.message}
			</div>
		</g:if>
		<g:hasErrors bean="${profileInstance}">
			<div class="errors">
				<g:renderErrors bean="${profileInstance}" as="list" />
			</div>
		</g:hasErrors>
		<table>
		<tbody>
		<tr>
		<td>
		<g:form method="post">
			<g:hiddenField name="id" value="${profileInstance?.id}" />
			<g:hiddenField name="version" value="${profileInstance?.version}" />
			<div class="dialog">
				<table>
					<tbody>
						<tr class="prop">
							<td valign="top" class="name"><label for="userId"><g:message
										code="profile.userId.label" default="User Id" /></label></td>
							<td valign="top">
								${profileInstance?.userId}
							</td>
						</tr>
						
						<tr class="prop">
							<td valign="top" class="name"><label for="name"><g:message
										code="profile.name.label" default="Name" /></label></td>
							<td valign="top"
								class="value ${hasErrors(bean: profileInstance, field: 'name', 'errors')}">
								<g:textField name="name" value="${profileInstance?.name}" size="60" />
							</td>
						</tr>
						
					    <tr class="prop">
							<td valign="top" class="name"><label for="primaryEmail"><g:message
										code="profile.primaryEmail.label" default="Primary Email" /></label>
							</td>
							<td valign="top"
								class="value ${hasErrors(bean: profileInstance, field: 'primaryEmail', 'errors')}">
								<g:textField name="primaryEmail"
									value="${profileInstance?.primaryEmail}" />
							</td>
						</tr>
						
						<tr class="prop">
							<td valign="top" class="name"><label for="secondaryEmail"><g:message
										code="profile.secondaryEmail.label" default="Secondary Email" /></label>
							</td>
							<td valign="top"
								class="value ${hasErrors(bean: profileInstance, field: 'secondaryEmail', 'errors')}">
								<g:textField name="secondaryEmail"
									value="${profileInstance?.secondaryEmail}" />
							</td>
						</tr>
						
						<tr class="prop">
							<td valign="top" class="name"><label for="primaryPhone"><g:message
										code="profile.primaryPhone.label" default="Primary Phone" /></label>
							</td>
							<td valign="top"
								class="value ${hasErrors(bean: profileInstance, field: 'primaryPhone', 'errors')}">
								<g:textField name="primaryPhone.number"
									value="${profileInstance?.primaryPhone?.number}" size="16"/>
							
								<g:select name="primaryPhone.type" value="${profileInstance.primaryPhone?.type}" 
								  from="['Home','Mobile','Work','Other']"
								  />
								 
							</td>
						</tr>
						
					
						<tr class="prop">
							<td valign="top" class="name"><label for="secondaryPhone"><g:message
										code="profile.secondaryPhone.label" default="Secondary Phone" /></label>
							</td>
							<td valign="top"
								class="value ${hasErrors(bean: profileInstance, field: 'secondaryPhone', 'errors')}">
								<g:textField name="secondaryPhone.number"
									value="${profileInstance?.secondaryPhone?.number}" size="16"/>
							
								<g:select name="secondaryPhone.type" value="${profileInstance.secondaryPhone?.type}" 
								  from="['Home','Mobile','Work','Other']"
								  />
							</td>
						</tr>
						<tr>
						<td colspan="2">
						<table>
						
						<tr class="prop">
							<td valign="top" class="name"><label for="address"><g:message
										code="profile.address.label" default="Address" /></label></td>
					    </tr>
					  
					    <tr class="prop">
					       <td valign="top" class="name"><label for="address"><g:message
										code="profile.address.address1.label" default="Line 1" /></label></td>
							<td valign="top"
								class="value ${hasErrors(bean: profileInstance, field: 'address.address1', 'errors')}">
								<g:textField name="address.address1"
									value="${profileInstance?.address?.address1}" size="60"/>				
							</td>
						</tr>
						 <tr class="prop">
					       <td valign="top" class="name"><label for="address"><g:message
										code="profile.address.address2.label" default="Line 2" /></label></td>
							<td valign="top"
								class="value ${hasErrors(bean: profileInstance, field: 'address.address2', 'errors')}">
								<g:textField name="address.address2"
									value="${profileInstance?.address?.address2}" size="60"/>				
							</td>
						</tr>
						 <tr class="prop">
					       <td valign="top" class="name"><label for="address"><g:message
										code="profile.address.city.label" default="City" /></label></td>
							<td valign="top"
								class="value ${hasErrors(bean: profileInstance, field: 'address.city', 'errors')}">
								<g:textField name="address.city"
									value="${profileInstance?.address?.city}" size="60"/>				
							</td>
						</tr>
						
						<tr class="prop">
					       <td valign="top" class="name"><label for="address"><g:message
										code="profile.address.state.label" default="State/Province" /></label></td>
							<td valign="top"
								class="value ${hasErrors(bean: profileInstance, field: 'address.state', 'errors')}">
								<g:textField name="address.state"
									value="${profileInstance?.address?.state}" size="2"/>				
							</td>
						</tr>
						
						<tr class="prop">
					       <td valign="top" class="name"><label for="address"><g:message
										code="profile.address.country.label" default="Country" /></label></td>
							<td valign="top"
								class="value ${hasErrors(bean: profileInstance, field: 'address.country', 'errors')}">
								<g:textField name="address.country"
									value="${profileInstance?.address?.country}" size="10"/>				
							</td>
						</tr>
						
						<tr class="prop">
					       <td valign="top" class="name"><label for="address"><g:message
										code="profile.address.postalCode.label" default="Postal Code" /></label></td>
							<td valign="top"
								class="value ${hasErrors(bean: profileInstance, field: 'address.postalCode', 'errors')}">
								<g:textField name="address.postalCode"
									value="${profileInstance?.address?.postalCode}" size="10"/>				
							</td>
						</tr>
						</table>
						</td>
						</tr>
						
					 	<tr class="prop">
							<td valign="top" class="name"><label for="instantMessage"><g:message
										code="profile.instantMessage.label" default="Instant Message" /></label>
							</td>
							<td valign="top"
								class="value ${hasErrors(bean: profileInstance, field: 'instantMessage', 'errors')}">
								<g:textField name="instantMessage"
									value="${profileInstance?.instantMessage}" />
							</td>
						</tr>



						<tr class="prop">
							<td valign="top" class="name"><label for="webSite"><g:message
										code="profile.webSite.label" default="Web Site" /></label></td>
							<td valign="top"
								class="value ${hasErrors(bean: profileInstance, field: 'webSite', 'errors')}">
								<g:textField name="webSite" value="${profileInstance?.webSite}" />
							</td>
						</tr>
				
					</tbody>
				</table>
			</div>
			<div class="buttons">
				<span class="button"><g:actionSubmit class="save"
						action="update"
						value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
				<sec:ifAnyGranted roles="ROLE_ADMIN">
					<span class="button"><g:actionSubmit class="delete"
							action="delete"
							value="${message(code: 'default.button.delete.label', default: 'Delete')}"
							onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
				</sec:ifAnyGranted>
			</div>
		</g:form>
			</td>
			<td>Your profile serves as a single source of contact information included in any resume you create. 
			<br/>
			It will not be used for any other purpose.
			</td>
		  </tr>
		 </tbody>
		</table>
	</div>
</body>
</html>
