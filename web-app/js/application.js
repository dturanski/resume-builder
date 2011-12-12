
var Ajax;
if (Ajax && (Ajax != null)) {
	Ajax.Responders.register({
	  onCreate: function() {
        if($('spinner') && Ajax.activeRequestCount>0)
          Effect.Appear('spinner',{duration:0.5,queue:'end'});
	  },
	  onComplete: function() {
        if($('spinner') && Ajax.activeRequestCount==0)
          Effect.Fade('spinner',{duration:0.5,queue:'end'});
	  }
	});
}

function dynamicTableRowContent(tableId,funcStr) {
	var content = 
		"<tr class=\"dynamic-table\">"+
		"<td class=\"dynamic-table\">"+eval(funcStr)+"</td>" +
		"<td class=\"dynamic-table\">" + 
		"<input class=\"dynamic-table-image\" type=\"image\" title=\"remove this item\" alt=\"remove this item\" src="+
		"\"" + contextRoot+
		"/images/skin/delete.gif\" "+
		"onclick=\"return removeTableRow(this);\"/>" +
		"</td>" + 	
		"<td class=\"dynamic-table\">" + 
		"<input class=\"dynamic-table-image\" type=\"image\" title=\"insert item before\" alt=\"insert item before\" src="+
		"\"" + contextRoot +
		"/images/skin/insert.gif\" "+
		" onclick=\"return insertTableRow(this, '" + tableId + "', '" + escapeSingleQuotes(funcStr)+ "');\"/>" +
		"</td>" + 
		"</tr>" ;
	//console.log("dtrc: [" + content + "]");
	return content;
}

