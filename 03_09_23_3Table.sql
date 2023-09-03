create database learn_3_table_join;
use learn_3_table_join;


/**
Student table
*/
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Age INT
);

INSERT INTO Students (StudentID, FirstName, LastName, Age)
VALUES
    (1, 'John', 'Doe', 20),
    (2, 'Jane', 'Smith', 22),
    (3, 'Bob', 'Johnson', 21),
    (4, 'Alice', 'Brown', 23),
    (5, 'Charlie', 'Wilson', 20),
    (6, 'Emma', 'Davis', 22),
    (7, 'David', 'Lee', 24),
    (8, 'Eva', 'Harris', 21),
    (9, 'Frank', 'Martin', 23),
    (10, 'Grace', 'Clark', 20);

rename table students to st;

/**
Course table
*/
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Credits INT
);

INSERT INTO Courses (CourseID, CourseName, Credits)
VALUES
    (101, 'Mathematics', 3),
    (102, 'History', 4),
    (103, 'Biology', 3),
    (104, 'Computer Science', 4),
    (105, 'English', 3),
    (106, 'Physics', 4),
    (107, 'Chemistry', 3),
    (108, 'Art', 2),
    (109, 'Music', 2),
    (110, 'Physical Education', 1);

rename table courses to c;

/**
Enrollment table
**/
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    Grade DECIMAL(4, 2),
    FOREIGN KEY (StudentID) REFERENCES st(StudentID),
    FOREIGN KEY (CourseID) REFERENCES c(CourseID)
);

INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, Grade)
VALUES
    (1001, 1, 101, 85.5),
    (1002, 1, 102, 78.0),
    (1003, 2, 101, 92.5),
    (1004, 2, 103, 88.0),
    (1005, 3, 104, 95.0),
    (1006, 4, 102, 79.5),
    (1007, 5, 105, 87.5),
    (1008, 6, 104, 90.0),
    (1009, 7, 106, 88.5),
    (1010, 8, 103, 84.0);
    
rename table enrollments to e;

# List all students who are enrolled in the "Mathematics" course.
select firstname, lastname, age, coursename 
from st join e 
	on st.studentId = e.studentid 
join c on e.courseid = c.courseid 
where c.coursename = 'Mathematics';

-- Find the average age of students who have a grade above 90.
select firstname, lastname, age from st join e on st.studentid = e.studentid where grade > 90;
select avg(st.age) as average_age from st join e on st.studentid = e.studentid where grade > 90;

-- Retrieve the names of students who are enrolled in more than one course.
select firstname, lastname, count(*) as total_enrollment from st
join e on st.studentid = e.studentid
group by st.studentid
having total_enrollment > 1; 

-- List the courses with the highest number of enrolled students.
select coursename, count(*) as total_enrolled_student from c
join e on c.courseid = e.courseid
group by c.courseid
having total_enrolled_student = 
(
	select count(*) as total_enrolled_student from c
	join e on c.courseid = e.courseid
	group by c.courseid limit 1
);

-- Find the student(s) with the highest grade in the "Computer Science" course
select firstname, lastname, grade, coursename from st 
join e on st.studentid = e.studentid
join c on e.courseid = c.courseid
where coursename = 'Computer Science'
having grade = (select max(grade) from e where courseid = e.courseid);

-- Calculate the total number of credits taken by each student.
select concat(firstname, ' ', lastname) as st_name, sum(credits) as total_credit from st
join e on st.studentid = e.studentid
join c on e.courseid = c.courseid
group by st.studentid; 

-- List the students who have not enrolled in any courses.
select firstname, lastname, age from st 
left join e on st.studentid = e.studentid
where courseid is null;

-- Find the average grade for each course.
select c.courseid, coursename, avg(grade) as average_grade from c 
join e on c.courseid = e.courseid
group by c.courseid; 

-- Retrieve the names of students who are older than the average age of all students.

select avg(age) from st; # get average age 
select firstname, lastname, age from st where age >  (select avg(age) from st);

-- Find the course(s) with the lowest average grade.
# get lowest grade among all course frade
select avg(grade) as average_grade from c 
join e on c.courseid = e.courseid
group by c.courseid order by average_grade asc limit 1; 

select c.courseid, coursename, avg(grade) as average_grade from c 
join e on c.courseid = e.courseid
group by c.courseid
having average_grade = (
	select avg(grade) as average_grade from c 
	join e on c.courseid = e.courseid
	group by c.courseid order by average_grade asc limit 1
); 


desc st;
desc c;
desc e;
select * from st;
select * from e;
select * from c;
