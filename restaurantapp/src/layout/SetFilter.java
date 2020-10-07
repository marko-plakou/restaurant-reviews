package layout;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

 
@WebServlet("/SetFilter")
public class SetFilter extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 HttpSession session=request.getSession();
		 String category=request.getParameter("cuisine").toString();
		 String region=request.getParameter("region").toString();
		 session.setAttribute("cuisine_type",category);
		 session.setAttribute("search_region", region);
		 response.sendRedirect("index.jsp");
		 
	}

}
