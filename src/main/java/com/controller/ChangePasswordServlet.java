package com.controller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import org.mindrot.jbcrypt.BCrypt;

public class ChangePasswordServlet extends HttpServlet {

protected void doPost(HttpServletRequest req, HttpServletResponse res)
throws ServletException, IOException {

HttpSession session = req.getSession();
String admin = (String) session.getAttribute("admin");
if(admin == null){
    res.sendRedirect("admin_login.jsp");
    return;
}

String oldPwd = req.getParameter("oldPwd");
String newPwd = req.getParameter("newPwd");
String confirmPwd = req.getParameter("confirmPwd");

if(!newPwd.equals(confirmPwd)){
    res.sendRedirect("change_password.jsp?msg=fail");
    return;
}

try{
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/argument_retention_db","root","admin");

PreparedStatement ps =
con.prepareStatement("SELECT password FROM admin_user WHERE username=?");
ps.setString(1, admin);
ResultSet rs = ps.executeQuery();

if(rs.next()){
String dbHash = rs.getString("password");

if(BCrypt.checkpw(oldPwd, dbHash)){
String newHash = BCrypt.hashpw(newPwd, BCrypt.gensalt(12));
PreparedStatement ups =
con.prepareStatement("UPDATE admin_user SET password=? WHERE username=?");
ups.setString(1, newHash);
ups.setString(2, admin);
ups.executeUpdate();

res.sendRedirect("change_password.jsp?msg=ok");
}else{
res.sendRedirect("change_password.jsp?msg=fail");
}
}
con.close();
}catch(Exception e){e.printStackTrace();}
}
}