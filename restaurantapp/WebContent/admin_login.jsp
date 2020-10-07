<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<title>Login</title>
<link rel="stylesheet" href="Styling/style.css">
<link rel="stylesheet" href="Styling/navigation_bar.css">
<link rel="stylesheet" href="Styling/buttons.css">
<link rel="stylesheet" href="Styling/Popups.css">
<link rel="stylesheet" href="Styling/admin_background.css">
</head>
<body>
<%response.setHeader("Cache-Control","no-cache,no-store,must-revalidate"); %>
<div class="navbar">
 <ul>
  <li><a href="index.jsp">Home</a></li>
  <li><a href="admin_login.jsp">Admins</a></li>
   <li><a href="restaurant_owners.jsp">Restaurant owners</a></li>
    </ul></div><br><br><br><br><br>
      <%if(session.getAttribute("admin_not_found")==null){session.setAttribute("admin_not_found", "false");}  
      else if (session.getAttribute("admin_not_found").toString().equals("true")){
      %>
	<div class="alert">
	  <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
	  <strong>Sorry!</strong>This admin does not exists or the password does not match.Please try again.
	</div><%session.setAttribute("admin_not_found","false");} %>
    <center><div class="level">
    <form action="admin_login" method="post">
    <h2>Admin Log In</h2>
    <h5 style="color:red;">The fields with(*) are required!</h5>
    
    <h4>*Email:</h4><i class="fas fa-envelope fa-2x" style='color:#ff9900;' aria-hidden="true" ></i><input type="email" name="admin_login_username" placeholder="Enter Your Email" required style="height:20px; margin:20px 50px 10px 20px;">
    <h4>*Password:</h4><i class="fas fa-lock fa-2x" style='color:#ff9900; ' ></i><input type="password" name="admin_login_password"placeholder="Enter Your Password" required style="height:20px; margin:20px 50px 10px 20px;">
    
    <br><br><button type="submit" value="admin_login" ><h5 style="color:white;">Log In</h5></button><br>
   </form> </div></center>
</body>
</html>