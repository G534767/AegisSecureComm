package com.aegis.newcontroller;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/dashboard")
public class DashboardRedirectServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("role") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");

        if ("ADMIN".equalsIgnoreCase(role)) {
            response.sendRedirect("adminHome.jsp");
        } else if ("OFFICER".equalsIgnoreCase(role)) {
            response.sendRedirect("officerHome.jsp");
        } else if ("SOLDIER".equalsIgnoreCase(role)) {
            response.sendRedirect("soldierHome.jsp");
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}