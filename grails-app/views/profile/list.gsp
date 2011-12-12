
<%@ page import="com.dturanski.resume.Profile" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'profile.label', default: 'profile')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'profile.id.label', default: 'Id')}" />
                        
                            <th><g:message code="profile.address.label" default="Address" /></th>
                        
                            <g:sortableColumn property="instantMessage" title="${message(code: 'profile.instantMessage.label', default: 'Instant Message')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'profile.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="primaryEmail" title="${message(code: 'profile.primaryEmail.label', default: 'Primary Email')}" />
                        
                            <th><g:message code="profile.primaryPhone.label" default="Primary Phone" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${profileInstanceList}" status="i" var="profileInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${profileInstance.id}">${fieldValue(bean: profileInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: profileInstance, field: "address")}</td>
                        
                            <td>${fieldValue(bean: profileInstance, field: "instantMessage")}</td>
                        
                            <td>${fieldValue(bean: profileInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: profileInstance, field: "primaryEmail")}</td>
                        
                            <td>${fieldValue(bean: profileInstance, field: "primaryPhone")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${profileInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
