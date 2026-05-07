<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AEGIS Secure System</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>

<style>
*{margin:0;padding:0;box-sizing:border-box}

body{
    font-family:'Segoe UI';
    background:#050a0f;
    color:#00d4ff;
    overflow:hidden;
}

/* GRID */
body::before{
    content:'';
    position:fixed;
    inset:0;
    background-image:
        linear-gradient(rgba(0,168,255,0.04) 1px, transparent 1px),
        linear-gradient(90deg, rgba(0,168,255,0.04) 1px, transparent 1px);
    background-size:40px 40px;
}

/* SCAN LIGHT */
body::after{
    content:'';
    position:fixed;
    top:-100%;
    left:0;
    width:100%;
    height:100%;
    background:linear-gradient(transparent, rgba(0,212,255,0.08), transparent);
    animation:scan 6s linear infinite;
}

@keyframes scan{
    0%{top:-100%}
    100%{top:100%}
}

/* LOADER */
#loader{
    position:fixed;
    width:100%;
    height:100%;
    background:black;
    display:flex;
    justify-content:center;
    align-items:center;
    flex-direction:column;
    z-index:999;
}

.bar{
    width:250px;
    height:4px;
    background:linear-gradient(to right,#00d4ff,transparent);
    animation:load 2s infinite;
}

@keyframes load{
    0%{transform:translateX(-100%)}
    100%{transform:translateX(100%)}
}

/* MAIN */
#main{
    display:none;
    animation:fade 1s ease;
}

@keyframes fade{
    from{opacity:0;transform:scale(0.95)}
    to{opacity:1;transform:scale(1)}
}

/* CENTER */
.container{
    height:100vh;
    display:flex;
    flex-direction:column;
    justify-content:center;
    align-items:center;
}

/* LOGO */
.logo{
    font-size:70px;
    letter-spacing:12px;
    margin-bottom:10px;
    text-shadow:0 0 15px #00d4ff,0 0 60px #00d4ff;
}

/* TYPE */
.typing{
    font-size:14px;
    color:#7aa3cc;
    margin-bottom:30px;
    border-right:2px solid #00d4ff;
    white-space:nowrap;
    overflow:hidden;
}

/* CARD */
.card{
    background:rgba(13,31,60,0.5);
    padding:40px;
    border-radius:14px;
    border:1px solid #1a3a6b;
    backdrop-filter:blur(12px);
    width:360px;
    text-align:center;
    transition:0.4s;
}

.card:hover{
    transform:translateY(-5px);
    box-shadow:0 0 60px rgba(0,168,255,0.7);
}

/* BUTTON */
.btn{
    display:block;
    padding:14px;
    margin-top:20px;
    border-radius:10px;
    text-decoration:none;
    color:white;
    font-weight:bold;
    letter-spacing:2px;
    background:linear-gradient(135deg,#00c6ff,#0072ff);
}

/* STATUS */
.status{
    margin-top:15px;
    color:#00ff88;
    font-size:12px;
}

.dot{
    width:8px;
    height:8px;
    background:#00ff88;
    border-radius:50%;
    display:inline-block;
    margin-right:5px;
    animation:blink 1s infinite;
}

@keyframes blink{
    0%,100%{opacity:1}
    50%{opacity:0.2}
}

/* CANVAS */
canvas{
    position:fixed;
    top:0;
    left:0;
    z-index:-1;
}
</style>
</head>

<body>

<div id="loader">
    <div class="bar"></div>
    <p style="margin-top:10px;">Booting AEGIS System...</p>
</div>

<canvas id="bg"></canvas>

<div id="main">
<div class="container">

    <div class="logo">AEGIS</div>
    <div class="typing" id="typing"></div>

    <div class="card">
        <h3>Command Access Portal</h3>

        <a href="login.jsp" class="btn">
            <i class="fas fa-lock"></i> Enter Secure System
        </a>

        <div class="status">
            <span class="dot"></span> System Online
        </div>
    </div>

</div>
</div>

<script>

/* LOADER */
setTimeout(()=>{
    loader.style.display="none";
    main.style.display="block";
},2000);

/* TYPE */
let txt="Secure Communication & Intelligence System";
let i=0;
function type(){
    if(i<txt.length){
        typing.innerHTML+=txt.charAt(i);
        i++;
        setTimeout(type,30);
    }
}
type();

/* 🚀 ULTRA JET NEURAL BACKGROUND */
const c = document.getElementById("bg");
const ctx = c.getContext("2d");

c.width = window.innerWidth;
c.height = window.innerHeight;

let nodes = [];

for (let i = 0; i < 120; i++) {
    nodes.push({
        x: Math.random() * c.width,
        y: Math.random() * c.height,
        dx: (Math.random() - 0.5) * 1.2,
        dy: (Math.random() - 0.5) * 1.2
    });
}

function drawNeural() {
    ctx.clearRect(0, 0, c.width, c.height);

    for (let i = 0; i < nodes.length; i++) {
        let a = nodes[i];

        ctx.beginPath();
        ctx.arc(a.x, a.y, 2.5, 0, Math.PI * 2);
        ctx.fillStyle = "#00e6ff";
        ctx.shadowBlur = 15;
        ctx.shadowColor = "#00d4ff";
        ctx.fill();

        for (let j = i + 1; j < nodes.length; j++) {
            let b = nodes[j];
            let dist = Math.hypot(a.x - b.x, a.y - b.y);

            if (dist < 140) {
                ctx.beginPath();
                ctx.moveTo(a.x, a.y);
                ctx.lineTo(b.x, b.y);
                ctx.strokeStyle = "rgba(0,212,255," + (1 - dist / 140) + ")";
                ctx.lineWidth = 0.7;
                ctx.stroke();
            }
        }

        a.x += a.dx;
        a.y += a.dy;

        if (a.x < 0 || a.x > c.width) a.dx *= -1;
        if (a.y < 0 || a.y > c.height) a.dy *= -1;
    }

    requestAnimationFrame(drawNeural);
}

drawNeural();

</script>

</body>
</html>