<!DOCTYPE html>
<html>
<head>
<title>User Register</title>
</head>
<body>

<h2>User Registration</h2>

<form action="UserRegisterServlet" method="post">
    Username:
    <input type="text" name="username" required><br><br>

    Password:
    <input type="password" name="password" required><br><br>

    <button type="submit">Register</button>
</form>

<a href="user_login.jsp">Already have account? Login</a>

</body>
</html>