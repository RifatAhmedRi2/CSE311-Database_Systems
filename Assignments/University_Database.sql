create database University_Database
go
use University_Database
go

create table department(
	dept_name varchar(20) constraint dept_pk primary key,
	building varchar(20),
	budget int
)

create table course(
	course_id varchar(10) primary key,
	title char(30),
	dept_name varchar(20) foreign key (dept_name) references department,
	credits decimal(2,1) not null
)

create table prereq(
	course_id varchar(10),
	prereq_id varchar(10),
	constraint prereq_pk primary key (course_id, prereq_id),
	constraint prereq_fk_1 foreign key (course_id) references course (course_id),
	constraint prereq_fk_2 foreign key (prereq_id) references course (course_id)
)

create table instructor(
	ID int,
	name varchar(20),
	dept_name varchar(20) not null,
	salary int,
	primary key (ID),
	foreign key (dept_name) references department (dept_name)
)

create table student(
	ID int,
	name varchar(20),
	dept_name varchar(20) not null,
	tot_cred decimal(4,1),
	constraint student_pk primary key (ID),
	constraint student_fk foreign key (dept_name) references department
)

create table advisor(
	s_id int,
	i_id int,
	primary key (s_id),
	foreign key (s_id) references student (ID),
	foreign key (i_id) references instructor (ID)
)

create table classroom(
	building varchar(20),
	room_number int,
	capacity int,
	primary key (building, room_number)
)

create table time_slot(
	time_slot_id char(2),
	day char(2),
	start_time time,
	end_time time,
	constraint time_pk primary key (time_slot_id, day, start_time)
)

create table section(
	course_id varchar(10),
	sec_id int,
	semester varchar(10),
	year int,
	building varchar(20) not null,
	room_number int not null,
	time_slot_id char(2),
	primary key (course_id, sec_id, semester, year),
	constraint section_fk foreign key (building, room_number) references classroom (building, room_number)
)

create table teaches(
	ID int,
	course_id varchar(10),
	sec_id int,
	semester varchar(10),
	year int,
	primary key (ID, course_id, sec_id, semester, year),
	foreign key (ID) references instructor,
	foreign key (course_id, sec_id, semester, year) references section
)

create table takes(
	ID int,
	course_id varchar(10),
	sec_id int,
	semester varchar(10),
	year int,
	grade char(2),
	constraint takes_pk primary key (ID, course_id, sec_id, semester, year),
	constraint takes_fk_1 foreign key (ID) references student,
	constraint takes_fk_2 foreign key (course_id, sec_id, semester, year) references section
)



insert into department
values
('Biology', 'Watson', '90000'),
('Comp. Sci.', 'Taylor', '100000'),
('Elec. Eng.', 'Taylor', '85000'),
('Finance', 'Painter', '120000'),
('History', 'Painter', '50000'),
('Music', 'Packard', '80000'),
('Physics', 'Watson', '70000')

select * from department


insert into instructor
values
('22222', 'Einstein', 'Physics', '95000'),
('12121', 'Wu', 'Finance', '90000'),
('32343', 'El Said', 'History', '60000'),
('45565', 'Katz', 'Comp. Sci.', '75000'),
('98345', 'Kim', 'Elec. Eng.', '80000'),
('76766', 'Crick', 'Biology', '72000'),
('10101', 'Srinivasan', 'Comp. Sci.', '65000'),
('58583', 'Califieri', 'History', '62000'),
('83821', 'Brandt', 'Comp. Sci.', '92000'),
('15151', 'Mozart', 'Music', '40000'),
('33456', 'Gold', 'Physics', '87000'),
('76543', 'Singh', 'Finance', '80000')

select * from instructor


insert into course
values
('BIO-101', 'Intro. to Biology', 'Biology', '4'),
('BIO-301', 'Genetics', 'Biology', '4'),
('BIO-399', 'Computational Biology', 'Biology', '3'),
('CS-101', 'Intro. to Computer Science', 'Comp. Sci.', '4'),
('CS-190', 'Game Design', 'Comp. Sci.', '4'),
('CS-315', 'Robotics', 'Comp. Sci.', '3'),
('CS-319', 'Image Processing', 'Comp. Sci.', '3'),
('CS-347', 'Database System Concepts', 'Comp. Sci.', '3'),
('EE-181', 'Intro. to Digital Systems', 'Elec. Eng.', '3'),
('FIN-201', 'Investment Banking', 'Finance', '3'),
('HIS-351', 'World History', 'History', '3'),
('MU-199', 'Music Video Production', 'Music', '3'),
('PHY-101', 'Physical Principles', 'Physics', '4')

select * from course


insert into prereq
values
('BIO-301', 'BIO-101'),
('BIO-399', 'BIO-101'),
('CS-190', 'CS-101'),
('CS-315', 'CS-101'),
('CS-319', 'CS-101'),
('CS-347', 'CS-101'),
('EE-181', 'PHY-101')

select * from prereq



insert into time_slot
values
('A', 'ST', '9:40', '11:10'),
('B', 'ST', '2:40', '4:10'),
('C', 'MW', '8:00', '9:30'),
('D', 'MW', '1:00', '2:30'),
('E', 'RA', '11:20', '12:50'),
('F', 'RA', '8:00', '9:30'),
('H', 'RA', '4:20', '5:50')

