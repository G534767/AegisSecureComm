package com.aegis.newcontroller;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.aegis.security.PasswordUtil;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/argument_retention_db";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "admin";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        System.out.println("🔐 LOGIN ATTEMPT: " + username);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            // =========================
            // 🔍 CHECK USER
            // =========================
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM users WHERE username=?"
            );
            ps.setString(1, username);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                String storedHash = rs.getString("password");
                String role = rs.getString("role");

                // =========================
                // 🔐 PASSWORD VALIDATION (FINAL FIX)
                // =========================
                boolean match = PasswordUtil.checkPassword(password, storedHash);

                System.out.println("ENTERED PASSWORD: " + password);
                System.out.println("DB HASH: " + storedHash);
                System.out.println("MATCH RESULT: " + match);

                if (!match) {

                    logAttack(con, username, "INVALID_PASSWORD", request);

                    System.out.println("❌ INVALID PASSWORD");
                    response.sendRedirect("login.jsp?msg=error");
                    return;
                }

                // =========================
                // 🔐 SUCCESS LOGIN
                // =========================
                System.out.println("✅ LOGIN SUCCESS: " + username);

                // =========================
                // 🔢 OTP GENERATION
                // =========================
                int otp = 100000 + new Random().nextInt(900000);

                LocalDateTime expiryTime = LocalDateTime.now().plusMinutes(2);
                Timestamp expiryTimestamp = Timestamp.valueOf(expiryTime);

                PreparedStatement updateOtp = con.prepareStatement(
                    "UPDATE users SET otp=?, otp_expiry=? WHERE username=?"
                );

                updateOtp.setString(1, String.valueOf(otp));
                updateOtp.setTimestamp(2, expiryTimestamp);
                updateOtp.setString(3, username);
                updateOtp.executeUpdate();

                System.out.println("🔐 OTP GENERATED: " + otp);

                // =========================
                // 🧠 SESSION STORE
                // =========================
                HttpSession session = request.getSession();
                session.setAttribute("otp_user", username);
                session.setAttribute("otp_role", role);

                // =========================
                // 📊 ACTIVITY LOG
                // =========================
                logActivity(con, username, "LOGIN_SUCCESS", request);

                con.close();

                // 👉 OTP PAGE
                response.sendRedirect("otp.jsp");

            } else {

                logAttack(con, username, "INVALID_USERNAME", request);

                System.out.println("❌ USER NOT FOUND");
                response.sendRedirect("login.jsp?msg=error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("ERROR: " + e.getMessage());
        }
    }

    // =========================
    // 🚨 ATTACK LOG
    // =========================
    private void logAttack(Connection con, String username, String type, HttpServletRequest request) {
        try {
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO attack_logs(username, event_type, ip_address) VALUES(?,?,?)"
            );
            ps.setString(1, username);
            ps.setString(2, type);
            ps.setString(3, request.getRemoteAddr());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // =========================
    // 📊 ACTIVITY LOG
    // =========================
    private void logActivity(Connection con, String username, String action, HttpServletRequest request) {
        try {
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO activity_logs(username, action, ip_address) VALUES(?,?,?)"
            );
            ps.setString(1, username);
            ps.setString(2, action);
            ps.setString(3, request.getRemoteAddr());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}