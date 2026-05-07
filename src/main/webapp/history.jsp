<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String role = (String) session.getAttribute("role");
String loggedUser = (String) session.getAttribute("username");

if (role == null) {
    response.sendRedirect("index.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>User History</title>

<style>
body {
    font-family: Arial, sans-serif;
    background: #f4f6f8;
}
.container {
    width: 85%;
    margin: 30px auto;
    background: white;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
}
.top-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
}
h2 {
    text-align: center;
}
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 15px;
}
th, td {
    padding: 10px;
    text-align: center;
    border-bottom: 1px solid #ddd;
}
th {
    background: #2c3e50;
    color: white;
}
.btn {
    padding: 8px 14px;
    background: #3498db;
    color: white;
    text-decoration: none;
    border-radius: 4px;
    border: none;
    cursor: pointer;
}
.btn-danger {
    background: #e74c3c;
}
.filter-box {
    margin: 15px 0;
}
.highlight {
    background-color: #fff3cd;
}

body.dark {
    background: #121212;
    color: #f1f1f1;
}

body.dark .container {
    background: #1e1e1e;
}

body.dark table th {
    background: #333;
    color: #fff;
}

body.dark table td {
    color: #eee;
}

body.dark input,
body.dark button,
body.dark a.btn {
    background: #1abc9c;
    color: #000;
}

body.dark .btn-danger {
    background: #e74c3c;
    color: #fff;
}

body.dark .highlight {
    background-color: #3a3a1a;
}
</style>
</head>

<body>

<div class="container">

<div class="top-bar">
    <h2>User History</h2>
    <div>
    	<button id="darkToggle" class="btn">🌙 Dark Mode</button>
    </div>
    <a class="btn btn-danger" href="logout.jsp">Logout</a>
</div>


<form method="get" action="history.jsp" class="filter-box">
    From:
    <input type="date" name="from">
    To:
    <input type="date" name="to">

    <input type="text"
           id="searchInput"
           name="username"
           placeholder="Search by username"
           value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">

    <button class="btn" type="submit">Filter</button>
    <a class="btn" href="export_excel.jsp">⬇ Download Excel</a>
</form>

<%

String selectedUser = request.getParameter("username");
String from = request.getParameter("from");
String to = request.getParameter("to");


Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/argument_retention_db",
        "root",
        "admin"
    );

    if ("viewer".equalsIgnoreCase(role)) {
        PreparedStatement logPs = con.prepareStatement(
            "INSERT INTO viewer_activity (viewer_username, action, viewed_user, ip_address) VALUES (?, ?, ?, ?)"
        );
        logPs.setString(1, loggedUser);
        logPs.setString(2, "VIEW_HISTORY");
        logPs.setString(3, loggedUser);
        logPs.setString(4, request.getRemoteAddr());
        logPs.executeUpdate();
        logPs.close();
    }

    String sql;

    if ("admin".equalsIgnoreCase(role)) {
        
        sql = "SELECT * FROM user_input WHERE 1=1";
    } else {
        
        sql = "SELECT * FROM user_input WHERE username=?";
    } 



    if (from != null && !from.isEmpty() && to != null && !to.isEmpty()) {
        sql += " AND created_at BETWEEN ? AND ?";
    }

    if ("admin".equalsIgnoreCase(role)) {
        if (selectedUser != null && !selectedUser.isEmpty()) {
            sql += " AND username = ?";
        }
    }

    ps = con.prepareStatement(sql);
    int index = 1;

    if (from != null && !from.isEmpty() && to != null && !to.isEmpty()) {
        ps.setString(index++, from + " 00:00:00");
        ps.setString(index++, to + " 23:59:59");
    }

    if ("admin".equalsIgnoreCase(role)) {
        if (selectedUser != null && !selectedUser.isEmpty()) {
            ps.setString(index++, selectedUser);
        }
    } else {
        
        ps.setString(index++, loggedUser);
    }

    rs = ps.executeQuery();

if ("viewer".equalsIgnoreCase(role)) {

    PreparedStatement logPs = con.prepareStatement(
        "INSERT INTO viewer_activity (viewer_username, viewed_username, action, ip_address) VALUES (?, ?, ?, ?)"
    );

    String viewedUser =
        (selectedUser != null && !selectedUser.isEmpty())
        ? selectedUser
        : "ALL_USERS";

    logPs.setString(1, loggedUser);
    logPs.setString(2, viewedUser);
    logPs.setString(3, "VIEW_HISTORY");
    logPs.setString(4, request.getRemoteAddr());

    logPs.executeUpdate();
    logPs.close();
}


boolean hasRecords = false;
%>


<table id="userTable">
<thead>
<tr>
    <th>ID</th>
    <th>Username</th>
    <th>Num1</th>
    <th>Num2</th>
    <th>Result</th>
    <th>Date</th>
    <th>Action</th>
</tr>
</thead>

<tbody>
<%
while (rs.next()) {
    hasRecords = true;

    boolean highlight =
        selectedUser != null &&
        selectedUser.equals(rs.getString("username"));
%>
<tr class="<%= highlight ? "highlight" : "" %>">
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("username") %></td>
    <td><%= rs.getInt("num1") %></td>
    <td><%= rs.getInt("num2") %></td>
    <td><%= rs.getInt("result") %></td>
    <td><%= rs.getTimestamp("created_at") %></td>
    <td>
<%

if ("admin".equalsIgnoreCase(role)) {
%>
    <a class="btn btn-danger"
       href="<%= request.getContextPath() %>/DeleteServlet?id=<%= rs.getInt("id") %>"
       onclick="return confirm('Delete this record?')">
       Delete
    </a>
<%
} else {
%>
    <span style="color:gray; font-style:italic;">View Only</span>
<%
}
%>
</td>
</tr>
<%
}
%>
<%
if (!hasRecords) {
%>
<tr>
    <td colspan="7" style="text-align:center; color:red; font-weight:bold;">
        No records found
    </td>
</tr>
<%
}
%>
</tbody>
</table>

<%
} catch (Exception e) {
    e.printStackTrace();
} finally {
    try { if (rs != null) rs.close(); } catch (Exception e) {}
    try { if (ps != null) ps.close(); } catch (Exception e) {}
    try { if (con != null) con.close(); } catch (Exception e) {}
}
%>

<br>
<a class="btn" href="<%= request.getContextPath() %>/admin_dashboard.jsp">
← Back to Dashboard
</a>

</div>


<script>
document.getElementById("searchInput").addEventListener("keyup", function () {
    let filter = this.value.toLowerCase();
    let rows = document.querySelectorAll("#userTable tbody tr");

    rows.forEach(row => {
        let username = row.cells[1].innerText.toLowerCase();
        row.style.display = username.includes(filter) ? "" : "none";
    });
});
const toggleBtn = document.getElementById("darkToggle");


if (localStorage.getItem("historyDark") === "on") {
 document.body.classList.add("dark");
 toggleBtn.innerText = "☀ Light Mode";
}

toggleBtn.addEventListener("click", () => {
 document.body.classList.toggle("dark");

 if (document.body.classList.contains("dark")) {
     localStorage.setItem("historyDark", "on");
     toggleBtn.innerText = "☀ Light Mode";
 } else {
     localStorage.setItem("historyDark", "off");
     toggleBtn.innerText = "🌙 Dark Mode";
 }
});
</script>

</body>
</html>