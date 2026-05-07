package com.aegis.newcontroller;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.aegis.util.AESUtil;

@WebServlet("/SendMessageServlet")
public class SendMessageServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String sender = (String) session.getAttribute("username");
        String receiver = request.getParameter("receiver");
        String message = request.getParameter("message");

        try {

            // 🔐 ENCRYPT
            String encryptedMessage = AESUtil.encrypt(message);

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/argument_retention_db",
                "root",
                "admin"
            );

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO messages (sender, receiver, message, status) VALUES (?, ?, ?, 'SENT')"
            );

            ps.setString(1, sender);
            ps.setString(2, receiver);
            ps.setString(3, encryptedMessage);

            ps.executeUpdate();

            con.close();

            // 🔥 ✅ REDIRECT TO INBOX (WHATSAPP FLOW)
            response.sendRedirect(request.getContextPath() + "/Inbox?from=send");

        } catch (Exception e) {
            e.printStackTrace();

            // ❌ ERROR PAGE REMOVE → DIRECT BACK
            response.sendRedirect(request.getContextPath() + "/sendMessage.jsp");
        }
    }
}