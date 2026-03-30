create database College_student_management_system ;

use college_student_management_system;

CREATE TABLE students ( 
student_id INT PRIMARY KEY, 
student_name VARCHAR(50), 
gender VARCHAR(10), 
city VARCHAR(50), 
join_year INT );

CREATE TABLE courses ( 
course_id INT PRIMARY KEY, 
course_name VARCHAR(100), 
department VARCHAR(50) );

CREATE TABLE marks (
 mark_id INT PRIMARY KEY,
 student_id INT, 
 course_id INT, 
 marks INT, 
 FOREIGN KEY (student_id) REFERENCES students(student_id), 
 FOREIGN KEY (course_id) REFERENCES courses(course_id) ) ;
 
 INSERT INTO students (
 student_id, student_name, 
 gender, 
 city, 
 join_year) 
 VALUES (1, 
 'Anu', 
 'F', 
 'Tumakuru', 2024),
(2, 'Ravi', 'M', 'Bengaluru', 2023), 
(3, 'Kiran', 'M', 'Tumakuru', 2024), 
(4, 'Sneha', 'F', 'Mysuru', 2023), 
(5, 'Manu', 'M', 'Tumakuru', 2022);

INSERT INTO courses (
course_id, course_name, department) 
VALUES (101, 'SQL Basics', 'Computer Science'), 
(102, 'Excel for Analysts', 'Commerce'), 
(103, 'Statistics', 'Mathematics');

INSERT INTO marks (
mark_id, student_id, course_id, marks) 
VALUES (1, 1, 101, 85), 
(2, 2, 101, 72), 
(3, 3, 101, 90), 
(4, 4, 102, 88), 
(5, 5, 103, 67), 
(6, 1, 103, 79), 
(7, 2, 102, 81);

#1.Display all students.
select * from students;
#Display only student_name and city from students table.
select student_name , city from students;
#Show all courses.
select * from courses;
#Display students who are from Tumakuru.
select * from students where city = "Tumakuru"; 
#Display students who joined in 2024.
select * from students where join_year = 2024 ;

#Show students whose gender is F.
select * from students where gender = "F" ;
#Show marks greater than 80.
select * from marks where marks > 80 ;
select * from marks ;
#Display course names from Commerce department.
select * from courses where department = "commerce" ;
#Show students who are not from Bengaluru.
select * from students where city != "Bengaluru" ;
#Display marks between 70 and 90.
select * from marks where marks between 70 and 90 ;
select marks from marks where marks between 70 and 90 ;
#Display all students ordered by student_name ascending.
select * from students order by student_name asc;
#Show marks ordered from highest to lowest
select * from marks order by marks desc ;
#Display students ordered by join_year descending
select * from students order by join_year desc ;
#Find total number of students.
select count(*) from students ;
#Find average marks.
select avg(marks) from marks ;
#Find highest marks.
select * from marks order by marks desc limit 1 ;
#Find lowest marks.
select * from marks order by marks asc limit 1 ;
#Find total marks scored by all students
select s.student_id , s.student_name , m.marks from students as s
inner join marks as m 
on s.student_id = m.student_id ;
select sum(m.marks) as total_marks 
from students as s
join marks as m
on s.student_id = m.student_id ;

