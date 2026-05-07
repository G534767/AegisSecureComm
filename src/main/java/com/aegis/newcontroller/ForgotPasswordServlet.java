package com.aegis.newcontroller;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");

        try {

            // 🔢 OTP generate (6 digit)
            Random rand = new Random();
            int otp = 100000 + rand.nextInt(900000);

            // ⏱ OTP expiry (5 minutes)
            LocalDateTime expiry = LocalDateTime.now().plusMinutes(5);

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/projectdb",
                "root",
                "admin"
            );

            // 🔥 Save OTP in DB
            PreparedStatement ps = con.prepareStatement(
                "UPDATE users SET otp=?, otp_expiry=? WHERE username=?"
            );

            ps.setString(1, String.valueOf(otp));
            ps.setTimestamp(2, Timestamp.valueOf(expiry));
            ps.setString(3, username);

            int rows = ps.executeUpdate();

            con.close();

            if (rows > 0) {

                // 🔥 For now console la print pannuvom
                System.out.println("OTP for " + username + " is: " + otp);

                // OTP page ku redirect
                response.sendRedirect("verifyOtp.jsp?username=" + username);

            } else {
                response.sendRedirect("result.jsp?msg=error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("result.jsp?msg=error");
        }
    }
}