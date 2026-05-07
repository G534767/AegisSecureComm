<%@ page session="true" %>
<%
if (session == null || session.getAttribute("username") == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}

String username = (String) session.getAttribute("username");

response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Soldier Dashboard | AEGIS</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
}

body{
background:#050a0f;
font-family:'Segoe UI';
color:#e0f0ff;
overflow:hidden;
position:relative;
}

/* BACKGROUND GRID */

body::before{
content:'';
position:fixed;
inset:0;
background-image:
linear-gradient(rgba(0,168,255,0.04) 1px, transparent 1px),
linear-gradient(90deg, rgba(0,168,255,0.04) 1px, transparent 1px);
background-size:40px 40px;
z-index:-2;
}

/* SCAN EFFECT */

body::after{
content:'';
position:fixed;
top:-100%;
left:0;
width:100%;
height:100%;
background:linear-gradient(
transparent,
rgba(0,212,255,0.05),
transparent
);
animation:scan 8s linear infinite;
z-index:-1;
pointer-events:none;
}

@keyframes scan{
0%{top:-100%}
100%{top:100%}
}

.wrapper{
display:flex;
height:100vh;
}

/* SIDEBAR */

.sidebar{
width:250px;
background:rgba(6,17,31,0.95);
border-right:1px solid #13395d;
padding:22px;
display:flex;
flex-direction:column;
backdrop-filter:blur(10px);
overflow:auto;
}

.logo{
font-size:42px;
font-weight:800;
letter-spacing:8px;
color:#00d4ff;
margin-bottom:35px;
text-shadow:
0 0 10px #00d4ff,
0 0 30px #00d4ff;
}

.user{
padding:18px;
background:rgba(11,29,49,0.8);
border-radius:16px;
margin-bottom:30px;
border:1px solid rgba(0,168,255,0.3);
box-shadow:0 0 20px rgba(0,168,255,0.15);
}

.user h3{
font-size:24px;
margin-bottom:8px;
}

.role{
font-size:13px;
color:#00ff88;
font-weight:bold;
letter-spacing:1px;
}

/* MENU */

.menu{
display:flex;
flex-direction:column;
gap:12px;
}

.menu a{
display:flex;
align-items:center;
gap:12px;
padding:16px;
border-radius:14px;
text-decoration:none;
color:#8bbce6;
transition:0.35s;
background:rgba(11,29,49,0.75);
border:1px solid transparent;
font-size:18px;
font-weight:500;
position:relative;
overflow:hidden;
z-index:10;
}

.menu a::before{
content:'';
position:absolute;
left:-100%;
top:0;
width:100%;
height:100%;
background:linear-gradient(
90deg,
transparent,
rgba(0,212,255,0.15),
transparent
);
transition:0.5s;
}

.menu a:hover::before{
left:100%;
}

.menu a:hover{
transform:translateX(6px);
background:#102c44;
border:1px solid #00a8ff;
box-shadow:0 0 20px rgba(0,168,255,0.35);
color:white;
}

.menu a i{
width:24px;
text-align:center;
}

/* FIX CLICK ISSUE */

.menu a,
.menu a *{
pointer-events:auto !important;
position:relative;
z-index:999;
}

/* LOGOUT */

