<%@ page session="true" %>

<%
if (session == null || session.getAttribute("otp_user") == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OTP Verification</title>

<style>
body{
    font-family:Segoe UI;
    background:#0f2027;
    color:white;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

.box{
    background:#203a43;
    padding:30px;
    border-radius:12px;
    text-align:center;
}

input{
    padding:10px;
    margin:10px;
    width:200px;
    border-radius:6px;
    border:none;
}

button{
    padding:10px 20px;
    background:#00c6ff;
    border:none;
    border-radius:6px;
    cursor:pointer;
}
</style>

</head>

<body>

<div class="box">
    <h2>Enter OTP</h2>

    <form action="verifyOtp" method="post">
        <input type="text" name="otp" placeholder="Enter OTP" required><br>
        <button type="submit">Verify</button>
    </form>
</div>

</body>
</html>