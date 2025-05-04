-- PART ONE: CREATING DB AND TABLES


CREATE database course_management;

--Creating Schema
CREATE schema courses

-- Create Students table
CREATE TABLE courses.Students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    date_of_birth DATE
);

select * from courses.students;

-- Create Instructors table
CREATE TABLE courses.Instructors (
    instructor_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Create Courses table
CREATE TABLE courses.Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_description TEXT,
    instructor_id INT NOT NULL,
    CONSTRAINT fk_instructor
        FOREIGN KEY (instructor_id) REFERENCES courses.Instructors(instructor_id) ON DELETE CASCADE
);

-- Create Enrollments table
CREATE TABLE courses.Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE DEFAULT CURRENT_DATE,
    grade CHAR(1),
    CONSTRAINT fk_student
        FOREIGN KEY (student_id)
		REFERENCES courses.Students(student_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_course
        FOREIGN KEY (course_id) REFERENCES courses.Courses(course_id) ON DELETE CASCADE
);

--PART TWO: INSERTING DATA TO THE DATABASE


-- Insert sample Students (10 students)
INSERT INTO courses.Students (student_id, first_name, last_name, email, date_of_birth) VALUES
  (1, 'John', 'Doe', 'john.doe@example.com', '2000-01-15'),
  (2, 'Jane', 'Smith', 'jane.smith@example.com', '1999-03-22'),
  (3, 'Michael', 'Johnson', 'michael.johnson@example.com', '2001-07-11'),
  (4, 'Emily', 'Davis', 'emily.davis@example.com', '2000-12-05'),
  (5, 'Daniel', 'Miller', 'daniel.miller@example.com', '1998-04-17'),
  (6, 'Sarah', 'Wilson', 'sarah.wilson@example.com', '2002-09-30'),
  (7, 'David', 'Anderson', 'david.anderson@example.com', '2001-02-20'),
  (8, 'Laura', 'Thomas', 'laura.thomas@example.com', '2000-11-25'),
  (9, 'Robert', 'Moore', 'robert.moore@example.com', '1999-06-10'),
  (10, 'Olivia', 'Martin', 'olivia.martin@example.com', '2000-08-08');

-- Insert sample Instructors (3 instructors)
INSERT INTO courses.Instructors (instructor_id, first_name, last_name, email) VALUES
  (1, 'John', 'Smith', 'john.smith@edtech.com'),
  (2, 'Alice', 'Johnson', 'alice.johnson@edtech.com'),
  (3, 'Robert', 'Brown', 'robert.brown@edtech.com');

-- Insert sample Courses (5 courses)
INSERT INTO courses.Courses (course_id, course_name, course_description, instructor_id) VALUES
  (1, 'Mathematics 101', 'Introduction to Algebra and Calculus', 2),      
  (2, 'History of Art', 'Exploration of art history through the ages', 3),   
  (3, 'Computer Science 101', 'Fundamentals of Computer Science', 1),        
  (4, 'Biology Basics', 'Overview of biological systems and organisms', 2),  
  (5, 'Philosophy 101', 'Introduction to philosophical thought', 3);             

-- Insert sample Enrollments (15 enrollments with a mix of grades)
  
INSERT INTO courses.Enrollments (enrollment_id, student_id, course_id, enrollment_date, grade) VALUES
  (1, 3, '2025-01-15', 'A'),
  (2, 1, '2025-01-16', 'B'),
  (3, 2, '2025-01-17', 'C'),
  (4, 4, '2025-01-18', 'B'),
  (5, 1, '2025-01-19', 'F'),
  (1, 2, '2025-02-01', 'B'),
  (2, 3, '2025-02-03', 'A'),
  (3, 3, '2025-02-05', 'D'),
  (4, 5, '2025-02-07', 'F'),
  (6, 4, '2025-02-09', 'A'),
  (7, 3, '2025-02-11', 'C'),
  (8, 2, '2025-02-13', 'B'),
  (9, 1, '2025-02-15', 'C'),
  (10, 5, '2025-02-17', 'A'),
  (1, 5, '2025-02-19', 'F'); 


