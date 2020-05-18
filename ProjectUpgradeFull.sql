CREATE TABLE AcademicDegree ( 
	ID int NOT NULL,
	Name varchar(50) NOT NULL
)
;

CREATE TABLE Auditorium ( 
	ID int NOT NULL,
	Name varchar(50) NOT NULL,
	OccupationType_ID int NOT NULL,
	NumberOfSeats int NOT NULL,
	HasProjector bit NOT NULL
)
;

CREATE TABLE Department ( 
	ID int NOT NULL,
	Name varchar(50) NOT NULL,
	Faculty_ID int NOT NULL,
	DescriptionD varchar(500)
)
;

CREATE TABLE Faculty ( 
	ID int NOT NULL,
	Name varchar(50) NOT NULL,
	DescriptionF varchar(500),
	Dean varchar(50)

)
;

CREATE TABLE Groups ( 
	ID int NOT NULL,
	NumberOfStudents int NOT NULL,
	Speciality_ID int NOT NULL
)
;

CREATE TABLE Lesson ( 
	ID int NOT NULL,
	TimeStart time(0) NOT NULL,
	TimeEnd time(0) NOT NULL,
	DateL datetime NOT NULL,
	Auditorium_ID int NOT NULL,
	Teacher_ID int NOT NULL,
	Subject_ID int NOT NULL
)
;

CREATE TABLE OccupationType ( 
	ID int NOT NULL,
	Name varchar(50) NOT NULL
)
;

CREATE TABLE Position ( 
	ID int NOT NULL,
	Name varchar(50) NOT NULL
)
;

CREATE TABLE Result_Student_Lesson ( 
	StudentR_ID int NOT NULL,
	LessonR_ID int NOT NULL,
	Result int NOT NULL,
	TypeOfCheck varchar(50) NOT NULL
)
;

CREATE TABLE Speciality ( 
	ID int NOT NULL,
	Name varchar(80) NOT NULL,
	Faculty_ID int NOT NULL,
	DescriptionS varchar(500)
)
;

CREATE TABLE Student ( 
	ID int NOT NULL,
	FirstName varchar(50) NOT NULL,
	LastName varchar(50) NOT NULL,
	DateOfBirth datetime NOT NULL,
	TelephoneNumber varchar(15) NOT NULL,
	Groups_ID int NOT NULL,
	Email varchar(70),
	Profile_photo varbinary(max)
)
;

CREATE TABLE Student_Lesson ( 
	Student_ID int NOT NULL,
	Lesson_ID int NOT NULL
)
;

CREATE TABLE Subject ( 
	ID int NOT NULL,
	Name varchar(80) NOT NULL,
	Obligatory bit NOT NULL,
	NumberOfHours int NOT NULL,
	DescriptionS varchar(500)
)
;

CREATE TABLE Teacher ( 
	ID int NOT NULL,
	Department_ID int NOT NULL,
	Position_ID int NOT NULL,
	AcademicDegree_ID int NOT NULL,
	FirstName varchar(50) NOT NULL,
	LastName varchar(50) NOT NULL,
	Office varchar(50) NOT NULL
)
;



CREATE UNIQUE INDEX IX_STUDENT ON Student (TelephoneNumber);

CREATE UNIQUE INDEX IX_SPECIALITY ON Speciality (Name);

CREATE UNIQUE INDEX IX_FACULTY ON Faculty (Name);

CREATE UNIQUE INDEX IX_Department on Department (Name);

CREATE UNIQUE INDEX IX_Position on Position (Name);

CREATE UNIQUE INDEX IX_AcademicDegree on AcademicDegree (Name);






ALTER TABLE AcademicDegree ADD CONSTRAINT PK_AcademicDegree 
	PRIMARY KEY (ID)
;

ALTER TABLE Auditorium ADD CONSTRAINT PK_Auditorium 
	PRIMARY KEY (ID)
;

ALTER TABLE Department ADD CONSTRAINT PK_Department 
	PRIMARY KEY (ID)
;

