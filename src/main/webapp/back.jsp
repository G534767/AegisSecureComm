<%@ page session="true" %>

<%
String role = (String) session.getAttribute("role");

String backPage = "login.jsp";

if ("ADMIN".equalsIgnoreCase(role)) {
    backPage = "admin_dashboard.jsp";
} else if ("SOLDIER".equalsIgnoreCase(role)) {
    backPage = "soldier_dashboard.jsp";
}
%>

<a href="<%= request.getContextPath() + "/" + backPage %>" class="back-btn">Back</a>