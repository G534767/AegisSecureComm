package com.controller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/UserLoginServlet")
public class UserLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/argument_retention_db",
                "root",
                "admin"
            );

            PreparedStatement ps = con.prepareStatement(
    "SELECT * FROM users WHERE username=? AND password=?"
            				);
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

           if (rs.next()) {

   
    HttpSession session = request.getSession();
    session.invalidate();
    session = request.getSession();

    
    session.setAttribute("role", "user");
    session.setAttribute("username", username);

   
    PreparedStatement psUpdate = con.prepareStatement(
        "UPDATE users SET login_count = login_count + 1, last_login = NOW() WHERE username=?"
    );
    psUpdate.setString(1, username);
    psUpdate.executeUpdate();

    response.sendRedirect("user_dashboard.jsp");
    return;
} else {
                response.sendRedirect("login.jsp?error=user");
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=server");
        }
    }
}