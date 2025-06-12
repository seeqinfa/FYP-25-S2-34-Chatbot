<?php
include '../../header.php';
require_once dirname(__DIR__, 2) . '/Controllers/Customer/viewFurnitureCtrl.php';

$controller = new FurnitureController();
$searchTerm = isset($_GET['search']) ? trim($_GET['search']) : '';
$currentPage = isset($_GET['page']) ? max(1, intval($_GET['page'])) : 1;
$itemsPerPage = 9;
$offset = ($currentPage - 1) * $itemsPerPage;

$totalItems = $controller->countFurniture($searchTerm);
$totalPages = ceil($totalItems / $itemsPerPage);
$furnitureList = $controller->getFurniturePaginated($offset, $itemsPerPage, $searchTerm);
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
        .card { background: rgba(255,255,255,0.8); border-radius: 10px; overflow: hidden; box-shadow: 0 4px 10px rgba(0,0,0,0.2); }
        .card img { width: 100%; height: 180px; object-fit: cover; }
        .card-body { padding: 15px;}
        .category { font-size: 12px; color: gray; }
        .name { font-size: 16px; font-weight: bold; margin: 5px 0; }
        .price { font-size: 16px; color: #e67e22; }
        .actions { display: flex; justify-content: center; gap: 8px; margin-top: 12px; }
        .btn { padding: 12px 12px; border-radius: 4px; background-color: #e67e22; color: white; font-size: 14px; text-decoration: none; transition: background-color 0.2s ease-in-out; text-align: center; white-space: nowrap; }
        .btn:hover { background-color: #c15500; }
        .pagination a { margin: 0 5px; padding: 8px 12px; border: 1px solid #ccc; border-radius: 4px; text-decoration: none; color: #e67e22; background-color: white; }
        .pagination a.active { background-color: #e67e22; color: white; border-color: #e67e22; }
    </style>
</head>
<body>
<div class="container">
    <form method="GET" style="margin-bottom: 20px; display: flex; gap: 10px;">
        <input type="text" name="search" placeholder="Search by name or category" value="<?php echo htmlspecialchars($searchTerm); ?>" style="padding: 8px; flex: 1; border: 1px solid #ccc; border-radius: 4px;">
        <button type="submit" style="padding: 8px 16px; background-color: #e67e22; color: white; border: none; border-radius: 4px; cursor: pointer;">Search</button>
    </form>

    <div class="grid">
        <?php foreach ($furnitureList as $item): ?>
            <div class="card-wrapper">
                <div class="card">
                    <img src="<?php echo htmlspecialchars($item->image_url); ?>" alt="<?php echo htmlspecialchars($item->name); ?>">
                    <div class="card-body">
                        <div class="category"><?php echo htmlspecialchars($item->category); ?></div>
                        <div class="name"><?php echo htmlspecialchars($item->name); ?></div>
                        <div class="price">$<?php echo htmlspecialchars($item->price); ?></div>
                        <div class="actions">
                            <a href="viewFurnitureDetailsUI.php?id=<?php echo urlencode($item->furnitureID); ?>" class="btn">View</a>
                            <a href="addToCart.php?id=<?php echo urlencode($item->furnitureID); ?>" class="btn">Add to Cart</a>
                        </div>
                    </div>
                </div>
            </div>
        <?php endforeach; ?>
    </div>

    <!-- Pagination -->
    <div class="pagination" style="text-align: center; margin-top: 30px;">
        <?php if ($currentPage > 1): ?>
            <a href="?search=<?php echo urlencode($searchTerm); ?>&page=<?php echo $currentPage - 1; ?>">&laquo; Prev</a>
        <?php endif; ?>

        <?php for ($i = 1; $i <= $totalPages; $i++): ?>
            <a href="?search=<?php echo urlencode($searchTerm); ?>&page=<?php echo $i; ?>" class="<?php echo ($i == $currentPage) ? 'active' : ''; ?>"> <?php echo $i; ?> </a>
        <?php endfor; ?>

        <?php if ($currentPage < $totalPages): ?>
            <a href="?search=<?php echo urlencode($searchTerm); ?>&page=<?php echo $currentPage + 1; ?>">Next &raquo;</a>
        <?php endif; ?>
    </div>
</div>
</body>
</html>
