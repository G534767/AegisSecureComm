<%@ page import="java.sql.*" %>
<%@ page session="true" %>

<%
String username = (String) session.getAttribute("username");
if(username == null){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Profile</title>

<style>
body{
    font-family:Segoe UI;
    background:#0b1c2c;
    color:white;
}

.container{
    width:400px;
    margin:80px auto;
    background:#102c44;
    padding:30px;
    border-radius:12px;
}

input, button{
    width:100%;
    padding:10px;
    margin:10px 0;
}

button{
    background:#00c6ff;
    color:white;
    border:none;
}
</style>
</head>

<body>
<%
String role = (String) session.getAttribute("role");
String backPage = "login.jsp";

if("ADMIN".equalsIgnoreCase(role)){
    backPage = "admin_dashboard.jsp";
}else{
    backPage = "soldier_dashboard.jsp";
}
%>

<div style="padding:20px;">
    <a href="<%= backPage %>" style="
        background:#00c6ff;
        padding:8px 14px;
        border-radius:6px;
        text-decoration:none;
        color:white;
    ">Back</a>
</div>

<div class="container">
<h2>Edit Profile</h2>

<form action="UpdateProfileServlet" method="post">

<input type="text" name="username" value="<%= username %>" readonly>

<input type="password" name="password" placeholder="New Password" required>

<button type="submit">Update</button>

</form>

</div>

</body>
</html>