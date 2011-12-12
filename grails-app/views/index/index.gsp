<%@ page import="com.dturanski.resume.Profile" %>
<%@ page import="com.dturanski.resume.User" %>
<html>
    <head>
        <title>Welcome to Resume Builder</title>
        <meta name="layout" content="main" />
        <style type="text/css" media="screen">

        #nav {
            margin-top:20px;
            margin-left:30px;
            width:228px;
            float:left;

        }
        .homePagePanel * {
            margin:0px;
        }
        .homePagePanel .panelBody ul {
            list-style-type:none;
            margin-bottom:10px;
        }
        .homePagePanel .panelBody h1 {
            text-transform:uppercase;
            font-size:1.1em;
            margin-bottom:10px;
        }
        .homePagePanel .panelBody {
            background: url(images/leftnav_midstretch.png) repeat-y top;
            margin:0px;
            padding:15px;
        }
        .homePagePanel .panelBtm {
            background: url(images/leftnav_btm.png) no-repeat top;
            height:20px;
            margin:0px;
        }

        .homePagePanel .panelTop {
            background: url(images/leftnav_top.png) no-repeat top;
            height:11px;
            margin:0px;
        }
        h2 {
            margin-top:15px;
            margin-bottom:15px;
            font-size:1.2em;
        }
        #pageBody {
            margin-left:280px;
            margin-right:20px;
        }
        </style>
    </head>
    <body>
    	<div id="user-nav"> 
    	<span>
    	
    	<sec:ifLoggedIn>
    		<sec:ifAllGranted roles="ROLE_USER">	
    		   <a href="${createLink(controller:'profile',action:'edit',id:profileInstance?.id)}">
    		   <sec:username/>
    		  </a>
    		</sec:ifAllGranted>
    		<g:link controller="logout">Log out</g:link>
    	</sec:ifLoggedIn>
    	
    
         <sec:ifAllGranted roles="ROLE_ADMIN">
              <g:link controller="user">User Admin</g:link>
          </sec:ifAllGranted>
        </span>
        </div>
        <div id="nav">
            <div class="homePagePanel">
                <div class="panelTop">
                
                </div>
                <div class="panelBody">
                    <ul>
                     <sec:ifNotLoggedIn>
    					<li><g:link controller="login">Login</g:link></li>
      					<li><g:link controller="register">Sign Up</g:link></li>
    				</sec:ifNotLoggedIn>
                     <sec:ifAllGranted roles="ROLE_USER">
                        <li><a href="${createLink(uri: '/resume/list')}">List Resumes</a></li>
                        <li><a href="${createLink(uri: '/resume/create')}">Create a Resume</a></li>
                     </sec:ifAllGranted>   
                        <li><a href="${createLink(uri: '/resume/demo')}">Demo</a></li>
                    </ul>
                </div>
                <div class="panelBtm"></div>
            </div>
        </div>
        <div id="pageBody">
            <h1>Welcome to Resume Builder</h1>
            <g:if test="${flash.message}">
			<div class="error">
				${flash.message}
			</div>
		</g:if>
            <p>Use this tool to create and manage your resume online.</p>

             
        </div>
    </body>
</html>
