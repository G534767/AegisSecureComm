<%@ page session="true" %>

<%
if (session == null || session.getAttribute("username") == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}

// 🔥 ROLE CHECK (ONLY ADMIN ACCESS)
String role = (String) session.getAttribute("role");
if (role == null || !"ADMIN".equalsIgnoreCase(role)) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add User | AEGIS</title>

<style>
body{
    margin:0;
    font-family:Segoe UI;
    background: linear-gradient(135deg,#0f2027,#203a43,#2c5364);
    color:white;
}

.container{
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

.box{
    width:400px;
    padding:30px;
    border-radius:15px;
    background:rgba(255,255,255,0.08);
    box-shadow:0 10px 30px rgba(0,0,0,0.6);
    text-align:center;
}

input, select{
    width:100%;
    padding:10px;
    margin:10px 0;
    border:none;
    border-radius:8px;
}

button{
    width:100%;
    padding:12px;
    border:none;
    border-radius:8px;
    background:#00c6ff;
    color:white;
    font-weight:bold;
    cursor:pointer;
}

button:hover{
    background:#009edc;
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

<!-- 🔥 COMMON BACK BUTTON INCLUDE -->
<jsp:include page="back.jsp" />

<div class="container">
<div class="box">

<h2>Add New User</h2>

<form action="AddUserServlet" method="post">

<input type="text" name="username" placeholder="Username" required>

<input type="password" name="password" placeholder="Password" required>

<select name="role" required>
    <option value="">Select Role</option>
    <option value="ADMIN">Admin</option>
    <option value="SOLDIER">Soldier</option>
</select>

<button type="submit">Add User</button>

</form>

</div>
</div>

</body>
</html>