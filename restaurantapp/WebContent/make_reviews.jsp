<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<link rel="stylesheet" href="Styling/navigation_bar.css">
<link rel="stylesheet" href="Styling/Popups.css">
<link rel="stylesheet" href="Styling/buttons.css">
<link rel="stylesheet" href="Styling/Tables.css">
<link rel="stylesheet" href="Styling/client_background.css">
 

<title>Make Review</title>

<style>

 
.container {
  display: block;
  position: relative;
  padding-left: 30px;
  margin-bottom: 3px;
  cursor: pointer;
  font-size: 17px;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}

.container input {
  position: absolute;
  opacity: 0;
  cursor: pointer;
}

.checkmark {
  position: absolute;
  top: 10;
  left: 0;
  height: 25px;
  width: 25px;
  background-color: #eee;
  border-radius: 50%;
}


.container:hover input ~ .checkmark {
  background-color: #ccc;
}


.container input:checked ~ .checkmark {
  background-color: #ff9900;
}

.checkmark:after {
  content: "";
  position: absolute;
  display: none;
}

.container input:checked ~ .checkmark:after {
  display: block;
}


.container .checkmark:after {
 	top: 9px;
	left: 9px;
	width: 8px;
	height: 8px;
	border-radius: 50%;
	background: white;
}

select, textarea {
  width: 100%;
  padding: 12px;
  border: 1px solid black;
  border-radius: 4px;
  resize: vertical;
}

label {
  padding: 12px 12px 12px 0;
  display: inline-block;
}

.active {
  display: block;
  text-align: center;
  padding: 14px 26px;
  background-color: #ff9900;
  margin: 7px;
  text-decoration: none;
}


</style>
</head>
<%
 if(session.getAttribute("key")==null){
	 response.sendRedirect("client_login.jsp");
	 
 }
 else{
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
 }

%>


 	
<body style="overflow-y:scroll;">


<%@ page import="java.sql.*" %>
<%@ page import="layout.dbConnector" %>
<% 
dbConnector connector=new dbConnector();
String query1="";
String query2="";
	
Connection c=null;
PreparedStatement stmt1=null;

ResultSet rs=null;



try {
    c = DriverManager
            .getConnection(connector.getConnectionString(),connector.getDbName(),connector.getDbPass());
    
    System.out.println("Connected to database successfully!!");
	 query1="select restaurant_name from restaurants where isactive=true";
	
	
				stmt1 = c.prepareStatement(query1);
				rs = stmt1.executeQuery();
	}  catch (SQLException ex) {} 
 	


%>

<div class="navbar">
 <ul>
  <li><a href="index.jsp">Home</a></li>
  <li><a href="client_my_reviews.jsp">My Reviews</a></li>
  
  
  <li style="float:right"><form  action="client_logout" method="post"><button class="active">Log Out</button></form></li>
  <li style="float:right"><a><i class="fas fa-user" style="margin-right:5px; color:#ff9900;"></i>${username}</a></li>
</ul> </div>
<%if(session.getAttribute("new_registration")==null){session.setAttribute("new_registration", "false");}  
      else if (session.getAttribute("new_registration").toString().equals("true")){%>
	<div class="alert2">
	  <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
	  <strong>Welcome!</strong>Your registration was successful.
	</div><%session.setAttribute("new_registration","false");} %>
<%if(session.getAttribute("new_review")==null){session.setAttribute("new_review", "?");}  
      else if (session.getAttribute("new_review").toString().equals("true")){%>
	<div class="alert2">
	  <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
	  <strong>New Review Submitted!</strong>Your review was successffully submitted.
	</div><%session.setAttribute("new_review","?");} 
	else if(session.getAttribute("new_review").toString().equals("false")){%>
	<div class="alert">
	  <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
	  <strong>Error!</strong>You have already wrote a review for this restaurant.
	</div><%session.setAttribute("new_review","?");} %>










	 
	

	<center><div class="level" style="text-align:left;">

    <form action="client_makes_review" method="post">
    
     <center><h2>User:</h2> ${username}</center><br><br>
     <center><h3>Select the restaurant you want to rate.</h3></center>
     
        
    
        <select name="restaurant_name" id="rn1" >
        <option selected value="${reviewed_restaurant_name}">${reviewed_restaurant_name}</option>
       </select>
       <br><br><br>
       <hr><center><h3>Select the number of stars you want to rate.</h3></center><br>
      

  <label class="container"><input type="radio" checked="checked" name="star_review" value="1"><i class='fas fa-star' style='color:#ff9900;'></i><span class="checkmark"></span></label><br>
  
  <label class="container"><input type="radio" name="star_review" value="2">
<i class='fas fa-star' style='color:#ff9900;'></i><i class='fas fa-star' style='color:#ff9900;'></i><span class="checkmark"></span></label><br>
 
 
  <label class="container"><input type="radio" name="star_review" value="3" >
<i class='fas fa-star' style='color:#ff9900; text-align:left;'></i><i class='fas fa-star' style='color:#ff9900;'></i><i class='fas fa-star' style='color:#ff9900;'></i><span class="checkmark"></span></label><br>

 
  <label class="container"><input type="radio" name="star_review" value="4">
<i class='fas fa-star' style='color:#ff9900;'></i><i class='fas fa-star' style='color:#ff9900;'></i><i class='fas fa-star' style='color:#ff9900;'></i><i class='fas fa-star' style='color:#ff9900;'></i><span class="checkmark"></span></label><br>
 
  
 <label class="container"><input type="radio" name="star_review" value="5">
<i class='fas fa-star' style='color:#ff9900;'></i><i class='fas fa-star' style='color:#ff9900;'></i><i class='fas fa-star' style='color:#ff9900;'></i><i class='fas fa-star' style='color:#ff9900;'></i><i class='fas fa-star' style='color:#ff9900;'></i><span class="checkmark"></span></label><br>
  <br><br><hr>
  
 

   		<center><h3>Write a comment or an opinion about the restaurant.</h3></center><br>
        <textarea  name="comment_review" placeholder="Write Your Review.." style="height:100px; width:93%;"></textarea>
      
     <br><br> <center><button  type="submit" style="color:white;" >Submit Review</button></center>
    
  </form>
  
</div>
</center>
	
	
 
 
 

</body>
</html>