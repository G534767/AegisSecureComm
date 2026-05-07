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
<title>Sent Messages</title>

<style>
body{
    font-family:Segoe UI;
    background:#0b1c2c;
    color:white;
}

.container{
    width:85%;
    margin:40px auto;
}

.topbar{
    display:flex;
    justify-content:space-between;
    margin-bottom:20px;
}

.back{
    background:#00c6ff;
    padding:8px 14px;
    border-radius:6px;
    text-decoration:none;
    color:white;
}

table{
    width:100%;
    border-collapse:collapse;
    background:#102c44;
}

th,td{
    padding:12px;
    text-align:center;
}

th{
    background:#00c6ff;
}

tr:nth-child(even){
    background:#0f2d44;
}

.msg{
    max-width:250px;
    overflow:hidden;
    text-overflow:ellipsis;
    white-space:nowrap;
}
</style>
</head>

<body>

<div class="container">

<div class="topbar">
    <a href="soldier_dashboard.jsp" class="back"> Back</a>
    <h2>Sent Messages</h2>
</div>

<table>
<tr>
<th>ID</th>
<th>To</th>
<th>Message</th>
<th>Time</th>
</tr>

<%
try{

Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/argument_retention_db",
"root",
"admin"
);

PreparedStatement ps = con.prepareStatement(
"SELECT * FROM messages WHERE sender=? ORDER BY id DESC"
);

ps.setString(1, username);

ResultSet rs = ps.executeQuery();

while(rs.next()){
%>

<tr>
<td><%= rs.getInt("id") %></td>
<td><%= rs.getString("receiver") %></td>
<td class="msg"><%= rs.getString("message") %></td>
<td><%= rs.getTimestamp("time") %></td>
</tr>

<%
}

}catch(Exception e){
out.println("Error: "+e.getMessage());
}
%>

</table>

</div>

</body>
</html>