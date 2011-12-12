<!DOCTYPE html>
<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        
        <link rel="stylesheet" href="${resource(dir:'css',file:'resume.css')}" />
        
        <link rel="stylesheet" href="${resource(dir:'js/jquery/css/overcast',file:'jquery-ui-1.8.13.custom.css')}" />
 
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
      
        <g:javascript library="application" />
        <g:javascript src="jquery/jquery-1.6.1.min.js"/>
        <g:javascript src="jquery/jquery-ui-1.8.13.custom.min.js"/> 
        <script type="text/javascript">
           var contextRoot = "${request.contextPath}"
        </script>
        <g:layoutHead />
        
    </head>
    <body>
        <div id="spinner" class="spinner" style="display:none;">
            <img src="${resource(dir:'images',file:'spinner.gif')}" alt="${message(code:'spinner.alt',default:'Loading...')}" />
        </div>
        <g:layoutBody />
    </body>
</html>