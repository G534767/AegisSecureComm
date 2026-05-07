package com.aegis.newcontroller;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/Inbox")
public class InboxServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = (String) request.getSession().getAttribute("username");

        List<String[]> messages = new ArrayList<>();

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/argument_retention_db",
                "root",
                "admin"
            );

            // ✅ STEP 1: UPDATE SEEN
            PreparedStatement psUpdate = con.prepareStatement(
                "UPDATE messages SET status='SEEN' WHERE receiver=?"
            );
            psUpdate.setString(1, username);
            psUpdate.executeUpdate();

            // ✅ STEP 2: FETCH
            PreparedStatement ps = con.prepareStatement(
                "SELECT sender, message, status FROM messages WHERE receiver=? ORDER BY id DESC"
            );

            ps.setString(1, username);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String sender = rs.getString("sender");
                String message = rs.getString("message");
                String status = rs.getString("status");

                messages.add(new String[]{sender, message, status});
            }

            con.close();

            // ✅ SAFE PASS
            request.setAttribute("messages", messages);

            request.getRequestDispatcher("inbox.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}