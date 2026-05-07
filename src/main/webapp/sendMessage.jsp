<%@ page session="true" %>

<%
if (session == null || session.getAttribute("username") == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}

String username = (String) session.getAttribute("username");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Send Message | AEGIS</title>

<style>
body{
    margin:0;
    font-family:'Segoe UI';
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
    background:rgba(255,255,255,0.08);
    padding:30px;
    border-radius:15px;
    width:400px;
    text-align:center;
    box-shadow:0 10px 30px rgba(0,0,0,0.6);
}

input, textarea{
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

/* ✅ COMMON BACK STYLE */
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
    transform: translateX(-5px);
}
</style>

</head>

<body>

<!-- ✅ COMMON BACK BUTTON -->
<jsp:include page="back.jsp" />

<div class="container">
<div class="box">

<h2>Send Secure Message</h2>

<form action="<%= request.getContextPath() %>/SendMessageServlet" method="post">

    <!-- 🔥 SENDER AUTO -->
    <input type="hidden" name="sender" value="<%= username %>">

    <input type="text" name="receiver" placeholder="Receiver Username" required>

    <textarea name="message" placeholder="Enter Message" required></textarea>

    <button type="submit">Send</button>

</form>

</div>
</div>

</body>
</html>