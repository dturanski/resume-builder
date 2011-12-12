
<%@ page import="com.dturanski.resume.Resume"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<g:set var="entityName"
	value="${message(code: 'resume.label', default: 'Resume')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
	<div class="nav">
<%--		<span class="menuButton"><a class="home"--%>
<%--			href="${createLink(uri: '/')}"><g:message--%>
<%--					code="default.home.label" /></a>--%>
<%--		</span> --%>
		<span class="menuButton"><g:link
				class="create" action="create">
				<g:message code="default.new.label" args="[entityName]" />
			</g:link>
		</span>
		<div id="user-nav">
			<span> <sec:ifLoggedIn>
					<sec:ifAllGranted roles="ROLE_USER">
						<a
							href="${createLink(controller:'profile',action:'edit',id:profileInstance?.id)}">
							<sec:username />
						</a>
					</sec:ifAllGranted>
					<g:link controller="logout">Log out</g:link>
				</sec:ifLoggedIn>
			</span>
		</div>
	</div>
	<div class="body">
		<h1>
			<g:message code="default.list.label" args="[entityName]" />
		</h1>
		<g:if test="${flash.message}">
			<div class="message">
				${flash.message}
			</div>
		</g:if>
		<div class="list">
			<table>
				<thead>
					<tr>

						<g:sortableColumn property="id"
							title="${message(code: 'resume.id.label', default: 'Id')}" />

						<g:sortableColumn property="description"
							title="${message(code: 'resume.description.label', default: 'Description')}" />

						<g:sortableColumn property="name"
							title="${message(code: 'resume.name.label', default: 'Name')}" />

						<g:sortableColumn property="objectives"
							title="${message(code: 'resume.objectives.label', default: 'Objectives')}" />

					 

					</tr>
				</thead>
				<tbody>
					<g:each in="${resumeInstanceList}" status="i" var="resumeInstance">
						<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

							<td><g:link action="show" id="${resumeInstance.id}">
									${fieldValue(bean: resumeInstance, field: "id")}
								</g:link></td>

							<td>
								${fieldValue(bean: resumeInstance, field: "description")}
							</td>

							<td>
								${fieldValue(bean: resumeInstance, field: "name")}
							</td>

							<td>
								${fieldValue(bean: resumeInstance, field: "objectives")}
							</td>

							 

						</tr>
					</g:each>
				</tbody>
			</table>
		</div>
		<div class="paginateButtons">
			<g:paginate total="${resumeInstanceTotal}" />
		</div>
	</div>
</body>
</html>
