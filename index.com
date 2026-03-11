<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>For Zaki ❤️</title>
    <style>
        /* Pastel Theme & Base */
        body {
            margin: 0;
            overflow: hidden;
            background: linear-gradient(135deg, #ffd1dc, #bde0fe);
            font-family: 'Comic Sans MS', 'Arial Rounded MT Bold', sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            color: #ff6b81;
            text-align: center;
            user-select: none;
        }

        /* Glowing Heart Container */
        .main-container {
            position: relative;
            z-index: 10;
            background: rgba(255, 255, 255, 0.4);
            padding: 40px;
            border-radius: 30px;
            box-shadow: 0 0 40px rgba(255, 107, 129, 0.6);
            backdrop-filter: blur(10px);
            max-width: 80%;
        }

        /* Typewriter Text */
        #message {
            font-size: 26px;
            min-height: 120px;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(255, 255, 255, 0.8);
            line-height: 1.5;
        }

        /* Waving Teddy */
        .teddy {
            font-size: 60px;
            display: inline-block;
            animation: wave 2s infinite;
            cursor: pointer;
            margin-bottom: 10px;
        }
        @keyframes wave {
            0%, 100% { transform: rotate(0deg); }
            25% { transform: rotate(-20deg); }
            75% { transform: rotate(20deg); }
        }

        /* Buttons */
        .btn-group {
            margin-top: 20px;
            display: flex;
            gap: 15px;
            justify-content: center;
        }
        button {
            background: #ffb6c1;
            border: none;
            padding: 12px 24px;
            border-radius: 20px;
            font-size: 16px;
            font-weight: bold;
            color: white;
            cursor: pointer;
            box-shadow: 0 4px 10px rgba(255, 107, 129, 0.3);
            transition: transform 0.2s, background 0.2s;
        }
        button:hover {
            transform: scale(1.1);
            background: #ff9fb0;
        }
        #moodFix { background: #a2d2ff; }
        #moodFix:hover { background: #8ec5fc; }

        /* Cursor Trail & Floating Items */
        .trail, .float-item {
            position: absolute;
            pointer-events: none;
            z-index: 9999;
            animation: fadeOut 1s linear forwards;
        }
        @keyframes fadeOut {
            0% { opacity: 1; transform: scale(1) translateY(0); }
            100% { opacity: 0; transform: scale(0.5) translateY(-20px); }
        }

        /* Animations for Background Elements */
        .rain, .bubble {
            position: absolute;
            pointer-events: none;
            z-index: 1;
        }
        .rain {
            animation: fall linear infinite;
            font-size: 24px;
        }
        @keyframes fall {
            to { transform: translateY(100vh) rotate(360deg); }
        }
        .bubble {
            background: rgba(255, 255, 255, 0.8);
            padding: 10px 20px;
            border-radius: 20px;
            color: #ff6b81;
            font-size: 16px;
            font-weight: bold;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            animation: floatUp linear infinite;
        }
        @keyframes floatUp {
            to { transform: translateY(-100vh); opacity: 0; }
        }

        /* Love Letter Popup */
        #popup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(255, 107, 129, 0.4);
            z-index: 100;
            border: 4px dashed #ffb6c1;
            max-width: 400px;
        }
        #popup h2 { margin-top: 0; color: #ff6b81; }
        .close-btn {
            background: #ff6b81;
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <div class="main-container">
        <div class="teddy" onclick="giveHug()">🧸</div>
        <div id="message"></div>
        
        <div class="btn-group">
            <button id="moodFix" onclick="fixMood()">🌈 Mood Fix</button>
            <button onclick="openLetter()">🎁 Secret Surprise</button>
        </div>
    </div>

    <div id="popup">
        <h2>💌 My Dearest Zaki,</h2>
        <p>I hate seeing you sad. Remember how amazing and capable you are.</p>
        <p>I'm sending you the biggest, tightest virtual hug right now! Everything will be okay. 💖</p>
        <button class="close-btn" onclick="closeLetter()">Close Letter</button>
    </div>

    <script>
        // Typewriter Effect
        const textToType = "Hey my love...\n\nI love you Zaki. I am there for you and I am super proud of you. ❤️";
        const messageEl = document.getElementById('message');
        let index = 0;

        function typeWriter() {
            if (index < textToType.length) {
                if (textToType.charAt(index) === '\n') {
                    messageEl.innerHTML += '<br>';
                } else {
                    messageEl.innerHTML += textToType.charAt(index);
                }
                index++;
                setTimeout(typeWriter, 70); // Typing speed
            }
        }

        // Heart Explosion on Load
        window.onload = () => {
            setTimeout(typeWriter, 600);
            createExplosion(window.innerWidth / 2, window.innerHeight / 2, 40);
            startBackgroundEffects();
        };

        // Cursor Heart Trail
        document.addEventListener('mousemove', (e) => {
            if (Math.random() > 0.6) { // Controls trail density
                const heart = document.createElement('div');
                heart.innerText = '💗';
                heart.className = 'trail';
                heart.style.left = (e.pageX - 10) + 'px';
                heart.style.top = (e.pageY - 10) + 'px';
                document.body.appendChild(heart);
                setTimeout(() => heart.remove(), 800);
            }
        });

        // Background Particles & Stickers
        const stickers = ['🧸', '✨', '☁️', '🌈', '🎁', '💖', '💗', '💌'];
        const comfortMessages = ["You're doing great", "I'm here for you", "Take a deep breath", "You are so loved", "Sending hugs"];

        function startBackgroundEffects() {
            setInterval(createRain, 400); // Sticker rain
            setInterval(createBubble, 3000); // Comforting clouds
        }

        function createRain() {
            const drop = document.createElement('div');
            drop.innerText = stickers[Math.floor(Math.random() * stickers.length)];
            drop.className = 'rain';
            drop.style.left = Math.random() * window.innerWidth + 'px';
            drop.style.top = '-50px';
            drop.style.animationDuration = Math.random() * 4 + 3 + 's';
            document.body.appendChild(drop);
            setTimeout(() => drop.remove(), 7000);
        }

        function createBubble() {
            const bubble = document.createElement('div');
            bubble.innerText = '☁️ ' + comfortMessages[Math.floor(Math.random() * comfortMessages.length)];
            bubble.className = 'bubble';
            bubble.style.left = Math.random() * (window.innerWidth - 200) + 'px';
            bubble.style.top = window.innerHeight + 50 + 'px';
            bubble.style.animationDuration = Math.random() * 5 + 6 + 's';
            document.body.appendChild(bubble);
            setTimeout(() => bubble.remove(), 11000);
        }

        // Interactions
        function fixMood() {
            // Shoots sparkles and rainbows everywhere
            for(let i=0; i<40; i++) {
                setTimeout(() => {
                    createParticle(Math.random() * window.innerWidth, window.innerHeight, true, '✨');
                    createParticle(Math.random() * window.innerWidth, 0, true, '🌈');
                }, i * 30);
            }
        }

        function giveHug() {
            const teddy = document.querySelector('.teddy');
            teddy.style.transform = 'scale(1.4)';
            setTimeout(() => teddy.style.transform = 'scale(1)', 300);
            
            // Get teddy position for the explosion
            const rect = teddy.getBoundingClientRect();
            createExplosion(rect.left + rect.width / 2, rect.top + rect.height / 2, 20);
        }

        function openLetter() {
            document.getElementById('popup').style.display = 'block';
            createExplosion(window.innerWidth / 2, window.innerHeight / 2, 30);
        }

        function closeLetter() {
            document.getElementById('popup').style.display = 'none';
        }

        function createExplosion(x, y, amount) {
            for(let i=0; i<amount; i++) {
                createParticle(x, y, true, '💗');
            }
        }

        function createParticle(x, y, isExplosion = false, char = '💗') {
            const p = document.createElement('div');
            p.innerText = char;
            p.className = 'trail';
            p.style.left = x + 'px';
            p.style.top = y + 'px';
            p.style.fontSize = '24px';
            
            if (isExplosion) {
                const angle = Math.random() * Math.PI * 2;
                const velocity = 30 + Math.random() * 150;
                p.style.transform = `translate(${Math.cos(angle) * velocity}px, ${Math.sin(angle) * velocity}px)`;
                p.style.transition = 'transform 1s ease-out, opacity 1s ease-in';
                
                // Trigger reflow to ensure transition happens
                p.getBoundingClientRect();
                
                setTimeout(() => p.style.opacity = '0', 50);
            }
            
            document.body.appendChild(p);
            setTimeout(() => p.remove(), 1000);
        }
    </script>
</body>
</html>
