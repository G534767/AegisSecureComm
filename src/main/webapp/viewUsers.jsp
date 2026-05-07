<%@ page import="java.sql.*" %>
<%@ page session="true" %>

<%
if (session == null || session.getAttribute("role") == null || 
    !"ADMIN".equalsIgnoreCase((String)session.getAttribute("role"))) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Users | AEGIS</title>

<style>
body{
    margin:0;
    font-family:Segoe UI;
    background: linear-gradient(135deg,#0f2027,#203a43,#2c5364);
    color:white;
}

.container{
    width:80%;
    margin:40px auto;
}

h2{
    text-align:center;
    margin-bottom:20px;
}

table{
    width:100%;
    border-collapse:collapse;
    background:rgba(255,255,255,0.08);
    border-radius:10px;
    overflow:hidden;
}

th, td{
    padding:12px;
    border-bottom:1px solid rgba(255,255,255,0.2);
    text-align:center;
}

th{
    background:#00c6ff;
    color:black;
}

tr:hover{
    background:rgba(255,255,255,0.1);
}

.back-btn {
    position: absolute;
    top: 20px;
    left: 25px;
    text-decoration: none;
    font-size: 16px;
    color: #00e6e6;
    font-weight: 600;
    padding: 8px 14px;
    border-radius: 8px;
    background: rgba(0, 230, 230, 0.1);
    transition: all 0.3s ease;
}

.back-btn:hover {
    background: #00e6e6;
    color: #000;
}
</style>

</head>

<body>

<!-- 🔥 COMMON BACK BUTTON -->
<jsp:include page="back.jsp" />

<div class="container">
<h2>All Users</h2>

<table>
<tr>
<th>ID</th>
<th>Username</th>
<th>Role</th>
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
    ResultSet rs = st.executeQuery("SELECT * FROM users");

    while(rs.next()){
%>

<tr>
<td><%= rs.getInt("id") %></td>
<td><%= rs.getString("username") %></td>
<td><%= rs.getString("role") %></td>
</tr>

<%
    }

    con.close();

} catch(Exception e){
%>
<tr>
<td colspan="3" style="color:red;">Error: <%= e.getMessage() %></td>
</tr>
<%
}
%>

</table>

</div>

</body>
</html>