package com.controller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class UserRegisterServlet extends HttpServlet {

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
                "INSERT INTO users (username, password) VALUES (?, ?)"
            );
            ps.setString(1, username);
            ps.setString(2, password);

            ps.executeUpdate();
            con.close();

            response.sendRedirect("user_login.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("user_register.jsp");
        }
    }
}