ALTER TABLE Faculty ADD CONSTRAINT PK_Faculty 
	PRIMARY KEY (ID)
;

ALTER TABLE Groups ADD CONSTRAINT PK_Groups 
	PRIMARY KEY (ID)
;

ALTER TABLE Lesson ADD CONSTRAINT PK_Lesson
	PRIMARY KEY (ID)
;

ALTER TABLE OccupationType ADD CONSTRAINT PK_OccupationType 
	PRIMARY KEY (ID)
;

ALTER TABLE Position ADD CONSTRAINT PK_Position 
	PRIMARY KEY (ID)
;

ALTER TABLE Result_Student_Lesson ADD CONSTRAINT PK_Result 
	PRIMARY KEY (StudentR_ID, LessonR_ID)
;

ALTER TABLE Speciality ADD CONSTRAINT PK_Speciality 
	PRIMARY KEY (ID)
;

ALTER TABLE Student ADD CONSTRAINT PK_Student 
	PRIMARY KEY (ID)
;

ALTER TABLE Student_Lesson ADD CONSTRAINT PK_Student_Lesson 
	PRIMARY KEY (Student_ID, Lesson_ID)
;

ALTER TABLE Subject ADD CONSTRAINT PK_Subject 
	PRIMARY KEY (ID)
;

ALTER TABLE Teacher ADD CONSTRAINT PK_Teacher 
	PRIMARY KEY (ID)
;




ALTER TABLE Auditorium ADD CONSTRAINT FK_Auditorium_OccupationType 
	FOREIGN KEY (OccupationType_ID) REFERENCES OccupationType (ID)
;

ALTER TABLE Department ADD CONSTRAINT FK_Department_Faculty 
	FOREIGN KEY (Faculty_ID) REFERENCES Faculty (ID)
;

ALTER TABLE Groups ADD CONSTRAINT FK_Groups_Speciality 
	FOREIGN KEY (Speciality_ID) REFERENCES Speciality (ID)
;

ALTER TABLE Lesson ADD CONSTRAINT FK_Lesson_Auditorium 
	FOREIGN KEY (Auditorium_ID) REFERENCES Auditorium (ID)
;

ALTER TABLE Lesson ADD CONSTRAINT FK_Lesson_Subject 
	FOREIGN KEY (Subject_ID) REFERENCES Subject (ID)
;

ALTER TABLE Lesson ADD CONSTRAINT FK_Lesson_Teacher 
	FOREIGN KEY (Teacher_ID) REFERENCES Teacher (ID)
;

ALTER TABLE Result_Student_Lesson ADD CONSTRAINT FK_Result_Student_Lesson_Student_Lesson 
	FOREIGN KEY (StudentR_ID, LessonR_ID) REFERENCES Student_Lesson (Student_ID, Lesson_ID)
;

ALTER TABLE Speciality ADD CONSTRAINT FK_Speciality_Faculty 
	FOREIGN KEY (Faculty_ID) REFERENCES Faculty (ID)
;

ALTER TABLE Student ADD CONSTRAINT FK_Student_Groups 
	FOREIGN KEY (Groups_ID) REFERENCES Groups (ID)
;

ALTER TABLE Student_Lesson ADD CONSTRAINT FK_Student_Lesson_Lesson 
	FOREIGN KEY (Lesson_ID) REFERENCES Lesson (ID)
;

ALTER TABLE Student_Lesson ADD CONSTRAINT FK_Student_Lesson_Student 
	FOREIGN KEY (Student_ID) REFERENCES Student (ID)
;

ALTER TABLE Teacher ADD CONSTRAINT FK_Teacher_AcademicDegree 
	FOREIGN KEY (AcademicDegree_ID) REFERENCES AcademicDegree (ID)
;

ALTER TABLE Teacher ADD CONSTRAINT FK_Teacher_Department 
	FOREIGN KEY (Department_ID) REFERENCES Department (ID)
;

