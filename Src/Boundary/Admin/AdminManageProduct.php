<?php
include '../../header.php';
require_once dirname(__DIR__, 2) . '/Controllers/Admin/AdminAddProductCtrl.php';

$controller = new AdminAddProductCtrl();
$searchTerm = isset($_GET['search']) ? trim($_GET['search']) : '';
$currentPage = isset($_GET['page']) ? max(1, intval($_GET['page'])) : 1;
$itemsPerPage = 9;
$offset = ($currentPage - 1) * $itemsPerPage;

$totalItems = $controller->countFurniture($searchTerm);
$totalPages = ceil($totalItems / $itemsPerPage);
$furnitureList = $controller->getFurniturePaginated($offset, $itemsPerPage, $searchTerm);
?>

<div class="container" style="margin-top: 140px; max-width: 1200px; width: 100%; padding: 0 20px;">
    <div style="margin-bottom: 15px;">
        <a href="AdminAddProduct.php" class="btn" style="padding: 6px 12px; background-color: #2ecc71; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 14px;  margin-bottom: 8px;">+ Add Product</a>
    </div>
    
    <form method="GET" style="display: flex; gap: 10px; margin-bottom: 20px;">
        <input type="text" name="search" placeholder="Search by name or category"
               value="<?php echo htmlspecialchars($searchTerm); ?>"
               style="padding: 8px; flex: 1; border: 1px solid #ccc; border-radius: 4px;">
        <button type="submit" style="padding: 8px 16px; background-color: #e67e22; color: white; border: none; border-radius: 4px; cursor: pointer;">Search</button>
    </form>

    <div style="overflow-x: auto;">
        <table style="width: 100%; border-collapse: collapse; background: rgba(255,255,255,0.9); border-radius: 10px; box-shadow: 0 4px 10px rgba(0,0,0,0.2);">
            <thead>
                <tr style="background-color: #e67e22; color: white;">
                    <th style="padding: 12px 15px; text-align: left; border-bottom: 2px solid #c15500;">Product Name</th>
                    <th style="padding: 12px 15px; text-align: left; border-bottom: 2px solid #c15500;">Category</th>
                    <th style="padding: 12px 15px; text-align: right; border-bottom: 2px solid #c15500;">Price</th>
                    <th style="padding: 12px 15px; text-align: center; border-bottom: 2px solid #c15500;">Quantity Left</th>
                    <th style="padding: 12px 15px; text-align: center; border-bottom: 2px solid #c15500;">Actions</th>
                </tr>
            </thead>
            <tbody id="furniture-table-body">
                <?php foreach ($furnitureList as $item): ?>
                    <tr id="row-<?php echo $item->furnitureID; ?>" style="border-bottom: 1px solid #ddd;">
                        <td style="padding: 12px 15px;"><?php echo htmlspecialchars($item->name); ?></td>
                        <td style="padding: 12px 15px;"><?php echo htmlspecialchars($item->category); ?></td>
                        <td style="padding: 12px 15px; text-align: right; color: #e67e22; font-weight: bold;">$<?php echo htmlspecialchars($item->price); ?></td>
                        <td style="padding: 12px 15px; text-align: center;">
                            <?php 
                            // Display quantity or 'Out of Stock' if 0, 'N/A' if null
                            if (isset($item->stock_quantity)) {
                                echo htmlspecialchars($item->stock_quantity > 0 ? $item->stock_quantity : 'Out of Stock');
                        } else {
                            echo 'N/A';
                }
                ?>
            </td>
                        <td style="padding: 12px 15px; text-align: center;">
                            <div style="display: flex; align-items: center; justify-content: center; padding: 8px 0px; gap: 20px;">
                                <a href="AdminEditProduct.php?id=<?php echo urlencode($item->furnitureID); ?>" 
                                class="btn" 
                                style="background-color: purple;">Edit</a>
                                <button onclick="confirmRemove('<?php echo $item->furnitureID; ?>', '<?php echo htmlspecialchars(addslashes($item->name)); ?>')" 
                                        class="btn" 
                                        style="background-color: red;">Remove</button>
                            </div>
                        </td>

                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>

    <div class="pagination" style="text-align: center; margin-top: 30px;">
        <?php if ($currentPage > 1): ?>
            <a href="?search=<?php echo urlencode($searchTerm); ?>&page=<?php echo $currentPage - 1; ?>">&laquo; Prev</a>
        <?php endif; ?>
        <?php for ($i = 1; $i <= $totalPages; $i++): ?>
            <a href="?search=<?php echo urlencode($searchTerm); ?>&page=<?php echo $i; ?>" class="<?php echo ($i == $currentPage) ? 'active' : ''; ?>"><?php echo $i; ?></a>
        <?php endfor; ?>
        <?php if ($currentPage < $totalPages): ?>
            <a href="?search=<?php echo urlencode($searchTerm); ?>&page=<?php echo $currentPage + 1; ?>">Next &raquo;</a>
        <?php endif; ?>
    </div>
</div>

<script>
function confirmRemove(furnitureId, furnitureName) {
    if (confirm('Are you sure you want to remove "' + furnitureName + '"?')) {
        removeFurniture(furnitureId);
    }
}

function removeFurniture(furnitureId) {
    // Show loading state
    const removeBtn = document.querySelector(`#row-${furnitureId} button[onclick^="confirmRemove"]`);
    removeBtn.disabled = true;
    removeBtn.textContent = 'Removing...';
    
    // Send AJAX request
    fetch('removeFurniture.php?id=' + encodeURIComponent(furnitureId), {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        }
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
        if (data.success) {
            // Remove the row from the table
            const row = document.getElementById('row-' + furnitureId);
            if (row) {
                row.style.transition = 'opacity 0.3s';
                row.style.opacity = '0';
                setTimeout(() => row.remove(), 300);
            }
        } else {
            alert('Error: ' + (data.message || 'Failed to remove item'));
            removeBtn.disabled = false;
            removeBtn.textContent = 'Remove';
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred while removing the item');
        removeBtn.disabled = false;
        removeBtn.textContent = 'Remove';
    });
}
</script>

</body>
</html>