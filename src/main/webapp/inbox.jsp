<%@ page import="java.util.*" %>
<%@ page import="com.aegis.util.AESUtil" %>
<%@ page session="true" %>

<%
if (session == null || session.getAttribute("username") == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}

String currentUser = (String) session.getAttribute("username");

List<String[]> messages = (List<String[]>) request.getAttribute("messages");
String from = request.getParameter("from");
// 🔔 NEW MESSAGE COUNT
int newCount = 0;
if(messages != null){
    for(String[] msg : messages){
        if(!msg[0].equals(currentUser) && "DELIVERED".equalsIgnoreCase(msg[2])){
            newCount++;
        }
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chat | AEGIS</title>

<style>
body{
    margin:0;
    font-family:Segoe UI;
    background:#0b141a;
    color:white;
}

/* HEADER */
.header{
    background:#202c33;
    padding:15px;
    text-align:center;
    font-weight:bold;
}

/* ALERT BOX */
.new-alert{
    background:#00c6ff;
    color:black;
    padding:10px;
    text-align:center;
    font-weight:bold;
}

/* CHAT AREA */
.chat-container{
    padding:20px;
    height:85vh;
    overflow-y:auto;
}

/* MESSAGE */
.message{
    max-width:60%;
    padding:10px 14px;
    margin:10px;
    border-radius:12px;
}

/* RECEIVED */
.other{
    background:#202c33;
}

/* SENT */
.me{
    background:#005c4b;
    margin-left:auto;
}

/* 🔥 NEW MESSAGE HIGHLIGHT */
.new-msg{
    border:2px solid #00e6e6;
}

/* NAME */
.sender{
    font-size:12px;
    color:#aaa;
}

/* STATUS */
.status{
    font-size:11px;
    margin-top:5px;
}

.status.sent{
    color:#aaa;
}

.status.seen{
    color:#4fc3f7;
    font-weight:bold;
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

<!-- ✅ COMMON BACK -->
<% if("send".equals(from)) { %>

<a href="<%= request.getContextPath() %>/sendMessage.jsp" class="back-btn">← Back</a>

<% } else { %>

<jsp:include page="back.jsp" />

<% } %>

<div class="header">
    Secure Chat
</div>

<!-- 🔔 ALERT -->
<% if(newCount > 0){ %>
<div class="new-alert">
    🔔 You have <%= newCount %> new message(s)
</div>
<% } %>

<div class="chat-container">

<%
if(messages != null){
    for(String[] msg : messages){

        String sender = msg[0];
        String encrypted = msg[1];
        String status = msg[2];

        boolean isMe = sender.equals(currentUser);

        String decrypted = "";
        try {
            decrypted = AESUtil.decrypt(encrypted);
        } catch(Exception e){
            decrypted = "Error decrypting";
        }
%>

<div class="message <%= isMe ? "me" : "other" %> 
<%= (!isMe && "DELIVERED".equalsIgnoreCase(status)) ? "new-msg" : "" %>">

<% if(!isMe){ %>
<div class="sender"><%= sender %></div>
<% } %>

<div><%= decrypted %></div>

<div class="status <%= "SEEN".equalsIgnoreCase(status) ? "seen" : "sent" %>">
    <% if(isMe){ %>
        <%= "SEEN".equalsIgnoreCase(status) ? "✔✔ Seen" : "✔ Delivered" %>
    <% } %>
</div>

</div>

<%
    }
}
%>

</div>

</body>
</html>