function escapeSingleQuotes(str) {
	var s= str.replace(/(?:\\')/g , "\'" );
	return s.replace(/(?:')/g , "\\'" );
}

function addTableRow(tableId,funcStr){
	$("#"+tableId).append(dynamicTableRowContent(tableId,funcStr));
	return false;
}

function textField(attributes){
	var content = "<input class=\"dynamic-table\" type=\"text\" ";
	for (var attr in attributes){
		content = content +  " " + attr + "=\"" + attributes[attr]+ "\"";
			
	}
	content = content + "/>";
	return content;
}

function insertTableRow(obj, tableId,funcStr) {
 //console.log(funcStr);	
 try {
	var tr = $(obj).closest("tr");
	var rowIndex = tr.index()-1;
	
	var content = dynamicTableRowContent(tableId, funcStr);
	
	if (rowIndex >= 0) {
		$('#' + tableId + ' > tbody  > tr').eq(rowIndex).after(content);
	} else {
		$("#"+tableId).prepend(content);
	}
 } catch (e) {
	// console.log(e);
 }
 return false;
}

function removeTableRow(obj) {
	//alert ($(obj).closest("tr")[0].rowIndex);
	$(obj).closest("tr").remove();
	return false;
}

/*
 * Education 
 */
function education() {
	var content = "<span><table><tr>" +
	td("School") +
	td(textField({size:40,name:'education_school'})) +
	td("Location") +  
	td(textField({size:40,name:'education_location'})) +
	td("Year") + 
	td(textField({size:4,name:'education_year'})) +
	td("Degree") + 
	td(textField({size:30,name:'education_degree'})) +
	"</tr></table></span>";
	return content;
}

function employment() {
	var content = "<span><br/><table><tr>" +
	td("Title") +
	td(textField({size:60,name:'employment_jobTitle'})) +
	"</tr>"+ 
	"<tr>" +
	td("Employer" ) +  
	td(textField({size:60,name:'employment_employer'})) +
	"</tr>"+
	"<tr>" +
	td("Location" ) +  
	td(textField({size:60,name:'employment_location'})) +
	"</tr>"+
	"<tr>" +
	td("From" ) + 
	td(textField({size:20,name:'employment_from'})) +
	"</tr>"+
	"<tr>" +
	td("To" ) + 
	td(textField({size:20,name:'employment_to'})) +
	"</tr>"+ 
	"<tr>" +
	 td("Job Description/Accomplishments",{colspan:2} ) + 
	 "</tr>"+ 
	 "<tr>" +
	 td("<p>This is free form text. Lines that begin with '*' will render as bullet points</p>",{colspan:2}) +
	 "</tr>"+
    "<tr>"+ 
 td('<textarea class="resume" name="employment_jobDescription" cols="80" rows="8"/>',{colspan:2}) +
   "</tr>" +
  "</table><hr/></span>"; 
			
	return content;
}

function td(str,attributes){
	var tag = '<td class="dynamic-table"';
	for (var attr in attributes){
		tag = tag +  ' ' + attr + '="' + attributes[attr]+ '"';
			
	}
	tag = tag + '>'
	//console.log(tag + str + '</td>')
	return tag + str + '</td>';
}

function initializeSection(section) {
	var cbName = '#sectionOptions\\.display'+ proper(section.id.replace('li-','')) 
	var checkBox = $(cbName)[0];
	if (checkBox == undefined) {
		//console.log("checkbox " + cbName + " undefined")
    	return;
    }
	return toggleSection(checkBox,section);
  
}

function toggleSection(checkBox,section) {
	  if (checkBox.checked ) {
	    	$(section).css("display","list-item"); 	    
		} else {
			$(section).css("display","none");
		}
	    $("#sections").tabs("select",0);
	    return false;
}

function sectionCheckboxClicked(checkBox) {
	var liName = 'li-'+ checkBox.name.replace('sectionOptions.display','').toLowerCase();
	 
	var section = $("#"+liName)[0];
	
	toggleSection(checkBox,section);
	return true;
}

function proper(string)
{
		return string.charAt(0).toUpperCase() + string.slice(1);
}

function resumeAsHtml(resume) {
	
	var sectionOptions = resume['sectionOptions'];
	var contactOptions = resume['contactOptions'];
	var contactInfo = resume['ownerProfile'];
	
	//console.log('displayObjectives:' + sectionOptions['displayObjectives']);
	var body = $('<body/>');
	body.append(
	   $('<h1/>', {
		'class':'preview',
		'id':'preview-resume-header',
		html:'Resume of ' + contactInfo['name']
	  }));
	  
	  if (sectionOptions['displayObjectives']){
		  body.append(
		  $('<h2/>', {
		   'class':'preview-section',
		    html:'Objectives'
	   }));
	  }
	  
	  if (sectionOptions['displaySummary']){
		  body.append(
		  $('<h2/>', {
		   'class':'preview-section',
		    html:'Summary'
	   }));
	  }
	  
	  
	  if (sectionOptions['displaySkills']){
		  body.append(
		  $('<h2/>', {
		   'class':'preview-section',
		    html:'Skills'
	   }));
	  }
	  
	  body.append(
			  $('<h2/>', {
			   'class':'preview-section',
			    html:'Employment History'
		   }));
	  
	  body.append(
			  $('<h2/>', {
			   'class':'preview-section',
			    html:'Education'
		   }));
	  
	  if (sectionOptions['displayPublications']){
		  body.append(
		  $('<h2/>', {
		   'class':'preview-section',
		    html:'Publications, Honors and Awards'
	   }));
	  }
	  
	  if (sectionOptions['displayInterests']){
		  body.append(
		  $('<h2/>', {
		   'class':'preview-section',
		    html:'Interests'
	   }));
	  }
	  
	  var contactTable = $('<table/>',{'class':'dynamic-table'});
	 
	  body.append(
			  $('<h2/>', {
			   'class':'preview-section',
			    html:'Contact Information'
		   }))
		   .append(contactTable);
		 
	  if (contactOptions['displayAddress']){
		 address(contactInfo['address'],contactTable);
	  }
	  if (contactOptions['displayPrimaryPhone']){
		  contactTable.append(tableRow(contactInfo['primaryPhone']['type']+' phone ',contactInfo['primaryPhone']['number']));
	  }
	  if (contactOptions['displaySecondaryPhone']){
		  contactTable.append(tableRow(contactInfo['secondaryPhone']['type']+' phone ',contactInfo['secondaryPhone']['number']));
	  }
	  if (contactOptions['displayPrimaryEmail']){
		 
		  contactTable.append(tableRow('Primary Email',contactInfo['primaryEmail']));
		 
	  }
	  if (contactOptions['displaySecondaryEmail']){
		  contactTable.append(tableRow('Secondary Email',contactInfo['secondaryEmail']));
	  }
	  if (contactOptions['displayInstantMessage']){
		  contactTable.append(tableRow('IM',contactInfo['instantMessage']));
	  }
	  if (contactOptions['displayWebSite']){
		  contactTable.append(tableRow('Web Site',contactInfo['webSite']));
	  }
	 
	//console.log(body.html());
	
	return body.appendTo('html');
}

function address(addr,table){
	 
	  table.append(tableRow('Address',addr['address1']));
	  
	  if (addr['address2'] && addr['address2'].length > 0){
		  table.append(tableRow('',addr['address2']));
	  }
	 	 
	  table.append(tableRow('',addr['city']+', '+addr['state'] + ' '+addr['postalCode']));
 
	  if (addr['country'] && addr['country'].length > 0){
		  table.append(tableRow('',addr['country']));  
	  }
	  
	 
}	  

function tableRow(label,data){
	  var tr = $('<tr/>');
	  tr.append($('<td/>',{'class':'dynamic-table',html:label}));
	  tr.append($('<td/>',{'class':'dynamic-table',html:data}));
	  return tr;
}

/*
 * getPageAsJSON
 */

function getPageAsJSON(){
    
	var resume = {};
	
	resume.contactOptions = {
			displayAddress :        $('#div-contact input[name="contactOptions.displayAddress"]').attr('checked') == 'checked',
			displayInstantMessage : $('#div-contact input[name="contactOptions.displayInstantMessage"]').attr('checked') == 'checked' ,
			displayPrimaryEmail :   $('#div-contact input[name="contactOptions.displayPrimaryEmail"]').attr('checked') == 'checked',
			displayPrimaryPhone :   $('#div-contact input[name="contactOptions.displayPrimaryPhone"]').attr('checked') == 'checked',
			displaySecondaryEmail : $('#div-contact input[name="contactOptions.displaySecondaryEmail"]').attr('checked') == 'checked',
			displaySecondaryPhone : $('#div-contact input[name="contactOptions.displaySecondaryPhone"]').attr('checked') == 'checked',
			displayWebSite :        $('#div-contact input[name="contactOptions.displayWebSite"]').attr('checked') == 'checked'

	};
	
	resume.sectionOptions = {
			displayInterests :    $('#properties input[name="sectionOptions.displayInterests"]').attr('checked') == 'checked',  
			displayObjectives :   $('#properties input[name="sectionOptions.displayObjectives"]').attr('checked') == 'checked',  
			displayPublications : $('#properties input[name="sectionOptions.displayPublications"]').attr('checked') == 'checked',  
			displaySkills :       $('#properties input[name="sectionOptions.displaySkills"]').attr('checked') == 'checked',  
			displaySummary :      $('#properties input[name="sectionOptions.displaySummary"]').attr('checked') == 'checked'
	
	};
	
	resume.objectives =  $('#objectives').val();
    resume.summary =  $('#summary').val();
    
    resume.skills = [];
    $.each($('[name=skills]'), function(){
    	resume.skills.push($(this).val());
      }
    );
    
    resume.interests = [];
    $.each($('[name=interests]'), function(){
    	resume.interests.push($(this).val());
      }
    );
    
    resume.publications = [];
    $.each($('[name=publications]'), function(){
    	resume.publications.push($(this).val());
      }
    );
    
  
    
    resume.ownerProfile = {
    	name: $("#contactName").text().trim(),
    	primaryEmail:$("#primaryEmail").text().trim(),
    	secondaryEmail:$("#secondaryEmail").text().trim(),
    	primaryPhone: parsePhone($("#primaryPhone").text().trim()),
    	secondaryPhone:parsePhone($("#secondaryPhone").text().trim()),
    	
    	address: {
    		address1:$("#address1").text().trim(),
    		address2:$("#address2").text().trim(),
    		city:$("#city").text().trim(),
    		state:$("#state").text().trim(),
    		country:$("#country").text().trim(),
    		postalCode:$("#postalCode").text().trim()
    	},
    	
    	instantMessage:$("#instantMessage").text().trim(),
    	webSite: $("#webSite").text().trim()
    }
	
	var json = JSON.stringify(resume);
	console.log(json);
    return json;
}
 
function parsePhone(phone){
	phone = phone.trim();
	var number = '';
	var type = '';
	var phoneTypes = ['Home','Mobile','Work','Other'];

	var re = /(.*?)\s+(Home|Mobile|Work|Other)/g;
	 
	var m = re.exec(phone);

	if (m != null ) {
	   number = m[1];
	   type = m[2];
	}
	
	return {number:number,type:type};
}



