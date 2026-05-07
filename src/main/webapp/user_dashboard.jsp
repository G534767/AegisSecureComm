<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
/* ========= SESSION VALIDATION (ONLY ONE PLACE) ========= */
String role = (String) session.getAttribute("role");
String username = (String) session.getAttribute("username");

if (role == null || username == null || !"user".equalsIgnoreCase(role)) {
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>User Dashboard</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<style>
body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f4f6f8;
}

/* ===== SIDEBAR ===== */
.sidebar {
    position: fixed;
    top: 0;
    left: 0;
    width: 220px;
    height: 100vh;
    background: linear-gradient(180deg, #2c3e50, #34495e);
    padding-top: 20px;
}

.sidebar h2 {
    color: #fff;
    text-align: center;
    margin-bottom: 30px;
}

.sidebar a {
    display: block;
    padding: 12px 20px;
    color: #ecf0f1;
    text-decoration: none;
    transition: 0.3s;
}

.sidebar a:hover {
    background: rgba(255,255,255,0.15);
}

.sidebar .logout {
    background: #e74c3c;
    margin-top: 20px;
}

.sidebar .logout:hover {
    background: #c0392b;
}

/* ===== MAIN CONTENT ===== */
.main-content {
    margin-left: 220px;
    padding: 30px;
}

.card {
    background: #fff;
    border-radius: 14px;
    padding: 25px;
    margin-bottom: 25px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.12);
}

.header-card {
    background: linear-gradient(135deg, #1abc9c, #16a085);
    color: #fff;
}

.header-card h2 {
    margin: 0;
}

.badge {
    display: inline-block;
    background: #f1c40f;
    color: #000;
    padding: 4px 10px;
    border-radius: 12px;
    font-size: 12px;
    font-weight: bold;
    margin-left: 10px;
}

.btn {
    display: inline-block;
    padding: 10px 18px;
    background: #3498db;
    color: #fff;
    text-decoration: none;
    border-radius: 6px;
    margin-right: 10px;
}

.btn:hover {
    background: #2980b9;
}

/* ===== RESPONSIVE ===== */
@media (max-width: 768px) {
    .sidebar {
        position: relative;
        width: 100%;
        height: auto;
    }
    .main-content {
        margin-left: 0;
    }
}
</style>
</head>

<body>

<!-- ===== SIDEBAR ===== -->
<div class="sidebar">
    <h2>User Panel</h2>

    <a href="user_dashboard.jsp">🏠 Dashboard</a>
    <a href="history.jsp">📜 My History</a>

    <a href="logout.jsp" class="logout">🚪 Logout</a>
</div>

<!-- ===== MAIN CONTENT ===== -->
<div class="main-content">

    <!-- HEADER CARD -->
    <div class="card header-card">
        <h2>
            Welcome <%= username %>
            <span class="badge">USER</span>
        </h2>
        <p>Logged in successfully</p>
    </div>

    <!-- ACTION CARD -->
    <div class="card">
        <h3>What would you like to do?</h3>

        <a class="btn" href="history.jsp">📊 View My History</a>
        <a class="btn" href="logout.jsp">🚪 Logout</a>
    </div>

</div>

</body>
</html>