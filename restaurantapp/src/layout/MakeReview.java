package layout;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/MakeReview")
public class MakeReview extends HttpServlet {
	
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		String reviewed_restaurant=request.getParameter("review_restaurant_button").toString();
		session.setAttribute("reviewed_restaurant_name", reviewed_restaurant);
		if (session.getAttribute("username")==null) {
			session.setAttribute("go_to_review","true");
			response.sendRedirect("client_login.jsp");
		}
		else {
			response.sendRedirect("make_reviews.jsp");
		}
	}

}
