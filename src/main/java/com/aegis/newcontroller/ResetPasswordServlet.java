package com.aegis.newcontroller;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.aegis.security.PasswordUtil;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String newPassword = request.getParameter("newPassword");

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/projectdb",
                "root",
                "admin"
            );

            // 🔐 Hash new password
            String hashedPassword = PasswordUtil.hashPassword(newPassword);

            // 🔥 Update password + clear OTP
            PreparedStatement ps = con.prepareStatement(
                "UPDATE users SET password=?, otp=NULL, otp_expiry=NULL WHERE username=?"
            );

            ps.setString(1, hashedPassword);
            ps.setString(2, username);

            int rows = ps.executeUpdate();

            con.close();

            if (rows > 0) {
                response.sendRedirect("result.jsp?msg=success");
            } else {
                response.sendRedirect("result.jsp?msg=error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("result.jsp?msg=error");
        }
    }
}