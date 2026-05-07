package com.aegis.newcontroller;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.aegis.security.PasswordUtil;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {

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

            String hashed = PasswordUtil.hashPassword(password);

            PreparedStatement ps = con.prepareStatement(
                "UPDATE users SET password=? WHERE username=?"
            );

            ps.setString(1, hashed);
            ps.setString(2, username);

            ps.executeUpdate();

            con.close();

            response.sendRedirect("admin_dashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}