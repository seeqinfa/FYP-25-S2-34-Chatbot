-- Complete LuxFurn Database Import Script
-- Run this script in your Railway MySQL database to create all tables and import initial data

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

-- Disable foreign key checks temporarily for clean import
SET FOREIGN_KEY_CHECKS = 0;

-- ========================================
-- 1. USERS TABLE (Base table - no dependencies)
-- ========================================

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` tinyint(1) DEFAULT 1 COMMENT '1 = active, 0 = banned',
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insert initial users
INSERT INTO `users` (`id`, `username`, `email`, `password`, `status`, `role`) VALUES
(1, 'test', 'sqinfa@gmail.com', '$2y$10$V20b2wivwCdVyImCxEEtX.lbRn5ST36tkjKH1aCZViu2.GJKfj1iW', 1, 'user'),
(2, 'tester', 'test@gmail.com', '$2y$10$6WwMOnChuAYfGywFfuTitevIanMG9p.HyEqwPzuZctFglP437DULC', 1, 'user'),
(6, 'admin', 'admin@gmail.com', '$2y$10$tTMV6v3ozZfN5ukt.ip6EusHIPESkmvBNKMCAt4U3QU66RI/tKUNW', 1, 'admin'),
(8, 'user', 'user@gmail.com', '$2y$10$sgArvTH1v1f.UDUjmpucGOVMXhdoFd/AhTLCtyItx.kZb0g9NqhMq', 1, 'user');

-- ========================================
-- 2. FURNITURES TABLE (Referenced by orders and other tables)
-- ========================================

DROP TABLE IF EXISTS `furnitures`;
CREATE TABLE `furnitures` (
  `furnitureID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `category` varchar(20) NOT NULL,
  `description` varchar(100) NOT NULL,
  `price` varchar(10) NOT NULL,
  `stock_quantity` int(10) NOT NULL,
  `image_url` varchar(50) NOT NULL,
  PRIMARY KEY (`furnitureID`),
  UNIQUE KEY `furnitureID` (`furnitureID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insert furniture data
INSERT INTO `furnitures` (`furnitureID`, `name`, `category`, `description`, `price`, `stock_quantity`, `image_url`) VALUES
(1, 'Sofa Luxe', 'Sofa', '3-seater leather sofa in dark brown', '899.00', 5, '../../img/Sofa.jpg'),
(2, 'Oak Dining Set', 'Dining', '6-seater solid oak wood dining set', '1299.00', 3, '../../img/table.jpg'),
(3, 'Ergo Chair', 'Chair', 'Ergonomic office chair with lumbar support', '199.00', 12, '../../img/ergochair.jpg'),
(4, 'Coffee Table', 'Table', 'Minimalist glass coffee table', '159.00', 7, '../../img/coffeetable.jpg'),
(5, 'Queen Bed Frame', 'Bed', 'Queen size bed frame with storage drawers', '699.00', 4, '../../img/queenbedframe.jpg'),
(6, 'Bookshelf Classic', 'Shelf', '5-tier wooden bookshelf', '249.00', 9, '../../img/bookshelf.jpg'),
(7, 'TV Console', 'Storage', 'Low-rise TV console with cable management', '399.00', 6, '../../img/tvconsole.jpg'),
(8, 'Recliner Seat', 'Sofa', 'Plush recliner with adjustable headrest', '499.00', 2, '../../img/reclinerseat.jpg'),
(9, 'Study Desk', 'Table', 'Compact study desk with side drawers', '299.00', 10, '../../img/studydesk.jpg'),
(10, 'Bar Stool Set', 'Chair', 'Set of 2 bar stools with footrest', '179.00', 8, '../../img/barstool.jpg'),
(11, 'Bed', 'Bedroom', 'bed', '1299.90', 5, '../../img/bed.jpg');

-- ========================================
-- 3. ORDERS TABLE (References users and furnitures)
-- ========================================

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
    `order_id` INT AUTO_INCREMENT PRIMARY KEY,
    `username` VARCHAR(50) NOT NULL,
    `customer_first_name` VARCHAR(50) NOT NULL,
    `customer_last_name`  VARCHAR(50) NOT NULL,
    `customer_email`      VARCHAR(100) NOT NULL,
    `customer_phone`      VARCHAR(20) NOT NULL,
    `shipping_address` VARCHAR(255) NOT NULL,
    `shipping_city`    VARCHAR(100) NOT NULL,
    `shipping_state`   VARCHAR(50)  NOT NULL,
    `shipping_zip`     VARCHAR(20)  NOT NULL,
    `subtotal`      DECIMAL(10,2) NOT NULL,
    `tax_amount`    DECIMAL(10,2) NOT NULL,
    `shipping_fee`  DECIMAL(10,2) NOT NULL,
    `total_amount`  DECIMAL(10,2) NOT NULL,
    `order_status` ENUM('pending','processing','shipped','delivered','cancelled') DEFAULT 'pending',
    `special_instructions` TEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_orders_username` (`username`),
    INDEX `idx_orders_email` (`customer_email`),
    INDEX `idx_orders_status` (`order_status`),
    INDEX `idx_orders_created` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insert sample orders
INSERT INTO `orders` (`order_id`, `username`, `customer_first_name`, `customer_last_name`, `customer_email`, `customer_phone`, `shipping_address`, `shipping_city`, `shipping_state`, `shipping_zip`, `subtotal`, `tax_amount`, `shipping_fee`, `total_amount`, `order_status`, `special_instructions`, `created_at`) VALUES
(1, 'test', 'John', 'Doe', 'john.doe@email.com', '12345678', '123 Main St', 'Anytown', 'CA', '12345', 1299.00, 103.92, 15.00, 1417.92, 'processing', 'Please handle with care', '2025-01-10 10:00:00'),
(2, 'tester', 'Jane', 'Smith', 'jane.smith@email.com', '87654321', '456 Oak Ave', 'Somewhere', 'NY', '54321', 159.00, 12.72, 15.00, 186.72, 'shipped', NULL, '2025-01-11 14:30:00'),
(3, 'user', 'Bob', 'Johnson', 'bob.johnson@email.com', '11223344', '789 Pine Rd', 'Elsewhere', 'TX', '67890', 199.00, 15.92, 15.00, 229.92, 'delivered', 'Leave at front door', '2025-01-12 09:15:00'),
(4, 'test', 'Alice', 'Brown', 'alice.brown@email.com', '44332211', '321 Elm St', 'Nowhere', 'FL', '09876', 1458.00, 116.64, 15.00, 1589.64, 'pending', NULL, '2025-01-13 16:45:00');

-- ========================================
-- 4. ORDER_ITEMS TABLE (References orders and furnitures)
-- ========================================

DROP TABLE IF EXISTS `order_items`;
CREATE TABLE `order_items` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `furniture_id` int(11) NOT NULL,
  `furniture_name` varchar(255) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`item_id`),
  KEY `idx_order_items_order` (`order_id`),
  KEY `idx_order_items_furniture` (`furniture_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`furniture_id`) REFERENCES `furnitures` (`furnitureID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insert order items
INSERT INTO `order_items` (`item_id`, `order_id`, `furniture_id`, `furniture_name`, `unit_price`, `quantity`, `total_price`) VALUES
(1, 1, 2, 'Oak Dining Set', 1299.00, 1, 1299.00),
(2, 2, 4, 'Coffee Table', 159.00, 1, 159.00),
(3, 3, 3, 'Ergo Chair', 199.00, 1, 199.00),
(4, 4, 4, 'Coffee Table', 159.00, 1, 159.00),
(5, 4, 2, 'Oak Dining Set', 1299.00, 1, 1299.00);

-- ========================================
-- 5. CHAT_MESSAGES TABLE (References users)
-- ========================================

DROP TABLE IF EXISTS `chat_messages`;
CREATE TABLE `chat_messages` (
  `username` varchar(100) NOT NULL,
  `sender` enum('user','bot') NOT NULL,
  `message_text` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`username`,`created_at`,`sender`),
  KEY `idx_chat_username_time` (`username`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ========================================
-- 6. CHATBOT_REVIEWS TABLE (References users)
-- ========================================

DROP TABLE IF EXISTS `chatbot_reviews`;
CREATE TABLE `chatbot_reviews` (
  `reviewID` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `rating` tinyint(4) NOT NULL CHECK (`rating` between 1 and 5),
  `comment` text NOT NULL,
  `admin_comment` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`reviewID`),
  KEY `idx_user` (`user_id`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_cb_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insert sample chatbot reviews
INSERT INTO `chatbot_reviews` (`reviewID`, `user_id`, `rating`, `comment`, `admin_comment`, `created_at`) VALUES
(1, 1, 5, 'Very helpful chatbot! It answered my questions instantly.', 'Glad this user had a great experience.', '2025-08-01 10:15:00'),
(2, 2, 4, 'Pretty good, but it gave me the wrong info once.', 'Review FAQ on shipping.', '2025-08-02 14:30:00'),
(3, 6, 3, 'It works, but sometimes repeats the same thing.', 'Improve context handling.', '2025-08-03 09:20:00'),
(4, 8, 3, 'Fast replies but not always relevant.', 'Intent tuning needed.', '2025-08-04 17:45:00'),
(5, 1, 4, 'Easy to use and quick.', 'test3', '2025-08-07 13:00:00'),
(6, 2, 5, 'Saved me time finding a product.', 'test2', '2025-08-07 19:25:00');

-- ========================================
-- 7. SUPPORT_TICKETS TABLE (References users)
-- ========================================

DROP TABLE IF EXISTS `support_tickets`;
CREATE TABLE `support_tickets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `assigned_admin_id` int(11) DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `status` enum('open','responded','resolved') DEFAULT 'open',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insert sample support tickets
INSERT INTO `support_tickets` (`id`, `user_id`, `assigned_admin_id`, `subject`, `message`, `status`, `created_at`) VALUES
(1, 1, NULL, 'Login issues', 'I cannot login to my account since yesterday', 'open', '2025-05-15 01:23:45'),
(2, 2, NULL, 'Order not received', 'I placed order #12345 5 days ago but still not received', 'open', '2025-05-16 06:12:33'),
(3, 1, NULL, 'Payment problem', 'Payment was deducted but order not confirmed', 'open', '2025-05-17 02:45:12'),
(4, 8, NULL, 'Product damaged', 'Received damaged product in order #12346', 'resolved', '2025-05-10 08:30:22'),
(5, 2, NULL, 'Account verification', 'Need help verifying my account', 'open', '2025-05-18 03:05:17');

-- ========================================
-- 8. TICKET_REPLIES TABLE (References support_tickets)
-- ========================================

DROP TABLE IF EXISTS `ticket_replies`;
CREATE TABLE `ticket_replies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ticket_id` int(11) NOT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_ticket_replies_ticket` (`ticket_id`),
  CONSTRAINT `fk_ticket_replies_ticket` FOREIGN KEY (`ticket_id`) REFERENCES `support_tickets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insert sample ticket replies
INSERT INTO `ticket_replies` (`id`, `ticket_id`, `admin_id`, `message`, `created_at`) VALUES
(1, 4, NULL, 'We apologize for the damaged item. A replacement will be sent within 2 business days.', '2025-05-11 10:54:45'),
(2, 5, NULL, 'Please check your email for the verification link. If you cannot find it, check your spam folder.', '2025-05-19 15:14:09');

-- ========================================
-- 9. SUPPORT_TICKET_ROLES TABLE
-- ========================================

DROP TABLE IF EXISTS `support_ticket_roles`;
CREATE TABLE `support_ticket_roles` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(128) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `assigned_by` varchar(128) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`),
  KEY `idx_active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insert sample support ticket roles
INSERT INTO `support_ticket_roles` (`id`, `username`, `active`, `assigned_by`, `created_at`, `updated_at`) VALUES
(1, 'admin', 1, 'admin', '2025-08-13 21:54:33', '2025-08-13 22:54:04');

-- ========================================
-- 10. INSTRUCTION_MANUALS TABLE
-- ========================================

DROP TABLE IF EXISTS `instruction_manuals`;
CREATE TABLE `instruction_manuals` (
  `manualID` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(150) NOT NULL,
  `product_code` varchar(80) DEFAULT NULL,
  `keywords` text DEFAULT NULL,
  `manual_url` varchar(255) NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`manualID`),
  KEY `idx_product_name` (`product_name`),
  KEY `idx_product_code` (`product_code`),
  KEY `idx_updated_at` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insert instruction manuals
INSERT INTO `instruction_manuals` (`manualID`, `product_name`, `product_code`, `keywords`, `manual_url`, `updated_at`) VALUES
(1, 'Ergo Chair', 'CHA-ERGO', 'chair ergonomic lumbar support office', '/assets/manuals/ergo_chair.pdf', '2025-08-11 00:17:22'),
(2, 'Coffee Table', 'TAB-COFF', 'table coffee glass minimalist living room', '/assets/manuals/coffee_table.pdf', '2025-08-11 00:17:22'),
(3, 'Queen Bed Frame', 'BED-QFRM', 'bed frame queen storage drawers bedroom', '/assets/manuals/queen_bed_frame.pdf', '2025-08-11 00:17:22'),
(4, 'Bookshelf Classic', 'SHE-BCLS', 'bookshelf shelf wooden 5-tier study', '/assets/manuals/bookshelf_classic.pdf', '2025-08-11 00:17:22'),
(5, 'TV Console', 'STO-TVCON', 'tv console storage low-rise cable management', '/assets/manuals/tv_console.pdf', '2025-08-11 00:17:22'),
(6, 'Recliner Seat', 'SOF-RECL', 'recliner sofa plush adjustable headrest', '/assets/manuals/recliner_seat.pdf', '2025-08-11 00:17:22'),
(7, 'Study Desk', 'TAB-STUD', 'study desk compact drawers office table', '/assets/manuals/study_desk.pdf', '2025-08-11 00:17:22'),
(8, 'Bar Stool Set', 'STL-BAR', 'bar stool set tall counter kitchen', '/assets/manuals/bar_stool_set.pdf', '2025-08-11 00:17:22');

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;

-- Commit the transaction
COMMIT;

-- Reset AUTO_INCREMENT values to ensure proper sequencing
ALTER TABLE `users` AUTO_INCREMENT = 9;
ALTER TABLE `furnitures` AUTO_INCREMENT = 12;
ALTER TABLE `orders` AUTO_INCREMENT = 5;
ALTER TABLE `order_items` AUTO_INCREMENT = 6;
ALTER TABLE `chatbot_reviews` AUTO_INCREMENT = 7;
ALTER TABLE `support_tickets` AUTO_INCREMENT = 6;
ALTER TABLE `ticket_replies` AUTO_INCREMENT = 3;
ALTER TABLE `support_ticket_roles` AUTO_INCREMENT = 2;
ALTER TABLE `instruction_manuals` AUTO_INCREMENT = 9;

-- Show completion message
SELECT 'Database import completed successfully!' as Status;