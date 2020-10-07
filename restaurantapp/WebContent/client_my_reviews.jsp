<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>My Reviews</title>
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<link rel="stylesheet" href="Styling/Tables.css">
<link rel="stylesheet" href="Styling/client_background.css">
<link rel="stylesheet" href="Styling/navigation_bar.css">
<link rel="stylesheet" href="Styling/buttons.css">
<link rel="stylesheet" href="Styling/Popups.css">
 

</head>
<body>
<%@ page import="layout.dbConnector" %>
<% dbConnector connector=new dbConnector(); %>
<sql:setDataSource var="db" driver="org.postgresql.Driver" url="<%=connector.getConnectionString() %>" user="<%=connector.getDbName() %>" password="<%=connector.getDbPass()%>"/>



<ul>
<li><a href="index.jsp">Home</a></li>

<li style="float:right"><a><i class="fas fa-user" style="margin-right:5px; color:#ff9900;"></i><c:out value="${username}"/></a></li>
 <li style="float:right"><form  action="client_logout" method="post"><button class="logout" type="submit"><i class="fas fa-door-open" style="margin-right:5px; color:#ff9900;"></i>Log Out</button></form></li>
</ul>



<sql:query dataSource="${db}" var="rs">SELECT restaurants.restaurant_name,stars_review,text_review from restaurants inner join user_reviews on restaurants.restaurant_name=user_reviews.restaurant_name where username=?;
<sql:param value="${username}"/>
</sql:query>


<script>
 function AtLeastOneCheckboxChecked(){
	  var checkboxes=document.getElementsByName("ReviewDelete");
	  var okay=false;
	  for (var i=0; i<checkboxes.length;i++){
		  if (checkboxes[i].checked){
			  okay=true;
			  break;
		  }
	  }
	 if (okay==true){
		 var confirmed=confirm("Are you sure?");
		 if (confirmed==true){
			 document.getElementByName("Delete").setAttribute("Delete","true");
			 document.getElementById("formsubmit").submit();
			 return true;
		 }
		 else {
			 return false;
		 }
	 }
	 else {
		 alert("Please Select a review");
		 return false;
	 }
 }
 </script>
 
 
 <c:choose>
 <c:when test="${procedure_failed==null}">
 <c:set var="procedure_failed" value="false" scope="session"/>
 </c:when>
 
 <c:when test="${procedure_failed=='true'}">
 <div class="alert">
   <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
	  <h1>Something went wrong! Please try again.</h1>
</div>
<c:set var="procedure_failed" value="false" scope="session"/>
 </c:when>
 </c:choose>
 
 <c:choose>
 <c:when test="${success==null}">
 <c:set var="success" value="false" scope="session"/>
 </c:when>
 
 <c:when test="${success=='true'}">
<div class="alert2">
   <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
	  <h1>You deleted your reviews successfully</h1>
</div>
 <c:set var="success" value="false" scope="session"/>
 </c:when>
 </c:choose>



<form action="client_deletes_reviews" method="post">
<div class="level" style="margin:auto;">
<table>
<thead>
<tr>
<th>Restaurant Name</th>
<th>Stars</th>
<th>Description</th>
</tr>
</thead>

<tbody>
<c:forEach items="${rs.rows}" var="review">
<c:if test="${rs.rowCount!=0}">
<tr>
<td>${review.restaurant_name}</td>
<td><i class='fas fa-star' style='color:#ff9900;'></i><c:out value="${review.stars_review}"/></td>
<td>${review.text_review}</td>
<td><input type="checkbox" name="ReviewDelete" value="${review.restaurant_name}"></td>
</tr>
</c:if>
</c:forEach>
</tbody>

</table>
<c:if test="${rs.rowCount>0}">
<button  id="Delete" onclick="javascript:return AtLeastOneCheckboxChecked();" name="Delete"><h5 style="color:white;">Delete</h5></button>
</c:if>

<c:if test="${rs.rowCount==0}">
<h1>You have no reviews yet!</h1>
</c:if>
</div>
</form>



 

 

</body>
</html>