<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AEGIS Secure System</title>

<style>
body{
    margin:0;
    font-family:'Segoe UI', sans-serif;
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background:url('<%= request.getContextPath() %>/images/login-bg.png') no-repeat center center/cover;
    overflow:hidden;
}

/* DARK OVERLAY */
.overlay{
    position:absolute;
    width:100%;
    height:100%;
    background:rgba(0,0,20,0.75);
}

/* MAIN CONTAINER */
.container{
    position:relative;
    z-index:2;
    width:400px;
    padding:35px;
    border-radius:15px;
    background:rgba(10,20,40,0.85);
    box-shadow:0 0 30px rgba(0,150,255,0.3);
    animation: fadeSlide 1s ease;
}

/* ANIMATION */
@keyframes fadeSlide{
    from{
        opacity:0;
        transform:translateY(40px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

/* STATUS BAR */
.status{
    background:#00ff9c22;
    color:#00ff9c;
    padding:8px;
    border-radius:8px;
    font-size:12px;
    margin-bottom:20px;
    text-align:center;
}

/* TITLE */
.title{
    font-size:26px;
    margin-bottom:5px;
    font-weight:500;
}

.subtitle{
    font-size:12px;
    color:#aaa;
    margin-bottom:20px;
}

/* INPUT */
.input-box{
    margin-bottom:15px;
}

input{
    width:100%;
    padding:12px;
    border-radius:8px;
    border:1px solid rgba(255,255,255,0.2);
    background:#1a2a40;
    color:white;
}

/* BUTTON */
.btn{
    width:100%;
    padding:14px;
    border:none;
    border-radius:8px;
    background:linear-gradient(90deg,#00c6ff,#0072ff);
    color:white;
    font-weight:bold;
    cursor:pointer;
    margin-top:10px;
    transition:0.3s;
}

.btn:hover{
    box-shadow:0 0 15px #00c6ff;
}

/* SMALL */
.small{
    font-size:11px;
    margin-top:10px;
    color:#aaa;
    display:flex;
    justify-content:space-between;
}

/* ERROR */
.error{
    color:#ff4d4d;
    margin-top:10px;
    text-align:center;
}
</style>

</head>

<body>

<div class="overlay"></div>

<div class="container">

    <!-- 🔥 SYSTEM STATUS -->
    <div class="status">
        ● SYSTEM ONLINE — SECURE CHANNEL ACTIVE
    </div>

    <!-- 🔥 TITLE -->
    <div class="title" id="typing"></div>
    <div class="subtitle">AUTHENTICATION REQUIRED</div>

    <form action="login" method="post">

        <div class="input-box">
            <input type="text" name="username" placeholder="Personnel ID / Username" required>
        </div>

        <div class="input-box">
            <input type="password" name="password" placeholder="Security Passphrase" required>
        </div>

        <button class="btn">AUTHENTICATE</button>

    </form>

    <div class="small">
        <span>End-to-End Encrypted</span>
        <span>Activity Monitored</span>
    </div>

    <%
        String msg = request.getParameter("msg");
        if ("error".equals(msg)) {
    %>
        <div class="error">ACCESS DENIED — INVALID CREDENTIALS</div>
    <%
        }
    %>

</div>

<!-- 🔥 TYPING EFFECT -->
<script>
const text = "AEGIS Secure Login";
let i = 0;

function typeEffect(){
    if(i < text.length){
        document.getElementById("typing").innerHTML += text.charAt(i);
        i++;
        setTimeout(typeEffect, 50);
    }
}
typeEffect();
</script>

</body>
</html>