<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<title>Login</title>
<link rel="stylesheet" href="Styling/style.css">
<link rel="stylesheet" href="Styling/navigation_bar.css">
<link rel="stylesheet" href="Styling/buttons.css">
<link rel="stylesheet" href="Styling/Popups.css">
<link rel="stylesheet" href="Styling/client_background.css">
</head>
<body>
<div class="navbar">
 <ul>
  <li><a href="index.jsp">Home</a></li>
  <li><a href="admin_login.jsp">Admins</a></li>
   <li><a href="restaurant_owners.jsp">Restaurant owners</a></li>
   </ul></div><br><br><br><br><br>
      <%if(session.getAttribute("user_not_found")==null){session.setAttribute("user_not_found", "false");}   
      else if (session.getAttribute("user_not_found").toString().equals("true")){%>
	<div class="alert">
	  <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
	  <strong>Sorry!</strong>This user do not exists or the password does not match.Please try again.
	</div><%session.setAttribute("user_not_found","false");} %>
    <center><div class="level">
    <form action="client_login" method="post">
    <h2>Log In</h2>
    <h5 style="color:red;">The fields with(*) are required!</h5>
    <h4>*Email:</h4><i class="fas fa-envelope fa-2x" style='color:#ff9900;' aria-hidden="true" ></i><input type="email" name="client_login_username" placeholder="Enter Your Email" required style="height:20px; margin:20px 50px 10px 20px;">
    <h4>*Password:</h4><i class="fas fa-lock fa-2x" style='color:#ff9900; ' ></i><input type="password" name="client_login_password"placeholder="Enter Your Password" required style="height:20px; margin:20px 50px 10px 20px;">
    <br><br><button type="submit" value="client_login" ><h5 style="color:white;">Log In</h5></button><br>
    <br> <h5 style="color:red;">Not Registered yet?</h5>
     
    
    
    
   </form>
   <button onclick="location.href='client_register.jsp'"><h5 style="color:white;">Sign Up</h5></button><br> </div></center>
</body>
</html>