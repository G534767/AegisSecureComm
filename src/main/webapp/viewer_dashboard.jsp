<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<%
if (!"viewer".equals(session.getAttribute("role"))) {
    response.sendRedirect("admin_login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Viewer Dashboard</title>
</head>
<body>
    <h2>👤 Viewer Dashboard</h2>
    <p>Welcome Viewer</p>

    <a href="logout.jsp">Logout</a>
</body>
</html>