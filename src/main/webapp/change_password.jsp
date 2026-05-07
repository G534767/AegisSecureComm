<%@ page contentType="text/html;charset=UTF-8" %>
<%
if (session.getAttribute("admin") == null) {
    response.sendRedirect("admin_login.jsp");
    return;
}
String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
<head>
<title>Change Password</title>
<style>
body{font-family:Arial;background:#f4f6f8}
.box{width:420px;margin:80px auto;background:#fff;padding:25px;border-radius:8px}
input{width:100%;padding:10px;margin:8px 0}
button{width:100%;padding:10px;background:#1976d2;color:#fff;border:none}
.msg{color:green}
.err{color:red}
</style>
</head>
<body>
<div class="box">
<h2>Change Password</h2>

<% if("ok".equals(msg)){ %><p class="msg">Password updated</p><% } %>
<% if("fail".equals(msg)){ %><p class="err">Old password wrong</p><% } %>

<form action="ChangePasswordServlet" method="post">
<input type="password" name="oldPwd" placeholder="Old Password" required>
<input type="password" name="newPwd" placeholder="New Password" required>
<input type="password" name="confirmPwd" placeholder="Confirm Password" required>
<button type="submit">Update</button>
</form>

<br>
<a href="admin_dashboard.jsp">⬅ Back</a>
</div>
</body>
</html>