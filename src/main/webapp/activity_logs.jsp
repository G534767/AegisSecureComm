<%@ page import="java.sql.*" %>
<%@ page session="true" %>

<%
if (session == null || session.getAttribute("username") == null) {
    response.sendRedirect("login.jsp");
    return;
}

String role = (String) session.getAttribute("role");

if (!"ADMIN".equalsIgnoreCase(role)) {
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Activity Logs</title>

<style>
body{
    font-family:Segoe UI;
    background:#0b1c2c;
    color:white;
}

.container{
    width:80%;
    margin:40px auto;
}

table{
    width:100%;
    border-collapse:collapse;
    background:#102c44;
}

th, td{
    padding:12px;
    text-align:center;
}

th{
    background:#00c6ff;
}

tr:nth-child(even){
    background:#0f2d44;
}
.topbar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:20px;
}

.back-btn{
    padding:8px 14px;
    background:#00c6ff;
    color:white;
    border-radius:6px;
    text-decoration:none;
}

.back-btn:hover{
    background:#0095cc;
}
</style>
</head>

<body>

<div class="container">
<div class="topbar">
    <a href="<%= request.getContextPath() %>/admin_dashboard.jsp" class="back-btn"> Back</a>
    <h2>Activity Logs</h2>
</div>
<h2>Activity Logs</h2>

<table>
<tr>
<th>ID</th>
<th>User</th>
<th>Action</th>
<th>IP</th>
<th>Time</th>
</tr>

<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/argument_retention_db",
        "root",
        "admin"
    );

    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM activity_logs ORDER BY id DESC");

    while(rs.next()){
%>

<tr>
<td><%= rs.getInt("id") %></td>
<td><%= rs.getString("username") %></td>
<td><%= rs.getString("action") %></td>
<td><%= rs.getString("ip_address") %></td>
<td><%= rs.getTimestamp("time") %></td>
</tr>

<%
    }

    con.close();

} catch(Exception e){
    out.println("ERROR: " + e.getMessage());
}
%>

</table>

</div>

</body>
</html>