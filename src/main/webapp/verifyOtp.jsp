<%@ page session="true" %>

<%
if (session == null || session.getAttribute("otp_user") == null) {
    response.sendRedirect("login.jsp");
    return;
}

String username = (String) session.getAttribute("otp_user");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Verify OTP | AEGIS</title>

<style>
body{
    margin:0;
    font-family:Segoe UI;
    background:#0f2027;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

.box{
    background:#203a43;
    padding:30px;
    border-radius:12px;
    width:320px;
    text-align:center;
    color:white;
}

input{
    width:100%;
    padding:10px;
    margin:10px 0;
    border-radius:6px;
    border:none;
}

button{
    width:100%;
    padding:10px;
    background:#00e6e6;
    border:none;
    border-radius:6px;
    cursor:pointer;
    font-weight:bold;
}
</style>

</head>

<body>

<div class="box">
<h2>Verify OTP</h2>

<form action="verifyOtp" method="post">

<input type="hidden" name="username" value="<%= username %>">

<input type="text" name="otp" placeholder="Enter OTP" required>

<button type="submit">Verify</button>

</form>

</div>

</body>
</html>