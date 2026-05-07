package com.aegis.newcontroller;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.aegis.security.PasswordUtil;

@WebServlet("/AddUserServlet")
public class AddUserServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/argument_retention_db";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "admin";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // 🔐 BASIC VALIDATION
        if (username == null || password == null || role == null ||
            username.trim().isEmpty() || password.trim().isEmpty()) {

            response.sendRedirect("result.jsp?msg=invalid");
            return;
        }

        username = username.trim();
        role = role.trim().toUpperCase();

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            // 🔍 CHECK USER EXISTS
            PreparedStatement check = con.prepareStatement(
                "SELECT username FROM users WHERE username=?"
            );
            check.setString(1, username);

            ResultSet rs = check.executeQuery();

            if (rs.next()) {
                // ⚠️ USER ALREADY EXISTS
                response.sendRedirect("result.jsp?msg=exists");
                con.close();
                return;
            }

            // 🔐 HASH PASSWORD
            String hashedPassword = PasswordUtil.hashPassword(password);

            // 💾 INSERT USER
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO users (username, password, role) VALUES (?, ?, ?)"
            );

            ps.setString(1, username);
            ps.setString(2, hashedPassword); // 🔥 HASH STORED
            ps.setString(3, role);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("result.jsp?msg=success");
            } else {
                response.sendRedirect("result.jsp?msg=error");
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("ERROR: " + e.getMessage());
        }
    }
}