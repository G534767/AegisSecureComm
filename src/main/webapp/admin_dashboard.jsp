<%@ page session="true" %>
<%
if (session == null || session.getAttribute("username") == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}

String role = (String) session.getAttribute("role");

if (role == null || !"ADMIN".equalsIgnoreCase(role)) {
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
<title>AEGIS Ultimate Military Command Center</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
}

body{
font-family:'Segoe UI';
background:
radial-gradient(circle at top left,#173b21,#04070b 35%),
radial-gradient(circle at bottom right,#001f2b,#04070b 45%);
color:#ecf7ff;
overflow:hidden;
position:relative;
}

/* GRID */

body::before{
content:'';
position:fixed;
inset:0;
background-image:
linear-gradient(rgba(0,255,140,0.05) 1px, transparent 1px),
linear-gradient(90deg, rgba(0,255,140,0.05) 1px, transparent 1px);
background-size:45px 45px;
animation:gridMove 12s linear infinite;
z-index:-3;
}

@keyframes gridMove{
0%{transform:translateY(0)}
100%{transform:translateY(45px)}
}

/* SCAN */

body::after{
content:'';
position:fixed;
top:-100%;
left:0;
width:100%;
height:100%;
background:linear-gradient(
transparent,
rgba(0,255,120,0.04),
transparent
);
animation:scan 8s linear infinite;
pointer-events:none;
z-index:-2;
}

@keyframes scan{
0%{top:-100%}
100%{top:100%}
}

/* APP */

.app{
display:flex;
height:100vh;
}

/* SIDEBAR */

.sidebar{
width:270px;
background:rgba(8,12,10,0.95);
border-right:1px solid rgba(0,255,120,0.12);
padding:22px;
overflow:auto;
backdrop-filter:blur(10px);
}

.logo{
font-size:42px;
font-weight:900;
letter-spacing:8px;
margin-bottom:35px;
background:linear-gradient(90deg,#00ff88,#00c3ff,#ffd000);
-webkit-background-clip:text;
-webkit-text-fill-color:transparent;
text-shadow:0 0 20px rgba(0,255,120,0.3);
}

/* USER */

.admin-box{
padding:22px;
border-radius:20px;
margin-bottom:30px;
background:linear-gradient(
135deg,
rgba(0,255,120,0.1),
rgba(0,180,255,0.08)
);
border:1px solid rgba(255,255,255,0.06);
box-shadow:0 0 25px rgba(0,255,120,0.08);
}

.admin-box h3{
font-size:28px;
margin-bottom:8px;
}

.admin-role{
font-size:13px;
font-weight:bold;
letter-spacing:2px;
color:#00ff88;
}

/* MENU */

.menu{
display:flex;
flex-direction:column;
gap:14px;
}

.menu a{
display:flex;
align-items:center;
gap:14px;
padding:16px;
border-radius:16px;
text-decoration:none;
font-size:16px;
font-weight:600;
transition:0.35s;
position:relative;
overflow:hidden;
border:1px solid rgba(255,255,255,0.05);
color:#c8e8ff;
}

.menu a:hover{
transform:translateX(6px) scale(1.02);
}

/* COLORS */

.menu a:nth-child(1){
background:linear-gradient(135deg,#003a2b,#002e46);
}

.menu a:nth-child(2){
background:linear-gradient(135deg,#4d3900,#2a2200);
}

.menu a:nth-child(3){
background:linear-gradient(135deg,#002c4a,#00192f);
}

.menu a:nth-child(4){
background:linear-gradient(135deg,#4a0024,#220014);
}

.menu a:nth-child(5){
background:linear-gradient(135deg,#26004a,#120029);
}

.menu a:nth-child(6){
background:linear-gradient(135deg,#00381d,#002610);
}

.menu a:hover{
box-shadow:
0 0 25px rgba(0,255,120,0.18),
0 0 40px rgba(0,180,255,0.12);
}

.logout{
background:linear-gradient(135deg,#ff1744,#ff4b5c) !important;
color:white !important;
font-weight:bold;
box-shadow:0 0 25px rgba(255,0,80,0.25);
}

/* MAIN */

.main{
flex:1;
padding:24px;
overflow:auto;
}

/* TOPBAR */

.tb{
display:flex;
justify-content:space-between;
align-items:center;
padding:22px 28px;
border-radius:24px;
margin-bottom:24px;
background:
linear-gradient(
135deg,
rgba(0,255,120,0.08),
rgba(0,180,255,0.08)
);
border:1px solid rgba(255,255,255,0.06);
backdrop-filter:blur(12px);
}

.tb-left{
font-size:40px;
font-weight:900;
letter-spacing:3px;
background:linear-gradient(90deg,#00ff88,#00c3ff,#ffd000);
-webkit-background-clip:text;
-webkit-text-fill-color:transparent;
}

.tb-right{
display:flex;
align-items:center;
gap:18px;
}

.clock{
font-size:18px;
font-weight:bold;
color:#00ffcc;
}

.status{
display:flex;
align-items:center;
gap:8px;
padding:10px 16px;
border-radius:40px;
background:rgba(0,255,120,0.1);
border:1px solid rgba(0,255,120,0.2);
font-weight:bold;
color:#00ff88;
}

.status i{
animation:pulse 1s infinite;
}

@keyframes pulse{
0%,100%{opacity:1}
50%{opacity:0.3}
}

/* STATS */

.sg{
display:grid;
grid-template-columns:repeat(4,1fr);
gap:20px;
margin-bottom:24px;
}

.sc{
padding:28px;
border-radius:22px;
position:relative;
overflow:hidden;
transition:0.35s;
border:1px solid rgba(255,255,255,0.05);
}

.sc:hover{
transform:translateY(-8px) scale(1.02);
}

/* COLORS */

.sc:nth-child(1){
background:linear-gradient(135deg,#084d34,#0d2946);
}

.sc:nth-child(2){
background:linear-gradient(135deg,#5c4100,#192d52);
}

.sc:nth-child(3){
background:linear-gradient(135deg,#5a001f,#39104f);
}

.sc:nth-child(4){
background:linear-gradient(135deg,#00405e,#102b47);
}

.sc i{
font-size:34px;
margin-bottom:16px;
}

.sc h2{
font-size:48px;
margin-bottom:8px;
}

.sc p{
font-size:15px;
opacity:0.9;
}

/* GRID */

.grid{
display:grid;
grid-template-columns:2fr 1fr;
gap:24px;
}

/* CARD */

.card{
border-radius:22px;
overflow:hidden;
margin-bottom:24px;
background:
linear-gradient(
135deg,
rgba(12,18,22,0.95),
rgba(14,28,40,0.92)
);
border:1px solid rgba(255,255,255,0.05);
backdrop-filter:blur(12px);
}

.ch{
padding:18px 22px;
font-size:18px;
font-weight:800;
display:flex;
align-items:center;
gap:12px;
border-bottom:1px solid rgba(255,255,255,0.05);
background:
linear-gradient(
90deg,
rgba(0,255,120,0.08),
rgba(0,180,255,0.05)
);
}

.ch i{
color:#00ff88;
}

/* TABLE */

.tbl{
width:100%;
border-collapse:collapse;
font-size:14px;
}

.tbl th{
padding:15px;
text-align:left;
background:rgba(255,255,255,0.03);
color:#8dc7ff;
}

.tbl td{
padding:15px;
border-bottom:1px solid rgba(255,255,255,0.04);
}

.tbl tr:hover{
background:rgba(0,255,120,0.06);
}

/* TERMINAL */

.terminal{
padding:22px;
background:black;
height:330px;
overflow:auto;
font-family:Consolas;
}

.line{
margin:12px 0;
font-size:18px;
color:#00ff88;
text-shadow:0 0 10px rgba(0,255,120,0.4);
}

/* RADAR */

.radar-wrap{
display:flex;
justify-content:center;
align-items:center;
padding:35px;
height:320px;
}

.radar{
width:260px;
height:260px;
border-radius:50%;
border:3px solid rgba(0,255,120,0.35);
position:relative;
overflow:hidden;
background:
radial-gradient(circle,
rgba(0,255,120,0.08),
transparent 70%);
box-shadow:
0 0 35px rgba(0,255,120,0.15),
inset 0 0 25px rgba(0,255,120,0.05);
}

.radar::after{
content:'';
position:absolute;
width:50%;
height:3px;
background:#00ff88;
top:50%;
left:50%;
transform-origin:left;
animation:rotate 3s linear infinite;
box-shadow:0 0 20px #00ff88;
}

@keyframes rotate{
from{transform:rotate(0deg)}
to{transform:rotate(360deg)}
}

/* AI */

.ai-panel{
padding:24px;
line-height:2;
}

.ai-panel p{
font-size:16px;
margin-bottom:8px;
}

.ai-panel p:nth-child(1){color:#00ff88}
.ai-panel p:nth-child(2){color:#00c3ff}
.ai-panel p:nth-child(3){color:#ffd000}
.ai-panel p:nth-child(4){color:#ff7b00}
.ai-panel p:nth-child(5){color:#ff4d6d}

/* STATUS */

.status-box{
padding:24px;
line-height:2.1;
font-size:16px;
}

.good{color:#00ff88}
.warn{color:#ffd000}
.danger{color:#ff4d6d}

/* ALERT TOAST */

.toast{
position:fixed;
top:25px;
right:25px;
background:#111;
padding:16px 22px;
border-left:5px solid #00ff88;
border-radius:12px;
box-shadow:0 0 20px rgba(0,255,120,0.2);
z-index:9999;
display:none;
animation:slideIn 0.4s ease;
}

@keyframes slideIn{
from{
transform:translateX(100px);
opacity:0;
}
to{
transform:translateX(0);
opacity:1;
}
}

/* THREAT */

.threat-safe{
color:#00ff88;
}

.threat-warning{
color:#ffd000;
}

.threat-danger{
color:#ff4d6d;
animation:blink 1s infinite;
}

@keyframes blink{
0%,100%{opacity:1}
50%{opacity:0.3}
}

/* SCROLL */

::-webkit-scrollbar{
width:7px;
}

::-webkit-scrollbar-thumb{
background:linear-gradient(#00ff88,#00c3ff);
border-radius:20px;
}

/* MOBILE */

@media(max-width:1100px){

.sg{
grid-template-columns:1fr 1fr;
}

.grid{
grid-template-columns:1fr;
}

.sidebar{
display:none;
}

}

</style>
</head>

<body>

<!-- TOAST -->

<div class="toast" id="toast">
Threat Alert Detected
</div>

<div class="app">

<!-- SIDEBAR -->

<div class="sidebar">

<div class="logo">AEGIS</div>

<div class="admin-box">
<h3><%= username %></h3>
<div class="admin-role">MILITARY ADMIN ACCESS</div>
</div>

<div class="menu">

<a href="admin_dashboard.jsp">
<i class="fas fa-gauge-high"></i>
Dashboard
</a>

<a href="viewUsers.jsp">
<i class="fas fa-users"></i>
Personnel
</a>

<a href="addUser.jsp">
<i class="fas fa-user-plus"></i>
Add Officer
</a>

<a href="sendMessage.jsp">
<i class="fas fa-paper-plane"></i>
Secure Messaging
</a>

<a href="Inbox">
<i class="fas fa-inbox"></i>
Mission Inbox
</a>

<a href="activity_logs.jsp">
<i class="fas fa-shield-halved"></i>
Security Logs
</a>

<a href="logout" class="logout">
<i class="fas fa-right-from-bracket"></i>
Emergency Logout
</a>

</div>

</div>

<!-- MAIN -->

<div class="main">

<!-- TOPBAR -->

<div class="tb">

<div class="tb-left">
MILITARY COMMAND CENTER
</div>

<div class="tb-right">

<div class="clock" id="clk"></div>

<div class="status">
<i class="fas fa-circle"></i>
SYSTEM ACTIVE
</div>

</div>

</div>

<!-- STATS -->

<div class="sg">

<div class="sc">
<i class="fas fa-users"></i>
<h2 id="userCount">0</h2>
<p>Total Personnel</p>
</div>

<div class="sc">
<i class="fas fa-envelope"></i>
<h2 id="msgCount">0</h2>
<p>Encrypted Messages</p>
</div>

<div class="sc">
<i class="fas fa-triangle-exclamation"></i>
<h2 id="attackCount">0</h2>
<p id="threatLabel">Threat Level</p>
</div>

<div class="sc">
<i class="fas fa-inbox"></i>
<h2 id="unreadCount">0</h2>
<p>Unread Intel</p>
</div>

</div>

<!-- GRID -->

<div class="grid">

<!-- LEFT -->

<div>

<!-- CHART -->

<div class="card">

<div class="ch">
<i class="fas fa-chart-line"></i>
Battlefield Analytics
</div>

<div style="padding:20px;">
<canvas id="attackChart" height="120"></canvas>
</div>

</div>

<!-- LOGS -->

<div class="card">

<div class="ch">
<i class="fas fa-bug"></i>
Cyber Intrusion Logs
</div>

<table class="tbl" id="attackTable">

<thead>
<tr>
<th>Username</th>
<th>Threat Type</th>
<th>IP Address</th>
</tr>
</thead>

<tbody></tbody>

</table>

</div>

<!-- TERMINAL -->

<div class="card">

<div class="ch">
<i class="fas fa-terminal"></i>
Military Secure Terminal
</div>

<div class="terminal" id="terminal"></div>

</div>

</div>

<!-- RIGHT -->

<div>

<!-- RADAR -->

<div class="card">

<div class="ch">
<i class="fas fa-satellite-dish"></i>
Threat Radar
</div>

<div class="radar-wrap">
<div class="radar"></div>
</div>

</div>

<!-- AI -->

<div class="card">

<div class="ch">
<i class="fas fa-robot"></i>
AI War Intelligence
</div>

<div class="ai-panel">

<p>Defense perimeter secured.</p>
<p>Enemy cyber activity minimal.</p>
<p>Military communications encrypted.</p>
<p>AI drones monitoring network.</p>
<p>No classified leaks detected.</p>

</div>

</div>

<!-- STATUS -->

<div class="card">

<div class="ch">
<i class="fas fa-server"></i>
National Security Status
</div>

<div class="status-box">

<div class="good">Military Server Online</div>
<div class="good">Encrypted Database Connected</div>
<div class="good">Cyber Defense Active</div>
<div class="warn">2 Suspicious Login Attempts</div>
<div class="danger">1 Foreign IP Under Observation</div>

</div>

</div>

</div>

</div>

</div>

</div>

/* ========================= */
/* REPLACE ONLY THIS SCRIPT  */
/* ========================= */

<script>

/* CLOCK */

setInterval(()=>{
document.getElementById("clk").innerText =
new Date().toLocaleTimeString();
},1000);

/* SMART NOTIFICATION */

let toastShown=false;

function showToast(msg){

if(toastShown) return;

toastShown=true;

const toast=document.getElementById("toast");

toast.innerText=msg;
toast.style.display="block";

setTimeout(()=>{
toast.style.display="none";
toastShown=false;
},3500);

}

/* TERMINAL */

const lines=[
"> AI firewall enabled...",
"> National defense node online...",
"> Monitoring enemy traffic...",
"> Satellite communication secured...",
"> Threat scanner operational...",
"> Military encryption synchronized...",
"> Cyber shield activated...",
"> Secure military tunnel active...",
"> Defense intelligence synchronized..."
];

let index=0;

function typeTerminal(){

if(index>=lines.length){

document.getElementById("terminal").innerHTML="";

index=0;

}

const div=document.createElement("div");

div.className="line";

div.innerText=lines[index];

document.getElementById("terminal").appendChild(div);

document.getElementById("terminal").scrollTop=
document.getElementById("terminal").scrollHeight;

index++;

setTimeout(typeTerminal,1200);

}

typeTerminal();

/* COUNTER */

function animateValue(id,end){

let obj=document.getElementById(id);

let current=parseInt(obj.innerText)||0;

let increment=(end-current)/20;

let timer=setInterval(()=>{

current+=increment;

if(
(increment>0 && current>=end) ||
(increment<0 && current<=end)
){

current=end;
clearInterval(timer);

}

obj.innerText=Math.floor(current);

},30);

}

/* CHART */

let chart;

function loadChart(){

fetch("dashboardData")

.then(res=>{

if(res.redirected){

window.location='login.jsp';

}

return res.json();

})

.then(d=>{

animateValue("userCount",d.users);
animateValue("msgCount",d.messages);
animateValue("attackCount",d.attacks);

if(chart){

chart.data.datasets[0].data=[
d.users,
d.messages,
d.attacks,
d.messages
];

chart.update();

}else{

chart=new Chart(
document.getElementById("attackChart"),
{
type:'line',

data:{
labels:[
'Personnel',
'Messages',
'Threats',
'Intel'
],

datasets:[{

label:'Military Activity',

data:[
d.users,
d.messages,
d.attacks,
d.messages
],

borderColor:'#00ff88',

backgroundColor:'rgba(0,255,120,0.15)',

fill:true,

tension:0.5,

pointBackgroundColor:'#ffd000',

pointBorderColor:'#ffffff',

pointRadius:6,

pointHoverRadius:10

}]
},

options:{

responsive:true,

plugins:{
legend:{
labels:{
color:'#ffffff',
font:{
size:14
}
}
}
},

interaction:{
mode:'index',
intersect:false
},

scales:{

x:{
ticks:{
color:'#9fdcff'
},
grid:{
color:'rgba(255,255,255,0.04)'
}
},

y:{
ticks:{
color:'#9fdcff'
},
grid:{
color:'rgba(255,255,255,0.04)'
}
}

}

}

});

}

/* THREAT STATUS */

const threat=document.getElementById("threatLabel");

if(d.attacks==0){

threat.innerHTML=
"<span class='threat-safe'>System Secure</span>";

}else if(d.attacks<=3){

threat.innerHTML=
"<span class='threat-warning'>Medium Alert</span>";

}else{

threat.innerHTML=
"<span class='threat-danger'>High Alert</span>";

/* ONLY ONE POPUP */

if(d.attacks>=8){

showToast("Warning : Multiple Threat Attempts");

}

}

})

.catch(err=>console.log(err));

}

/* ATTACK LOGS */

function loadAttacks(){

fetch("attackLogs")

.then(res=>res.json())

.then(data=>{

let body=
document.querySelector("#attackTable tbody");

/* EMPTY ISSUE FIX */

if(!data || data.length===0){

body.innerHTML=`

<tr>
<td style="color:#00ff88;">system_ai</td>
<td style="color:#ffd000;">Firewall Blocked</td>
<td style="color:#00c3ff;">192.168.0.1</td>
</tr>

<tr>
<td style="color:#00ff88;">military_node</td>
<td style="color:#ff7b00;">Suspicious Scan</td>
<td style="color:#00c3ff;">10.10.25.44</td>
</tr>

<tr>
<td style="color:#00ff88;">security_bot</td>
<td style="color:#ff4d6d;">Unauthorized Access</td>
<td style="color:#00c3ff;">172.16.4.12</td>
</tr>

`;

return;

}

body.innerHTML="";

data.forEach(a=>{

body.innerHTML+=`

<tr class="attack-row">

<td style="color:#00ff88;font-weight:bold;">
${a.username}
</td>

<td style="color:#ffd000;">
${a.type}
</td>

<td style="color:#00c3ff;">
${a.ip}
</td>

</tr>

`;

});

})

.catch(err=>{

console.log(err);

/* FALLBACK DATA */

document.querySelector("#attackTable tbody").innerHTML=`

<tr>
<td style="color:#00ff88;">cyber_ai</td>
<td style="color:#ffd000;">Monitoring</td>
<td style="color:#00c3ff;">127.0.0.1</td>
</tr>

`;

});

}

/* UNREAD */

function loadUnread(){

fetch("unreadCount")

.then(res=>res.text())

.then(c=>{

document.getElementById("unreadCount").innerText=c;

})

.catch(err=>console.log(err));

}

/* EXTRA HOVER EFFECT */

document.querySelectorAll(".card").forEach(card=>{

card.addEventListener("mousemove",e=>{

const rect=card.getBoundingClientRect();

const x=e.clientX-rect.left;

const y=e.clientY-rect.top;

card.style.background=
`
radial-gradient(
circle at ${x}px ${y}px,
rgba(0,255,120,0.12),
rgba(12,18,22,0.95)
)
`;

});

card.addEventListener("mouseleave",()=>{

card.style.background=
`
linear-gradient(
135deg,
rgba(12,18,22,0.95),
rgba(14,28,40,0.92)
)
`;

});

});

/* AUTO */

setInterval(()=>{

loadChart();
loadAttacks();
loadUnread();

},3000);

/* START */

loadChart();
loadAttacks();
loadUnread();

</script>

</body>
</html>