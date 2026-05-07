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
import javax.servlet.http.HttpSession;

@WebServlet("/DeleteServlet")
public class DeleteServlet extends HttpServlet {

protected void doGet(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {
	HttpSession session = request.getSession(false);
if (session == null || session.getAttribute("admin") == null) {
    response.sendRedirect("admin_login.jsp");
    return;
}

String role = (String) session.getAttribute("role");

if (role == null || !"admin".equalsIgnoreCase(role)) {
    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
    return;
}

    int id = Integer.parseInt(request.getParameter("id"));

    String url = "jdbc:mysql://localhost:3306/argument_retention_db";
    String user = "root";
    String password = "admin";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, user, password);

        PreparedStatement ps =
            con.prepareStatement("DELETE FROM user_input WHERE id=?");
        ps.setInt(1, id);
        ps.executeUpdate();

        con.close();

        response.sendRedirect("history.jsp");

    } catch (Exception e) {
        e.printStackTrace();
    }
}
}