ALTER TABLE Teacher ADD CONSTRAINT FK_Teacher_Position 
	FOREIGN KEY (Position_ID) REFERENCES Position (ID)
;



ALTER TABLE Result_Student_Lesson ADD CONSTRAINT CK_Result_Student_Lesson_TypeOfCheck CHECK (TypeOfCheck IN ('Midterm', 'Quiz', 'Final', 'Task'));

ALTER TABLE Result_Student_Lesson ADD CONSTRAINT CK_Result_Student_Lesson_Result CHECK (Result >= 0);

ALTER TABLE Student ADD CONSTRAINT CK_Student_DateOfBirth CHECK (YEAR(getdate()) - YEAR(DateOfBirth) >= 15);

ALTER TABLE Groups ADD CONSTRAINT CK_Groups_NumOfStude CHECK (NumberOfStudents > 10);

ALTER TABLE Subject ADD CONSTRAINT CK_Subject_NumOfHours CHECK (NumberOfHours > 0);


ALTER TABLE Lesson ADD CONSTRAINT CK_Lesson_Date CHECK (YEAR(DateL) > 2000);  

ALTER TABLE Student ADD CONSTRAINT CK_Student_TelephoneNumber CHECK (len(TelephoneNumber) >= 10);

ALTER TABLE Student ADD CONSTRAINT CK_Student_Email CHECK (Email LIKE '%___@___%.__%');

ALTER TABLE Groups ADD CONSTRAINT DF_Groups_NumOfStudents DEFAULT 15 for NumberOfStudents;

ALTER TABLE Lesson ADD CONSTRAINT DF_Lesson_DateL DEFAULT getdate() for DateL;


INSERT INTO Faculty (ID, Name, DescriptionF, Dean) VALUES (1, 'Law', 'In the final year, extra courses are taught by orienting and dividing students into more specific specialisations, such as civil, state jurisdiction, criminal law, international law, and others. ','James Bond');
INSERT INTO Faculty (ID, Name, DescriptionF, Dean) VALUES (2, 'Social sciences','The Faculty of Social Sciences examines society. We educate experts who understand social phenomena and can place them in a historical and social context.','Paul Wong');
INSERT INTO Faculty (ID, Name, DescriptionF, Dean) VALUES (3, 'Engineering','The main areas taught at the Faculty of Engineering cover fundamental and advanced knowledge in the development of integrated web applications, algorithms, software designing, database systems, discrete mathematics, logical programming, cryptography, computer networks, computer simulation, and others','Meghan Collins');
INSERT INTO Faculty (ID, Name, DescriptionF, Dean) VALUES (4, 'Business','Apart from degree programmes, the faculty offers specialized training programs, research and consultancy services to the organizations, executives and professionals in the public and private sectors.','Melanie James');
INSERT INTO Faculty (ID, Name, DescriptionF, Dean) VALUES (5, 'Education and Humanities','The Facultys mission is to train professional teachers and educationalists who are creative and independent minded to meet the high demand for teachers who will transform communities globally and country wide.','Roy Green');

INSERT INTO Position (ID, Name) VALUES (1, 'Lab-Instructor');
INSERT INTO Position (ID, Name) VALUES (2, 'Lecturer');
INSERT INTO Position (ID, Name) VALUES (3, 'Senior Lecturer');
INSERT INTO Position (ID, Name) VALUES (4, 'Professor');
INSERT INTO Position (ID, Name) VALUES (5, 'Associate Professor');
INSERT INTO Position (ID, Name) VALUES (6, 'Assistant Professor');

INSERT INTO AcademicDegree (ID, Name) VALUES (1, 'Bachelor of Science');
INSERT INTO AcademicDegree (ID, Name) VALUES (2, 'Master of Science');
INSERT INTO AcademicDegree (ID, Name) VALUES (3, 'Doctor of Science');

INSERT INTO OccupationType (ID, Name) VALUES (1, 'Lecture');
INSERT INTO OccupationType (ID, Name) VALUES (2, 'Practise-Lab');

