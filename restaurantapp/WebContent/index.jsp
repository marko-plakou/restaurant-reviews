<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<link rel="stylesheet" href="Styling/navigation_bar.css">
<link rel="stylesheet" href="Styling/buttons.css">
<link rel="stylesheet" href="Styling/Popups.css">
<link rel="stylesheet" href="Styling/Tables.css">
<link rel="stylesheet" href="Styling/client_background.css">
 

<title>Welcome to Our Site</title>
<style>

.filter{
border: 3px solid #ff9900;
background-color:white;
border-radius:7px;
width:10%;
padding:5px;
float:left;
text-align:left;
}

.filter label{
 
  display: block;
  padding-left: 15px;
  text-indent: -15px;
  margin-left:6px;
}

.filter input[type=radio] {
  width: 13px;
  height: 13px;
  padding: 0;
  margin:0;
  vertical-align: bottom;
  position: relative;
  top: -1px;
  *overflow: hidden;
  margin:2px;
}

.topleft{
position:absolute;
width:15%;
border: 3px solid #ff9900;
border-radius:7px;
margin-top:350px;
}

 

h1{
color:white;
}

</style>
</head>



 	
<body style="overflow:scroll;">
<%response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");%>
<%@ page import="layout.dbConnector" %>
<%dbConnector connector=new dbConnector(); %>

<sql:setDataSource var="db" driver="org.postgresql.Driver" url="<%=connector.getConnectionString() %>" user="<%=connector.getDbName() %>" password="<%=connector.getDbPass() %>"/>
<sql:query dataSource="${db}" var="rs3">select distinct restaurant_type from restaurants where isactive=true</sql:query>
<sql:query dataSource="${db}" var="rs5">select distinct restaurant_region from restaurants where isactive=true</sql:query>

<c:choose>

<c:when test="${(cuisine_type=='All' or cuisine_type==null) and (search_region=='All' or search_region==null)}">
<sql:query dataSource="${db}" var="rs">select sum(stars_review)/count(restaurants.restaurant_name) as average_rating,restaurants.restaurant_name,restaurant_region,restaurant_type,telephone,img_path,isactive from restaurants left join user_reviews on restaurants.restaurant_name=user_reviews.restaurant_name  group by restaurants.restaurant_name order by average_rating Desc nulls last;</sql:query>
</c:when>

<c:when test="${cuisine_type!=null and (search_region=='All' or search_region==null) }">
<sql:query dataSource="${db}" var="rs">select sum(stars_review)/count(restaurants.restaurant_name) as average_rating,restaurants.restaurant_name,restaurant_region,restaurant_type,telephone,img_path,isactive from restaurants left join user_reviews on restaurants.restaurant_name=user_reviews.restaurant_name where restaurant_type=? group by restaurants.restaurant_name order by average_rating Desc nulls last;
<sql:param value="${cuisine_type}"/>
</sql:query>
</c:when>

<c:when test="${(cuisine_type=='All' or cuisine_type==null) and search_region!=null}">
<sql:query dataSource="${db}" var="rs">select sum(stars_review)/count(restaurants.restaurant_name) as average_rating,restaurants.restaurant_name,restaurant_region,restaurant_type,telephone,img_path,isactive from restaurants left join user_reviews on restaurants.restaurant_name=user_reviews.restaurant_name where restaurant_region=? group by restaurants.restaurant_name order by average_rating Desc nulls last;
<sql:param value="${search_region}"/>
</sql:query>
</c:when>


<c:otherwise>
<sql:query dataSource="${db}" var="rs">select sum(stars_review)/count(restaurants.restaurant_name) as average_rating,restaurants.restaurant_name,restaurant_region,restaurant_type,telephone,img_path,isactive from restaurants left join user_reviews on restaurants.restaurant_name=user_reviews.restaurant_name where restaurant_type=? and restaurant_region=? group by restaurants.restaurant_name order by average_rating Desc nulls last;
<sql:param value="${cuisine_type}"/> 
<sql:param value="${search_region}"/>
</sql:query>
</c:otherwise>



</c:choose>
 

<div><center><h2>Res|Revs Restaurant Reviews</h2></center></div>
<div class="navbar">
 <ul>
  <li><a href="#index">Home</a></li>
  <c:if test="${username!=null}"><li><a href="client_my_reviews.jsp">My Reviews</a></li></c:if>
  <c:if test="${username==null}"><li><a href="admin_login.jsp">Admins</a></li></c:if>
  <c:if test="${username==null}"><li><a href="restaurant_owners.jsp">Restaurant owners</a></li></c:if>
  
  
  <c:choose>
  <c:when test="${username==null}">
  <li style="float:right"><a href="client_register.jsp">Sign Up</a></li>
  </c:when>
  
  <c:otherwise>
  <li style="float:right"><form  action="client_logout" method="post"><button class="logout" type="submit"><i class="fas fa-door-open" style="margin-right:5px; color:#ff9900;"></i>Log Out</button></form></li>
  </c:otherwise> 
  </c:choose>
  
  <c:choose>
  <c:when test="${username==null}">
  <li style="float:right"><a href="client_login.jsp">Log In</a></li>
  </c:when>
  <c:otherwise>
  <li style="float:right"><a><i class="fas fa-user" style="margin-right:5px; color:#ff9900;"></i><c:out value="${username}"/></a></li>
  </c:otherwise>
  </c:choose>
  
