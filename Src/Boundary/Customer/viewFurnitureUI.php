<?php include '../../header.php'; ?>
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
        <?php
        $furniture = [
            ["category" => "Living Room", "name" => "Modern Sofa", "price" => "$1099.99", "old_price" => "$1299.99", "image" => "../../img/sofa.jpg", "rating" => "4.8 (120)", "sale" => false],
            ["category" => "Dining Room", "name" => "Scandinavian Dining Table", "price" => "$849.99", "old_price" => null, "image" => "../../img/table.jpg", "rating" => "4.6 (89)", "sale" => false],
            ["category" => "Bedroom", "name" => "Queen Size Platform Bed", "price" => "$599.99", "old_price" => "$899.99", "image" => "../../img/bed.jpg", "rating" => "4.7 (78)", "sale" => false
        ],
        ];

        foreach ($furniture as $item) {
            echo '<div class="card-wrapper">';
            if ($item["sale"]) echo '<div class="sale-badge">Sale</div>';
            echo '<div class="card">';
            echo '<img src="' . $item["image"] . '" alt="' . $item["name"] . '">';
            echo '<div class="card-body">';
            echo '<div class="category">' . $item["category"] . '</div>';
            echo '<div class="name">' . $item["name"] . '</div>';
            echo '<div class="price">' . $item["price"];
            if ($item["old_price"]) echo ' <span style="text-decoration:line-through;color:gray;">' . $item["old_price"] . '</span>';
            echo '</div>';
            echo '<div class="rating"><i class="fa fa-star"></i> ' . $item["rating"] . '</div>';
            echo '</div></div></div>';
        }
        ?>
    </div>
</div>
</body>
</html>
