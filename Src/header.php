<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
require_once dirname(__DIR__) . '/src/config.php';
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>LuxFurn</title>

    <!-- External CSS -->
    <link rel="stylesheet" href="<?= CSS_PATH ?>/style.css" />
	<link rel="stylesheet" href="<?= CSS_PATH ?>/chatbot.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <!-- Internal Styles -->
    <style>
        /* General UI */
        .wrapper {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            background: rgba(0, 0, 0, 0.4);
            backdrop-filter: blur(100px);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            transform: scale(0);
            transition: transform 0.3s ease;
        }

        .wrapper.active-popup {
            transform: scale(1);
        }

        .wrapper .form-box {
            width: 400px;
            background: white;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.3);
            position: relative;
        }

        .icon-close {
            position: absolute;
            top: 15px;
            right: 15px;
            width: 30px;
            height: 30px;
            background: black;
            color: white;
            font-size: 1.2rem;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            z-index: 2;
        }

        /* Navigation */
        .nav-dropdown {
            position: relative;
            display: inline-block;
        }

        .nav-link {
            color: white;
            padding: 10px 16px;
            text-decoration: none;
            font-size: 14px;
        }

        .nav-dropdown-content {
            display: none;
            position: absolute;
            background-color: white;
            min-width: 160px;
            right: 0;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            z-index: 1000;
            border-radius: 6px;
        }

        .nav-dropdown-content a {
            color: black;
            padding: 12px 16px;
            display: block;
            text-decoration: none;
            font-size: 14px;
            transition: background-color 0.2s ease;
            margin-left: 0 !important;
        }

        .nav-dropdown-content a:hover {
            background-color: #e67e22;
            color: white;
        }

        .nav-dropdown:hover .nav-dropdown-content {
            display: block;
        }

        /* Logo */
        .logo-img {
            height: 40px;
            width: auto;
        }

        .logo-text {
            margin: 0;
            font-size: 24px;
            font-weight: bold;
        }

        .logo-link {
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
            color: inherit;
        }


    </style>
</head>
<body>

<header>
    <div class="logo-container">
        <a href="/FYP-25-S2-34-Chatbot/Src/Boundary/index.php" class="logo-link">
            <img src="/FYP-25-S2-34-Chatbot/Src/img/logo.png" alt="LuxFurn" class="logo-img" />
            <h2 class="logo-text">LuxFurn</h2>
        </a>
    </div>
    <nav class="navigation">
        <a href="/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/aboutpageUI.php">About</a>
        <a href="/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/viewFurnitureUI.php">View Furniture</a>
        <div class="nav-dropdown">
            <a href="#" class="nav-link">My Orders ▾</a>
            <div class="nav-dropdown-content">
                <a href="/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/viewCart.php">View Cart</a>
                <a href="/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/viewOrderUI.php">View Order</a>
            </div>
        </div>
        <?php if (!empty($_SESSION['is_logged_in'])): ?>
            <?php if ($_SESSION['role'] === 'admin'): ?>
                <a href="../admin/adminDashboardUI.php">Admin Dashboard</a>
            <?php endif; ?>
            <span style="color:white; margin-left:20px;">Welcome, <?= htmlspecialchars($_SESSION['username']) ?></span>
            <a href="<?= CONTROLLERS_URL ?>/logoutController.php">Logout</a>
        <?php else: ?>
            <button class="btnLogin">Login</button>
        <?php endif; ?>
    </nav>
</header>

