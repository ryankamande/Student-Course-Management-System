# Student Course Management System

## Project Overview
This project is a Student Course Management System for an EdTech company. The system tracks students, instructors, courses, and enrollments using a PostgreSQL database hosted on Aiven DaaS. It supports advanced SQL queries and database features to manage and analyze enrollment data in an educational setting.

## Database Schema
The database schema includes the following tables:
- **Students**
  - `student_id` (INT, PRIMARY KEY)
  - `first_name` (VARCHAR)
  - `last_name` (VARCHAR)
  - `email` (VARCHAR)
  - `date_of_birth` (DATE)
- **Instructors**
  - `instructor_id` (INT, PRIMARY KEY)
  - `first_name` (VARCHAR)
  - `last_name` (VARCHAR)
  - `email` (VARCHAR)
- **Courses**
  - `course_id` (INT, PRIMARY KEY)
  - `course_name` (VARCHAR)
  - `course_description` (TEXT)
  - `instructor_id` (INT, FOREIGN KEY references Instructors)
- **Enrollments**
  - `enrollment_id` (INT, PRIMARY KEY)
  - `student_id` (INT, FOREIGN KEY references Students)
  - `course_id` (INT, FOREIGN KEY references Courses)
  - `enrollment_date` (DATE)
  - `grade` (CHAR(1))

## Instructions to Run the SQL Code
1. **Create the Database:**  
   On Aiven DaaS, create a PostgreSQL database named `course_management`.
2. **Connect to the Database:**  
   Use your preferred PostgreSQL client (psql, PgAdmin, etc.) to connect to the `course_management` database.
3. **Run the Script:**  
   Execute the `setup.sql` script provided in the repository. This script contains commands to create the schema, insert sample data, run sample queries, and set up advanced features such as views, indexes, and triggers.
   ```bash
   psql -d course_management -f Student Course Management System.sql
