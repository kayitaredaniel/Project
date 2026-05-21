-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 21, 2026 at 04:03 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ssrms`
--

-- --------------------------------------------------------

--
-- Table structure for table `class`
--

CREATE TABLE `class` (
  `classCode` varchar(10) NOT NULL,
  `className` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `class`
--

INSERT INTO `class` (`classCode`, `className`) VALUES
(' C04', 'l5sod'),
('C01', 'Primary 1'),
('C02', 'Primary 2'),
('C06', 'L4SOD');

-- --------------------------------------------------------

--
-- Table structure for table `result`
--

CREATE TABLE `result` (
  `resultID` int(11) NOT NULL,
  `studentID` int(11) DEFAULT NULL,
  `mathsMark` int(11) DEFAULT NULL CHECK (`mathsMark` between 0 and 100),
  `scienceMark` int(11) DEFAULT NULL CHECK (`scienceMark` between 0 and 100),
  `englishMark` int(11) DEFAULT NULL CHECK (`englishMark` between 0 and 100),
  `kinyarwandaMark` int(11) DEFAULT NULL CHECK (`kinyarwandaMark` between 0 and 100),
  `socialMark` int(11) DEFAULT NULL CHECK (`socialMark` between 0 and 100),
  `term` varchar(20) DEFAULT NULL,
  `totalMarks` int(11) GENERATED ALWAYS AS (`mathsMark` + `scienceMark` + `englishMark` + `kinyarwandaMark` + `socialMark`) STORED,
  `percentage` decimal(5,2) GENERATED ALWAYS AS (`totalMarks` / 500 * 100) STORED,
  `grade` varchar(20) GENERATED ALWAYS AS (case when `totalMarks` / 500 * 100 >= 80 then 'Distinction' when `totalMarks` / 500 * 100 >= 65 then 'Merit' when `totalMarks` / 500 * 100 >= 50 then 'Pass' when `totalMarks` / 500 * 100 >= 40 then 'Weak Pass' else 'Fail' end) STORED,
  `totalMark` int(11) DEFAULT NULL,
  `Rank` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `result`
--

INSERT INTO `result` (`resultID`, `studentID`, `mathsMark`, `scienceMark`, `englishMark`, `kinyarwandaMark`, `socialMark`, `term`, `totalMark`, `Rank`) VALUES
(1, 1, 90, 85, 78, 88, 92, 'Term 1', NULL, NULL),
(2, 2, 65, 70, 72, 68, 74, 'Term 1', NULL, NULL),
(3, 3, 50, 55, 60, 58, 52, 'Term 1', NULL, NULL),
(4, 4, 35, 42, 40, 38, 45, 'Term 1', NULL, NULL),
(5, 3, 20, 20, 20, 20, 0, 'Term2', NULL, NULL),
(6, 8, 58, 89, 98, 57, 89, 'Term3', 391, NULL),
(7, 4, 99, 90, 98, 89, 90, 'Term1', 466, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `studentID` int(11) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `gender` enum('Male','Female') NOT NULL,
  `dateOfBirth` date DEFAULT NULL,
  `classCode` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`studentID`, `firstName`, `lastName`, `gender`, `dateOfBirth`, `classCode`) VALUES
(1, 'Jean', 'Mukasa', 'Male', '2010-05-12', 'C01'),
(2, 'Alice', 'Uwimana', 'Female', '2010-07-20', 'C01'),
(3, 'Eric', 'Habimana', 'Male', '2009-09-15', 'C02'),
(4, 'Catherine', 'Nyiransabimana', 'Female', '2025-08-12', 'C02'),
(7, 'KAYITARE', 'Mukasa', 'Male', '2010-05-11', 'C01'),
(8, 'KAYITARE', 'DANIEL', 'Male', '2008-02-01', 'C01'),
(11, 'ERIC', 'TWIRINGIYIMANA', 'Male', '0002-12-12', 'C01');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `class`
--
ALTER TABLE `class`
  ADD PRIMARY KEY (`classCode`);

--
-- Indexes for table `result`
--
ALTER TABLE `result`
  ADD PRIMARY KEY (`resultID`),
  ADD KEY `fk_student` (`studentID`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`studentID`),
  ADD KEY `fk_class` (`classCode`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `result`
--
ALTER TABLE `result`
  MODIFY `resultID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `studentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `result`
--
ALTER TABLE `result`
  ADD CONSTRAINT `fk_student` FOREIGN KEY (`studentID`) REFERENCES `student` (`studentID`) ON DELETE CASCADE;

--
-- Constraints for table `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `fk_class` FOREIGN KEY (`classCode`) REFERENCES `class` (`classCode`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