INSERT INTO  Auditorium (ID, Name, OccupationType_ID, NumberOfSeats, HasProjector) VALUES (1, 'E109', 1, 100, 1);
INSERT INTO  Auditorium (ID, Name, OccupationType_ID, NumberOfSeats, HasProjector) VALUES (2, 'F102', 2, 30, 1);
INSERT INTO  Auditorium (ID, Name, OccupationType_ID, NumberOfSeats, HasProjector) VALUES (3, 'D105', 2, 25, 0);
INSERT INTO  Auditorium (ID, Name, OccupationType_ID, NumberOfSeats, HasProjector) VALUES (4, 'D110', 1, 100, 1);
INSERT INTO  Auditorium (ID, Name, OccupationType_ID, NumberOfSeats, HasProjector) VALUES (5, 'G112', 1, 100, 1);


INSERT INTO Subject (ID, Name,  Obligatory, NumberOfHours, DescriptionS) VALUES (1, 'Introduction to Algorithms', 1, 200, 'The Algorithm designed are language-independent, i.e. they are just plain instructions that can be implemented in any language, and yet the output will be the');
INSERT INTO Subject (ID, Name,  Obligatory, NumberOfHours, DescriptionS) VALUES (2, 'Database Management Systems 1', 1, 200,'A database management system (DBMS) is system software for creating and managing databases.');
INSERT INTO Subject (ID, Name,  Obligatory, NumberOfHours, DescriptionS) VALUES (3, 'Economics', 0, 150, 'the branch of knowledge concerned with the production, consumption, and transfer of wealth.');
INSERT INTO Subject (ID, Name,  Obligatory, NumberOfHours, DescriptionS) VALUES (4, 'Game Physics', 0, 150,'Computer animation physics or game physics involves the introduction of the laws of physics into a simulation or game engine, particularly in 3D computer graphics, for the purpose of making the effects appear more realistic to the observer. ');
INSERT INTO Subject (ID, Name,  Obligatory, NumberOfHours, DescriptionS) VALUES (5, 'Philosophy', 1, 170,'the study of the fundamental nature of knowledge, reality, and existence, especially when considered as an academic discipline.');


INSERT INTO Department (ID, Name, Faculty_ID, DescriptionD) VALUES (1, 'Computer Sciences', 3, 'The Department of Computer Science offers the undergraduate degree Bachelor of Science in Computer Science');
INSERT INTO Department (ID, Name, Faculty_ID, DescriptionD) VALUES (2, 'Economics and Business', 4, 'The Department of Economics and Business of CEU is a research-oriented department with an international faculty holding PhDs from some of the best');
INSERT INTO Department (ID, Name, Faculty_ID, DescriptionD) VALUES (3, 'Jurisprudence', 1, 'Students in the Department of Jurisprudence study law and government through a systematic curriculum that nurtures talented graduates who solidly understand');
INSERT INTO Department (ID, Name, Faculty_ID, DescriptionD) VALUES (4, 'Philology', 5, 'Philology is the study of language in oral and written historical sources');
INSERT INTO Department (ID, Name, Faculty_ID, DescriptionD) VALUES (5, 'Social Sciences', 2, 'The Department of Social Sciences offers several disciplines of study to help you further your educational pursuits');


INSERT INTO Teacher (ID, Department_ID, Position_ID, AcademicDegree_ID, FirstName, LastName, Office) VALUES (1, 1, 2, 2, 'Damir', 'Kurmanbayev', 'F320');
INSERT INTO Teacher (ID, Department_ID, Position_ID, AcademicDegree_ID, FirstName, LastName, Office) VALUES (2, 1, 3, 2, 'Satbek', 'Abdyldaev', 'F319');
INSERT INTO Teacher (ID, Department_ID, Position_ID, AcademicDegree_ID, FirstName, LastName, Office) VALUES (3, 2, 1, 2, 'Assya', 'Dyussenova', 'E222');
INSERT INTO Teacher (ID, Department_ID, Position_ID, AcademicDegree_ID, FirstName, LastName, Office) VALUES (4, 4, 4, 3, 'Shynar', 'Auyelbekova', 'D319');
INSERT INTO Teacher (ID, Department_ID, Position_ID, AcademicDegree_ID, FirstName, LastName, Office) VALUES (5, 5, 5, 3, 'Gaukhar', 'Arepova', 'G333');

