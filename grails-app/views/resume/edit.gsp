<%@ page import="com.dturanski.resume.Resume"%>
<%@ page import="com.dturanski.resume.Profile"%>
<html>
<head>
<meta name="layout" content="main" />
<title>Edit Resume</title>
<script type="text/javascript">
    $(document).ready(function() {
    	  document.editResume.reset();
       	  $("#sections > ul > li").each( function() {
              initializeSection($(this)[0]);
          });
      
          $("#sections").tabs();
       	  $("#sections").tabs("select",0);

          $("#dialog").dialog({ autoOpen: false, title:'Preview'/*, width:'800'*/ } );
		  var html;
          $('#preview').click(function() {
              var resume = getPageAsJSON(); 
              var url = contextRoot+"/resume/show/${resumeInstance.id}";
          
        	  $.getJSON(url,function(data){
              	 $("#dialog").html(resumeAsHtml(data));
        	     $("#dialog").dialog('open');
        	});
      		return false;
          });
      	 })       
    </script>
</head>
<body>
	<g:if test="${mode.equals('create')}">
		<h1>New Resume</h1>
	</g:if>
	<g:else>
		<h1>Edit Resume</h1>
	</g:else>
	<div class="nav">
		<span class="menuButton"><a class="home"
			href="${createLink(uri: '/')}"><g:message
					code="default.home.label" /></a></span> <span class="menuButton"><a
			href="" id="preview">Preview</a></span> <span class="menuButton"><g:link
				class="logout" controller="logout">Logout</g:link></span>

	</div>

	<div class="body">
		<g:if test="${flash.message}">
			<div class="message">
				${flash.message}
			</div>
		</g:if>
		<g:hasErrors bean="${resumeInstance}">
			<div class="errors">
				<g:renderErrors bean="${resumeInstance}" as="list" />
			</div>
		</g:hasErrors>
		<g:form name="editResume" action="save">
			<g:hiddenField name="id" value="${resumeInstance?.id}" />
			<g:hiddenField name="version" value="${resumeInstance?.version}" />
			<div id="properties">
				<table>
					<tr class="prop">
						<td class="name">Resume Name</td>
						<td class="value"><g:textField name="name" size="60"
								value="${resumeInstance.name?resumeInstance.name : profileInstance.userId + '\'s Resume'}" /></td>
					</tr>
					<tr class="prop">
						<td class="name">Description</td>
						<td class="value"><g:textArea name="description" cols="80"
								rows="2" width="80" value="${resumeInstance.description}" /></td>
					</tr>
					<tr class="prop">
						<td valign="top" colspan="2">
							<table>
								<tr>
									<td colspan=10>Select optional sections to include:</td>
								</tr>
								<tr>
									<td valign="top">Objectives</td>
									<td valign="top" style="border-right: 1px solid #CCCCCC;">
										<g:checkBox name="sectionOptions.displayObjectives"
											value="${resumeInstance.sectionOptions.displayObjectives}"
											onclick="return sectionCheckboxClicked(this);" />
									</td>

									<td valign="top">Summary</td>
									<td valign="top" style="border-right: 1px solid #CCCCCC;">
										<g:checkBox name="sectionOptions.displaySummary"
											value="${resumeInstance.sectionOptions.displaySummary}"
											onclick="return sectionCheckboxClicked(this);" />
									</td>

									<td valign="top">Skills</td>
									<td valign="top" style="border-right: 1px solid #CCCCCC;">
										<g:checkBox name="sectionOptions.displaySkills"
											value="${resumeInstance.sectionOptions.displaySkills}"
											onclick="return sectionCheckboxClicked(this);" />
									</td>

									<td valign="top">Publications, Honors and Awards</td>
									<td valign="top" style="border-right: 1px solid #CCCCCC;">
										<g:checkBox name="sectionOptions.displayPublications"
											value="${resumeInstance.sectionOptions.displayPublications}"
											onclick="return sectionCheckboxClicked(this);" />
									</td>

									<td valign="top">Interests</td>
									<td valign="top"><g:checkBox
											name="sectionOptions.displayInterests"
											value="${resumeInstance.sectionOptions.displayInterests}"
											onclick="return sectionCheckboxClicked(this);" /></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
			<div id="sections">
				<ul>
					<li id="li-objectives"><a href="#div-objectives">Objectives</a></li>
					<li id="li-summary"><a href="#div-summary">Summary</a></li>
					<li id="li-skills"><a href="#div-skills">Skills</a></li>
					<li id="li-employment"><a href="#div-employment">Employment</a></li>
					<li id="li-education"><a href="#div-education">Education</a></li>
					<li id="li-publications"><a href="#div-publications">Publications,
							Honors and Awards</a></li>
					<li id="li-interests"><a href="#div-interests">Interests</a></li>
					<li id="li-contact"><a href="#div-contact">Contact
							Information</a></li>
				</ul>
				<div id="div-objectives">
					<p>Provide a brief statement of your career objectives. This is
						free form text. Lines that begin with '*' will render as bullet
						points</p>
					<g:textArea class="resume" name="objectives" cols="80" rows="6"
						value="${resumeInstance.objectives}" />
				</div>
				<div id="div-summary">
					<p>Summarize your professional accomplishments. This is free
						form text. Lines that begin with '*' will render as bullet points</p>
					<g:textArea class="resume" name="summary" cols="80" rows="6"
						value="${resumeInstance.summary}" />
				</div>
				<div id="div-skills">
					<p>List any technical and professional skills</p>
					<input class="dynamic-table-image" type="image" alt="add item"
						title="add item" src="${request.contextPath}/images/skin/add.gif"
						onclick="return addTableRow('skills-table','textField({name:\'skills\',size:80,value:\'new skill\'})');" />
					<span>
						<table id="skills-table" class="dynamic-table">
							<g:each in="${resumeInstance.skills}" var="skill">
								<tr class="dynamic-table">
									<td class="dynamic-table"><g:textField
											class="dynamic-table" name="skills" size="80"
											value="${skill}" />
									<td class="dynamic-table"><input
										class="dynamic-table-image" type="image"
										title="remove this item" alt="remove this item"
										src="${request.contextPath}/images/skin/delete.gif"
										onclick="return removeTableRow(this);" /></td>
									<td class="dynamic-table"><input
										class="dynamic-table-image" type="image"
										title="insert item before" alt="insert item before"
										src="${request.contextPath}/images/skin/insert.gif"
										onclick="return insertTableRow(this,'skills-table','textField({name:\'skills\',size:80,value:\'new skill\'})');" />
									</td>
								</tr>
							</g:each>
						</table>
					</span>
				</div>
				<div id="div-employment">
					<p>Provide your employment history</p>
					<input class="dynamic-table-image" type="image" alt="add item"
						title="add item" src="${request.contextPath}/images/skin/add.gif"
						onclick="return addTableRow('employment-table','employment()');" />
					<span>
						<table id="employment-table" class="dynamic-table">
							<g:each in="${resumeInstance.employment}" var="employment">
								<tr>
									<td><span><br />
											<table class="dynamic-table">
												<tr class="dynamic-table">
													<td class="dynamic-table">Title</td>
													<td class="dynamic-table"><g:textField
															name="employment_jobTitle" size="60"
															value="${employment.jobTitle}" />
												</tr>
												<tr class="dynamic-table">
													<td class="dynamic-table">Employer</td>
													<td class="dynamic-table"><g:textField
															name="employment_employer" size="60"
															value="${employment.employer}" />
												</tr>
												<tr class="dynamic-table">
													<td class="dynamic-table">Location</td>
													<td class="dynamic-table"><g:textField
															name="employment_location" size="60"
															value="${employment.location}" />
												</tr>
												<tr>
													<td class="dynamic-table">From</td>
													<td class="dynamic-table"><g:textField
															name="employment_from" size="20"
															value="${employment.from}" />
												</tr>
												<tr class="dynamic-table">
													<td class="dynamic-table">To</td>
													<td class="dynamic-table"><g:textField
															name="employment_to" size="20" value="${employment.to}" />
												</tr>
												<tr class="dynamic-table">
													<td colspan="2" class="dynamic-table">Job Description/Accomplishments</td>
												<tr>
													<td class="dynamic-table" colspan="2"><p>This is
															free form text. Lines that begin with '*' will render as
															bullet points</p></td>
												</tr>
												<tr class="dynamic-table">
												  <td colspan="2" class="dynamic-table">
													<g:textArea class="resume" name="employment_jobDescription"
													value="${employment.jobDescription}"
														cols="80" rows="8"/>
												  </td>
												</tr>
											</table>
											<hr /> </span></td>
									<td class="dynamic-table"><input
										class="dynamic-table-image" type="image"
										title="remove this item" alt="remove this item"
										src="${request.contextPath}/images/skin/delete.gif"
										onclick="return removeTableRow(this);" /></td>
									<td class="dynamic-table"><input
										class="dynamic-table-image" type="image"
										title="insert item before" alt="insert item before"
										src="${request.contextPath}/images/skin/insert.gif"
										onclick="return insertTableRow(this,'employment-table','employment()');" />
									</td>
								</tr>
							</g:each>
						</table>
					</span>
				</div>
				<div id="div-education">
					<p>Provide your educational history, degrees attained, etc.</p>
					<input class="dynamic-table-image" type="image" alt="add item"
						title="add item" src="${request.contextPath}/images/skin/add.gif"
						onclick="return addTableRow('education-table','education()');" />
					<span>
						<table id="education-table" class="dynamic-table">
							<g:each in="${resumeInstance.education}" var="education">

								<tr class="dynamic-table">
									<td><span>
											<table>
												<tr>
													<td class="dynamic-table">School</td>
													<td class="dynamic-table"><g:textField
															class="dynamic-table" name="education_school" size="40"
															value="${education.school}" /></td>
													<td class="dynamic-table">Location</td>
													<td class="dynamic-table"><g:textField
															class="dynamic-table" name="education_location" size="40"
															value="${education.location}" /></td>
													<td class="dynamic-table">Year</td>
													<td class="dynamic-table"><g:textField
															class="dynamic-table" name="education_year" size="4"
															value="${education.year}" /></td>
													<td class="dynamic-table">Degree</td>
													<td class="dynamic-table"><g:textField
															class="dynamic-table" name="education_degree" size="30"
															value="${education.degree}" /></td>
												</tr>
											</table>
									</span></td>
									<td class="dynamic-table"><input
										class="dynamic-table-image" type="image"
										title="remove this item" alt="remove this item"
										src="${request.contextPath}/images/skin/delete.gif"
										onclick="return removeTableRow(this);" /></td>
									<td class="dynamic-table"><input
										class="dynamic-table-image" type="image"
										title="insert item before" alt="insert item before"
										src="${request.contextPath}/images/skin/insert.gif"
										onclick="return insertTableRow(this,'education-table','education()');" />
									</td>
								</tr>
							</g:each>
						</table>
					</span>
				</div>
				<div id="div-publications">
					<p>List any publications, honors and awards</p>
					<input class="dynamic-table-image" type="image" alt="add item"
						title="add item" src="${request.contextPath}/images/skin/add.gif"
						onclick="return addTableRow('publications-table','textField({name:\'publications\',size:120,value:\'new publication, honor or award\'})');" />
					<span>
						<table id="publications-table" class="dynamic-table"></table>
					</span>
				</div>
				<div id="div-interests">
					<p>List any relevant personal and professional interests</p>
					<input class="dynamic-table-image" type="image" alt="add item"
						title="add item" src="${request.contextPath}/images/skin/add.gif"
						onclick="return addTableRow('interest-table','textField({name:\'interests\',size:120,value:\'new interest\'})');" />
					<span>
						<table id="interest-table" class="dynamic-table"></table>
					</span>
				</div>
				<div id="div-contact">
					<p>Select fields to include in your resume</p>
					<span>
						<table class="dynamic-table">
							<tbody>
								<tr class="class="dynamic-table"">
									<table>
										<tbody>


											<tr class="dynamic-table">
												<td valign="top" class="dynamic-table"><label for="name"><g:message
															code="profile.name.label" default="Name" /></label></td>
												<td class="dynamic-table" valign="top" id="contactName">
													${profileInstance?.name}
												</td>
											</tr>

											<tr class="dynamic-table">
												<td valign="top" class="dynamic-table"><label for="primaryEmail"><g:message
															code="profile.primaryEmail.label" default="Primary Email" /></label>
												</td>
												<td valign="top" class="dynamic-table" id="primaryEmail">
													${profileInstance?.primaryEmail}
												</td>
												<td valign="top" class="dynamic-table"><label
													for="contactOptions.displayPrimaryEmail">include</label></td>
												<td class="dynamic-table"><g:checkBox
														name="contactOptions.displayPrimaryEmail"
														value="${resumeInstance.contactOptions.displayPrimaryEmail}" />
												</td>
											</tr>

											<tr class="dynamic-table">
												<td valign="top" class="dynamic-table"><label
													for="secondaryEmail"><g:message
															code="profile.secondaryEmail.label"
															default="Secondary Email" /></label></td>
												<td class="dynamic-table" valign="top" id="secondaryEmail">
													${profileInstance?.secondaryEmail}
												</td>
												<td valign="top" class="dynamic-table"><label
													for="contactOptions.displaySecondaryEmail">include</label>
												</td>
												<td class="dynamic-table"><g:checkBox
														name="contactOptions.displaySecondaryEmail"
														value="${resumeInstance.contactOptions.displaySecondaryEmail}" />
												</td>
											</tr>

											<tr class="dynamic-table">
												<td valign="top" class="dynamic-table"><label for="primaryPhone"><g:message
															code="profile.primaryPhone.label" default="Primary Phone" /></label>
												</td>
												<td valign="top" class="dynamic-table" 	id="primaryPhone">
													${profileInstance?.primaryPhone?.number} ${profileInstance.primaryPhone.type}
												</td>
												<td valign="top" class="dynamic-table"><label
													for="contactOptions.displayPrimaryPhone">include</label></td>
												<td class="dynamic-table"><g:checkBox
														name="contactOptions.displayPrimaryPhone"
														value="${resumeInstance.contactOptions.displayPrimaryPhone}" />
												</td>
											</tr>

											<tr class="dynamic-table">
												<td valign="top" class="dynamic-table"><label
													for="secondaryPhone"><g:message
															code="profile.secondaryPhone.label"
															default="Secondary Phone" /></label></td>
												<td valign="top" class="dynamic-table" id="secondaryPhone">
													${profileInstance?.secondaryPhone?.number}  ${profileInstance.secondaryPhone.type}
												</td>
												
												<td valign="top" class="dynamic-table"><label
													for="contactOptions.displaySecondaryPhone">include</label>
												</td>
												<td class="dynamic-table"><g:checkBox
														name="contactOptions.displaySecondaryPhone"
														value="${resumeInstance.contactOptions.displaySecondaryPhone}" />
												</td>
											</tr>
											<tr class="dynamic-table">
												<td colspan="2" class="dynamic-table">
													<table class="dynamic-table">

														<tr class="dynamic-table">
															<td valign="top" class="dynamic-table"><label for="address"><g:message
																		code="profile.address.label" default="Address" /></label></td>

														</tr>

														<tr class="dynamic-table">
															<td valign="top" class="dynamic-table"><label for="address"><g:message
																		code="profile.address.address1.label" default="Line 1" /></label></td>
															<td valign="top" class="dynamic-table" id="address1">
																${profileInstance?.address?.address1}
															</td>
														</tr>
														<tr class="dynamic-table">
															<td valign="top" class="dynamic-table"><label for="address"><g:message
																		code="profile.address.address2.label" default="Line 2" /></label></td>
															<td valign="top" class="dynamic-table"  id="address2">
																${profileInstance?.address?.address2}
															</td>
														</tr>
														<tr class="dynamic-table">
															<td valign="top" class="dynamic-table"><label for="address"><g:message
																		code="profile.address.city.label" default="City" /></label></td>
															<td valign="top" class="dynamic-table"  id="city">
																${profileInstance?.address?.city}
															</td>
														</tr>

														<tr class="dynamic-table">
															<td valign="top" class="dynamic-table"><label for="address"><g:message
																		code="profile.address.state.label"
																		default="State/Province" /></label></td>
															<td valign="top" class="dynamic-table"  id="state">
																${profileInstance?.address?.state}
															</td>
														</tr>

														<tr class="dynamic-table">
															<td valign="top" class="dynamic-table"><label for="address"><g:message
																		code="profile.address.country.label" default="Country" /></label></td>
															<td valign="top" class="dynamic-table"  id="country">
																${profileInstance?.address?.country}
															</td>
														</tr>

														<tr class="dynamic-table">
															<td valign="top" class="dynamic-table"><label for="address"><g:message
																		code="profile.address.postalCode.label"
																		default="Postal Code" /></label></td>
															<td valign="top" class="dynamic-table"  id="postalCode">
																${profileInstance?.address?.postalCode}
															</td>
														</tr>
													</table>
												</td>
												<td class="dynamic-table"><label
													for="contactOptions.displayAddress">include</label></td>
												<td class="dynamic-table"><g:checkBox name="contactOptions.displayAddress"
														value="${resumeInstance.contactOptions.displayAddress}" />
												</td>
											</tr>
											<tr class="dynamic-table">
												<td valign="top" class="dynamic-table"><label
													for="instantMessage"><g:message
															code="profile.instantMessage.label"
															default="Instant Message" /></label></td>
												<td valign="top" class="dynamic-table" id="instantMessage">
													${profileInstance?.instantMessage}
												</td>
												<td valign="top" class="dynamic-table"><label
													for="contactOptions.displayInstantMessage">include</label>
												</td>
												<td valign="top" class="dynamic-table"><g:checkBox
														name="contactOptions.displayInstantMessage"
														value="${resumeInstance.contactOptions.displayInstantMessage}" />
												</td>
											</tr>

											<tr class="dynamic-table">
												<td valign="top" class="dynamic-table"><label for="webSite"><g:message
															code="profile.webSite.label" default="Web Site" /></label></td>
												<td valign="top" id="webSite">
													${profileInstance?.webSite}
												</td>
												<td valign="top" class="dynamic-table"><label
													for="contactOptions.displayWebSite">include</label></td>
												<td valign="top" class="dynamic-table"><g:checkBox
														name="contactOptions.displayWebSite"
														value="${resumeInstance.contactOptions.displayWebSite}" />
												</td>
											</tr>
										</tbody>
									</table>
								</tr>
							</tbody>
							<tr>
						</table>
					</span>
				</div>
			</div>

			<div id="dialog"></div>
			<div class="buttons">
				<span class="button"> <g:if test="${mode.equals('create')}">
						<g:actionSubmit class="save" action="save"
							value="${message(code: 'default.button.save.label', default: 'Save')}" />
					</g:if> <g:else>
						<g:actionSubmit class="save" action="update"
							value="${message(code: 'default.button.update.label', default: 'Update')}" />

						<span class="button"><g:actionSubmit class="delete"
								action="delete"
								value="${message(code: 'default.button.delete.label', default: 'Delete')}"
								onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span></span>
				</g:else>
		</g:form>
	</div>
</body>
</html>