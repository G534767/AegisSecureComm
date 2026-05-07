package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

protected void doPost(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {

String username = request.getParameter("username");
String password = request.getParameter("password");

try {
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/argument_retention_db",
"root","admin");

PreparedStatement ps =
con.prepareStatement("SELECT password, role FROM admin_user WHERE username=?");
ps.setString(1, username);

ResultSet rs = ps.executeQuery();

if (rs.next()) {
String hash = rs.getString("password");
String role = rs.getString("role");

if (PasswordUtil.checkPassword(password, hash)) {
HttpSession session = request.getSession();
session.removeAttribute("username"); 
session.removeAttribute("viewer");
session.setAttribute("admin", username);
session.setAttribute("role", role);
session.setAttribute("loginTime", new java.util.Date());

response.sendRedirect("admin_dashboard.jsp");
return;
}
}

response.sendRedirect("admin_login.jsp?error=1");
con.close();

} catch (Exception e) {
e.printStackTrace();
response.sendRedirect("admin_login.jsp?error=1");
}
}
}