INSERT INTO Lesson (ID, TimeStart, TimeEnd, DateL, Auditorium_ID, Teacher_ID, Subject_ID) VALUES (1, '09:00:00', '10:50:00', CONVERT(datetime,'2019-06-10',102), 1, 1, 4);
INSERT INTO Lesson (ID, TimeStart, TimeEnd, DateL, Auditorium_ID, Teacher_ID, Subject_ID) VALUES (2, '14:00:00', '15:50:00', CONVERT(datetime,'2019-06-12',102), 2, 2, 1);
INSERT INTO Lesson (ID, TimeStart, TimeEnd, DateL, Auditorium_ID, Teacher_ID, Subject_ID) VALUES (3, '11:00:00', '11:50:00', CONVERT(datetime,'2019-06-10',102), 3, 3, 3);
INSERT INTO Lesson (ID, TimeStart, TimeEnd, DateL, Auditorium_ID, Teacher_ID, Subject_ID) VALUES (4, '16:00:00', '17:50:00', CONVERT(datetime,'2019-06-11',102), 2, 2, 2);
INSERT INTO Lesson (ID, TimeStart, TimeEnd, DateL, Auditorium_ID, Teacher_ID, Subject_ID) VALUES (5, '09:00:00', '10:50:00', CONVERT(datetime,'2019-06-15',102), 5, 5, 5);

INSERT INTO Speciality (ID, Name, Faculty_ID, DescriptionS) VALUES (1, 'Information Systems', 3, 'Information Systems (and Technology) is a speciality on the point of intersection of the following two: Business Administration and Computer Science.');
INSERT INTO Speciality (ID, Name, Faculty_ID, DescriptionS) VALUES (2, 'Computing Systems and Software', 3,' Computing Systems stream offers three specializations, which includes a Computer Science specialization');
INSERT INTO Speciality (ID, Name, Faculty_ID, DescriptionS) VALUES (3, 'Economics', 4, 'Economists develop expertise and conduct research in various specialized disciplines within the field of economics.');
INSERT INTO Speciality (ID, Name, Faculty_ID, DescriptionS) VALUES (4, 'International Relations', 2,'The field of international relations is exceptionally dynamic, changing alongside an evolving global community committed to social justice, environmental.');
INSERT INTO Speciality (ID, Name, Faculty_ID, DescriptionS) VALUES (5, 'Jurisprudence', 1, 'Bodies of state and local self-government, law enforcement agencies, Judiciary, advocacy and notary offices are the spheres of legal system graduates can work in successfully.');

INSERT INTO Groups (ID, NumberOfStudents, Speciality_ID) VALUES (1, 15, 1);
INSERT INTO Groups (ID, NumberOfStudents, Speciality_ID) VALUES (2, 20, 2);
INSERT INTO Groups (ID, NumberOfStudents, Speciality_ID) VALUES (3, 18, 1);
INSERT INTO Groups (ID, NumberOfStudents, Speciality_ID) VALUES (4, 21, 3);
INSERT INTO Groups (ID, NumberOfStudents, Speciality_ID) VALUES (5, 19, 4);

