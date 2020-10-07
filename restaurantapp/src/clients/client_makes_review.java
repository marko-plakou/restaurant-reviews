package clients;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import reviews.Reviews;


@WebServlet("/client_makes_review")
public class client_makes_review extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		String restaurant;
		int stars_given;
		String comment="";
		String username=session.getAttribute("username").toString();
		stars_given=Integer.parseInt(request.getParameter("star_review").toString());
		comment=request.getParameter("comment_review").toString();
		restaurant=request.getParameter("restaurant_name");
		Reviews review=new Reviews(username,restaurant,stars_given);
		review.setComment(comment);
		clientDbConnector cdb=new clientDbConnector();
		if(cdb.client_makes_review(review)==true) {
			session.setAttribute("new_review","true");
			response.sendRedirect("make_reviews.jsp");
		}
		else {
		session.setAttribute("new_review","false");
		response.sendRedirect("make_reviews.jsp");
		}
	    }
	

}
