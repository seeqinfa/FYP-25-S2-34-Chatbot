-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 13, 2025 at 07:21 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `luxfurn`
--

-- --------------------------------------------------------

--
-- Table structure for table `chatbot_reviews`
--

CREATE TABLE `chatbot_reviews` (
  `reviewID` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `rating` tinyint(4) NOT NULL CHECK (`rating` between 1 and 5),
  `comment` text DEFAULT NULL,
  `admin_comment` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chatbot_reviews`
--

INSERT INTO `chatbot_reviews` (`reviewID`, `user_id`, `rating`, `comment`, `admin_comment`, `created_at`) VALUES
(11, 1, 5, 'Very helpful chatbot! It answered my questions instantly.', 'Glad this user had a great experience.', '2025-08-01 10:15:00'),
(12, 2, 4, 'Pretty good, but it gave me the wrong info once.', 'Need to review the FAQ on shipping.', '2025-08-02 14:30:00'),
(13, 6, 3, 'It works, but sometimes repeats the same thing.', 'Might need to improve context handling.', '2025-08-03 09:20:00'),
(14, 8, 3, 'Fast replies but not always relevant.', 'Possible NLP intent misclassification.', '2025-08-04 17:45:00'),
(15, 9, 2, 'It could not help me with my order issue.', 'Escalate order-related queries to human agents sooner.', '2025-08-05 11:10:00'),
(16, 10, 1, 'Terrible! Gave me wrong answers every time.', 'Possible bug in knowledge base integration.', '2025-08-06 08:50:00'),
(17, 1, 4, 'I like it! Very easy to use and quick.', 'test1', '2025-08-07 13:00:00'),
(18, 2, 5, 'Saved me so much time finding the product I wanted.', 'test2', '2025-08-07 19:25:00'),
(19, 6, 2, 'It’s okay, but the chatbot doesn’t understand certain phrases.', 'Need to add more training examples.', '2025-08-08 09:15:00');

-- --------------------------------------------------------

--
-- Table structure for table `chat_messages`
--

CREATE TABLE `chat_messages` (
  `username` varchar(100) NOT NULL,
  `sender` enum('user','bot') NOT NULL,
  `message_text` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chat_messages`
--

INSERT INTO `chat_messages` (`username`, `sender`, `message_text`, `created_at`) VALUES
('yg', 'user', 'hi', '2025-08-08 09:45:02'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-08 09:45:02'),
('yg', 'user', 'manual', '2025-08-08 17:39:02'),
('yg', 'user', 'give me manual please', '2025-08-09 10:45:10'),
('yg', 'user', 'give me manual', '2025-08-09 10:52:27'),
('yg', 'user', 'hi', '2025-08-09 11:35:33'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-09 11:35:33'),
('yg', 'user', 'instruction manual', '2025-08-09 11:35:39'),
('yg', 'bot', 'You can find the instruction manual here: http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/InstructionManualsUI.php?q=instruction%20manual', '2025-08-09 11:35:39'),
('yg', 'user', 'i need instruction manual for my table', '2025-08-09 11:36:04'),
('yg', 'bot', 'You can find the instruction manual here: http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/InstructionManualsUI.php?q=i%20need%20instruction%20manual%20for%20my%20table', '2025-08-09 11:36:04'),
('yg', 'user', 'its me scooby doo', '2025-08-09 12:05:58'),
('yg', 'bot', 'What are the dimensions of your space? (e.g., 200x100x80 cm)', '2025-08-09 12:05:58'),
('yg', 'user', 'hi', '2025-08-09 12:06:14'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-09 12:06:14'),
('yg', 'user', 'manual please', '2025-08-09 12:06:22'),
('yg', 'bot', 'Opening the instruction manual for manual please... || <script>window.open(\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/InstructionManualsUI.php?q=manual%20please\", \"_blank\");</script>', '2025-08-09 12:06:22'),
('yg', 'user', 'can i have the manual  please', '2025-08-09 12:06:37'),
('yg', 'bot', 'Opening the instruction manual for can i have the manual  please... || <script>window.open(\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/InstructionManualsUI.php?q=can%20i%20have%20the%20manual%20%20please\", \"_blank\");</script>', '2025-08-09 12:06:37'),
('yg', 'user', 'hi', '2025-08-09 16:20:07'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-09 16:20:07'),
('yg', 'user', 'chair manual', '2025-08-09 16:20:14'),
('yg', 'bot', 'What are the dimensions of your space? (e.g., 200x100x80 cm)', '2025-08-09 16:20:14'),
('yg', 'user', 'hi', '2025-08-09 16:20:17'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-09 16:20:17'),
('yg', 'user', 'can i get instruction manual for chair', '2025-08-09 16:20:23'),
('yg', 'bot', 'What are the dimensions of your space? (e.g., 200x100x80 cm)', '2025-08-09 16:20:23'),
('yg', 'user', '200x100x80', '2025-08-09 16:20:30'),
('yg', 'bot', 'I would recommend the <a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/viewFurnitureDetailsUI.php?id=3\">Ergo Chair</a>', '2025-08-09 16:20:30'),
('yg', 'user', 'hi', '2025-08-09 16:20:46'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-09 16:20:46'),
('yg', 'user', 'can you give me recommendation on furniture', '2025-08-09 16:20:52'),
('yg', 'bot', 'What are the dimensions of your space? (e.g., 200x100x80 cm)', '2025-08-09 16:20:52'),
('yg', 'user', '200x100x80', '2025-08-09 16:20:59'),
('yg', 'bot', 'I would recommend the <a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/viewFurnitureDetailsUI.php?id=3\">Ergo Chair</a>', '2025-08-09 16:20:59'),
('yg', 'user', 'hi', '2025-08-09 16:21:10'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-09 16:21:10'),
('yg', 'user', 'manual', '2025-08-09 16:21:13'),
('yg', 'bot', 'Opening the instruction manual for manual... || <script>window.open(\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/InstructionManualsUI.php?q=manual\", \"_blank\");</script>', '2025-08-09 16:21:13'),
('yg', 'user', 'hi', '2025-08-09 16:37:06'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-09 16:37:06'),
('yg', 'user', 'can i get a manual', '2025-08-09 16:37:15'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-09 16:37:15'),
('yg', 'user', 'chair', '2025-08-09 16:37:20'),
('yg', 'bot', 'Sorry, I didn\'t understand that. Here\'s some common queries I can help you with: ||   1. Browse our furniture catalog  ||   2. Check your order status   ||   3. Leave feedback or a review   ||   4. Talk to a human agent   || Just type what you\'d like to do!', '2025-08-09 16:37:20'),
('yg', 'user', 'instruction manual', '2025-08-09 16:37:31'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-09 16:37:31'),
('yg', 'user', 'recliner seat', '2025-08-09 16:37:35'),
('yg', 'bot', 'What are the dimensions of your space? (e.g., 200x100x80 cm)', '2025-08-09 16:37:35'),
('yg', 'user', 'instruction manual', '2025-08-09 16:37:46'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-09 16:37:46'),
('yg', 'user', 'Ergo Chair', '2025-08-09 16:37:49'),
('yg', 'bot', 'Sorry, I didn\'t understand that. Here\'s some common queries I can help you with: ||   1. Browse our furniture catalog  ||   2. Check your order status   ||   3. Leave feedback or a review   ||   4. Talk to a human agent   || Just type what you\'d like to do!', '2025-08-09 16:37:49'),
('yg', 'user', 'hi', '2025-08-10 14:35:04'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-10 14:35:04'),
('yg', 'user', 'i need instruction manual for ergo chair', '2025-08-10 14:35:09'),
('yg', 'bot', 'What are the dimensions of your space? (e.g., 200x100x80 cm)', '2025-08-10 14:35:09'),
('yg', 'user', 'instruuction manual', '2025-08-10 14:35:23'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-10 14:35:23'),
('yg', 'user', 'ergo chair', '2025-08-10 14:35:25'),
('yg', 'bot', 'Sorry, I didn\'t understand that. Here\'s some common queries I can help you with: ||   1. Browse our furniture catalog  ||   2. Check your order status   ||   3. Leave feedback or a review   ||   4. Talk to a human agent   || Just type what you\'d like to do!', '2025-08-10 14:35:25'),
('yg', 'user', 'hi', '2025-08-10 15:02:07'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-10 15:02:07'),
('yg', 'user', 'instruction manual please', '2025-08-10 15:02:15'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-10 15:02:15'),
('yg', 'user', 'ergo chair', '2025-08-10 15:02:18'),
('yg', 'bot', 'Sorry, I didn\'t understand that. Here\'s some common queries I can help you with: ||   1. Browse our furniture catalog  ||   2. Check your order status   ||   3. Leave feedback or a review   ||   4. Talk to a human agent   || Just type what you\'d like to do!', '2025-08-10 15:02:18'),
('yg', 'user', 'instructin manual', '2025-08-10 15:02:31'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-10 15:02:31'),
('yg', 'user', 'chair', '2025-08-10 15:02:33'),
('yg', 'bot', 'Sorry, I didn\'t understand that. Here\'s some common queries I can help you with: ||   1. Browse our furniture catalog  ||   2. Check your order status   ||   3. Leave feedback or a review   ||   4. Talk to a human agent   || Just type what you\'d like to do!', '2025-08-10 15:02:33'),
('yg', 'user', 'hi', '2025-08-10 15:34:13'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-10 15:34:13'),
('yg', 'user', 'instruction manual', '2025-08-10 15:34:18'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-10 15:34:18'),
('yg', 'user', 'ergo chair', '2025-08-10 15:34:21'),
('yg', 'bot', 'Sorry, I didn\'t understand that. Here\'s some common queries I can help you with: ||   1. Browse our furniture catalog  ||   2. Check your order status   ||   3. Leave feedback or a review   ||   4. Talk to a human agent   || Just type what you\'d like to do!', '2025-08-10 15:34:21'),
('yg', 'user', 'hi', '2025-08-10 15:40:15'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-10 15:40:15'),
('yg', 'user', 'instruction manual', '2025-08-10 15:40:19'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-10 15:40:19'),
('yg', 'user', 'ergo chair', '2025-08-10 15:40:27'),
('yg', 'bot', 'Opening the instruction manual for chair…', '2025-08-10 15:40:27'),
('yg', 'user', 'hi', '2025-08-10 15:50:12'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-10 15:50:12'),
('yg', 'user', 'instruction manual', '2025-08-10 15:50:21'),
('yg', 'bot', 'Opening the instruction manual for chair…', '2025-08-10 15:50:21'),
('yg', 'user', 'hi', '2025-08-10 15:53:34'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-10 15:53:34'),
('yg', 'user', 'instruction manual please', '2025-08-10 15:53:37'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-10 15:53:37'),
('yg', 'user', 'ergo chair', '2025-08-10 15:53:41'),
('yg', 'bot', 'Here’s the instruction manual for chair: <a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/InstructionManualsUI.php?q=chair\" target=\"_blank\">Click here</a>', '2025-08-10 15:53:41'),
('yg', 'user', 'hi', '2025-08-10 16:12:59'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-10 16:12:59'),
('yg', 'user', 'insturction manual please', '2025-08-10 16:13:04'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-10 16:13:04'),
('yg', 'user', 'ergo chair', '2025-08-10 16:13:09'),
('yg', 'user', 'hi', '2025-08-10 16:13:20'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-10 16:13:20'),
('yg', 'user', 'instruction manual please', '2025-08-10 16:13:26'),
('yg', 'user', 'hi', '2025-08-10 16:14:28'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-10 16:14:28'),
('yg', 'user', 'instruction manual', '2025-08-10 16:14:34'),
('yg', 'user', 'instruction manual', '2025-08-10 16:22:10'),
('yg', 'user', 'hi', '2025-08-10 16:22:13'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-10 16:22:13'),
('yg', 'user', 'can i get instruction manual for ergo chair', '2025-08-10 16:22:22'),
('yg', 'user', 'hi', '2025-08-10 16:22:23'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-10 16:22:23'),
('yg', 'user', 'can i get instruction manual', '2025-08-10 16:22:32'),
('yg', 'user', 'hi', '2025-08-10 16:22:57'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-10 16:22:57'),
('yg', 'user', 'insturction manual please', '2025-08-10 16:23:02'),
('yg', 'user', 'hi', '2025-08-10 16:45:58'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-10 16:45:58'),
('yg', 'user', 'instruction manual please', '2025-08-10 16:46:03'),
('yg', 'user', 'hi', '2025-08-10 16:46:52'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-10 16:46:52'),
('yg', 'user', 'instruction manual please', '2025-08-10 16:46:58'),
('yg', 'bot', 'Here’s the instruction manual for please: http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/InstructionManualsUI.php?q=please', '2025-08-10 16:46:58'),
('yg', 'user', 'instruction manual for study desk', '2025-08-10 16:51:01'),
('yg', 'bot', 'Here’s the instruction manual for study desk: http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/InstructionManualsUI.php?q=study%20desk', '2025-08-10 16:51:01'),
('yg', 'user', 'hi', '2025-08-10 16:52:17'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-10 16:52:17'),
('yg', 'user', 'can i get instruction manual for study desk', '2025-08-10 16:52:28'),
('yg', 'bot', 'Here’s the instruction manual for chair: http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=chair', '2025-08-10 16:52:28'),
('yg', 'user', 'hi', '2025-08-10 16:54:05'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-10 16:54:05'),
('yg', 'user', 'can i get instruction manual for ergo chair', '2025-08-10 16:54:14'),
('yg', 'bot', 'Here’s the instruction manual for chair: <a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=chair\" target=\"_blank\">http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=chair</a>', '2025-08-10 16:54:14'),
('yg', 'user', 'hii', '2025-08-11 07:49:19'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 07:49:19'),
('yg', 'user', 'can i get instruction manual for ergo chair', '2025-08-11 07:49:29'),
('yg', 'bot', 'Here’s the instruction manual for chair: <a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=chair\" target=\"_blank\">http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=chair</a>', '2025-08-11 07:49:29'),
('yg', 'user', 'can i get instruction manual', '2025-08-11 07:49:55'),
('yg', 'bot', 'Here’s the instruction manual for chair: <a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=chair\" target=\"_blank\">http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=chair</a>', '2025-08-11 07:49:55'),
('yg', 'user', 'hi', '2025-08-11 07:58:52'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 07:58:52'),
('yg', 'user', 'please give instruction manual for ergo chair', '2025-08-11 07:59:02'),
('yg', 'bot', 'Here’s the instruction manual for chair: <a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=chair\" target=\"_blank\">http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=chair</a>', '2025-08-11 07:59:02'),
('yg', 'user', 'furiniture recoomendation', '2025-08-11 08:00:00'),
('yg', 'bot', 'What are the dimensions of your space? (e.g., 200x100x80 cm)', '2025-08-11 08:00:00'),
('yg', 'user', '200x100x80', '2025-08-11 08:00:03'),
('yg', 'bot', 'I would recommend the <a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/viewFurnitureDetailsUI.php?id=3\">Ergo Chair</a>', '2025-08-11 08:00:03'),
('yg', 'user', 'can i get instruction manual for coffee table', '2025-08-11 08:52:34'),
('yg', 'bot', 'Here’s the instruction manual for chair: <a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=chair\" target=\"_blank\">http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=chair</a>', '2025-08-11 08:52:34'),
('yg', 'user', 'can i get instruction manual for tv console', '2025-08-11 08:52:44'),
('yg', 'bot', 'Here’s the instruction manual for TV Console: <a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=TV%20Console\" target=\"_blank\">http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=TV%20Console</a>', '2025-08-11 08:52:44'),
('yg', 'user', 'can i get instruction manual for queen bed frame', '2025-08-11 08:53:03'),
('yg', 'bot', 'Here’s the instruction manual for frame: <a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=frame\" target=\"_blank\">http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=frame</a>', '2025-08-11 08:53:03'),
('yg', 'user', 'hi', '2025-08-11 09:05:17'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 09:05:17'),
('yg', 'user', 'can i get instruction manual for coffee table', '2025-08-11 09:05:32'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-11 09:05:32'),
('yg', 'user', 'coffee table', '2025-08-11 09:05:39'),
('yg', 'bot', 'Here’s the instruction manual for coffee table: http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=coffee%20table', '2025-08-11 09:05:39'),
('yg', 'user', 'can i get instruction manual for ergo chair', '2025-08-11 09:06:15'),
('yg', 'bot', 'Here’s the instruction manual for ergo chair: http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=ergo%20chair', '2025-08-11 09:06:15'),
('yg', 'user', 'can i get instruction manual for coffee table?', '2025-08-11 09:06:26'),
('yg', 'bot', 'Here’s the instruction manual for coffee table: http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=coffee%20table', '2025-08-11 09:06:26'),
('yg', 'user', 'can i get instruction manual', '2025-08-11 09:06:39'),
('yg', 'bot', 'Here’s the instruction manual for chair: http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=chair', '2025-08-11 09:06:39'),
('yg', 'user', 'hi', '2025-08-11 09:06:45'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 09:06:45'),
('yg', 'user', 'i would like to get insturction manual for my furniture', '2025-08-11 09:06:55'),
('yg', 'bot', 'Here’s the instruction manual for my furniture: http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=my%20furniture', '2025-08-11 09:06:55'),
('yg', 'user', 'instruction manual', '2025-08-11 09:07:57'),
('yg', 'bot', 'Here’s the instruction manual for chair:', '2025-08-11 09:07:57'),
('yg', 'user', 'can i get instruction manual for tv console', '2025-08-11 09:08:11'),
('yg', 'bot', 'Here’s the instruction manual for TV Console:', '2025-08-11 09:08:11'),
('yg', 'user', 'hi', '2025-08-11 09:09:23'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 09:09:23'),
('yg', 'user', 'can i get instruction manual for tv console', '2025-08-11 09:09:31'),
('yg', 'bot', 'Here’s the instruction manual for TV Console: [Click here](http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=TV%20Console)', '2025-08-11 09:09:31'),
('yg', 'user', 'hi', '2025-08-11 09:12:37'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 09:12:37'),
('yg', 'user', 'instruction manual for coffee table please', '2025-08-11 09:12:44'),
('yg', 'bot', 'Here’s the instruction manual for TV Console:', '2025-08-11 09:12:44'),
('yg', 'user', 'I need the manual for TV Console', '2025-08-11 09:17:25'),
('yg', 'bot', 'Here’s the instruction manual for TV Console: <a href=\'http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=TV Console\' target=\'_blank\'>Click here</a>', '2025-08-11 09:17:25'),
('yg', 'user', 'I need the manual for ergo chair', '2025-08-11 09:17:40'),
('yg', 'bot', 'Here’s the instruction manual for chair: <a href=\'http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=chair\' target=\'_blank\'>Click here</a>', '2025-08-11 09:17:40'),
('yg', 'user', 'can i get instruction manual', '2025-08-11 09:18:02'),
('yg', 'bot', 'Here’s the instruction manual for chair: <a href=\'http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=chair\' target=\'_blank\'>Click here</a>', '2025-08-11 09:18:02'),
('yg', 'user', 'need instruction manual', '2025-08-11 09:18:11'),
('yg', 'bot', 'Here’s the instruction manual for chair: <a href=\'http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=chair\' target=\'_blank\'>Click here</a>', '2025-08-11 09:18:11'),
('yg', 'user', 'hi', '2025-08-11 09:32:11'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 09:32:11'),
('yg', 'user', 'need instruction manual', '2025-08-11 09:32:16'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-11 09:32:16'),
('yg', 'user', 'coffee table', '2025-08-11 09:32:19'),
('yg', 'bot', 'What are the dimensions of your space? (e.g., 200x100x80 cm) || Which furniture item do you need the instruction manual for?', '2025-08-11 09:32:19'),
('yg', 'user', 'i need instruction manual for ergo chair', '2025-08-11 09:32:32'),
('yg', 'bot', 'Here’s the instruction manual for ergo chair: <a href=\'http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=ergo%20chair\' target=\'_blank\' rel=\'noopener\'>Click here</a>', '2025-08-11 09:32:32'),
('yg', 'user', 'i need instruction manual', '2025-08-11 09:32:39'),
('yg', 'bot', 'Here’s the instruction manual for ergo chair: <a href=\'http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=ergo%20chair\' target=\'_blank\' rel=\'noopener\'>Click here</a>', '2025-08-11 09:32:39'),
('yg', 'user', 'can i get instruction manual for tv console', '2025-08-11 09:33:51'),
('yg', 'bot', 'Here’s the instruction manual for tv console: <a href=\'http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=tv%20console\' target=\'_blank\' rel=\'noopener\'>Click here</a>', '2025-08-11 09:33:51'),
('yg', 'user', 'get i get instruction manual for coffee table', '2025-08-11 09:34:10'),
('yg', 'bot', 'Here’s the instruction manual for tv console: <a href=\'http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=tv%20console\' target=\'_blank\' rel=\'noopener\'>Click here</a>', '2025-08-11 09:34:10'),
('yg', 'user', 'can i get instruction manual for coffee table', '2025-08-11 09:40:48'),
('yg', 'bot', 'Here’s the instruction manual for tv console: <a href=\'http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=tv%20console\' target=\'_blank\' rel=\'noopener\'>Click here</a>', '2025-08-11 09:40:48'),
('yg', 'user', 'can i get instruction manual for coffee table', '2025-08-11 09:40:54'),
('yg', 'bot', 'Here’s the instruction manual for tv console: <a href=\'http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=tv%20console\' target=\'_blank\' rel=\'noopener\'>Click here</a>', '2025-08-11 09:40:54'),
('yg', 'user', 'can i get instruction manual for ergo chair', '2025-08-11 09:41:01'),
('yg', 'bot', 'Here’s the instruction manual for ergo chair: <a href=\'http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=ergo%20chair\' target=\'_blank\' rel=\'noopener\'>Click here</a>', '2025-08-11 09:41:01'),
('yg', 'user', 'can i get instruction manual for booksheld classic', '2025-08-11 09:41:11'),
('yg', 'bot', 'Here’s the instruction manual for booksheld classic: <a href=\'http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=booksheld%20classic\' target=\'_blank\' rel=\'noopener\'>Click here</a>', '2025-08-11 09:41:11'),
('yg', 'user', 'can i get instruction manual for table', '2025-08-11 09:41:22'),
('yg', 'bot', 'Here’s the instruction manual for booksheld classic: <a href=\'http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=booksheld%20classic\' target=\'_blank\' rel=\'noopener\'>Click here</a>', '2025-08-11 09:41:22'),
('yg', 'user', 'can i get instruction manual', '2025-08-11 09:42:10'),
('yg', 'bot', 'Here’s the instruction manual for booksheld classic: <a href=\'http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=booksheld%20classic\' target=\'_blank\' rel=\'noopener\'>Click here</a>', '2025-08-11 09:42:10'),
('yg', 'user', 'hi', '2025-08-11 09:56:11'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 09:56:11'),
('yg', 'user', 'I need the manual for Ergo Chair', '2025-08-11 09:56:41'),
('yg', 'bot', 'Here’s the instruction manual for ergo chair: <a href=\'http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=ergo%20chair\' target=\'_blank\' rel=\'noopener\'>Click here</a>', '2025-08-11 09:56:41'),
('yg', 'user', 'manual for Coffee Table', '2025-08-11 09:56:54'),
('yg', 'bot', 'Here’s the instruction manual for ergo chair: <a href=\'http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=ergo%20chair\' target=\'_blank\' rel=\'noopener\'>Click here</a>', '2025-08-11 09:56:54'),
('yg', 'user', 'show me the instructions for Recliner Seat', '2025-08-11 09:57:07'),
('yg', 'bot', 'Here’s the instruction manual for recliner seat: <a href=\'http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=recliner%20seat\' target=\'_blank\' rel=\'noopener\'>Click here</a>', '2025-08-11 09:57:07'),
('yg', 'user', 'assembly guide for Queen Bed Frame', '2025-08-11 09:57:19'),
('yg', 'bot', 'Here’s the instruction manual for Queen Bed Frame: <a href=\'http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Queen%20Bed%20Frame\' target=\'_blank\' rel=\'noopener\'>Click here</a>', '2025-08-11 09:57:19'),
('yg', 'user', 'where is the product manual for Bookshelf Classic?', '2025-08-11 09:57:30'),
('yg', 'bot', 'Here’s the instruction manual for Bookshelf Classic: <a href=\'http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Bookshelf%20Classic\' target=\'_blank\' rel=\'noopener\'>Click here</a>', '2025-08-11 09:57:30'),
('yg', 'user', 'manual for Coffee Table', '2025-08-11 09:57:43'),
('yg', 'bot', 'Here’s the instruction manual for Bookshelf Classic: <a href=\'http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Bookshelf%20Classic\' target=\'_blank\' rel=\'noopener\'>Click here</a>', '2025-08-11 09:57:43'),
('yg', 'user', 'I need the manual', '2025-08-11 09:57:53'),
('yg', 'bot', 'Here’s the instruction manual for Bookshelf Classic: <a href=\'http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Bookshelf%20Classic\' target=\'_blank\' rel=\'noopener\'>Click here</a>', '2025-08-11 09:57:53'),
('yg', 'user', 'instruction manual please', '2025-08-11 09:58:04'),
('yg', 'bot', 'Here’s the instruction manual for Bookshelf Classic: <a href=\'http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Bookshelf%20Classic\' target=\'_blank\' rel=\'noopener\'>Click here</a>', '2025-08-11 09:58:04'),
('yg', 'user', 'hi', '2025-08-11 10:42:23'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 10:42:23'),
('yg', 'user', 'can i get instruction manual', '2025-08-11 10:44:57'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-11 10:44:57'),
('yg', 'user', 'coffee table', '2025-08-11 10:45:03'),
('yg', 'bot', 'Sorry, I didn\'t understand that. Here\'s some common queries I can help you with: ||   1. Browse our furniture catalog  ||   2. Check your order status   ||   3. Leave feedback or a review   ||   4. Talk to a human agent   || Just type what you\'d like to do! || Which furniture item do you need the instruction manual for?', '2025-08-11 10:45:03'),
('yg', 'user', 'tv console', '2025-08-11 10:45:17'),
('yg', 'bot', 'Sorry, I didn\'t understand that. Here\'s some common queries I can help you with: ||   1. Browse our furniture catalog  ||   2. Check your order status   ||   3. Leave feedback or a review   ||   4. Talk to a human agent   || Just type what you\'d like to do! || Which furniture item do you need the instruction manual for?', '2025-08-11 10:45:17'),
('yg', 'user', 'can i get instruction manual for ergo chair', '2025-08-11 10:45:31'),
('yg', 'bot', 'Here’s the instruction manual for Chair: http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Chair', '2025-08-11 10:45:31'),
('yg', 'user', 'hi', '2025-08-11 10:46:01'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 10:46:01'),
('yg', 'user', 'get i can instruction manual for queen bed frame', '2025-08-11 10:46:09'),
('yg', 'bot', 'Here’s the instruction manual for Frame: http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Frame', '2025-08-11 10:46:09'),
('yg', 'user', 'hi', '2025-08-11 11:09:18'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 11:09:18'),
('yg', 'user', 'instrction manual please', '2025-08-11 11:09:22'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-11 11:09:22'),
('yg', 'user', 'ergo chair', '2025-08-11 11:09:26'),
('yg', 'bot', 'Sorry, I didn\'t understand that. Here\'s some common queries I can help you with: ||   1. Browse our furniture catalog  ||   2. Check your order status   ||   3. Leave feedback or a review   ||   4. Talk to a human agent   || Just type what you\'d like to do! || Which furniture item do you need the instruction manual for?', '2025-08-11 11:09:26'),
('yg', 'user', 'can i get instruction manuual for ergo chair', '2025-08-11 11:11:08'),
('yg', 'bot', 'Here’s the instruction manual for Chair: http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Chair', '2025-08-11 11:11:08'),
('yg', 'user', 'can i get instruction manual for coffee table', '2025-08-11 11:11:21'),
('yg', 'bot', 'Here’s the instruction manual for Chair: http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Chair', '2025-08-11 11:11:21'),
('yg', 'user', 'can i get instruction manual for queen bed frame', '2025-08-11 11:11:29'),
('yg', 'bot', 'Here’s the instruction manual for Frame: http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Frame', '2025-08-11 11:11:29'),
('yg', 'user', 'hi', '2025-08-11 11:25:12'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 11:25:12'),
('yg', 'user', 'can i get instruction manual?', '2025-08-11 11:25:18'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-11 11:25:18'),
('yg', 'user', 'ergo chair', '2025-08-11 11:25:21'),
('yg', 'bot', 'Sorry, I didn\'t understand that. Here\'s some common queries I can help you with: ||   1. Browse our furniture catalog  ||   2. Check your order status   ||   3. Leave feedback or a review   ||   4. Talk to a human agent   || Just type what you\'d like to do! || Which furniture item do you need the instruction manual for?', '2025-08-11 11:25:21'),
('yg', 'user', 'hi', '2025-08-11 11:30:49'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 11:30:49'),
('yg', 'user', 'instruction manual for ergo chair please', '2025-08-11 11:30:54'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-11 11:30:54'),
('yg', 'user', 'ergo chair', '2025-08-11 11:31:01'),
('yg', 'bot', 'Here’s the instruction manual for Ergo Chair: http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair', '2025-08-11 11:31:01'),
('yg', 'user', 'can i get instructoin manuual for coffee table', '2025-08-11 11:31:11'),
('yg', 'bot', 'Here’s the instruction manual for Ergo Chair: http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair', '2025-08-11 11:31:11'),
('yg', 'user', 'can i get instruction manual for qeen bed frame', '2025-08-11 11:31:21'),
('yg', 'bot', 'Here’s the instruction manual for Ergo Chair: http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair', '2025-08-11 11:31:21'),
('yg', 'user', 'i need instruction manuual', '2025-08-11 11:31:31'),
('yg', 'bot', 'Here’s the instruction manual for Ergo Chair: http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair', '2025-08-11 11:31:31'),
('yg', 'user', 'instruction manual', '2025-08-11 11:31:39'),
('yg', 'bot', 'Here’s the instruction manual for Ergo Chair: http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair', '2025-08-11 11:31:39'),
('yg', 'user', 'hi', '2025-08-11 11:41:07'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 11:41:07'),
('yg', 'user', 'would like to get instructoin manual', '2025-08-11 11:41:15'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-11 11:41:15'),
('yg', 'user', 'ergo chair', '2025-08-11 11:41:20'),
('yg', 'bot', 'Here’s the instruction manual for Ergo Chair: Click here\nhttp://localhost/FYP-25-S2-34-Chatbot/manuals/ergo-chair.pdf', '2025-08-11 11:41:20'),
('yg', 'user', 'would like to get instruction manual for ergo chair', '2025-08-11 11:41:33'),
('yg', 'bot', 'Here’s the instruction manual for Ergo Chair: Click here\nhttp://localhost/FYP-25-S2-34-Chatbot/manuals/ergo-chair.pdf', '2025-08-11 11:41:33'),
('yg', 'user', 'can i get instruction manual for coffee table', '2025-08-11 11:41:42'),
('yg', 'bot', 'Here’s the instruction manual for Ergo Chair: Click here\nhttp://localhost/FYP-25-S2-34-Chatbot/manuals/ergo-chair.pdf', '2025-08-11 11:41:42'),
('yg', 'user', 'can i get instruction manual for queen bed frame', '2025-08-11 11:42:00'),
('yg', 'bot', 'Here’s the instruction manual for Ergo Chair: Click here\nhttp://localhost/FYP-25-S2-34-Chatbot/manuals/ergo-chair.pdf', '2025-08-11 11:42:00'),
('yg', 'user', 'can i get instruction manual for bookshelf classic', '2025-08-11 11:42:13'),
('yg', 'bot', 'Here’s the instruction manual for Ergo Chair: Click here\nhttp://localhost/FYP-25-S2-34-Chatbot/manuals/ergo-chair.pdf', '2025-08-11 11:42:13'),
('yg', 'user', 'hi', '2025-08-11 11:48:13'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 11:48:13'),
('yg', 'user', 'instruction manuual', '2025-08-11 11:48:20'),
('yg', 'bot', 'Here’s the instruction manual search for \"Ergo Chair\": http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=instruction%20manuual', '2025-08-11 11:48:20'),
('yg', 'user', 'hi', '2025-08-11 11:55:44'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 11:55:44'),
('yg', 'user', 'can i get instruction manual for ergo chair', '2025-08-11 11:55:56'),
('yg', 'bot', 'Here’s the instruction manual search for \"Ergo Chair\": http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=can%20i%20get%20instruction%20manual%20for%20ergo%20chair', '2025-08-11 11:55:56'),
('yg', 'user', 'hi there', '2025-08-11 11:56:00'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 11:56:00'),
('yg', 'user', 'can i get instruction manal for coffee table', '2025-08-11 11:56:08'),
('yg', 'bot', 'Here’s the instruction manual search for \"Ergo Chair\": http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=can%20i%20get%20instruction%20manal%20for%20coffee%20table', '2025-08-11 11:56:08'),
('yg', 'user', 'instruction manual for coffee table please?', '2025-08-11 11:58:23'),
('yg', 'bot', 'Here’s the instruction manual search for \"Ergo Chair\": http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=instruction%20manual%20for%20coffee%20table%20please%3F', '2025-08-11 11:58:23'),
('yg', 'user', 'hi', '2025-08-11 12:01:00'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 12:01:00'),
('yg', 'user', 'instruction manual for coffee table please?', '2025-08-11 12:01:03'),
('yg', 'bot', 'Here’s the instruction manual search for \"Ergo Chair\": http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=instruction%20manual%20for%20coffee%20table%20please', '2025-08-11 12:01:03'),
('yg', 'user', 'instruction manual for ergo chair', '2025-08-11 12:08:14'),
('yg', 'bot', 'Here’s the instruction manual search for \"Ergo Chair\": http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=instruction%20manual%20for%20ergo%20chair', '2025-08-11 12:08:14'),
('yg', 'user', 'hi', '2025-08-11 12:10:37'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 12:10:37'),
('yg', 'user', 'can i get instruction manual for ergo chair', '2025-08-11 12:10:43'),
('yg', 'bot', 'Here’s the instruction manual search based on what you typed:\n[http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=can%20i%20get%20instruction%20manual%20for%20ergo%20chair](http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=can%20i%20get%20instruction%20manual%20for%20ergo%20chair)', '2025-08-11 12:10:43'),
('yg', 'user', 'can i get instruction manual for coffee table', '2025-08-11 12:11:47'),
('yg', 'bot', 'Here’s the instruction manual search for **Coffee Table**:\n[http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=can%20i%20get%20instruction%20manual%20for%20coffee%20table](http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=can%20i%20get%20instruction%20manual%20for%20coffee%20table)', '2025-08-11 12:11:47'),
('yg', 'user', 'hi', '2025-08-11 12:17:01'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 12:17:01'),
('yg', 'user', 'can i get instruction manual for ergo chair', '2025-08-11 12:17:09'),
('yg', 'user', 'can i get instruuction manual for coffee table', '2025-08-11 12:17:19'),
('yg', 'user', 'hi', '2025-08-11 12:19:07'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 12:19:07'),
('yg', 'user', 'can i get instruction manual for ergo chair', '2025-08-11 12:19:14'),
('yg', 'user', 'hi', '2025-08-11 12:22:54'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 12:22:54'),
('yg', 'user', 'can i get instruction manual for ergo chair', '2025-08-11 12:22:57'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Ergo Chair</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=can%20i%20get%20instruction%20manual%20for%20ergo%20chair\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=can%20i%20get%20instruction%20manual%20for%20ergo%20chair', '2025-08-11 12:22:57'),
('yg', 'user', 'can i get instruction manual for coffee table', '2025-08-11 12:23:32'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Coffee Table</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=can%20i%20get%20instruction%20manual%20for%20coffee%20table\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=can%20i%20get%20instruction%20manual%20for%20coffee%20table', '2025-08-11 12:23:32'),
('yg', 'user', 'can i get instruction manual for coffee table', '2025-08-11 12:27:49'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Coffee Table</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Coffee%20Table\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Coffee%20Table', '2025-08-11 12:27:49'),
('yg', 'user', 'can i get instruction manual for table', '2025-08-11 12:28:00'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Coffee Table</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Coffee%20Table\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Coffee%20Table', '2025-08-11 12:28:00'),
('yg', 'user', 'can i get instruction manual for ergo chair', '2025-08-11 12:28:17'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Ergo Chair</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair', '2025-08-11 12:28:17'),
('yg', 'user', 'can i get instruction manual for bookshelf classic', '2025-08-11 12:28:28'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Bookshelf Classic</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Bookshelf%20Classic\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Bookshelf%20Classic', '2025-08-11 12:28:28'),
('yg', 'user', 'can i get instruction manual', '2025-08-11 12:28:39'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Bookshelf Classic</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Bookshelf%20Classic\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Bookshelf%20Classic', '2025-08-11 12:28:39'),
('yg', 'user', 'can i get instruction manual for coffee table', '2025-08-11 12:32:07'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Coffee Table</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Coffee%20Table\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Coffee%20Table', '2025-08-11 12:32:07'),
('yg', 'user', 'hi', '2025-08-11 12:32:11'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 12:32:11'),
('yg', 'user', 'can i get instruction manual', '2025-08-11 12:32:17'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-11 12:32:17'),
('yg', 'user', 'ergo chair', '2025-08-11 12:32:22'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Ergo Chair</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair', '2025-08-11 12:32:22'),
('yg', 'user', 'hi', '2025-08-11 12:32:26'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 12:32:26'),
('yg', 'user', 'can i get instruction manual', '2025-08-11 12:32:34'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-11 12:32:34'),
('yg', 'user', 'coffee table', '2025-08-11 12:32:40'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Coffee Table</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Coffee%20Table\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Coffee%20Table', '2025-08-11 12:32:40'),
('yg', 'user', 'instruction manual for coffee table', '2025-08-11 12:33:34'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Coffee Table</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Coffee%20Table\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Coffee%20Table', '2025-08-11 12:33:34'),
('yg', 'user', 'Manual for ERGO CHAIR, please!', '2025-08-11 12:33:44'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Ergo Chair</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair', '2025-08-11 12:33:44'),
('yg', 'user', 'an i get instruction manual for tv console', '2025-08-11 12:33:56'),
('yg', 'bot', 'Here’s the instruction manual search for <b>TV Console</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=TV%20Console\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=TV%20Console', '2025-08-11 12:33:56'),
('yg', 'user', 'manual for coffe table', '2025-08-11 12:34:11'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-11 12:34:11'),
('yg', 'user', 'coffee table', '2025-08-11 12:34:17'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Coffee Table</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Coffee%20Table\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Coffee%20Table', '2025-08-11 12:34:17'),
('yg', 'user', 'can i get instruction manual', '2025-08-11 12:34:28'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-11 12:34:28'),
('yg', 'user', 'queen bed frame', '2025-08-11 12:34:39'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Queen Bed Frame</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Queen%20Bed%20Frame\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Queen%20Bed%20Frame', '2025-08-11 12:34:39'),
('yg', 'user', 'manual for coffee table and tv console', '2025-08-11 12:34:49'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Coffee Table</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Coffee%20Table\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Coffee%20Table', '2025-08-11 12:34:49'),
('yg', 'user', 'assembly guide for recliner', '2025-08-11 12:35:05'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-11 12:35:05'),
('yg', 'user', 'recliner', '2025-08-11 12:35:11'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-11 12:35:11'),
('yg', 'user', 'recliner seat', '2025-08-11 12:35:23'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Recliner Seat</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Recliner%20Seat\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Recliner%20Seat', '2025-08-11 12:35:23'),
('yg', 'user', 'pls manual 🙏 for bookshelf classic', '2025-08-11 12:35:34'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Bookshelf Classic</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Bookshelf%20Classic\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Bookshelf%20Classic', '2025-08-11 12:35:34'),
('yg', 'user', 'manual for tv console?', '2025-08-11 12:36:01'),
('yg', 'bot', 'Here’s the instruction manual search for <b>TV Console</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=TV%20Console\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=TV%20Console', '2025-08-11 12:36:01'),
('yg', 'user', 'insturction manual please', '2025-08-11 13:09:42'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-11 13:09:42'),
('yg', 'user', 'i want instructoin manual', '2025-08-11 13:11:29'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-11 13:11:29'),
('yg', 'user', 'coffee table', '2025-08-11 13:11:34'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Coffee Table</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Coffee%20Table\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Coffee%20Table', '2025-08-11 13:11:34'),
('yg', 'user', 'can i get instructoin manual', '2025-08-11 13:11:59'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-11 13:11:59'),
('yg', 'user', 'table', '2025-08-11 13:12:04'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-11 13:12:04'),
('yg', 'user', 'can i get instructoin manual for recliner seat', '2025-08-11 13:13:03'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Recliner Seat</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Recliner%20Seat\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Recliner%20Seat', '2025-08-11 13:13:03'),
('yg', 'user', 'hi', '2025-08-11 13:46:53'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 13:46:53'),
('yg', 'user', 'can i get instruction manual for my furinutre?', '2025-08-11 13:47:02'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-11 13:47:02'),
('yg', 'user', 'chair', '2025-08-11 13:47:10'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-11 13:47:10'),
('yg', 'user', 'can i get instruction manual', '2025-08-11 13:51:10'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-11 13:51:10'),
('yg', 'user', 'chair', '2025-08-11 13:51:20');
INSERT INTO `chat_messages` (`username`, `sender`, `message_text`, `created_at`) VALUES
('yg', 'bot', 'Here’s the instruction manual search for <b>chair</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=chair\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=chair', '2025-08-11 13:51:20'),
('yg', 'user', 'assembly guide for recliner', '2025-08-11 13:51:33'),
('yg', 'bot', 'Here’s the instruction manual search for <b>assembly guide for recliner</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=assembly%20guide%20for%20recliner\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=assembly%20guide%20for%20recliner', '2025-08-11 13:51:33'),
('yg', 'user', 'manual for recliner', '2025-08-11 14:01:24'),
('yg', 'bot', 'Here’s the instruction manual search for <b>manual for recliner</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=manual%20for%20recliner\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=manual%20for%20recliner', '2025-08-11 14:01:24'),
('yg', 'user', 'can i get a manual for ergo chair', '2025-08-11 14:02:57'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Ergo Chair</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair', '2025-08-11 14:02:57'),
('yg', 'user', 'can i get manual for chair', '2025-08-11 14:03:06'),
('yg', 'bot', 'Here’s the instruction manual search for <b>can i get manual for chair</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=can%20i%20get%20manual%20for%20chair\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=can%20i%20get%20manual%20for%20chair', '2025-08-11 14:03:06'),
('yg', 'user', 'CAN I GET manual for recliner', '2025-08-11 14:15:03'),
('yg', 'bot', 'Here’s the instruction manual search for <b>CAN I GET manual for recliner</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=CAN%20I%20GET%20manual%20for%20recliner\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=CAN%20I%20GET%20manual%20for%20recliner', '2025-08-11 14:15:03'),
('yg', 'user', 'manual for recliner', '2025-08-11 14:15:14'),
('yg', 'bot', 'Here’s the instruction manual search for <b>manual for recliner</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=manual%20for%20recliner\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=manual%20for%20recliner', '2025-08-11 14:15:14'),
('yg', 'user', 'hi', '2025-08-11 14:16:10'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 14:16:10'),
('yg', 'user', 'manual for recliner please', '2025-08-11 14:16:15'),
('yg', 'user', 'can i get manual for recliner', '2025-08-11 14:16:23'),
('yg', 'user', 'hi', '2025-08-11 14:16:25'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 14:16:25'),
('yg', 'user', 'instruction manual', '2025-08-11 14:16:31'),
('yg', 'user', 'hi', '2025-08-11 14:17:26'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 14:17:26'),
('yg', 'user', 'instruction manual', '2025-08-11 14:17:31'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-11 14:17:31'),
('yg', 'user', 'ergo chair', '2025-08-11 14:17:36'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Ergo Chair</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair', '2025-08-11 14:17:36'),
('yg', 'user', 'instruction manual for recliner', '2025-08-11 14:17:42'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Recliner Seat</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Recliner%20Seat\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Recliner%20Seat', '2025-08-11 14:17:42'),
('yg', 'user', 'can i get instruction manual', '2025-08-11 14:17:58'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-11 14:17:58'),
('yg', 'user', 'queen bed frame', '2025-08-11 14:18:04'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Queen Bed Frame</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Queen%20Bed%20Frame\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Queen%20Bed%20Frame', '2025-08-11 14:18:04'),
('yg', 'user', 'can i get instruction manuual for a bed frame', '2025-08-11 14:18:12'),
('yg', 'bot', 'Here’s the instruction manual search for <b>bed frame</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=bed%20frame\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=bed%20frame', '2025-08-11 14:18:13'),
('yg', 'user', 'hello', '2025-08-11 14:18:22'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-11 14:18:22'),
('yg', 'user', 'can i get instruction manual for my tv console', '2025-08-11 14:18:32'),
('yg', 'bot', 'Here’s the instruction manual search for <b>TV Console</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=TV%20Console\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=TV%20Console', '2025-08-11 14:18:32'),
('yg', 'user', 'can i get instruction manual', '2025-08-11 14:18:48'),
('yg', 'bot', 'Which furniture item do you need the instruction manual for?', '2025-08-11 14:18:48'),
('yg', 'user', 'bookshelf', '2025-08-11 14:18:58'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Bookshelf Classic</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Bookshelf%20Classic\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Bookshelf%20Classic', '2025-08-11 14:18:58'),
('yg', 'user', 'hi', '2025-08-12 17:02:14'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-12 17:02:14'),
('yg', 'user', 'can i get instructoin manuual for ergo chair ?', '2025-08-12 17:02:23'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Ergo Chair</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair', '2025-08-12 17:02:23'),
('yg', 'user', 'how abotu bookshelf classic ?', '2025-08-12 17:02:54'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Bookshelf Classic</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Bookshelf%20Classic\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Bookshelf%20Classic', '2025-08-12 17:02:54'),
('yg', 'user', 'recliner seat', '2025-08-12 17:03:04'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Recliner Seat</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Recliner%20Seat\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Recliner%20Seat', '2025-08-12 17:03:04'),
('yg', 'user', 'gimmie the recliner seat manual', '2025-08-12 17:08:19'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Recliner Seat</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Recliner%20Seat\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Recliner%20Seat', '2025-08-12 17:08:19'),
('yg', 'user', 'dont give me the instruction manual for recliner seat', '2025-08-12 17:08:36'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Recliner Seat</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Recliner%20Seat\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Recliner%20Seat', '2025-08-12 17:08:36'),
('yg', 'user', 'hi', '2025-08-12 17:08:39'),
('yg', 'bot', 'Hi there! How can I assist you today?', '2025-08-12 17:08:39'),
('yg', 'user', 'can i get studdy desk', '2025-08-12 17:08:46'),
('yg', 'bot', 'Sorry, I didn\'t understand that. Here\'s some common queries I can help you with: ||   1. Browse our furniture catalog \n  2. Check your order status  \n  3. Leave feedback or a review  \n  4. Talk to a human agent   || Just type what you\'d like to do!', '2025-08-12 17:08:46'),
('yg', 'user', 'study desk', '2025-08-12 17:08:53'),
('yg', 'bot', 'I need your order ID to cancel your order.', '2025-08-12 17:08:53'),
('yg', 'user', 'talk to a human agent', '2025-08-12 17:09:29'),
('yg', 'bot', 'Connecting you to a human agent now...', '2025-08-12 17:09:29'),
('yg', 'user', 'exit', '2025-08-12 17:09:53'),
('yg', 'user', 'recommend me some furnitures', '2025-08-12 17:10:07'),
('yg', 'bot', 'What are the dimensions of your space? (e.g., 200x100x80 cm)', '2025-08-12 17:10:07'),
('yg', 'user', '1x1x1', '2025-08-12 17:10:14'),
('yg', 'bot', 'I would recommend the <a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/viewFurnitureDetailsUI.php?id=3\">Ergo Chair</a>', '2025-08-12 17:10:14'),
('yg', 'user', '1x1x1', '2025-08-12 17:10:24'),
('yg', 'bot', 'I would recommend the <a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/viewFurnitureDetailsUI.php?id=3\">Ergo Chair</a>', '2025-08-12 17:10:24'),
('yg', 'user', '1x1x1', '2025-08-12 17:10:36'),
('yg', 'bot', 'I would recommend the <a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/viewFurnitureDetailsUI.php?id=3\">Ergo Chair</a>', '2025-08-12 17:10:36'),
('yg', 'user', 'qeen bed frame', '2025-08-12 17:10:44'),
('yg', 'bot', 'Here’s the instruction manual search for <b>bed frame</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=bed%20frame\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=bed%20frame', '2025-08-12 17:10:44'),
('yg', 'user', 'can i check on my order', '2025-08-13 08:24:17'),
('yg', 'bot', 'I couldn’t find any orders on your account.', '2025-08-13 08:24:17'),
('yg', 'user', 'can i see my orders', '2025-08-13 08:25:21'),
('yg', 'bot', 'I couldn’t find any orders on your account.', '2025-08-13 08:25:21'),
('yg', 'user', 'check order', '2025-08-13 08:25:39'),
('yg', 'bot', 'I couldn’t find any orders on your account.', '2025-08-13 08:25:39'),
('yg', 'user', 'cancel order', '2025-08-13 08:56:30'),
('yg', 'bot', 'I couldn’t find any orders on your account.', '2025-08-13 08:56:30'),
('yg', 'user', 'check order', '2025-08-13 08:58:43'),
('yg', 'bot', 'I couldn’t find any orders on your account.', '2025-08-13 08:58:43'),
('yg', 'user', 'instruction manual for ergo chair please', '2025-08-13 08:59:39'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Ergo Chair</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair', '2025-08-13 08:59:39'),
('yg', 'user', 'hi there', '2025-08-13 09:04:09'),
('yg', 'bot', 'Hi there! How can I assist you today? || Please choose an option:', '2025-08-13 09:04:09'),
('yg', 'user', 'can i get instruction manual for coffee table', '2025-08-13 09:04:50'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Coffee Table</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Coffee%20Table\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Coffee%20Table', '2025-08-13 09:04:50'),
('yg', 'user', 'hi', '2025-08-13 09:05:58'),
('yg', 'bot', 'Hi there! How can I assist you today? || Please choose an option:', '2025-08-13 09:05:58'),
('yg', 'user', 'test', '2025-08-13 09:06:01'),
('yg', 'bot', 'I need your order ID to cancel your order.', '2025-08-13 09:06:01'),
('yg', 'user', 'test', '2025-08-13 09:06:03'),
('yg', 'bot', 'I need your order ID to cancel your order.', '2025-08-13 09:06:03'),
('yg', 'user', 'test', '2025-08-13 09:06:10'),
('yg', 'bot', 'I need your order ID to cancel your order.', '2025-08-13 09:06:10'),
('yg', 'user', 'test', '2025-08-13 09:23:03'),
('yg', 'bot', 'I need your order ID to cancel your order.', '2025-08-13 09:23:03'),
('yg', 'user', 'test', '2025-08-13 09:23:11'),
('yg', 'bot', 'I need your order ID to cancel your order.', '2025-08-13 09:23:11'),
('yg', 'user', 'can i get instruction manual for tv console', '2025-08-13 09:24:51'),
('yg', 'bot', 'Here’s the instruction manual search for <b>TV Console</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=TV%20Console\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=TV%20Console', '2025-08-13 09:24:51'),
('yg', 'user', 'hi', '2025-08-13 09:31:27'),
('yg', 'bot', 'Hi there! How can I assist you today? || Please choose an option:', '2025-08-13 09:31:27'),
('yg', 'user', 'can i get instruction manual for ergo chair?', '2025-08-13 09:31:39'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Ergo Chair</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair', '2025-08-13 09:31:39'),
('yg', 'user', 'instruction manual for tv console', '2025-08-13 09:33:11'),
('yg', 'bot', 'Here’s the instruction manual search for <b>TV Console</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=TV%20Console\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=TV%20Console', '2025-08-13 09:33:11'),
('yg', 'user', 'hi', '2025-08-13 10:08:29'),
('yg', 'bot', 'Hi there! How can I assist you today? || Please choose an option:', '2025-08-13 10:08:29'),
('yg', 'user', 'hi can i get instruction manual for queen bed frame', '2025-08-13 10:08:41'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Queen Bed Frame</b>: [Open manual search](http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Queen%20Bed%20Frame)', '2025-08-13 10:08:41'),
('yg', 'user', 'hi', '2025-08-13 10:18:24'),
('yg', 'bot', 'Hi there! How can I assist you today? || Please choose an option:', '2025-08-13 10:18:24'),
('yg', 'user', 'instruction manual for coffee table', '2025-08-13 10:18:31'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Coffee Table</b>: http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Coffee%20Table', '2025-08-13 10:18:31'),
('yg', 'user', 'yoyoyo', '2025-08-13 10:19:30'),
('yg', 'bot', 'Sorry, I didn\'t understand that. Here\'s some common queries I can help you with: ||   1. Browse our furniture catalog \n  2. Check your order status  \n  3. Leave feedback or a review  \n  4. Talk to a human agent   || Just type what you\'d like to do!', '2025-08-13 10:19:30'),
('yg', 'user', 'yo', '2025-08-13 10:19:36'),
('yg', 'user', 'can i get instruction manual for tv console', '2025-08-13 10:19:47'),
('yg', 'user', 'can i get instruction manual for ergo chair', '2025-08-13 10:19:59'),
('yg', 'user', 'hi', '2025-08-13 10:20:23'),
('yg', 'bot', 'Hi there! How can I assist you today? || Please choose an option:', '2025-08-13 10:20:23'),
('yg', 'user', 'can i get instrction manal for coffee table', '2025-08-13 10:20:35'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Coffee Table</b>', '2025-08-13 10:20:35'),
('yg', 'user', 'hi', '2025-08-13 10:23:18'),
('yg', 'bot', 'Hi there! How can I assist you today? || Please choose an option:', '2025-08-13 10:23:18'),
('yg', 'user', 'can i get manal for bookshelf classic', '2025-08-13 10:23:32'),
('yg', 'user', 'can i get instruction manual for queen bed frame', '2025-08-13 10:23:47'),
('yg', 'user', 'hi can i get instruction manual for tv console', '2025-08-13 10:24:33'),
('yg', 'user', 'hi', '2025-08-13 10:38:39'),
('yg', 'bot', 'Hi there! How can I assist you today? || Please choose an option:', '2025-08-13 10:38:39'),
('yg', 'user', 'check orders', '2025-08-13 10:38:47'),
('yg', 'bot', '**Your Orders:**\n- Order #8 — pending\n- Order #7 — pending\n- Order #6 — cancelled\n- Order #5 — cancelled\n- Order #4 — pending\n- Order #3 — pending\n- Order #2 — pending\n- Order #1 — cancelled || Which order would you like to check? (I’ve listed your orders above.) You can click a button or type the order ID.', '2025-08-13 10:38:47'),
('yg', 'user', 'order 2', '2025-08-13 10:38:56'),
('yg', 'bot', '**Order #2**\n- Status: pending\n- Placed: 2025-06-20 18:43:15\n- Total: $1156.56\n- Ship to: Pasir Ris Drive 3 Block 632 #09-400, asdasd, AK 510632\n- Items:\n  • Queen Bed Frame × 1 — $699.00\n  • Coffee Table × 1 — $159.00\n  • Ergo Chair × 1 — $199.00\n**ETA:** 5 days.', '2025-08-13 10:38:56'),
('yg', 'user', 'can i cancel order', '2025-08-13 10:40:22'),
('yg', 'bot', '**Your Orders:**\n- Order #8 — pending\n- Order #7 — pending\n- Order #6 — cancelled\n- Order #5 — cancelled\n- Order #4 — pending\n- Order #3 — pending\n- Order #2 — pending\n- Order #1 — cancelled || Which order would you like to cancel? (I’ve listed your orders above.) You can click a button or type the order ID.', '2025-08-13 10:40:22'),
('yg', 'user', 'cancel order 2', '2025-08-13 10:40:30'),
('yg', 'bot', '**Your Orders:**\n- Order #8 — pending\n- Order #7 — pending\n- Order #6 — cancelled\n- Order #5 — cancelled\n- Order #4 — pending\n- Order #3 — pending\n- Order #2 — pending\n- Order #1 — cancelled || Which order would you like to cancel? (I’ve listed your orders above.) You can click a button or type the order ID.', '2025-08-13 10:40:30'),
('yg', 'user', '2', '2025-08-13 10:40:35'),
('yg', 'user', 'cancel order', '2025-08-13 10:40:43'),
('yg', 'bot', '**Your Orders:**\n- Order #8 — pending\n- Order #7 — pending\n- Order #6 — cancelled\n- Order #5 — cancelled\n- Order #4 — pending\n- Order #3 — pending\n- Order #2 — pending\n- Order #1 — cancelled || Which order would you like to cancel? (I’ve listed your orders above.) You can click a button or type the order ID.', '2025-08-13 10:40:43'),
('yg', 'user', '2', '2025-08-13 10:40:45'),
('yg', 'user', 'instructioin manual for ergo chair', '2025-08-13 10:41:40'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Ergo Chair</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair', '2025-08-13 10:41:40'),
('yg', 'user', 'canel order', '2025-08-13 10:43:05'),
('yg', 'bot', '**Your Orders:**\n- Order #8 — pending\n- Order #7 — pending\n- Order #6 — cancelled\n- Order #5 — cancelled\n- Order #4 — pending\n- Order #3 — pending\n- Order #2 — pending\n- Order #1 — cancelled || Which order would you like to cancel? (I’ve listed your orders above.) You can click a button or type the order ID.', '2025-08-13 10:43:05'),
('yg', 'user', '2', '2025-08-13 10:43:10'),
('yg', 'user', 'hi', '2025-08-13 10:45:48'),
('yg', 'bot', 'Hi there! How can I assist you today? || Please choose an option:', '2025-08-13 10:45:48'),
('yg', 'user', 'cancel order', '2025-08-13 10:45:51'),
('yg', 'bot', '**Your Orders:**\n- Order #8 — pending\n- Order #7 — pending\n- Order #6 — cancelled\n- Order #5 — cancelled\n- Order #4 — pending\n- Order #3 — pending\n- Order #2 — pending\n- Order #1 — cancelled || Which order would you like to cancel? (I’ve listed your orders above.) You can click a button or type the order ID.', '2025-08-13 10:45:51'),
('yg', 'user', '2', '2025-08-13 10:45:52'),
('yg', 'user', 'hi', '2025-08-13 10:52:04'),
('yg', 'bot', 'Hi there! How can I assist you today? || Please choose an option:', '2025-08-13 10:52:04'),
('yg', 'user', '2', '2025-08-13 10:52:11'),
('yg', 'bot', 'Confirm cancel for order #2?', '2025-08-13 10:52:11'),
('yg', 'user', 'can i get instruction manual for ergo chair', '2025-08-13 10:52:33'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Ergo Chair</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair', '2025-08-13 10:52:33'),
('yg', 'user', 'hi', '2025-08-13 10:55:39'),
('yg', 'bot', 'Hi there! How can I assist you today? || Please choose an option:', '2025-08-13 10:55:39'),
('yg', 'user', 'can i get instruction manual for ergo chair', '2025-08-13 10:55:50'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Ergo Chair</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair', '2025-08-13 10:55:50'),
('yg', 'user', 'hi', '2025-08-13 11:35:15'),
('yg', 'bot', 'Hi there! How can I assist you today? || Please choose an option:', '2025-08-13 11:35:15'),
('yg', 'user', 'hi', '2025-08-13 14:56:15'),
('yg', 'bot', 'Hi there! How can I assist you today? || Please choose an option:', '2025-08-13 14:56:15'),
('yg', 'user', 'hi', '2025-08-13 15:22:13'),
('yg', 'bot', 'Hi there! How can I assist you today? || Please choose an option:', '2025-08-13 15:22:13'),
('yg', 'user', 'instruction for ergo chair', '2025-08-13 15:22:19'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Ergo Chair</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Ergo%20Chair', '2025-08-13 15:22:19'),
('yg', 'user', 'can i get instruction for queen bed', '2025-08-13 15:23:25'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Queen Bed Frame</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Queen%20Bed%20Frame\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Queen%20Bed%20Frame', '2025-08-13 15:23:25'),
('yg', 'user', 'gimmie money pls', '2025-08-13 17:00:13'),
('yg', 'bot', 'Hi there! How can I assist you today? || Please choose an option:', '2025-08-13 17:00:13'),
('yg', 'user', 'hi', '2025-08-13 17:08:59'),
('yg', 'bot', 'Hi there! How can I assist you today? || Please choose an option:', '2025-08-13 17:08:59'),
('yg', 'user', 'hi', '2025-08-13 17:13:36'),
('yg', 'bot', 'Hi there! How can I assist you today? || Please choose an option:', '2025-08-13 17:13:36'),
('yg', 'user', 'goodbye', '2025-08-13 17:15:07'),
('yg', 'bot', 'Goodbye! Let me know if you need anything else.', '2025-08-13 17:15:07'),
('yg', 'user', 'when will my order arriive', '2025-08-13 17:15:19'),
('yg', 'bot', '**Your Orders:**\n- Order #8 — pending\n- Order #7 — pending\n- Order #6 — cancelled\n- Order #5 — cancelled\n- Order #4 — pending\n- Order #3 — pending\n- Order #2 — cancelled\n- Order #1 — cancelled || Which order would you like to check? (I’ve listed your orders above.) You can click a button or type the order ID.', '2025-08-13 17:15:19'),
('yg', 'user', 'show me sofa', '2025-08-13 17:15:46'),
('yg', 'bot', 'Here’s the instruction manual search for <b>sofa</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=sofa\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=sofa', '2025-08-13 17:15:46'),
('yg', 'user', 'hi i need help', '2025-08-13 17:16:11'),
('yg', 'bot', 'Here\'s some common queries I can help you with: ||   1. Browse our furniture catalog \n  2. Check your order status  \n  3. Leave feedback or a review  \n  4. Talk to a human agent   || Just type what you\'d like to do!', '2025-08-13 17:16:11'),
('yg', 'user', 'can i get instruction manual for recliner seat', '2025-08-13 17:18:39'),
('yg', 'bot', 'Here’s the instruction manual search for <b>Recliner Seat</b>:<br><a href=\"http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Recliner%20Seat\" target=\"_blank\" rel=\"noopener noreferrer\">Open manual search</a><br>http://localhost/FYP-25-S2-34-Chatbot/Src/Boundary/Customer/CustomerInstructionManualUI.php?q=Recliner%20Seat', '2025-08-13 17:18:39'),
('yg2', 'user', 'hey', '2025-08-13 11:42:05'),
('yg2', 'bot', 'Hi there! How can I assist you today? || Please choose an option:', '2025-08-13 11:42:05');

-- --------------------------------------------------------

--
-- Table structure for table `furnitures`
--

CREATE TABLE `furnitures` (
  `furnitureID` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `category` varchar(20) NOT NULL,
  `description` varchar(100) NOT NULL,
  `price` varchar(10) NOT NULL,
  `stock_quantity` int(10) NOT NULL,
  `image_url` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `furnitures`
--

INSERT INTO `furnitures` (`furnitureID`, `name`, `category`, `description`, `price`, `stock_quantity`, `image_url`) VALUES
(3, 'Ergo Chair', 'Chair', 'Ergonomic office chair with lumbar support', '199.00', 12, '../../img/ergochair.jpg'),
(4, 'Coffee Table', 'Table', 'Minimalist glass coffee table', '159.00', 7, '../../img/coffeetable.jpg'),
(5, 'Queen Bed Frame', 'Bed', 'Queen size bed frame with storage drawers', '699.00', 4, '../../img/queenbedframe.jpg'),
(6, 'Bookshelf Classic', 'Shelf', '5-tier wooden bookshelf', '249.00', 9, '../../img/bookshelf.jpg'),
(7, 'TV Console', 'Storage', 'Low-rise TV console with cable management', '399.00', 6, '../../img/tvconsole.jpg'),
(8, 'Recliner Seat', 'Sofa', 'Plush recliner with adjustable headrest', '499.00', 2, '../../img/reclinerseat.jpg'),
(9, 'Study Desk', 'Table', 'Compact study desk with side drawers', '299.00', 10, '../../img/studydesk.jpg'),
(10, 'Bar Stool Set', 'Chair', 'Set of 2 bar stools with footrest', '179.00', 8, '../../img/barstool.jpg'),
(11, 'Bed', 'Bedroom', 'bed', '1299.90', 5, '../../img/bed.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `instruction_manuals`
--

CREATE TABLE `instruction_manuals` (
  `manualID` int(11) NOT NULL,
  `product_name` varchar(150) NOT NULL,
  `product_code` varchar(80) DEFAULT NULL,
  `keywords` text DEFAULT NULL,
  `manual_url` varchar(255) NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `instruction_manuals`
--

INSERT INTO `instruction_manuals` (`manualID`, `product_name`, `product_code`, `keywords`, `manual_url`, `updated_at`) VALUES
(1, 'Ergo Chair', 'CHA-ERGO', 'chair ergonomic lumbar support office', '/assets/manuals/ergo_chair.pdf', '2025-08-11 00:17:22'),
(2, 'Coffee Table', 'TAB-COFF', 'table coffee glass minimalist living room', '/assets/manuals/coffee_table.pdf', '2025-08-11 00:17:22'),
(3, 'Queen Bed Frame', 'BED-QFRM', 'bed frame queen storage drawers bedroom', '/assets/manuals/queen_bed_frame.pdf', '2025-08-11 00:17:22'),
(4, 'Bookshelf Classic', 'SHE-BCLS', 'bookshelf shelf wooden 5-tier study', '/assets/manuals/bookshelf_classic.pdf', '2025-08-11 00:17:22'),
(5, 'TV Console', 'STO-TVCON', 'tv console storage low-rise cable management', '/assets/manuals/tv_console.pdf', '2025-08-11 00:17:22'),
(6, 'Recliner Seat', 'SOF-RECL', 'recliner sofa plush adjustable headrest', '/assets/manuals/recliner_seat.pdf', '2025-08-11 00:17:22'),
(7, 'Study Desk', 'TAB-STUD', 'study desk compact drawers office table', '/assets/manuals/study_desk.pdf', '2025-08-11 00:17:22'),
(8, 'Bar Stool Set', 'STL-BAR', 'bar stool set tall counter kitchen', '/assets/manuals/bar_stool_set.pdf', '2025-08-11 00:17:22');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `customer_first_name` varchar(50) NOT NULL,
  `customer_last_name` varchar(50) NOT NULL,
  `customer_email` varchar(100) NOT NULL,
  `customer_phone` varchar(20) NOT NULL,
  `shipping_address` varchar(255) NOT NULL,
  `shipping_city` varchar(100) NOT NULL,
  `shipping_state` varchar(50) NOT NULL,
  `shipping_zip` varchar(20) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `tax_amount` decimal(10,2) NOT NULL,
  `shipping_fee` decimal(10,2) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `order_status` enum('pending','processing','shipped','delivered','cancelled') DEFAULT 'pending',
  `special_instructions` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `username`, `customer_first_name`, `customer_last_name`, `customer_email`, `customer_phone`, `shipping_address`, `shipping_city`, `shipping_state`, `shipping_zip`, `subtotal`, `tax_amount`, `shipping_fee`, `total_amount`, `order_status`, `special_instructions`, `created_at`, `updated_at`) VALUES
(1, 'yg', 'Yang', 'Guang', 'bladekoi99@gmail.com', '91266236', 'Pasir Ris Drive 3 Block 632 #09-400', 'singapore', 'AL', '510632', 159.00, 12.72, 15.00, 186.72, 'cancelled', 'asdasdsa', '2025-06-17 14:03:45', '2025-08-12 12:58:42'),
(2, 'yg', 'Yang', 'Guang', 'bladekoi99@gmail.com', '91266236', 'Pasir Ris Drive 3 Block 632 #09-400', 'asdasd', 'AK', '510632', 1057.00, 84.56, 15.00, 1156.56, 'cancelled', 'assdasd', '2025-06-20 10:43:15', '2025-08-13 10:52:15'),
(3, 'yg', 'Yang', 'Guang', 'bladekoi99@gmail.com', '91266236', 'Pasir Ris Drive 3 Block 632 #09-400', 'Singapore', 'AL', '510632', 699.00, 55.92, 15.00, 769.92, 'pending', 'adasd', '2025-06-20 11:10:43', '2025-08-12 12:58:42'),
(4, 'yg', 'Yang', 'Guang', 'bladekoi99@gmail.com', '91266236', 'Pasir Ris Drive 3 Block 632 #09-400', '123', 'AL', '510632', 159.00, 12.72, 15.00, 186.72, 'pending', 'asdasds', '2025-06-20 12:16:45', '2025-08-12 12:58:42'),
(5, 'yg', 'Yang', 'Guang', 'bladekoi99@gmail.com', '91266236', 'Pasir Ris Drive 3 Block 632 #09-400', 'asdasd', 'AZ', '510632', 159.00, 12.72, 15.00, 186.72, 'cancelled', '', '2025-08-11 14:42:31', '2025-08-12 13:45:25'),
(6, 'yg', 'yang guang', 'soon', 'bladekoi99@gmail.com', '91266236', 'Pasir Ris Drive 3 Block 623 #09-400', 'Singapore', 'AK', '510632', 858.00, 68.64, 15.00, 941.64, 'cancelled', '', '2025-08-12 16:16:50', '2025-08-12 16:17:04'),
(7, 'yg', 'Yang', 'Guang', 'bladekoi99@gmail.com', '91266236', 'Pasir Ris Drive 3 Block 632 #09-400', 'Singapore', 'AL', '510632', 159.00, 12.72, 15.00, 186.72, 'pending', '', '2025-08-12 16:51:58', '2025-08-12 16:51:58'),
(8, 'yg', 'Yang', 'Guang', 'bladekoi99@gmail.com', '91266236', 'Pasir Ris Drive 3 Block 632 #09-400', 'singapore', 'AK', '510632', 898.00, 71.84, 15.00, 984.84, 'pending', '', '2025-08-13 08:58:38', '2025-08-13 08:58:38');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `item_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `furniture_id` int(11) NOT NULL,
  `furniture_name` varchar(255) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`item_id`, `order_id`, `furniture_id`, `furniture_name`, `unit_price`, `quantity`, `total_price`) VALUES
(1, 1, 4, 'Coffee Table', 159.00, 1, 159.00),
(2, 2, 5, 'Queen Bed Frame', 699.00, 1, 699.00),
(3, 2, 4, 'Coffee Table', 159.00, 1, 159.00),
(4, 2, 3, 'Ergo Chair', 199.00, 1, 199.00),
(5, 3, 5, 'Queen Bed Frame', 699.00, 1, 699.00),
(6, 4, 4, 'Coffee Table', 159.00, 1, 159.00),
(7, 5, 4, 'Coffee Table', 159.00, 1, 159.00),
(8, 6, 5, 'Queen Bed Frame', 699.00, 1, 699.00),
(9, 6, 4, 'Coffee Table', 159.00, 1, 159.00),
(10, 7, 4, 'Coffee Table', 159.00, 1, 159.00),
(11, 8, 3, 'Ergo Chair', 199.00, 1, 199.00),
(12, 8, 5, 'Queen Bed Frame', 699.00, 1, 699.00);

-- --------------------------------------------------------

--
-- Table structure for table `support_tickets`
--

CREATE TABLE `support_tickets` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `status` enum('open','responded','resolved') NOT NULL DEFAULT 'open',
  `assigned_admin_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `support_tickets`
--

INSERT INTO `support_tickets` (`id`, `user_id`, `subject`, `message`, `status`, `assigned_admin_id`, `created_at`, `updated_at`) VALUES
(1, 91, 'Order damaged', 'My table arrived with a scratch on the top surface.', 'resolved', 9, '2025-08-09 09:15:00', '2025-08-14 00:46:41'),
(2, 91, 'Assembly help (Ergo Chair)', 'I need help assembling the Ergo Chair. The backrest is confusing.', 'responded', 9, '2025-08-08 14:30:00', '2025-08-14 00:46:43'),
(3, 1, 'Missing screws (TV Console)', 'The hardware bag did not include size M6 screws.', 'open', 12, '2025-08-07 11:05:00', '2025-08-14 00:46:44'),
(4, 11, 'Change delivery address', 'Please change my delivery address to 88 Sunset Ave.', 'resolved', 9, '2025-08-06 16:40:00', '2025-08-14 00:43:45'),
(5, 11, 'Refund request', 'I would like to request a refund for order #55021.', 'responded', 9, '2025-08-06 09:00:00', '2025-08-14 00:56:29'),
(6, 106, 'Warranty question', 'What is the warranty for the Bookshelf Classic?', 'responded', 15, '2025-08-05 13:22:00', '2025-08-09 18:20:00'),
(7, 107, 'Color mismatch', 'The coffee table looks lighter than the photo.', 'open', 9, '2025-08-05 08:45:00', '2025-08-05 08:45:00'),
(8, 108, 'Bulk order discount', 'We plan to buy 12 chairs. Any bulk discount?', 'open', NULL, '2025-08-04 17:55:00', '2025-08-04 17:55:00'),
(9, 109, 'Payment failed', 'Payment failed twice on checkout. Please help.', 'responded', 9, '2025-08-04 10:11:00', '2025-08-08 12:00:00'),
(10, 110, 'Clean leather recliner', 'How do I clean and condition the leather recliner?', 'resolved', 15, '2025-08-03 15:05:00', '2025-08-05 09:00:00'),
(11, 111, 'Track my order', 'Where can I track order #55200?', 'open', 12, '2025-08-03 09:30:00', '2025-08-03 09:30:00'),
(12, 112, 'Invoice needed', 'Please send an invoice with my company details.', 'responded', 9, '2025-08-02 18:25:00', '2025-08-08 13:45:00'),
(13, 113, 'Packaging was wet', 'The outer carton was damp when delivered.', 'open', NULL, '2025-08-02 12:12:00', '2025-08-02 12:12:00'),
(14, 114, 'Late delivery', 'Delivery is 3 days late, any update?', 'open', 12, '2025-08-01 16:00:00', '2025-08-01 16:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `support_ticket_replies`
--

CREATE TABLE `support_ticket_replies` (
  `id` int(10) UNSIGNED NOT NULL,
  `ticket_id` int(10) UNSIGNED NOT NULL,
  `admin_id` int(10) UNSIGNED DEFAULT NULL,
  `message` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `support_ticket_replies`
--

INSERT INTO `support_ticket_replies` (`id`, `ticket_id`, `admin_id`, `message`, `created_at`) VALUES
(1, 1, 9, 'im sorry', '2025-08-14 00:14:04'),
(2, 1, 9, 'Im sorry 2', '2025-08-14 00:14:17'),
(3, 2, NULL, 'customer reply', '2025-08-14 00:41:27'),
(4, 5, NULL, 'i need money', '2025-08-14 00:44:22'),
(5, 5, 9, 'how much money', '2025-08-14 00:44:38'),
(6, 5, NULL, 'i need money', '2025-08-14 00:44:42'),
(7, 5, NULL, 'pls give money', '2025-08-14 00:56:29');

-- --------------------------------------------------------

--
-- Table structure for table `support_ticket_roles`
--

CREATE TABLE `support_ticket_roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(128) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `assigned_by` varchar(128) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `support_ticket_roles`
--

INSERT INTO `support_ticket_roles` (`id`, `username`, `active`, `assigned_by`, `created_at`, `updated_at`) VALUES
(1, 'admin', 1, 'yg', '2025-08-13 21:54:33', '2025-08-14 00:59:36'),
(2, 'yg', 1, 'yg', '2025-08-13 21:54:33', '2025-08-14 00:59:36'),
(12, 'yg2', 0, 'yg', '2025-08-13 22:54:04', '2025-08-14 00:57:38');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` tinyint(1) DEFAULT 1 COMMENT '1 = active, 0 = banned',
  `role` enum('admin','user') NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `status`, `role`) VALUES
(1, 'test', 'sqinfa@gmail.com', '$2y$10$V20b2wivwCdVyImCxEEtX.lbRn5ST36tkjKH1aCZViu2.GJKfj1iW', 1, 'user'),
(2, 'tester', 'test@gmail.com', '$2y$10$6WwMOnChuAYfGywFfuTitevIanMG9p.HyEqwPzuZctFglP437DULC', 1, 'user'),
(6, 'admin', 'admin@gmail.com', '$2y$10$tTMV6v3ozZfN5ukt.ip6EusHIPESkmvBNKMCAt4U3QU66RI/tKUNW', 1, 'admin'),
(8, 'user', 'user@gmail.com', '$2y$10$sgArvTH1v1f.UDUjmpucGOVMXhdoFd/AhTLCtyItx.kZb0g9NqhMq', 1, 'user'),
(9, 'yg', 'yg@yg.com', '$2y$10$u89rCuhbuU8zgNgCrT9UouTFe9gi2uudnN3bgClAfOtYAMOs.2k1y', 1, 'admin'),
(10, 'yg1', 'yg1@yg.com', '$2y$10$Gl..R/t2YnSYWI8oJfzKkOVocH7s2gmH2RwbYJPedA9hKikIBZktm', 1, 'user'),
(11, 'yg2', 'yg2@yg.com', '$2y$10$E6awsNqXXCRHxrC4Knfj0ux7leQjSs6o7vlr1SRhQTqIo5NyJcYhq', 1, 'user');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chatbot_reviews`
--
ALTER TABLE `chatbot_reviews`
  ADD PRIMARY KEY (`reviewID`),
  ADD KEY `fk_cb_user` (`user_id`);

--
-- Indexes for table `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD PRIMARY KEY (`username`,`created_at`,`sender`),
  ADD KEY `idx_chat_username_time` (`username`,`created_at`);

--
-- Indexes for table `furnitures`
--
ALTER TABLE `furnitures`
  ADD PRIMARY KEY (`furnitureID`),
  ADD UNIQUE KEY `furnitureID` (`furnitureID`);

--
-- Indexes for table `instruction_manuals`
--
ALTER TABLE `instruction_manuals`
  ADD PRIMARY KEY (`manualID`),
  ADD KEY `idx_product_name` (`product_name`),
  ADD KEY `idx_product_code` (`product_code`),
  ADD KEY `idx_updated_at` (`updated_at`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `idx_orders_email` (`customer_email`),
  ADD KEY `idx_orders_status` (`order_status`),
  ADD KEY `idx_orders_created` (`created_at`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `idx_order_items_order` (`order_id`),
  ADD KEY `idx_order_items_furniture` (`furniture_id`);

--
-- Indexes for table `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_assigned` (`assigned_admin_id`),
  ADD KEY `idx_user` (`user_id`);

--
-- Indexes for table `support_ticket_replies`
--
ALTER TABLE `support_ticket_replies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ticket` (`ticket_id`);

--
-- Indexes for table `support_ticket_roles`
--
ALTER TABLE `support_ticket_roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_username` (`username`),
  ADD KEY `idx_active` (`active`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chatbot_reviews`
--
ALTER TABLE `chatbot_reviews`
  MODIFY `reviewID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `furnitures`
--
ALTER TABLE `furnitures`
  MODIFY `furnitureID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `instruction_manuals`
--
ALTER TABLE `instruction_manuals`
  MODIFY `manualID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `support_tickets`
--
ALTER TABLE `support_tickets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `support_ticket_replies`
--
ALTER TABLE `support_ticket_replies`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `support_ticket_roles`
--
ALTER TABLE `support_ticket_roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chatbot_reviews`
--
ALTER TABLE `chatbot_reviews`
  ADD CONSTRAINT `fk_cb_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`furniture_id`) REFERENCES `furnitures` (`furnitureID`);

--
-- Constraints for table `support_ticket_replies`
--
ALTER TABLE `support_ticket_replies`
  ADD CONSTRAINT `fk_support_ticket_replies_ticket` FOREIGN KEY (`ticket_id`) REFERENCES `support_tickets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
