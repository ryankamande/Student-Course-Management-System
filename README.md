# Student Course Management System

## Project Overview
This project is a Student Course Management System for an EdTech company. The system tracks students, instructors, courses, and enrollments using a PostgreSQL database hosted on Aiven DaaS. Here, we use DBeaver as our database manager to interact with the database, run the provided SQL script, and test advanced functionalities such as views, indexes, and triggers.

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

## Instructions to Run the SQL Code Using DBeaver

### Step 1: Set Up Your Aiven PostgreSQL Database
1. Log in to your Aiven account and provision a PostgreSQL database, naming it `course_management`.
2. Note the connection details such as the host, port, database name, username, and password.

### Step 2: Connect to Your Database via DBeaver
1. Open DBeaver.
2. Click on **Database** > **New Database Connection**.
3. Select **PostgreSQL** as the database type and click **Next**.
4. Enter your Aiven PostgreSQL connection details (host, port, database name `course_management`, username, and password).
5. Click **Test Connection** to ensure everything is working properly, then click **Finish**.

### Step 3: Run the SQL Script
1. In DBeaver, navigate to your `course_management` database in the Database Navigator.
2. Right-click on the database and select **SQL Editor** > **New SQL Script**.
3. Copy the contents of the `Student Course Management System.sql` file into the script editor.
4. Execute the script by clicking the **Execute** button (or pressing Ctrl+Enter).
5. The script will create the necessary tables, insert sample data, and set up the views, indexes, and triggers as described.

## Explanation of the Schema
- **Students & Instructors:** Store personal information.
- **Courses:** Contains course-related details and ties each course to an instructor.
- **Enrollments:** Logs which student is enrolled in which course, including the enrollment date and grade.
- **Enrollment Log (Advanced):** Created via a trigger to log every new course enrollment for auditing purposes.

## Key Queries
- **Students Enrolled in at Least One Course:** Retrieves students with one or more enrollments.
- **Students Enrolled in More than Two Courses:** Filters out students using a HAVING clause after grouping by student.
- **Courses with Total Enrolled Students:** Uses a LEFT JOIN to show enrollment counts per course.
- **Average Grade per Course:** Converts letter grades into numerical values (A=4, B=3, etc.) and calculates the average.
- **Students Without Enrollments:** Uses an outer join to find students missing enrollment records.
- **Instructors with Number of Courses Taught:** Shows how many courses each instructor is responsible for.
- **Students in John Smith's Courses:** Joins multiple tables to find students in courses taught by "John Smith."
- **Top 3 Students by Average Grade:** Orders students based on their average grade and lists the top three.
- **Students Failing More Than One Course:** Identifies students who have more than one failing (F) grade.

## Advanced SQL Features
- **View:** `student_course_summary` which aggregates student names, course names, and grades.
- **Index:** Added on the field `Enrollments.student_id` for improved query performance.
- **Trigger:** Automatically logs new enrollments into an `enrollment_log` table for auditing.

## Challenges and Lessons Learned
- Designing a robust schema for educational data.
- Ensuring data integrity using foreign keys, constraints, and triggers.
- Utilizing advanced SQL functions and performance optimization techniques.
- Managing cloud-based PostgreSQL instances via Aiven DaaS and using DBeaver for a seamless development experience.

**Testing Advanced Features in DBeaver**

- To verify the view, run:
  ```sql
  SELECT * FROM student_course_summary;
