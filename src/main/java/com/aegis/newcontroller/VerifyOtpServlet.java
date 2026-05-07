package com.aegis.newcontroller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/verifyOtp")
public class VerifyOtpServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String enteredOtp = request.getParameter("otp");

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("otp_user");

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/argument_retention_db",
                "root",
                "admin"
            );

            PreparedStatement ps = con.prepareStatement(
                "SELECT otp, otp_expiry, role FROM users WHERE username=?"
            );

            ps.setString(1, username);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                String dbOtp = rs.getString("otp");
                Timestamp expiry = rs.getTimestamp("otp_expiry");

                // 🔐 OTP VALIDATION
                if (dbOtp != null && dbOtp.equals(enteredOtp)
                        && expiry != null
                        && expiry.after(new Timestamp(System.currentTimeMillis()))) {

                    // ✅ OTP SUCCESS → REMOVE OTP
                    PreparedStatement clearOtp = con.prepareStatement(
                        "UPDATE users SET otp=NULL, otp_expiry=NULL WHERE username=?"
                    );
                    clearOtp.setString(1, username);
                    clearOtp.executeUpdate();

                    String role = rs.getString("role");

                    // ✅ SESSION SET
                    session.setAttribute("username", username);
                    session.setAttribute("role", role);

                    // 🔥 REDIRECT
                    if ("ADMIN".equalsIgnoreCase(role)) {
                        response.sendRedirect("admin_dashboard.jsp");
                    } else {
                        response.sendRedirect("soldier_dashboard.jsp");
                    }

                } else {
                    response.getWriter().println("❌ Invalid or Expired OTP");
                }

            } else {
                response.getWriter().println("❌ User not found");
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("ERROR: " + e.getMessage());
        }
    }
}