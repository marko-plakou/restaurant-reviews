package clients;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



@WebServlet("/client_register")
public class client_register_servlet extends HttpServlet  {
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		String client_reg_username;
		String client_reg_password;
		String client_reg_conf_password;
		client_reg_username=request.getParameter("client_register_username");
		client_reg_password=request.getParameter("client_register_password");
		client_reg_conf_password=request.getParameter("client_register_confirm_pass");
		if(client_reg_password.equals(client_reg_conf_password)) {
			
			Clients new_client=new Clients(client_reg_username,client_reg_password);
			clientDbConnector new_client_registration=new clientDbConnector();
			if(new_client_registration.client_register(new_client)==false) {
				session.setAttribute("username_already_exists", "true");
				session.setAttribute("new_registration", "false");
				response.sendRedirect("client_register.jsp");
			}
			else {
				session.setAttribute("username", client_reg_username);
				session.setAttribute("key", "true");
				session.setAttribute("new_registration", "true");
				response.sendRedirect("index.jsp");}
			
		}
		
		else {
			session.setAttribute("pass_dont_match","true");
			response.sendRedirect("client_register.jsp");
			
		
	}

}}