select * from time_slot


insert into classroom
values
('Painter', '514', '30'),
('Packard', '101', '35'),
('Taylor', '3128', '35'),
('Watson', '120', '40'),
('Watson', '100', '40'),
('NAC', '413', '40'),
('SAC', '203', '40'),
('Lib', '802', '35')

select * from classroom


insert into section
values
('BIO-101', '1', 'Summer', '2017', 'Painter', '514', 'B'),
('BIO-301', '1', 'Summer', '2018', 'Painter', '514', 'A'),
('CS-101', '1', 'Fall', '2017', 'Packard', '101', 'H'),
('CS-101', '1', 'Spring', '2018', 'Packard', '101', 'F'),
('CS-190', '1', 'Spring', '2017', 'Taylor', '3128', 'E'),
('CS-190', '2', 'Spring', '2017', 'Taylor', '3128', 'A'),
('CS-315', '1', 'Spring', '2018', 'Watson', '120', 'D'),
('CS-319', '1', 'Spring', '2018', 'Watson', '100', 'B'),
('CS-319', '2', 'Spring', '2018', 'Taylor', '3128', 'C'),
('CS-347', '1', 'Fall', '2017', 'Taylor', '3128', 'A'),
('EE-181', '1', 'Spring', '2017', 'Taylor', '3128', 'C'),
('FIN-201', '1', 'Spring', '2018', 'Packard', '101', 'B'),
('HIS-351', '1', 'Spring', '2018', 'Painter', '514', 'C'),
('MU-199', '1', 'Spring', '2018', 'Packard', '101', 'D'),
('PHY-101', '1', 'Fall', '2017', 'Watson', '100', 'A')

select * from section


insert into teaches
values
('10101', 'CS-101', '1', 'Fall', '2017'),
('10101', 'CS-315', '1', 'Spring', '2018'),
('10101', 'CS-347', '1', 'Fall', '2017'),
('12121', 'FIN-201', '1', 'Spring', '2018'),
('15151', 'MU-199', '1', 'Spring', '2018'),
('22222', 'PHY-101', '1', 'Fall', '2017'),
('32343', 'HIS-351', '1', 'Spring', '2018'),
('45565', 'CS-101', '1', 'Spring', '2018'),
('45565', 'CS-319', '1', 'Spring', '2018'),
('76766', 'BIO-101', '1', 'Summer', '2017'),
('76766', 'BIO-301', '1', 'Summer', '2018'),
('83821', 'CS-190', '1', 'Spring', '2017'),
('83821', 'CS-190', '2', 'Spring', '2017'),
('83821', 'CS-319', '2', 'Spring', '2018'),
('98345', 'EE-181', '1', 'Spring', '2017')

select * from teaches


insert into student
values
('19317', 'Rifat ', 'Comp. Sci.', '48'),
('19316', 'Ahnaf', 'Comp. Sci.', '45'),
('19375', 'Saif', 'Comp. Sci.', '42'),
('19206', 'Mitul', 'Comp. Sci.', '58'),
('19313', 'Preenan', 'Elec. Eng.', '51'),
('18112', 'Akash', 'Elec. Eng.', '78'),
('18246', 'Utshab', 'Elec. Eng.', '72'),
('19123', 'Anayet', 'Biology', '61'),
('19119', 'Karim', 'Biology', '58'),
('20202', 'Hasan', 'Physics', '35'),
('16202', 'Sokina', 'Physics', '122.5'),
('17237', 'Nishat', 'Music', '88'),
('18369', 'Fahim', 'Finance', '60'),
('17329', 'Mina', 'History', '76')

select * from student


insert into advisor
values
('16202', '33456'),
('17237', '15151'),
('17329', '58583'),
('18112', '98345'),
('18246', '98345'),
('18369', '12121'),
('19119', '76766'),
('19123', '76766'),
('19206', '83821'),
('19313', '98345'),
('19316', '45565'),
('19317', '10101'),
('19375', '45565'),
('20202', '22222')

select * from advisor


insert into takes
values
('16202', 'Phy-101', '1', 'Fall', '2017', 'A'),
('17237', 'FIN-201', '1', 'Spring', '2018', 'B+'),
('17329', 'HIS-351', '1', 'Spring', '2018', 'B'),
('18112', 'EE-181', '1', 'Spring', '2017', 'B+'),
('18246', 'EE-181', '1', 'Spring', '2017', 'B-'),
('18369', 'FIN-201', '1', 'Spring', '2018', 'B'),
('19119', 'BIO-301', '1', 'Summer', '2018', 'A'),
('19123', 'BIO-101', '1', 'Summer', '2017', 'A-'),
('19206', 'CS-190', '2', 'Spring', '2017', 'B'),
('19313', 'EE-181', '1', 'Spring', '2017', 'B+'),
('19316', 'CS-190', '1', 'Spring', '2017', 'B'),
('19317', 'CS-190', '2', 'Spring', '2017', 'A'),
('19375', 'CS-190', '2', 'Spring', '2017', 'B'),
('20202', 'Phy-101', '1', 'Fall', '2017', 'B-')

select * from takes