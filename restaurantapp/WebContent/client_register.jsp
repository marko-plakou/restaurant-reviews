<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<link rel="stylesheet" href="Styling/Popups.css">
<link rel="stylesheet" href="Styling/navigation_bar.css">
<link rel="stylesheet" href="Styling/buttons.css">
<link rel="stylesheet" href="Styling/client_background.css">
<link rel="stylesheet" href="Styling/style.css">

<title>Client Register</title>

</head>
<body>

<div class="navbar">
 <ul>
  <li><a href="index.jsp">Home</a></li>
  <li><a href="admin_login.jsp">Admins</a></li>
   <li><a href="index.jsp">Restaurant owners</a></li>
   </ul></div>
    <% if(session.getAttribute("username_already_exists")==null){session.setAttribute("username_already_exists", "false");}
    else if (session.getAttribute("username_already_exists").toString().equals("true")){%>
	<div class="alert">
	  <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
	  <strong>Error!</strong>This username already exists.Please try another one.
	</div><%session.setAttribute("username_already_exists","false");} %>
    <% if(session.getAttribute("pass_dont_match")==null){session.setAttribute("pass_dont_match", "false");} 
    else if (session.getAttribute("pass_dont_match").toString().equals("true")){%>
	<div class="alert">
	  <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
	  <strong>Error!</strong>The passwords do not match.Please try again.
	</div>
 <% session.setAttribute("pass_dont_match", "false");} %>
    
    <center><div class="level">
    <form action="client_register" method="post" name="register">
    <h2>Sign Up</h2>
    <h5 style="color:red;">The fields with(*) are required!</h5>
    
    <h4>*Email:</h4><i class="fas fa-envelope fa-2x" style='color:#ff9900;' aria-hidden="true" ></i><input type="email" name="client_register_username" placeholder="Enter Your Email" required style="height:20px; margin:20px 50px 10px 20px;">
    <h4>*Password:</h4><i class="fas fa-lock fa-2x" style='color:#ff9900; ' ></i><input type="password" name="client_register_password"placeholder="Enter Your Password" required style="height:20px; margin:20px 50px 10px 20px;">
    <h4>*Confirm Password:</h4><i class="fas fa-redo fa-2x" style='color:#ff9900; '  ></i><input type="password" name="client_register_confirm_pass"placeholder="Confirm Your Password" required style="height:20px; margin:20px 50px 10px 20px;">
    <br><br><button type="submit" value="client_register" ><h5 style="color:white;">Sign Up</h5></button>
    <h5 style="color:red;">Already Registered?</h5>
    <br>
    
    
    
   </form> 
   <button onclick="location.href='client_login.jsp'"><h5 style="color:white;">Log In</h5></button>
   </div></center>
   
</body>
</html>