package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/HelloServlet")
public class HelloServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String url = "jdbc:mysql://localhost:3306/argument_retention_db";
        String dbUser = "root";
        String dbPass = "admin";

        Connection con = null;
        PreparedStatement ps = null;

        try {
            // 1. Read form values
            String username = request.getParameter("name"); // IMPORTANT
            int num1 = Integer.parseInt(request.getParameter("num1"));
            int num2 = Integer.parseInt(request.getParameter("num2"));

            int result = num1 + num2;

            // 2. Get session values
            String role = (String) request.getSession().getAttribute("role");
            String ip = request.getRemoteAddr();

            // 3. DB connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, dbUser, dbPass);

            // 4. Insert query
            String sql = "INSERT INTO user_input " +
                         "(username, num1, num2, result, user_role, ip_address) " +
                         "VALUES (?, ?, ?, ?, ?, ?)";

            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setInt(2, num1);
            ps.setInt(3, num2);
            ps.setInt(4, result);
            ps.setString(5, role);
            ps.setString(6, ip);

            ps.executeUpdate();

            // 5. Send data to result.jsp
            request.setAttribute("username", username);
            request.setAttribute("num1", num1);
            request.setAttribute("num2", num2);
            request.setAttribute("result", result);

            request.getRequestDispatcher("result.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=1");
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}