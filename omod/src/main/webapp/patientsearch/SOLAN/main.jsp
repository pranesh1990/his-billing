<%--
 *  Copyright 2009 Society for Health Information Systems Programmes, India (HISP India)
 *
 *  This file is part of Billing module.
 *
 *  Billing module is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.

 *  Billing module is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Billing module.  If not, see <http://www.gnu.org/licenses/>.
 *
--%>
<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.openmrs.Patient"%>

<script type="text/javascript">
	
	PATIENTSEARCHRESULT = {
		oldBackgroundColor: "",
		
		/** Click to view patient info */
		//ghanshyam,11-nov-2013,New Requirement #2938 Dealing with Dead Patient
		visit: function(patientId,deadInfo){	
		if(deadInfo=="true"){
		alert("This Patient is Dead");
		return false;
		}				
			window.location.href = openmrsContextPath + "/module/billing/patientServiceBill.list?patientId=" + patientId;
		}
	};
	
	jQuery(document).ready(function(){
	
		// hover rows
		jQuery(".patientSearchRow").hover(
			function(event){					
				obj = event.target;
				while(obj.tagName!="TR"){
					obj = obj.parentNode;
				}
				PATIENTSEARCHRESULT.oldBackgroundColor = jQuery(obj).css("background-color");
				jQuery(obj).css("background-color", "#00FF99");									
			}, 
			function(event){
				obj = event.target;
				while(obj.tagName!="TR"){
					obj = obj.parentNode;
				}
				jQuery(obj).css("background-color", PATIENTSEARCHRESULT.oldBackgroundColor);				
			}
		);
	});
</script>

<c:choose>
	<c:when test="${not empty patients}">
		<table style="width: 100%">
			<tr>
				<td><b>Identifier</b>
				</td>
				<td><b>Name</b>
				</td>
				<td><b>Age</b>
				</td>
				<td><b>Gender</b>
				</td>
				<td><b>Birthdate</b>
				</td>
				<td><b>Phone number</b>
				</td>
			</tr>
			<c:forEach items="${patients}" var="patient" varStatus="varStatus">
			<!-- ghanshyam,11-nov-2013,New Requirement #2938 Dealing with Dead Patient -->
				<tr
					class='${varStatus.index % 2 == 0 ? "oddRow" : "evenRow" } patientSearchRow'
					onclick="PATIENTSEARCHRESULT.visit(${patient.patientId},'${patient.dead}');">
					<td>${patient.patientIdentifier.identifier}</td>
					<td>${patient.givenName} ${patient.middleName}
						${patient.familyName}</td>
					<td><c:choose>
							<c:when test="${patient.age == 0}">&lt 1</c:when>
							<c:otherwise>${patient.age}</c:otherwise>
						</c:choose></td>
					<td><c:choose>
							<c:when test="${patient.gender eq 'M'}">
								<img src="${pageContext.request.contextPath}/images/male.gif" />
							</c:when>
							<c:otherwise>
								<img src="${pageContext.request.contextPath}/images/female.gif" />
							</c:otherwise>
						</c:choose></td>
					<td><openmrs:formatDate date="${patient.birthdate}" /></td>
 						<td>
						<%
						Patient patient = (Patient) pageContext.getAttribute("patient");
						Map<Integer, Map<Integer, String>> attributes = (Map<Integer, Map<Integer, String>>) pageContext.findAttribute("attributeMap");						
						Map<Integer, String> patientAttributes = (Map<Integer, String>) attributes.get(patient.getPatientId());
						String phoneNumber = patientAttributes.get(16);
						if(phoneNumber!=null)
							out.print(phoneNumber);					
					%>
					</td>
				</tr>
			</c:forEach>
		</table>
	</c:when>
	<c:otherwise>
	No Patient found.
	</c:otherwise>
</c:choose>