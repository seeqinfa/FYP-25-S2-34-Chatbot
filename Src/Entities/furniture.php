<?php
class Furniture {
    public $furnitureID;
    public $name;
    public $category;
    public $description;
    public $price;
    public $stock_quantity;
    public $image_url;

    public function __construct($furnitureID, $name, $category, $description, $price, $stock_quantity, $image_url) {
        $this->furnitureID = $furnitureID;
        $this->name = $name;
        $this->category = $category;
        $this->description = $description;
        $this->price = $price;
        $this->stock_quantity = $stock_quantity;
        $this->image_url = $image_url;
    }
}
?>