<!-- Login/Register Modal -->
<div class="wrapper" id="loginWrapper">
    <span class="icon-close" id="closeLogin">&times;</span>

    <!-- Login Form -->
    <div class="form-box login">
        <h2>Login</h2>
        <form action="<?= CONTROLLERS_URL ?>/loginController.php" method="POST">
            <div class="input-box">
                <span class="icon"><ion-icon name="person"></ion-icon></span>
                <input type="text" name="username" required />
                <label>Username</label>
            </div>
            <div class="input-box">
                <span class="icon"><ion-icon name="lock-closed"></ion-icon></span>
                <input type="password" name="password" required />
                <label>Password</label>
            </div>
            <div class="remember-forgot">
                <label><input type="checkbox" /> Remember me</label>
            </div>
            <button type="submit" name="login" class="btn">Login</button>
            <div class="login-register">
                <p>Don't have an account? <a href="#" class="register-link">Register</a></p>
            </div>
        </form>
    </div>

    <!-- Register Form -->
    <div class="form-box register" style="display: none;">
        <h2>Register</h2>
        <form action="<?= CONTROLLERS_URL ?>/registerController.php" method="POST">
            <div class="input-box">
                <span class="icon"><ion-icon name="person"></ion-icon></span>
                <input type="text" name="username" required />
                <label>Username</label>
            </div>
            <div class="input-box">
                <span class="icon"><ion-icon name="mail"></ion-icon></span>
                <input type="email" name="email" required />
                <label>Email</label>
            </div>
            <div class="input-box">
                <span class="icon"><ion-icon name="lock-closed"></ion-icon></span>
                <input type="password" name="password" required />
                <label>Password</label>
            </div>
            <div class="remember-forgot">
                <label><input type="checkbox" required /> I agree to the terms & conditions</label>
            </div>
            <button type="submit" name="register" class="btn">Register</button>
            <div class="login-register">
                <p>Already have an account? <a href="#" class="login-link">Login</a></p>
            </div>
        </form>
    </div>
</div>

<!-- Chatbot (only for logged-in users) -->
<?php if (!empty($_SESSION['is_logged_in'])): ?>
    <div id="chatbot-container">
        <div id="chatbot-header">LuxBot</div>
        <div id="chatbot-body">
            <div id="chat-log"></div>
            <form id="chat-form">
                <input type="text" id="chat-input" placeholder="Ask me something..." autocomplete="off" />
                <button type="submit">Send</button>
            </form>
        </div>
    </div>
<?php endif; ?>

<!-- External Scripts -->
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

<!-- Internal Scripts -->
<script>
document.addEventListener(
		"DOMContentLoaded", () => {const loginBtn = document.querySelector(".btnLogin");
        const wrapper = document.getElementById("loginWrapper");
        const closeBtn = document.getElementById("closeLogin");
        const registerLink = document.querySelector(".register-link");
        const loginLink = document.querySelector(".login-link");
        const loginForm = document.querySelector(".form-box.login");
        const registerForm = document.querySelector(".form-box.register");

        loginBtn?.addEventListener("click", () => {
            document.body.style.overflow = 'hidden';
            wrapper.classList.add("active-popup");
            loginForm.style.display = "block";
            registerForm.style.display = "none";
        });

        closeBtn?.addEventListener("click", () => {
            document.body.style.overflow = '';
            wrapper.classList.remove("active-popup");
        });

        registerLink?.addEventListener("click", (e) => {
            e.preventDefault();
            loginForm.style.display = "none";
            registerForm.style.display = "block";
        });

        loginLink?.addEventListener("click", (e) => {
            e.preventDefault();
            loginForm.style.display = "block";
            registerForm.style.display = "none";
        });

    const form = document.getElementById("chat-form");
    const input = document.getElementById("chat-input");
    const log   = document.getElementById("chat-log");
    if (!form || !input || !log) return;   // pages without chatbot

    /* ───── 1.  LOAD SAVED HISTORY ───── */
    fetch("/FYP-25-S2-34-Chatbot/Src/Controllers/chatHistoryController.php")
        .then(r => r.json())
        .then(history => {
            history.forEach(row => {
                const who   = row.sender === "user" ? "You"    : "LuxBot";
                const clazz = row.sender === "user" ? "user-message" : "bot-message";
                const div   = document.createElement("div");
                div.className = `chat-message ${clazz}`;
                div.innerHTML = `<strong>${who}:</strong> ${row.message_text}`;
                log.appendChild(div);
            });
            log.scrollTop = log.scrollHeight;
        })
        .catch(err => console.error("history error:", err));

    /* ───── 2.  SEND NEW MESSAGE ───── */
    form.addEventListener("submit", async e => {
        e.preventDefault();
        const msg = input.value.trim();
        if (!msg) return;

        // show user bubble immediately
        log.innerHTML += `<div class="chat-message user-message"><strong>You:</strong> ${msg}</div>`;
        input.value = "";

        const res  = await fetch("/FYP-25-S2-34-Chatbot/Src/Controllers/chatbotController.php", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: "message=" + encodeURIComponent(msg)
        });
        const data = await res.json();

        // show bot bubble
        log.innerHTML += `<div class="chat-message bot-message"><strong>LuxBot:</strong> ${data.response}</div>`;
        log.scrollTop = log.scrollHeight;
    });
});
</script>
