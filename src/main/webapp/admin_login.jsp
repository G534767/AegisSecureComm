<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login</title>
</head>

<body>

<h2>Admin Login</h2>

<form action="login" method="post">

<input type="text" name="username" placeholder="Username" required><br><br>

<input type="password" name="password" placeholder="Password" required><br><br>

<input type="hidden" name="roleType" value="ADMIN">

<button type="submit">Login</button>

</form>

</body>
</html>