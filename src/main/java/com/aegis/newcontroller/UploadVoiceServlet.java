package com.aegis;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/uploadVoice")
@MultipartConfig
public class UploadVoiceServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Part filePart = request.getPart("audio");
        String fileName = "voice_" + System.currentTimeMillis() + ".webm";

        String uploadPath = getServletContext().getRealPath("") + "voices";

        File dir = new File(uploadPath);
        if (!dir.exists()) dir.mkdir();

        String filePath = uploadPath + File.separator + fileName;

        filePart.write(filePath);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/projectdb",
                "root",
                "root"
            );

            HttpSession session = request.getSession();
            int senderId = (int) session.getAttribute("userId");

            int receiverId = Integer.parseInt(request.getParameter("receiverId"));

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO voice_messages (sender_id, receiver_id, file_path) VALUES (?, ?, ?)"
            );

            ps.setInt(1, senderId);
            ps.setInt(2, receiverId);
            ps.setString(3, filePath);

            ps.executeUpdate();

            con.close();

            response.sendRedirect("voice.jsp?msg=sent");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}