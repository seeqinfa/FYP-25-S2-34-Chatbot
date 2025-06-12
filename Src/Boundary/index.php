<?php
if (session_status() == PHP_SESSION_NONE) {
    session_start(); // Start session if not already started
}
require_once dirname(__DIR__) . '/config.php';
require_once CONTROLLERS_PATH . '/viewUserProfileController.php';

$ViewUserProfileController = new ViewUserProfileController();
$availableProfiles = $ViewUserProfileController->listProfiles();
?>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>HomePage</title>
	<link rel="stylesheet" href="<?php echo CSS_PATH;?>/style.css">
</head>
<body>

<header>
	<h2 class="logo">LuxFurn</h2>
	<nav class="navigation">
		<a href="#">Home</a>
		<a href="#">About</a>
		<a href="/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/viewFurnitureUI.php">View Furniture</a>
		<?php if (isset($_SESSION['is_logged_in']) && $_SESSION['is_logged_in']): ?>
			<?php if ($_SESSION['role'] === 'admin'): ?>
				<a href="adminDashboard.php">Admin Dashboard</a>
			<?php endif; ?>

			<span style="color:white; margin-left:20px;">Welcome, <?= htmlspecialchars($_SESSION['username']) ?></span>
			<a href="<?php echo CONTROLLERS_URL; ?>/logoutController.php">Logout</a>
		<?php else: ?>
			<button class="btnLogin">Login</button>
		<?php endif; ?>
	</nav>
</header>

<div id="pop-up-message">
    <button onclick="closePopUpMsg()">Close</button>
    <p id="message-content"></p>
</div>

<div class="wrapper">
	<span class="icon-close"><ion-icon name="close"></ion-icon></span>

	<!-- Login Form -->
	<div class="form-box login">
		<h2>Login</h2>
		<form id="login-form" action="<?php echo CONTROLLERS_URL;?>/loginController.php" method="POST">
			<div class="input-box">
				<span class="icon"><ion-icon name="person"></ion-icon></span>
				<input type="text" name="username" required>
				<label>Username</label>
			</div>
			<div class="input-box">
				<span class="icon"><ion-icon name="lock-closed"></ion-icon></span>
				<input type="password" name="password" required>
				<label>Password</label>
			</div>
			<div class="remember-forgot">
				<label><input type="checkbox">Remember me</label>
			</div>
			<button type="submit" name="login" class="btn">Login</button>
			<div class="login-register">
				<p>Don't have an account?<a href="#" class="register-link">Register</a></p>
			</div>
		</form>
	</div>

	<!-- Registration Form -->
	<div class="form-box register">
		<h2>Registration</h2>
		<form id="register-form" action="<?php echo CONTROLLERS_URL;?>/registerController.php" method="POST" onsubmit="return validateRegistrationForm()">
			<div class="input-box">
				<span class="icon"><ion-icon name="person"></ion-icon></span>
				<input type="text" name="username" id="username" required>
				<label>Username</label>
			</div>
			<div class="input-box">
				<span class="icon"><ion-icon name="mail"></ion-icon></span>
				<input type="email" name="email" id="email" required>
				<label>Email</label>
			</div>
			<div class="input-box">
				<span class="icon"><ion-icon name="lock-closed"></ion-icon></span>
				<input type="password" name="password" id="password" required>
				<label>Password</label>
			</div>
			<div class="remember-forgot">
				<label><input type="checkbox" id="terms" required>I agree to the terms & conditions</label>
			</div>
			<button type="submit" name="register" class="btn">Register</button>
			<div class="login-register">
				<p>Already have an account?<a href="#" class="login-link">Login</a></p>
			</div>
		</form>
	</div>
</div>

<?php if (isset($_SESSION['is_logged_in']) && $_SESSION['is_logged_in']): ?>
<link rel="stylesheet" href="<?php echo CSS_PATH;?>/chatbot.css">
<div id="chatbot-popup">
  <div id="chatbot-header" onclick="toggleChatbot()">Chat with us</div>
  <div id="chatbot-body" style="display: none;">
  <div id="chat-messages"></div>
  <form id="chat-form" onsubmit="sendChatMessage(event)">
    <input type="text" id="chat-input" placeholder="Type your message..." required autocomplete="off">
    <button type="submit">Send</button>
  </form>
</div>

</div>
<?php endif; ?>


<script src="<?php echo JAVASCRIPT_PATH;?>/script.js"></script>
<script>
	const CONTROLLERS_URL = "<?php echo CONTROLLERS_URL; ?>";
</script>
<script src="<?php echo JAVASCRIPT_PATH;?>/chatbot.js"></script> 
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<script>
	function closePopUpMsg() {
		document.getElementById('pop-up-message').style.display = 'none';
	}

	<?php if (isset($_SESSION['message']) && $_SESSION['message']) : ?>
		document.getElementById('message-content').textContent = "<?php echo $_SESSION['message']; ?>";
		document.getElementById('pop-up-message').style.display = 'block';
		<?php unset($_SESSION['message']); ?>
	<?php endif; ?>
</script>

</body>
</html>
