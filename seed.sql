-- CREATE DATABASE  attendance_app;

DROP TABLE IF EXISTS student_attendance;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS attendance_status;
DROP TABLE IF EXISTS courses;

CREATE TABLE courses (
  course_id SERIAL PRIMARY KEY,
  name VARCHAR(30),
  start_date DATE,
  end_date DATE,
  course_type VARCHAR(15)
);

CREATE TABLE attendance_status (
  attendance_status_id SERIAL PRIMARY KEY,
  status VARCHAR(30),
  colour_code VARCHAR(1)
);

CREATE TABLE students (
  student_id SERIAL PRIMARY KEY,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  course_id INT,
  FOREIGN KEY(course_id) REFERENCES courses(course_id)
);

CREATE TABLE student_attendance (
  student_attendance_id SERIAL PRIMARY KEY,
  attendance_date DATE default now(),
  student_id INT,
  FOREIGN KEY(student_id) REFERENCES students(student_id),
  attendance_status_id INT REFERENCES attendance_status(attendance_status_id),
  description VARCHAR(100)
);

INSERT INTO courses(name, start_date, end_date, course_type) VALUES ('Eng-30','2019/04/01', '2019/06/28','Engineering');
INSERT INTO courses(name, start_date, end_date, course_type) VALUES ('Busi-26','2019/05/13','2019/07/05','Business');
INSERT INTO courses(name, start_date, end_date, course_type) VALUES ('Needs assignment','2019/05/13','2019/10/04','Unassigned');


INSERT INTO attendance_status(status, colour_code) VALUES ('On Time', 'g');
INSERT INTO attendance_status(status, colour_code) VALUES ('<5 mins late', 'y');
INSERT INTO attendance_status(status, colour_code) VALUES ('>5 mins late', 'o');
INSERT INTO attendance_status(status, colour_code) VALUES ('Absent', 'r');
INSERT INTO attendance_status(status, colour_code) VALUES ('Authorised Absent', 'b');

INSERT INTO students(first_name, last_name, course_id) VALUES ('Joel','McNamara','1');
INSERT INTO students(first_name, last_name, course_id) VALUES ('Matthew','Murphy','1');
INSERT INTO students(first_name, last_name, course_id) VALUES ('Patrick','Daneshyar','1');
INSERT INTO students(first_name, last_name, course_id) VALUES ('Radoslav','Shtarkov','1');
INSERT INTO students(first_name, last_name, course_id) VALUES ('Isharq','Hussain','1');
INSERT INTO students(first_name, last_name, course_id) VALUES ('Jake','Brown','1');

INSERT INTO students(first_name, last_name, course_id) VALUES ('Student','Bob','2');
INSERT INTO students(first_name, last_name, course_id) VALUES ('Student','Steve','2');
INSERT INTO students(first_name, last_name, course_id) VALUES ('Student','Phil','2');
INSERT INTO students(first_name, last_name, course_id) VALUES ('Student','Ryan','2');
INSERT INTO students(first_name, last_name, course_id) VALUES ('Student','Terrance','2');



INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/13','1','1','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/13','2','1','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/13','3','1','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/13','4','1','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/13','5','1','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/13','6','1','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/13','7','1','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/13','8','1','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/13','9','1','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/13','10','1','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/13','11','1','');

INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/14','1','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/14','2','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/14','3','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/14','4','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/14','5','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/14','6','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/14','7','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/14','8','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/14','9','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/14','10','2','');
INSERT INTO student_attendance(attendance_date, student_id, attendance_status_id, description) VALUES ('2019/05/14','11','2','');
