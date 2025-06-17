<?php
include '../../header.php';
require_once dirname(__DIR__, 2) . '/Controllers/Customer/viewOrderCtrl.php';

$orderInfo = null;
$error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $controller = new ViewOrderCtrl();
    $result = $controller->getOrderDetails($_POST['order_id']);

    if (isset($result['error'])) {
        $error = $result['error'];
    } else {
        $orderInfo = $result['data'];
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Order</title>
    <link rel="stylesheet" href="../../style.css">
    <style>
        .container {
            max-width: 700px;
            margin: 200px auto;
            background: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
        }
        .form-title {
            text-align: center;
            font-size: 24px;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            font-weight: 500;
        }
        input[type="number"] {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 16px;
        }
        .btn {
            background-color: #e67e22;
            color: white;
            padding: 10px 16px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #cf711f;
        }
        .error {
            color: red;
            text-align: center;
            margin-top: 10px;
        }
        .order-info {
            margin-top: 30px;
            background-color: #fdfdfd;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
        }
        .order-info h3 {
            margin-bottom: 15px;
            color: #333;
        }
        .order-info ul {
            list-style: none;
            padding-left: 0;
        }
        .order-info li {
            margin-bottom: 8px;
            font-size: 15px;
        }
        .order-info strong {
            color: #444;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-title">Track Your Order</div>

        <form method="POST">
            <div class="form-group">
                <label for="order_id">Enter Order Number:</label>
                <input type="number" name="order_id" id="order_id" required>
            </div>
            <button class="btn" type="submit">Search</button>
        </form>

        <?php if ($error): ?>
            <p class="error"><?php echo htmlspecialchars($error); ?></p>
        <?php elseif ($orderInfo): ?>
            <div class="order-info">
                <h3>Order #<?php echo $orderInfo['order_id']; ?></h3>
                <ul>
                    <li><strong>Name:</strong> <?php echo htmlspecialchars($orderInfo['customer_first_name'] . ' ' . $orderInfo['customer_last_name']); ?></li>
                    <li><strong>Email:</strong> <?php echo htmlspecialchars($orderInfo['customer_email']); ?></li>
                    <li><strong>Address:</strong> <?php echo htmlspecialchars($orderInfo['shipping_address'] . ', ' . $orderInfo['shipping_city'] . ', ' . $orderInfo['shipping_state'] . ' ' . $orderInfo['shipping_zip']); ?></li>
                    <li><strong>Status:</strong> <?php echo htmlspecialchars($orderInfo['order_status']); ?></li>
                    <li><strong>Total:</strong> $<?php echo number_format($orderInfo['total_amount'], 2); ?></li>
                    <li><strong>Ordered on:</strong> <?php echo $orderInfo['created_at']; ?></li>
                </ul>
            </div>
        <?php endif; ?>
    </div>
</body>
</html>