INSERT INTO Student (ID, FirstName, LastName, DateOfBirth, TelephoneNumber, Groups_ID, Email, Profile_photo) VALUES (1,'Adil', 'Bolatkhanov', convert(datetime, '2001-06-11', 102), '87789307168', 1, 'kwenten@mail.ru',(SELECT * FROM OPENROWSET(BULK 'C:\StudentProfiles\course-workload-studying-id820697270-180404.jpg', SINGLE_BLOB) as T1));
INSERT INTO Student (ID, FirstName, LastName, DateOfBirth, TelephoneNumber, Groups_ID, Email, Profile_photo) VALUES (2,'Erasil', 'Yediluly', convert(datetime, '2001-07-15', 102), '87771237676', 1, 'yediluly@mail.ru',(SELECT * FROM OPENROWSET(BULK 'C:\StudentProfiles\course-workload-studying-id820697270-180404.jpg', SINGLE_BLOB) as T1));
INSERT INTO Student (ID, FirstName, LastName, DateOfBirth, TelephoneNumber, Groups_ID, Email, Profile_photo) VALUES (3,'Baurjan', 'Yerkeshov', convert(datetime, '2000-02-02', 102), '87785555555', 2, 'baby11@mail.ru',(SELECT * FROM OPENROWSET(BULK 'C:\StudentProfiles\student-boy-1-square.jpg', SINGLE_BLOB) as T1));
INSERT INTO Student (ID, FirstName, LastName, DateOfBirth, TelephoneNumber, Groups_ID, Email, Profile_photo) VALUES (4,'Aslan', 'Aset', convert(datetime, '2001-10-11', 102), '87781113838', 3, 'asset@mail.ru',(SELECT * FROM OPENROWSET(BULK 'C:\StudentProfiles\University-student-stock-pixabay.jpg', SINGLE_BLOB) as T1));
INSERT INTO Student (ID, FirstName, LastName, DateOfBirth, TelephoneNumber, Groups_ID, Email, Profile_photo) VALUES (5,'Janserik', 'Bolat', convert(datetime, '1999-06-11', 102), '877533313133', 2, 'bolat1999@mail.ru',(SELECT * FROM OPENROWSET(BULK 'C:\StudentProfiles\960x0.jpg', SINGLE_BLOB) as T1));
INSERT INTO Student (ID, FirstName, LastName, DateOfBirth, TelephoneNumber, Groups_ID, Email, Profile_photo) VALUES (6,'Almas', 'Tanayev', convert(datetime, '2002-09-14', 102), '87778881122', 4, 'almashok@mail.ru',(SELECT * FROM OPENROWSET(BULK 'C:\StudentProfiles\home_mob.jpg', SINGLE_BLOB) as T1));



INSERT INTO Student_Lesson (Student_ID, Lesson_ID) VALUES (1, 2);
INSERT INTO Student_Lesson (Student_ID, Lesson_ID) VALUES (2, 2);
INSERT INTO Student_Lesson (Student_ID, Lesson_ID) VALUES (3, 1);
INSERT INTO Student_Lesson (Student_ID, Lesson_ID) VALUES (4, 4);
INSERT INTO Student_Lesson (Student_ID, Lesson_ID) VALUES (5, 1);
INSERT INTO Student_Lesson (Student_ID, Lesson_ID) VALUES (6, 3);

INSERT INTO Result_Student_Lesson ( StudentR_ID, LessonR_ID, Result, TypeOfCheck) VALUES ( 1, 2, 30, 'Midterm');
INSERT INTO Result_Student_Lesson ( StudentR_ID, LessonR_ID, Result, TypeOfCheck) VALUES ( 2, 2, 28, 'Midterm');
INSERT INTO Result_Student_Lesson ( StudentR_ID, LessonR_ID, Result, TypeOfCheck) VALUES ( 3, 1, 5, 'Task');
INSERT INTO Result_Student_Lesson ( StudentR_ID, LessonR_ID, Result, TypeOfCheck) VALUES ( 4, 4, 10, 'Quiz');
INSERT INTO Result_Student_Lesson ( StudentR_ID, LessonR_ID, Result, TypeOfCheck) VALUES ( 5, 1, 4, 'Task');




UPDATE Subject SET NumberOfHours = 210 WHERE ID = 1;

UPDATE Teacher SET AcademicDegree_ID = 3 WHERE FirstName = 'Satbek' AND LastName = 'Abdyldaev';

UPDATE Student SET Email = 'iamadilbolatkhanov@gmail.com' WHERE ID = 1;

