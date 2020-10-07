package clients;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



@WebServlet("/client_login")
public class client_login_servlet extends HttpServlet {
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		String client_login_username;
		String client_login_password;
		client_login_username=request.getParameter("client_login_username");
		client_login_password=request.getParameter("client_login_password");
		Clients client=new Clients(client_login_username,client_login_password);
		clientDbConnector new_client_login=new clientDbConnector();
		if(new_client_login.clients_login(client)==false) {
			session.setAttribute("user_not_found", "true");
			response.sendRedirect("client_login.jsp");
		}else { 
		if (session.getAttribute("go_to_review")==null)
			
		{session.setAttribute("key", true);
		session.setAttribute("username", client_login_username);
		response.sendRedirect("index.jsp");}
		else {
			session.setAttribute("key", true);
			session.setAttribute("username", client_login_username);
			response.sendRedirect("make_reviews.jsp");
		}
		
		}
	}

}
