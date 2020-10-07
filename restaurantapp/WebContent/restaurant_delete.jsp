<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<link rel="stylesheet" href="Styling/restaurant_owner_background.css">
<link rel="stylesheet" href="Styling/Popups.css">
<link rel="stylesheet" href="Styling/buttons.css">
<link rel="stylesheet" href="Styling/Tables.css">
<title>Remove Restaurant</title>
</head>
<body>

<!-- CANNOT NAVIGATE FROM URL BAR OR COME BACK AFTER LOGOUT  -->
<c:if test="${username==null}"><%response.sendRedirect("restaurant_owners.jsp");%></c:if>
<%
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
%>




<!-- SQL QUERIES AND DB CONNECTION -->
<%@ page import="layout.dbConnector" %>
<% dbConnector connector=new dbConnector(); %>
<sql:setDataSource var="db" driver="org.postgresql.Driver" url="<%=connector.getConnectionString() %>" user="<%=connector.getDbName() %>" password="<%=connector.getDbPass()%>"/>
<sql:query dataSource="${db}" var="rs">Select * from restaurants where ro_username=?
<sql:param value="${username}"/>
</sql:query>


<!--SUCCESSFUL OR FAILED DELETION POP-UP -->
<c:choose>
<c:when test="${restaurants_deleted==null }">
<c:set var="restaurants_deleted" value="false" scope="session"/>
</c:when>

<c:when test="${restaurants_deleted==true}">
<div class="alert2">
<span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
<h1>You have successfully deleted your restaurants</h1>
<c:set var="restaurants_deleted" value="false" scope="session"/>
</div>
</c:when>

</c:choose>




<!--JAVASCRIPT  -->
<script>
 function AtLeastOneCheckboxChecked(){
	  var checkboxes=document.getElementsByName("RestaurantNames");
	  var okay=false;
	  for (var i=0; i<checkboxes.length;i++){
		  if (checkboxes[i].checked){
			  okay=true;
			  break;
		  }
	  }
	 if (okay==true){
		 var confirmed=confirm("Are you sure? If you delete the restaurants, all of their reviews will be deleted.");
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
		 alert("Please Select a restaurant");
		 return false;
	 }
 }
 </script>

<center>
<div class="level">
<form action="restaurant_owner_deletes_restaurant" method="post" id="formsubmit">
<table>
<caption style="font-size:200%">My Restaurants</caption>
<thead>
<tr>
<th>Name</th>
<th>Cuisine Type</th>
<th>Region</th>
<th></th>
</tr>
</thead>
<tbody>
<c:forEach items="${rs.rows}" var="res">
<tr>
<td>${res.restaurant_name}</td>
<td><c:out value="${res.restaurant_type}"/></td>
<td><c:out value="${res.restaurant_region}" /></td>
<td><input type="checkbox" name="RestaurantNames" value="${res.restaurant_name}"></td>
</tr>
</c:forEach>
</tbody>
</table>
<center><button onclick="javascript:return AtLeastOneCheckboxChecked()"  name="Delete" ><h5 style="color:white;">Delete</h5></button></center>
</form>
</div>
</center>

</body>
</html>