<?php
include '../../header.php';
require_once dirname(__DIR__, 2) . '/Controllers/Admin/AdminSupportTicketsCtrl.php';

// Initialize controller and variables
$controller = new AdminSupportTicketsCtrl();
$error = '';
$success = '';

// Ensure session
if (session_status() !== PHP_SESSION_ACTIVE) {
    session_start();
}

// Use logged-in admin id if available; otherwise reply anonymously
$adminId = $_SESSION['admin_id'] ?? null;


// Generate CSRF token
if (empty($_SESSION['csrf_token'])) {
    $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
}

// Handle form submission
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['response'])) {
    $ticketId = (int)($_POST['ticket_id'] ?? 0);
    $message  = trim($_POST['response'] ?? '');

    try {
        $controller->respondToTicket($ticketId, $adminId, $message);
        $success = "Reply sent.";
    } catch (Throwable $e) {
        $error = $e->getMessage();
    }
}


// Get ticket details if viewing single ticket
$ticket = null;
if (isset($_GET['id'])) {
    $ticket = $controller->getTicketDetails($_GET['id']);
    
    // Get replies for this ticket if available
    if ($ticket) {
        $ticket['replies'] = $controller->getTicketReplies($ticket['id']);
    }
}

// Get all tickets for listing
$tickets = $controller->getAllTickets();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Support Tickets - Admin Panel</title>
    <link rel="stylesheet" href="../../CSS/style.css">
    <style>
        .container {
            margin-top: 140px;
            max-width: 1200px;
            width: 100%;
            padding: 0 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: rgba(255,255,255,0.9);
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #e67e22;
            color: white;
        }
        .status-open {
            color: #e74c3c;
            font-weight: bold;
        }
        .status-responded {
            color: #2ecc71;
            font-weight: bold;
        }
        .status-resolved {
            color: #3498db;
            font-weight: bold;
        }
        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            color: white;
            text-decoration: none;
            display: inline-block;
            margin-right: 5px;
        }
        .btn-respond {
            background-color: #3498db;
        }
        .btn-view {
            background-color: #9b59b6;
        }
        .message {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        .error {
            background-color: #ffebee;
            color: #e74c3c;
            border-left: 4px solid #e74c3c;
        }
        .success {
            background-color: #e8f5e9;
            color: #2ecc71;
            border-left: 4px solid #2ecc71;
        }
        .response-form {
            background: rgba(255,255,255,0.9);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
            margin-top: 20px;
        }
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            resize: vertical;
            min-height: 100px;
            margin-bottom: 5px;
        }
        .reply {
            background-color: #f9f9f9;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 10px;
        }
        .reply-meta {
            color: #666;
            font-size: 0.9em;
            margin-bottom: 5px;
        }
        #charCounter {
            display: block;
            text-align: right;
            color: #666;
            font-size: 0.8em;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Support Tickets</h1>
        
        <?php if (!empty($error)): ?>
            <div class="message error"><?php echo htmlspecialchars($error); ?></div>
        <?php endif; ?>
        
        <?php if (!empty($success)): ?>
            <div class="message success"><?php echo htmlspecialchars($success); ?></div>
        <?php endif; ?>

        <?php if ($ticket): ?>
            <a href="AdminSupportTicketsUI.php" class="btn" style="background-color: #95a5a6;">&larr; Back to Tickets</a>
            
            <div class="response-form">
                <h2>Respond to Ticket #<?php echo htmlspecialchars($ticket['id']); ?></h2>
                <p><strong>Subject:</strong> <?php echo htmlspecialchars($ticket['subject']); ?></p>
                <p><strong>Status:</strong> <span class="status-<?php echo strtolower($ticket['status']); ?>">
                    <?php echo htmlspecialchars(ucfirst($ticket['status'])); ?>
                </span></p>
                <p><strong>Customer Message:</strong></p>
                <div class="reply">
                    <p><?php echo nl2br(htmlspecialchars($ticket['message'])); ?></p>
                </div>
                
                <?php if (!empty($ticket['replies'])): ?>
                    <h3>Previous Responses</h3>
                    <?php foreach ($ticket['replies'] as $reply): ?>
                        <div class="reply">
                            <div class="reply-meta">
                                <strong>Admin #<?php echo htmlspecialchars($reply['admin_id']); ?></strong>
                                <em><?php echo htmlspecialchars($reply['created_at']); ?></em>
                            </div>
                            <p><?php echo nl2br(htmlspecialchars($reply['message'])); ?></p>
                        </div>
                    <?php endforeach; ?>
                <?php endif; ?>
                
                <form method="POST">
                    <input type="hidden" name="csrf_token" value="<?php echo $_SESSION['csrf_token']; ?>">
                    <input type="hidden" name="ticket_id" value="<?php echo (int)$ticket['id']; ?>">
                <div>
                    <label for="response"><strong>Your Response:</strong></label>
                    <textarea name="response" id="response" required oninput="updateCounter()"></textarea>
                    <span id="charCounter">0/1000 characters</span>
                </div>
                    <button type="submit" class="btn btn-respond">Send Response</button>
                </form>

            </div>
        <?php else: ?>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Subject</th>
                        <th>Status</th>
                        <th>Created At</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($tickets as $ticket): ?>
                        <tr>
                            <td><?php echo htmlspecialchars($ticket['id']); ?></td>
                            <td><?php echo htmlspecialchars($ticket['subject']); ?></td>
                            <td class="status-<?php echo strtolower($ticket['status']); ?>">
                                <?php echo htmlspecialchars(ucfirst($ticket['status'])); ?>
                            </td>
                            <td><?php echo htmlspecialchars($ticket['created_at']); ?></td>
                            <td>
                                <a href="AdminSupportTicketsUI.php?id=<?php echo $ticket['id']; ?>" class="btn btn-respond">Respond</a>
                                <a href="AdminSupportTicketsUI.php?id=<?php echo $ticket['id']; ?>" class="btn btn-view">View</a>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        <?php endif; ?>
    </div>

    <script>
    function updateCounter() {
        const textarea = document.getElementById('response');
        const counter = document.getElementById('charCounter');
        const maxLength = 1000;
        const remaining = maxLength - textarea.value.length;
        
        if (remaining < 0) {
            textarea.value = textarea.value.substring(0, maxLength);
            counter.textContent = maxLength + '/' + maxLength + ' characters (limit reached)';
            counter.style.color = 'red';
        } else {
            counter.textContent = textarea.value.length + '/' + maxLength + ' characters';
            counter.style.color = remaining < 100 ? 'orange' : '#666';
        }
    }
    </script>
</body>
</html>