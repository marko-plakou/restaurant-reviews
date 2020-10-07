package clients;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admins.adminDbConnector;

 
@WebServlet("/client_deletes_reviews")
public class client_deletes_reviews extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 HttpSession session=request.getSession();
		 String reviews[]=request.getParameterValues("ReviewDelete");
		 String client_username=session.getAttribute("username").toString();
		 clientDbConnector cdb=new clientDbConnector();
		 for (int i=0; i<reviews.length;i++) {
			 if (cdb.client_deletes_reviews(reviews[i], client_username)==false) {
				 session.setAttribute("procedure_failed","true");
				 session.setAttribute("success", "false");
				 response.sendRedirect("client_my_reviews.jsp");
			 }
			 else {
				 session.setAttribute("success", "true");
			 }
			 
		 }
		 response.sendRedirect("client_my_reviews.jsp");
		 } 
		 
	}


