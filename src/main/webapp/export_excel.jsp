<%@ page import="java.sql.*" %>
<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "attachment; filename=user_history.xls");

String from = request.getParameter("from");
String to = request.getParameter("to");

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/argument_retention_db",
    "root",
    "admin"
);

String sql = "SELECT * FROM user_input WHERE 1=1";
if (from != null && !from.isEmpty())
    sql += " AND DATE(created_at) >= '" + from + "'";
if (to != null && !to.isEmpty())
    sql += " AND DATE(created_at) <= '" + to + "'";

Statement st = con.createStatement();
ResultSet rs = st.executeQuery(sql);
%>

<table border="1">
<tr>
    <th>ID</th>
    <th>Username</th>
    <th>Num1</th>
    <th>Num2</th>
    <th>Result</th>
    <th>Date</th>
</tr>

<%
while(rs.next()) {
%>
<tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("username") %></td>
    <td><%= rs.getInt("num1") %></td>
    <td><%= rs.getInt("num2") %></td>
    <td><%= rs.getInt("result") %></td>
    <td><%= rs.getTimestamp("created_at") %></td>
</tr>
<%
}
con.close();
%>
</table>