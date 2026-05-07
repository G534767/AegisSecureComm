<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.List" %>
<%@ page import="com.aegis.dao.MessageDAO" %>
<%@ page import="com.aegis.model.Message" %>
<%@ page import="com.aegis.util.AESUtil" %>
<%@ page import="com.aegis.util.DBConnection" %>

<html>
<head>
    <title>Inbox</title>
</head>
<body>

<h2>View Messages</h2>

<form method="get">
    Enter Receiver Name:
    <input type="text" name="receiver">
    <input type="submit" value="View">
</form>

<hr>

<%
    String receiver = request.getParameter("receiver");

    if(receiver != null){

        Connection conn = DBConnection.getConnection();
        MessageDAO dao = new MessageDAO();

        List<Message> list = dao.getMessages(conn, receiver);

        for(Message msg : list){

            String decrypted = AESUtil.decrypt(msg.getMessage());

%>

<p>
<b>From:</b> <%= msg.getSender() %> <br>
<b>Message:</b> <%= decrypted %> <br>
<b>Time:</b> <%= msg.getTimestamp() %>
</p>
<hr>

<%
        }
    }
%> 

</body>
</html>