<%@ page language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forgot Password | AEGIS</title>

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

button:hover{
    background:#00cccc;
}
</style>

</head>

<body>

<div class="box">
<h2>Forgot Password</h2>

<form action="ForgotPasswordServlet" method="post">

<input type="text" name="username" placeholder="Enter Username" required>

<button type="submit">Send OTP</button>

</form>

</div>

</body>
</html>