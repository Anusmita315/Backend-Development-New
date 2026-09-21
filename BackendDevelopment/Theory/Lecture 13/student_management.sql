CREATE DATABASE student_management;
-- Lecture 13: Introduction to Databases
-- Relational vs NoSQL Databases
-- PostgreSQL Practical

-- Task 1: Create Database
-- Run this command from the terminal:
-- createdb student_management

-- Task 2: Create students table

CREATE TABLE students (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    branch VARCHAR(50) NOT NULL,
    email VARCHAR(255) UNIQUE,
    enrollment_date DATE
);

-- Task 3: Insert at least 5 student records

INSERT INTO students (name, branch, email, enrollment_date)
VALUES
    ('Aarav', 'CSE', 'aarav@upes.ac.in', '2024-01-15'),
    ('Diya', 'ECE', 'diya@upes.ac.in', '2024-02-10'),
    ('Rohan', 'IT', 'rohan@upes.ac.in', '2024-03-20'),
    ('Priya', 'CSE', 'priya@upes.ac.in', '2024-04-05'),
    ('Meera', 'CSE', 'meera@upes.ac.in', '2025-01-12');

-- Verify inserted records
SELECT * FROM students;

-- Task 4(a): Retrieve all students in the CSE branch

SELECT * FROM students
WHERE branch = 'CSE';

-- Task 4(b): Find students enrolled after January 2024

SELECT * FROM students
WHERE enrollment_date > '2024-01-31';

-- Task 4(c): Update a student's branch

UPDATE students
SET branch = 'CSE'
WHERE id = 2;

-- Verify update
SELECT * FROM students
WHERE id = 2;

-- Task 4(d): Delete a student record

DELETE FROM students
WHERE id = 5;

-- Verify deletion
SELECT * FROM students;