--PART THREE: WRITE SQL QUERIES
  
  
-- 1. Students who enrolled in at least one course
SELECT DISTINCT s.student_id, s.first_name, s.last_name
FROM Students s 
JOIN Enrollments e ON s.student_id = e.student_id;

-- 2. Students enrolled in more than two courses
SELECT s.student_id, s.first_name, s.last_name, COUNT(e.course_id) AS course_count
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT(e.course_id) > 2;

-- 3. Courses with total enrolled students
SELECT c.course_id, c.course_name, COUNT(e.student_id) AS total_enrolled
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

-- 4. Average grade per course (with grade conversion: A=4, B=3, C=2, D=1, F=0)
SELECT c.course_id, c.course_name,
       AVG(CASE e.grade
              WHEN 'A' THEN 4
              WHEN 'B' THEN 3
              WHEN 'C' THEN 2
              WHEN 'D' THEN 1
              WHEN 'F' THEN 0
           END) AS average_grade
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

-- 5. Students who haven't enrolled in any course
SELECT s.student_id, s.first_name, s.last_name
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;

-- 6. Students with their average grade across all courses
SELECT s.student_id, s.first_name, s.last_name,
       AVG(CASE e.grade
              WHEN 'A' THEN 4
              WHEN 'B' THEN 3
              WHEN 'C' THEN 2
              WHEN 'D' THEN 1
              WHEN 'F' THEN 0
           END) AS average_grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name;

-- 7. Instructors with the number of courses they teach
SELECT i.instructor_id, i.first_name, i.last_name, COUNT(c.course_id) AS course_count
FROM Instructors i
JOIN Courses c ON i.instructor_id = c.instructor_id
GROUP BY i.instructor_id, i.first_name, i.last_name;

-- 8. Students enrolled in a course taught by "John Smith"
SELECT DISTINCT s.student_id, s.first_name, s.last_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
JOIN Instructors i ON c.instructor_id = i.instructor_id
WHERE i.first_name = 'John' AND i.last_name = 'Smith';

-- 9. Top 3 students by average grade
SELECT s.student_id, s.first_name, s.last_name,
       AVG(CASE e.grade
              WHEN 'A' THEN 4
              WHEN 'B' THEN 3
              WHEN 'C' THEN 2
              WHEN 'D' THEN 1
              WHEN 'F' THEN 0
           END) AS average_grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name
ORDER BY average_grade DESC
LIMIT 3;

-- 10. Students failing (grade = 'F') in more than one course
SELECT s.student_id, s.first_name, s.last_name, COUNT(*) AS fail_count
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.grade = 'F'
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT(*) > 1;


-- PART 4: Advanced SQL
-- =====================================================

-- Create a VIEW named student_course_summary (student name, course, grade)
CREATE OR REPLACE VIEW student_course_summary AS
SELECT s.first_name || ' ' || s.last_name AS student_name,
       c.course_name,
       e.grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;

-- Add an INDEX on Enrollments.student_id to improve query performance
CREATE INDEX idx_enrollments_student_id ON Enrollments(student_id);

-- Optional: Create a trigger to log new enrollments

-- First, create a table to hold enrollment logs
DROP TABLE IF EXISTS courses.enrollment_log;

CREATE TABLE enrollment_log (
    log_id SERIAL PRIMARY KEY,
    enrollment_id INT,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the trigger function
CREATE OR REPLACE FUNCTION log_new_enrollment()
RETURNS trigger AS $$
BEGIN
  INSERT INTO enrollment_log(enrollment_id, student_id, course_id, enrollment_date)
  VALUES (NEW.enrollment_id, NEW.student_id, NEW.course_id, NEW.enrollment_date);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create the trigger that calls the function after an insert on Enrollments
CREATE TRIGGER trigger_enrollment_log
AFTER INSERT ON Enrollments
FOR EACH ROW
EXECUTE PROCEDURE log_new_enrollment();

  


