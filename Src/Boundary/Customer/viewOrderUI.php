<?php
include '../../header.php';
require_once dirname(__DIR__, 2) . '/Controllers/Customer/viewOrderCtrl.php';

$orderInfo  = null;
$alert      = '';     // shows success or error for both actions
$alertClass = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $controller = new ViewOrderCtrl();

    /* ---------- 1. CANCEL ORDER ---------- */
    if (isset($_POST['cancel_order'])) {              // NEW
        $result = $controller->cancelOrder($_POST['order_id']);

        if (isset($result['error'])) {
            $alert      = $result['error'];
            $alertClass = 'error';
        } else {
            // refresh order details so UI shows the updated status
            $orderInfo  = $controller->getOrderDetails($_POST['order_id'])['data'] ?? null;
            $alert      = 'Order cancelled successfully.';
            $alertClass = 'success';
        }

    /* ---------- 2. SEARCH ORDER ---------- */
    } else {
        $result = $controller->getOrderDetails($_POST['order_id']);

        if (isset($result['error'])) {
            $alert      = $result['error'];
            $alertClass = 'error';
        } else {
            $orderInfo = $result['data'];
        }
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
        .container   { max-width: 700px; margin: 100px auto; background: rgba(255,255,255,0.9); padding: 30px;
                       border-radius: 10px; box-shadow: 0 8px 24px rgba(0,0,0,0.15); }
        .form-title  { text-align: center; font-size: 24px; margin-bottom: 20px; }
        .form-group  { margin-bottom: 15px; }
        label        { font-weight: 500; }
        input[type="number"] { width: 100%; padding: 10px; border-radius: 6px; border: 1px solid #ccc; font-size: 16px; }
        .btn         { background-color: #e67e22; color: #fff; padding: 10px 16px; border: none; border-radius: 6px; font-size: 16px; cursor: pointer; }
        .btn:hover   { background-color: #cf711f; }
        .btn.cancel  { background-color: #d9534f; }           /* NEW – red cancel button */
        .btn.cancel:hover { background-color: #c9302c; }      /* NEW */
        .alert       { text-align: center; margin-top: 15px; font-size: 15px; }
        .alert.error { color: #b00020; }
        .alert.success { color: #2e7d32; }
        .order-info  { margin-top: 30px; background-color: #fdfdfd; border: 1px solid #ddd; border-radius: 8px; padding: 20px; }
        .order-info h3 { margin-bottom: 15px; color: #333; }
        .order-info ul { list-style: none; padding-left: 0; }
        .order-info li { margin-bottom: 8px; font-size: 15px; }
        .order-info strong { color: #444; }
    </style>
</head>
<body>
<div class="container">
    <div class="form-title">Track Your Order</div>

    <!-- SEARCH FORM -->
    <form method="POST">
        <div class="form-group">
            <label for="order_id">Enter Order Number:</label>
            <input type="number" name="order_id" id="order_id" required>
        </div>
        <button class="btn" type="submit" name="search_order">Search</button>
    </form>

    <?php if ($alert): ?>
        <p class="alert <?php echo $alertClass; ?>"><?php echo htmlspecialchars($alert); ?></p>
    <?php endif; ?>

    <?php if ($orderInfo): ?>
        <div class="order-info">
            <h3>Order #<?php echo $orderInfo->getOrderId(); ?></h3>
            <ul>
                <li><strong>Name:</strong> <?php echo htmlspecialchars($orderInfo->getCustomerFirstName() . ' ' . $orderInfo->getCustomerLastName()); ?></li>
                <li><strong>Email:</strong> <?php echo htmlspecialchars($orderInfo->getCustomerEmail()); ?></li>
                <li><strong>Address:</strong> <?php echo htmlspecialchars($orderInfo->getShippingAddress() . ', ' . $orderInfo->getShippingCity() . ', ' . $orderInfo->getShippingState() . ' ' . $orderInfo->getShippingZip()); ?></li>
                <li><strong>Status:</strong> <?php echo htmlspecialchars($orderInfo->getOrderStatus()); ?></li>
                <li><strong>Total:</strong> $<?php echo number_format($orderInfo->getTotalAmount(), 2); ?></li>
                <li><strong>Ordered on:</strong> <?php echo $orderInfo->getCreatedAt(); ?></li>
            </ul>

            <?php
            // show cancel button only if order is still cancellable
            $nonCancellable = ['Cancelled', 'Shipped', 'Delivered'];   // tweak as needed
            if (!in_array($orderInfo->getOrderStatus(), $nonCancellable)):
            ?>
                <!-- CANCEL FORM -->
                <form method="POST" onsubmit="return confirm('Are you sure you want to cancel this order?');">
                    <input type="hidden" name="order_id" value="<?php echo $orderInfo->getOrderId(); ?>">
                    <button type="submit" name="cancel_order" class="btn cancel">Cancel Order</button>
                </form>
            <?php endif; ?>
        </div>
    <?php endif; ?>
</div>
</body>
</html>
