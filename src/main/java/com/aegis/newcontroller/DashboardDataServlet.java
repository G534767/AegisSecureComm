package com.aegis.newcontroller;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/dashboardData")
public class DashboardDataServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");

        int userCount = 0;
        int messageCount = 0;
        int attackCount = 0;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/argument_retention_db",
                "root",
                "admin"
            );

            // USERS
            PreparedStatement ps1 = con.prepareStatement("SELECT COUNT(*) FROM users");
            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) userCount = rs1.getInt(1);

            // MESSAGES
            PreparedStatement ps2 = con.prepareStatement("SELECT COUNT(*) FROM messages");
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) messageCount = rs2.getInt(1);

            // ATTACKS
            PreparedStatement ps3 = con.prepareStatement("SELECT COUNT(*) FROM attack_logs");
            ResultSet rs3 = ps3.executeQuery();
            if (rs3.next()) attackCount = rs3.getInt(1);

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        String json = "{"
                + "\"users\":" + userCount + ","
                + "\"messages\":" + messageCount + ","
                + "\"attacks\":" + attackCount
                + "}";

        response.getWriter().write(json);
    }
}