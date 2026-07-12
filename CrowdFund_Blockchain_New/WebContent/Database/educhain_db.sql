-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 28, 2026 at 06:41 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `educhain_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `investments`
--

CREATE TABLE `investments` (
  `investment_id` int(11) NOT NULL,
  `lender_id` int(11) DEFAULT NULL,
  `loan_id` int(11) DEFAULT NULL,
  `investment_amount` decimal(12,2) DEFAULT NULL,
  `investment_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `transaction_hash` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `investments`
--

INSERT INTO `investments` (`investment_id`, `lender_id`, `loan_id`, `investment_amount`, `investment_date`, `transaction_hash`) VALUES
(1, 5, 1, 1.00, '2026-01-27 19:46:04', '0x4c10cd2fb2e49fecdb964b9aa3cb84');

-- --------------------------------------------------------

--
-- Table structure for table `lender_profiles`
--

CREATE TABLE `lender_profiles` (
  `lender_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `institution_name` varchar(255) DEFAULT NULL,
  `investment_budget` varchar(50) DEFAULT NULL,
  `total_invested` decimal(12,2) DEFAULT 0.00,
  `wallet_balance` decimal(12,2) DEFAULT 5000.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lender_profiles`
--

INSERT INTO `lender_profiles` (`lender_id`, `user_id`, `email`, `institution_name`, `investment_budget`, `total_invested`, `wallet_balance`) VALUES
(1, 5, 'john@capital.com', 'Individual Investor', '500-2000', 1.00, 4999.00),
(2, 6, 'kumar@capital.com', 'Individual Investor', '500-2000', 0.00, 5000.00);

-- --------------------------------------------------------

--
-- Table structure for table `loan_requests`
--

CREATE TABLE `loan_requests` (
  `loan_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `loan_title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `amount_required` decimal(10,2) NOT NULL,
  `amount_raised` decimal(10,2) DEFAULT 0.00,
  `tenure_months` int(11) NOT NULL,
  `interest_rate` decimal(4,2) DEFAULT 5.00,
  `status` varchar(50) DEFAULT 'OPEN',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `block_hash` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan_requests`
--

INSERT INTO `loan_requests` (`loan_id`, `user_id`, `email`, `loan_title`, `description`, `amount_required`, `amount_raised`, `tenure_months`, `interest_rate`, `status`, `created_at`, `block_hash`) VALUES
(1, 1, 'yash@gmail.com', 'Admission Fee for IT Master Degree', 'After Education complete I Start the repayment.', 2000.00, 201.00, 12, 5.00, 'OPEN', '2026-01-27 18:07:33', '0xdfbc8c99795c4964a3c6');

-- --------------------------------------------------------

--
-- Table structure for table `repayments`
--

CREATE TABLE `repayments` (
  `repay_id` int(11) NOT NULL,
  `loan_id` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `amount_paid` decimal(10,2) DEFAULT NULL,
  `payment_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `previous_hash` varchar(255) DEFAULT NULL,
  `current_hash` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `repayments`
--

INSERT INTO `repayments` (`repay_id`, `loan_id`, `email`, `amount_paid`, `payment_date`, `previous_hash`, `current_hash`) VALUES
(1, 1, 'yash@gmail.com', 100.00, '2026-01-27 18:29:11', '0', 'b1b6ae25c968861f845db3c600bb9681815d2954aab033ab430955b8679df572'),
(2, 1, 'yash@gmail.com', 100.00, '2026-01-27 18:30:41', 'b1b6ae25c968861f845db3c600bb9681815d2954aab033ab430955b8679df572', '79608edce448971f6ae488dc29f5edd18742b0b1b97bb2734f7103d0d9a9a4aa');

-- --------------------------------------------------------

--
-- Table structure for table `student_profiles`
--

CREATE TABLE `student_profiles` (
  `profile_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `adhar_no` varchar(255) DEFAULT NULL,
  `pan_no` varchar(255) DEFAULT NULL,
  `university_name` varchar(255) DEFAULT NULL,
  `degree_name` varchar(100) DEFAULT NULL,
  `current_year` varchar(20) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT 0,
  `id_proof_path` varchar(255) DEFAULT NULL,
  `admission_letter_path` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_profiles`
--

INSERT INTO `student_profiles` (`profile_id`, `user_id`, `email`, `adhar_no`, `pan_no`, `university_name`, `degree_name`, `current_year`, `bio`, `is_verified`, `id_proof_path`, `admission_letter_path`) VALUES
(1, 1, 'yash@gmail.com', '832982198219', 'ABCD78712P', 'SPPU University, Pune', 'BE in Information Technology', 'Final Year', 'Need Funding for Higher Education.', 0, '1_ID_ID Proof.png', '1_Letter_Mansi Resume.pdf');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('student','lender','admin') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `contact`, `password`, `role`, `created_at`) VALUES
(1, 'Yash Patil', 'yash@gmail.com', '9876543212', 'a994696540befd55c96017a162c7ae2685f2010a7fd3224c0ada25241913933b', 'student', '2026-01-27 12:23:13'),
(2, 'Raj Patil', 'raj@gmail.com', '9876543210', 'b3282a2f2a28757b3a18ab833de16a9c54518c0b0cf493e3f0a7cf09386f326a', 'student', '2026-01-27 13:13:58'),
(5, 'John Smith', 'john@capital.com', '9878909876', '7a5df5ffa0dec2228d90b8d0a0f1b0767b748b0a41314c123075b8289e4e053f', 'lender', '2026-01-27 18:54:38'),
(6, 'Kumar Sharma', 'kumar@capital.com', '8909789065', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 'lender', '2026-01-27 19:05:43'),
(7, 'Admin User', 'admin@gmail.com', '8888888888', 'admin', 'admin', '2026-01-28 04:04:51');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `investments`
--
ALTER TABLE `investments`
  ADD PRIMARY KEY (`investment_id`),
  ADD KEY `lender_id` (`lender_id`),
  ADD KEY `loan_id` (`loan_id`);

--
-- Indexes for table `lender_profiles`
--
ALTER TABLE `lender_profiles`
  ADD PRIMARY KEY (`lender_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `loan_requests`
--
ALTER TABLE `loan_requests`
  ADD PRIMARY KEY (`loan_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `repayments`
--
ALTER TABLE `repayments`
  ADD PRIMARY KEY (`repay_id`),
  ADD KEY `loan_id` (`loan_id`);

--
-- Indexes for table `student_profiles`
--
ALTER TABLE `student_profiles`
  ADD PRIMARY KEY (`profile_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `investments`
--
ALTER TABLE `investments`
  MODIFY `investment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `lender_profiles`
--
ALTER TABLE `lender_profiles`
  MODIFY `lender_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `loan_requests`
--
ALTER TABLE `loan_requests`
  MODIFY `loan_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `repayments`
--
ALTER TABLE `repayments`
  MODIFY `repay_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `student_profiles`
--
ALTER TABLE `student_profiles`
  MODIFY `profile_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `investments`
--
ALTER TABLE `investments`
  ADD CONSTRAINT `investments_ibfk_1` FOREIGN KEY (`lender_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `investments_ibfk_2` FOREIGN KEY (`loan_id`) REFERENCES `loan_requests` (`loan_id`);

--
-- Constraints for table `lender_profiles`
--
ALTER TABLE `lender_profiles`
  ADD CONSTRAINT `lender_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `loan_requests`
--
ALTER TABLE `loan_requests`
  ADD CONSTRAINT `loan_requests_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `repayments`
--
ALTER TABLE `repayments`
  ADD CONSTRAINT `repayments_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `loan_requests` (`loan_id`);

--
-- Constraints for table `student_profiles`
--
ALTER TABLE `student_profiles`
  ADD CONSTRAINT `student_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