INSERT INTO Faculty (ID, Name) VALUES (6, 'Arts');

DELETE FROM Faculty WHERE Name = 'Arts';

INSERT INTO Groups (ID, NumberOfStudents, Speciality_ID) VALUES (6, 22, 5);

DELETE FROM Groups WHERE Speciality_ID = 5;

INSERT INTO Speciality (ID, Name, Faculty_ID) VALUES (6, 'ABC', 5);

DELETE FROM Speciality WHERE ID = 6;

 
create view Student_info as select FirstName, LastName, DateOfBirth, TelephoneNumber, Email, Profile_photo, Groups_ID as GroupNumber, 
Speciality.Name as Speciality, Speciality.DescriptionS as SpecialityDescription, Faculty.Name as Faculty
from Student join Groups on Student.Groups_ID = Groups.ID join Speciality on Groups.Speciality_ID = Speciality.ID join Faculty on 
Faculty.ID = Speciality.Faculty_ID;

Create view Teacher_info as select FirstName, LastName, Position.Name as Position,Office, AcademicDegree.Name as AcademicDegree, Department.Name as Department, 
DescriptionD as DepartmentDescription ,Faculty.Name as Faculty from Teacher join Position on Teacher.Position_ID = Position.ID join AcademicDegree on AcademicDegree.ID = Teacher.AcademicDegree_ID
left join Department on Teacher.Department_ID = Department.ID left join Faculty on Department.Faculty_ID = Faculty.ID;

create view Lesson_info as select TimeStart, TimeEnd, DateL, Auditorium.Name as Auditorium, OccupationType.Name as OccupationType, Subject.Name as Subject,
 Teacher.FirstName as TeachersFirstName, Teacher.LastName as TeachersLastName
from Lesson join Auditorium on Auditorium.ID = Lesson.Auditorium_ID join OccupationType on Auditorium.OccupationType_ID = OccupationType.ID join Subject on 
Subject.ID = Lesson.Subject_ID join Teacher on Teacher.ID = Lesson.Teacher_ID;

create view Student_Lesson_INFO as select Student.FirstName as Name, Student.LastName as Surname, Student.Groups_ID	as GroupsNumber, Lesson.DateL, 
Lesson.TimeStart, Lesson.TimeEnd, Auditorium.Name as Auditorium, OccupationType.Name as OccupationType, Subject.Name as Subject,
 Teacher.FirstName as TeachersFirstName, Teacher.LastName as TeachersLastName  from Student_Lesson join Student on Student_Lesson.Student_ID = Student.ID join
 Lesson on Student_Lesson.Lesson_ID = Lesson.ID join Auditorium on Auditorium.ID = Lesson.Auditorium_ID join OccupationType on Auditorium.OccupationType_ID = OccupationType.ID
 join Subject on Subject.ID = Lesson.Subject_ID join Teacher on Teacher.ID = Lesson.Teacher_ID;

create view Result_Student_Lesson_INFO as select Student.FirstName as Name, Student.LastName as Surname, Student.Groups_ID	as GroupsNumber, Lesson.DateL, 
Lesson.TimeStart, Lesson.TimeEnd, Auditorium.Name as Auditorium, OccupationType.Name as OccupationType, Subject.Name as Subject,
 Teacher.FirstName as TeachersFirstName, Teacher.LastName as TeachersLastName, Result, TypeOfCheck  from Result_Student_Lesson join
 Student_Lesson on Result_Student_Lesson.StudentR_ID = Student_Lesson.Student_ID AND Result_Student_Lesson.LessonR_ID = Student_Lesson.Lesson_ID join 
 Student on Student_Lesson.Student_ID = Student.ID join
 Lesson on Student_Lesson.Lesson_ID = Lesson.ID join Auditorium on Auditorium.ID = Lesson.Auditorium_ID join OccupationType on Auditorium.OccupationType_ID = OccupationType.ID
 join Subject on Subject.ID = Lesson.Subject_ID join Teacher on Teacher.ID = Lesson.Teacher_ID;



