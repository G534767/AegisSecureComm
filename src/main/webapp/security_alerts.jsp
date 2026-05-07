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
<title>Security Alerts</title>

<style>
body{
    font-family:Segoe UI;
    background:#0b1c2c;
    color:white;
    margin:0;
}

/* HEADER */
.header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:20px;
}

/* BACK */
.back{
    background:#00c6ff;
    padding:8px 14px;
    border-radius:6px;
    text-decoration:none;
    color:white;
}

/* TITLE */
.title{
    font-size:22px;
}

/* TABLE */
.container{
    width:90%;
    margin:auto;
}

table{
    width:100%;
    border-collapse:collapse;
    background:#102c44;
    border-radius:10px;
    overflow:hidden;
}

th,td{
    padding:14px;
    text-align:center;
}

th{
    background:#ff416c;
}

tr:nth-child(even){
    background:#0f2d44;
}

/* COLORS */
.red{ color:#ff4b2b; font-weight:bold; }
.orange{ color:#ffa500; font-weight:bold; }

</style>
</head>

<body>

<div class="header">
    <a href="soldier_dashboard.jsp" class="back"> Back</a>
    <div class="title"> Security Alerts</div>
</div>

<div class="container">

<table>
<tr>
<th>ID</th>
<th>User</th>
<th>Type</th>
<th>IP</th>
</tr>

<%
try{
Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/argument_retention_db",
"root",
"admin"
);

PreparedStatement ps = con.prepareStatement(
"SELECT * FROM attack_logs ORDER BY id DESC"
);

ResultSet rs = ps.executeQuery();

while(rs.next()){

String type = rs.getString("event_type");
String color = type.contains("BRUTE") ? "red" : "orange";
%>

<tr>
<td><%= rs.getInt("id") %></td>
<td><%= rs.getString("username") %></td>
<td class="<%= color %>"><%= type %></td>
<td><%= rs.getString("ip_address") %></td>
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