.logout{
background:linear-gradient(135deg,#ff3860,#ff1744) !important;
color:white !important;
font-weight:bold;
}

/* MAIN */

.main{
flex:1;
padding:22px;
overflow:auto;
}

/* TOPBAR */

.topbar{
display:flex;
justify-content:space-between;
align-items:center;
margin-bottom:24px;
padding:18px 22px;
background:rgba(8,21,33,0.7);
border:1px solid rgba(0,168,255,0.2);
border-radius:16px;
backdrop-filter:blur(10px);
}

.title{
font-size:34px;
font-weight:800;
letter-spacing:2px;
color:#ffffff;
}

.status{
font-size:14px;
color:#00ff88;
display:flex;
align-items:center;
gap:8px;
}

.status i{
animation:pulse 1s infinite;
}

@keyframes pulse{
0%,100%{opacity:1}
50%{opacity:0.3}
}

/* STATS */

.cards{
display:grid;
grid-template-columns:repeat(3,1fr);
gap:20px;
margin-bottom:24px;
}

.card{
background:rgba(16,44,68,0.75);
border:1px solid rgba(0,168,255,0.2);
padding:22px;
border-radius:18px;
backdrop-filter:blur(12px);
transition:0.35s;
position:relative;
overflow:hidden;
}

.card::before{
content:'';
position:absolute;
top:0;
left:-100%;
width:100%;
height:100%;
background:linear-gradient(
90deg,
transparent,
rgba(255,255,255,0.08),
transparent
);
transition:0.6s;
}

.card:hover::before{
left:100%;
}

.card:hover{
transform:translateY(-6px);
box-shadow:0 0 35px rgba(0,168,255,0.35);
}

.card h2{
font-size:42px;
color:#00d4ff;
margin-bottom:10px;
}

.card p{
font-size:15px;
color:#8bbce6;
}

/* THREAT COLORS */

.threat-low{
border-left:5px solid #00ff88;
}

.threat-high{
border-left:5px solid red;
animation:danger 1.3s infinite;
}

@keyframes danger{
0%,100%{
box-shadow:0 0 8px rgba(255,0,0,0.3);
}
50%{
box-shadow:0 0 25px rgba(255,0,0,0.8);
}
}

/* CONTENT */

.content{
display:grid;
grid-template-columns:1fr 1fr;
gap:22px;
}

/* TERMINAL */

.terminal{
background:#000;
height:340px;
border-radius:18px;
padding:24px;
font-family:Consolas;
overflow:auto;
border:1px solid #00d4ff;
box-shadow:0 0 25px rgba(0,212,255,0.25);
}

.terminal h3{
margin-bottom:18px;
color:#00d4ff;
font-size:18px;
}

.line{
margin:10px 0;
color:#00ff88;
font-size:16px;
animation:flicker 1s infinite alternate;
}

@keyframes flicker{
from{opacity:0.8}
to{opacity:1}
}

/* RADAR */

.radar-box{
display:flex;
justify-content:center;
align-items:center;
background:rgba(8,21,33,0.85);
border-radius:18px;
border:1px solid rgba(0,168,255,0.25);
height:340px;
position:relative;
overflow:hidden;
}

.radar{
width:280px;
height:280px;
border-radius:50%;
border:3px solid rgba(0,255,255,0.4);
position:relative;
overflow:hidden;
box-shadow:0 0 30px rgba(0,255,255,0.15);
}

.radar::before{
content:'';
position:absolute;
width:100%;
height:100%;
background:
radial-gradient(circle,
rgba(0,255,255,0.12),
transparent 70%);
}

.radar::after{
content:'';
position:absolute;
width:50%;
height:3px;
background:#00ffea;
top:50%;
left:50%;
transform-origin:left;
animation:rotate 3s linear infinite;
box-shadow:0 0 20px #00ffea;
}

@keyframes rotate{
from{transform:rotate(0deg)}
to{transform:rotate(360deg)}
}

/* AI PANEL */

.ai{
margin-top:24px;
background:rgba(8,21,33,0.85);
padding:24px;
border-radius:18px;
border:1px solid rgba(0,168,255,0.2);
box-shadow:0 0 20px rgba(0,168,255,0.15);
}

.ai h3{
margin-bottom:18px;
font-size:20px;
color:#00d4ff;
}

.ai-msg p{
margin:14px 0;
color:#00ff88;
font-size:18px;
}

/* SCROLLBAR */

::-webkit-scrollbar{
width:7px;
}

::-webkit-scrollbar-thumb{
background:#00a8ff;
border-radius:10px;
}

</style>
</head>

<body>

<div class="wrapper">

<!-- SIDEBAR -->

<div class="sidebar">

<div class="logo">AEGIS</div>

<div class="user">
<h3><%= username %></h3>
<div class="role">SOLDIER ACCESS</div>
</div>

<div class="menu">

<a href="soldier_dashboard.jsp">
<i class="fas fa-gauge-high"></i>
<span>Dashboard</span>
</a>

<a href="<%= request.getContextPath() %>/sendMessage.jsp">
<i class="fas fa-paper-plane"></i>
<span>Send Message</span>
</a>

<a href="<%= request.getContextPath() %>/Inbox">
<i class="fas fa-inbox"></i>
<span>Inbox</span>
</a>

<a href="<%= request.getContextPath() %>/security_alerts.jsp">
<i class="fas fa-shield-halved"></i>
<span>Security Alerts</span>
</a>

<a href="<%= request.getContextPath() %>/logout"
class="logout">
<i class="fas fa-right-from-bracket"></i>
<span>Logout</span>
</a>

</div>

</div>

<!-- MAIN -->

<div class="main">

<div class="topbar">

<div class="title">
SOLDIER COMMAND CENTER
</div>

<div class="status">
<i class="fas fa-circle"></i>
Secure Connection Active
</div>

</div>

<!-- THREAT CARDS -->

<div class="cards">

<div class="card threat-low">
<h2>LOW</h2>
<p>Threat Level</p>
</div>

<div class="card">
<h2 id="msgCount">12</h2>
<p>Unread Messages</p>
</div>

<div class="card threat-high">
<h2>2</h2>
<p>Suspicious Activities</p>
</div>

</div>

<!-- CONTENT -->

<div class="content">

<!-- TERMINAL -->

<div class="terminal">

<h3>
<i class="fas fa-terminal"></i>
 Live Secure Terminal
</h3>

<div class="line">> Secure connection established...</div>
<div class="line">> Monitoring border surveillance...</div>
<div class="line">> Encryption layer active...</div>
<div class="line">> AI scanning network traffic...</div>
<div class="line">> No malware signatures found...</div>
<div class="line">> Threat detection enabled...</div>
<div class="line">> Secure military node online...</div>

</div>

<!-- RADAR -->

<div class="radar-box">

<div class="radar"></div>

</div>

</div>

<!-- AI ASSISTANT -->

<div class="ai">

<h3>
<i class="fas fa-robot"></i>
 AI Security Assistant
</h3>

<div class="ai-msg">

<p>No active cyber attacks detected.</p>
<p>Military communication encrypted.</p>
<p>Surveillance systems operational.</p>
<p>Firewall integrity stable.</p>
<p>Last threat blocked successfully.</p>

</div>

</div>

</div>

</div>

</body>
</html>