package com.aegis.newcontroller;

import java.io.IOException;
import java.sql.*;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/unreadCount")
public class UnreadCountServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String username = (String) request.getSession().getAttribute("username");

        int count = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/argument_retention_db",
                "root",
                "admin"
            );

            PreparedStatement ps = con.prepareStatement(
                "SELECT COUNT(*) FROM messages WHERE receiver=? AND status='SENT'"
            );

            ps.setString(1, username);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.getWriter().print(count);
    }
}