</ul> </div>

<form action="SetFilter" method="post">
<div class="filter">
<h2>Region</h2>
 <label><input type="radio" id="All" name="region" value="All">All</label>
<c:forEach items="${rs5.rows}" var="region">
<label><input type="radio" id="${region.restaurant_region}" name="region" value="${region.restaurant_region}">${region.restaurant_region}</label>
</c:forEach>
<h2>Cuisine Type</h2>
<label><input type="radio" id="All" name="cuisine" value="All">All</label>
<c:forEach items="${rs3.rows}" var="kind">
<label><input type="radio" id="${kind.restaurant_type}" name="cuisine" value="${kind.restaurant_type}">${kind.restaurant_type}</label>
</c:forEach>

<script>
function Checkboxes(){
	var perioxes =document.getElementsByName("region");
	var kouzines=document.getElementsByName("cuisine");
	
	var perioxh_checked=false;
	var kouzina_checked=false;
	
	for (var i=0; i<kouzines.length;i++){
		if (kouzines[i].checked) {
			kouzina_checked=true;
			break;
			}
	}
	
	for (var i=0; i<perioxes.length;i++){
		if (perioxes[i].checked){
			perioxh_checked=true;
			break;
		}
	}
	
	if (perioxh_checked==true && kouzina_checked==true) {
		return true;
		}
	else if (perioxh_checked==true && kouzina_checked==false) {
		alert("Please select a cuisine type");
		return false;
	}
	else if (perioxh_checked==false && kouzina_checked==true) {
		alert("Please select a region");
		return false;
	}
	else if (perioxh_checked==false && kouzina_checked==false) {
		alert("Please select region and cuisine type");
		return false;
		} 
}

</script>






<input onclick="javascript:return Checkboxes();" type="submit" value="Submit" >
</div>
</form>

   <div style="margin-left:675px;">
    <c:choose>
    
    <c:when test="${(cuisine_type=='All' or cuisine_type==null) and (search_region=='All' or search_region==null)}">
    <h1>Region:All</h1>
    <h1>Cuisine Type:All</h1>
    </c:when>
    
    <c:when test="${cuisine_type!=null and (search_region=='All' or search_region==null) }">
    <h1>Region:All</h1>
    <h1>Cuisine Type:${cuisine_type}</h1>
    </c:when>
    
    <c:when test="${search_region!=null and (cuisine_type=='All' or cuisine_type==null) }">
    <h1>Region:${search_region}</h1>
    <h1>Cuisine Type:All</h1>
    </c:when>
    
    <c:otherwise>
    <h1>Region:${search_region}</h1>
    <h1>Cuisine Type:${cuisine_type}</h1>
    </c:otherwise>
    
    </c:choose>
    </div>
	<c:forEach items="${rs.rows}" var="row">
	<c:if test="${row.isactive==true}">
	<center>
	<div  class="level">
	<h2>${row.restaurant_name}</h2>
	<center><img src="rest_photos/${row.img_path}" style="width:450px; height:300px;"></center>
	<h3><i class="fas fa-utensils-alt" style='color:#ff9900;'></i> Type:<c:out value="${row.restaurant_type}"/></h3>
	<h3><i class="fas fa-map-marker-alt" style='color:#ff9900;'></i> Address:${row.restaurant_region}</h3>
	<h3><i class="fas fa-phone-square-alt" style='color:#ff9900;'></i> Telephone:<c:out value="${row.telephone}"/></h3>
	
	
	<c:if test="${row.average_rating!=null}"><h3>Total Rate:<c:out value="${row.average_rating}"/><i class='fas fa-star' style='color:#ff9900;'></i></h3></c:if>
	<div style="overflow-x:scroll;">
	
	<sql:query dataSource="${db}" var="rs2">select * from user_reviews where restaurant_name=?
    <sql:param value="${row.restaurant_name}"/>
    </sql:query>
    
	<table>
<tbody>
<tr><td>User</td>	
	<td>Stars Given</td>
	<td>Comment</td>
</tr>
	<c:forEach items="${rs2.rows}" var="reviews">
	<tr>
	<td><c:out value="${reviews.username}"/></td>	
	<td><c:out value="${reviews.stars_review}"/><i class='fas fa-star fa-xs' style='color:#ff9900;'></i></td>
	<td >${reviews.text_review}</td>
    </tr>
	</c:forEach>
	
	</tbody></table>
	 
	
	 
	</div>

	
	<br>
	 
	<form action="MakeReview" method="post">
	<input type="hidden" name="review_restaurant_button" value="${row.restaurant_name}"/>
	<button style="color:white;" type="submit">Make Review</button>
	</form>
	</div>
	</center>
	 
	
	
	

	 
</c:if><br>
</c:forEach>

<%session.removeAttribute("cuisine_type");
  session.removeAttribute("search_region");%>


   
 
 
</body>
</html>