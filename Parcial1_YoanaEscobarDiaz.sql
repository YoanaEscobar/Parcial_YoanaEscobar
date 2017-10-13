--1) Create a tablespace called "COURSES" with two datafiles each one of 50Mb, 
--   the name of the datafiles should be: courses1.dbf and courses2.dbf

CREATE TABLESPACE COURSES DATAFILE 
'courses1.dbf' size 50M,
'courses2.dbf' size 50M
EXTENT MANAGEMENT LOCAL 
SEGMENT SPACE MANAGEMENT AUTO;

--2) Create a profile named "admin" with the following specifications: 
--   a) Idle time of 15 minutes b) Failed login attempts 3 c) 2 sessions per user

CREATE PROFILE admin LIMIT 
SESSIONS_PER_USER 1
IDLE_TIME 15
FAILED_LOGIN_ATTEMPTS 3
PASSWORD_LIFE_TIME 40;

--3) Create an user named with your github's username (In my case would be amartinezg) 
--   with unlimited space on tablespace, the profile should be "admin"

CREATE USER YoanaEscobar
IDENTIFIED BY 12345
PROFILE admin
QUOTA UNLIMITED ON COURSES;

--4) Your user should be able to log in and have DBA privileges

GRANT CONNECT,DBA TO YoanaEscobar;

--5) Create 4 tables (LOG IN WITH YOUR USER!!!!!):

--COURSES(id, name, code, date_start, date_end) STUDENTS(id, first_name, last_name, date_of_birth, city, address) 
--ATTENDANCE(id, student_id, course_id, attendance_date) ANSWERS(id, number_of_question, answer)

--Types of columns:

--int: id (all tables), attendance(student_id, course_id) varchar2(255): courses(name, code), 
--students(first_name, last_name, city, address), answers(number_of_question, answer) date: 
--courses(date_start, date_end), students(date_of_birth), attendance(attendance_date)

--Add these constraints:

--Primary keys for all tables
--Create a sequence with the name "answer_sequence" starting in 100 with steps of 2 and associate it with answers table. 
--(Do not use identity columns)
--Name of the courses MUST only accept 'Business and Computing', 'Computer Science', 'Chemistry', 'History' and 'Zoology'
--number_of_question column in answer table MUST only accept values 'QUESTION 1', 'QUESTION 2', 'QUESTION 3', 'QUESTION 4', 
--'QUESTION 5' (In uppercase)
--Foreign key in attendance table for students and courses.


CREATE TABLE COURSES (
Id int not null,
name varchar2(255) not null,
code varchar2(255) not null,
date_start date,
date_end date,
CONSTRAINT PK_COURSES_Id PRIMARY KEY(Id),
CONSTRAINT CT_name CHECK(name IN ('Business and Computing','Computer Science','Chemistry','History','Zoology')));

CREATE TABLE STUDENTS (
Id int not null,
first_name varchar2(255) not null,
last_name varchar2(255) not null,
date_of_birth date,
city varchar2(255),
address varchar2(255) not null,
CONSTRAINT PK_STUDENTS_Id PRIMARY KEY(Id));

CREATE TABLE ATTENDANCE (
Id int not null,
student_id int,
course_id int ,
attendance_date date not null,
CONSTRAINT PK_ATTENDANCE_Id PRIMARY KEY(Id),
CONSTRAINT FK_COURSES_Id FOREIGN KEY(course_id) REFERENCES COURSES(Id),
CONSTRAINT FK_STUDENTS_Id FOREIGN KEY(student_id) REFERENCES STUDENTS (Id)); 

CREATE TABLE ANSWERS (
Id int not null,
number_of_question varchar2(255) not null,
answer varchar2(255) not null,
CONSTRAINT PK_ANSWERS_Id PRIMARY KEY(Id),
CONSTRAINT CT_number_of_question CHECK(number_of_question IN ('QUESTION 1','QUESTION 2','QUESTION 3','QUESTION 4','QUESTION 5')));

