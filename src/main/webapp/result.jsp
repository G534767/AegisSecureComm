<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<title>Result</title>

<style>
body {
    background: #0f2027;
    color: white;
    font-family: Arial;
    text-align: center;
    margin-top: 100px;
}

.box {
    background: #1c3b44;
    padding: 30px;
    border-radius: 12px;
    display: inline-block;
}

.success {
    color: #00ffcc;
}

.error {
    color: #ff4d4d;
}

a {
    display: inline-block;
    margin-top: 20px;
    text-decoration: none;
    color: #00e6e6;
}
</style>

</head>
<body>

<div class="box">

<%
String msg = request.getParameter("msg");

if("success".equals(msg)){
%>
    <h2 class="success">✅ Operation Successful</h2>
<%
}else{
%>
    <h2 class="error">❌ Something went wrong</h2>
<%
}
%>

<a href="admin_dashboard.jsp">⬅ Back to Dashboard</a>

</div>

</body>
</html>