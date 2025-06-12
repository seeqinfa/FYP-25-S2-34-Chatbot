<?php 
include '../../header.php';
require_once dirname(__DIR__, 2) . '/Entities/furniture.php';
require_once dirname(__DIR__, 2) . '/Controllers/Customer/viewFurnitureCtrl.php';
require_once dirname(__DIR__, 2) . '/config.php';

$controller = new FurnitureController();
$furnitureList = $controller->getAllFurniture();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Furniture Gallery</title>
    <link rel="stylesheet" href="../../CSS/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .container {
            margin-top: 120px;
            padding: 20px;
            max-width: 1200px;
            width: 100%;
        }
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
        }
        .card {
            background: rgba(255,255,255,0.8);
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }
        .card img {
            width: 100%;
            height: 180px;
            object-fit: cover;
        }
        .card-body {
            padding: 15px;
        }
        .card-body .category {
            font-size: 12px;
            color: gray;
        }
        .card-body .name {
            font-size: 16px;
            font-weight: bold;
            margin: 5px 0;
        }
        .card-body .price {
            font-size: 16px;
            color: #e67e22;
        }
        .card-body .rating {
            margin-top: 5px;
            color: #f39c12;
        }
        .sale-badge {
            position: absolute;
            background: red;
            color: white;
            padding: 3px 8px;
            font-size: 12px;
            top: 10px;
            left: 10px;
            border-radius: 3px;
        }
        .card-wrapper {
            position: relative;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="grid">
        <?php foreach ($furnitureList as $item): ?>
            <div class="card-wrapper">
                <div class="card">
                    <img src="<?php echo htmlspecialchars($item->image_url); ?>" alt="<?php echo htmlspecialchars($item->name); ?>">
                    <div class="card-body">
                        <div class="category"><?php echo htmlspecialchars($item->category); ?></div>
                        <div class="name"><?php echo htmlspecialchars($item->name); ?></div>
                        <div class="price">$<?php echo htmlspecialchars($item->price); ?></div>

                        <div class="actions" style="margin-top: 10px;">
                            <a href="viewFurnitureDetailsUI.php?id=<?php echo urlencode($item->furnitureID); ?>" class="btn">View</a>
                            <a href="addToCart.php?id=<?php echo urlencode($item->furnitureID); ?>" class="btn">Add to Cart</a>
                        </div>
                    </div>
                </div>
            </div>
        <?php endforeach; ?>
    </div>
</div>
</body>
</html>
