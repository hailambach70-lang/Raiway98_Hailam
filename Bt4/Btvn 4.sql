DROP DATABASE IF EXISTS Testing_System;

CREATE DATABASE Testing_System;

USE Testing_System;

-- Bảng 1:Department

DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
DepartmentID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
DepartmentName VARCHAR(50) NOT NULL UNIQUE KEY
);

INSERT INTO Department(DepartmentName) 
VALUES
						('Marketing'),
						('Sale'		),
						('Bảo vệ'	),
						('Nhân sự'	),
						('Kỹ thuật'	),
						('Tài chính'),
						('Phó giám đốc'),
						('Giám đốc'	),
						('Thư kí'	),
						('Bán hàng'	);
                        
-- Bảng 2:Position

DROP TABLE IF EXISTS Position;
CREATE TABLE `Position` (
PositionID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
PositionName ENUM('DEV','TEST','Scrum Master','PM') NOT NULL UNIQUE KEY
);

INSERT INTO `Position`(PositionName) 
VALUES 					('Dev'	),
						('Test'	),
						('Scrum Master'),
						('PM'	); 

-- Bảng 3:Account

DROP TABLE IF EXISTS Account;
CREATE TABLE `Account` (
AccountID		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Email			VARCHAR(50) NOT NULL UNIQUE KEY,
Username		VARCHAR(50) NOT NULL UNIQUE KEY,
FullName		VARCHAR(50) NOT NULL,
DepartmentID	TINYINT UNSIGNED NOT NULL,
PositionID		TINYINT UNSIGNED NOT NULL,
CreateDate		DATETIME DEFAULT NOW(),
FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID),
FOREIGN KEY(PositionID) REFERENCES `Position`(PositionID)
);

INSERT INTO `Account`(Email,Username,FullName,DepartmentID,PositionID,CreateDate) 
VALUES				  
						('phamvana01@gmail.com','PhamVanA01','Pham Van A',1,1,'2022-03-05'),
						('phamvanb02@gmail.com','PhamVanB02','Pham Van B',2,2,'2022-03-05'),
						('phamvanc03@gmail.com','PhamVanC03','Pham Van C',3,3,'2022-05-08'),
						('phamvand04@gmail.com','PhamVanD04','Pham Van D',4,4,'2023-06-09'),
						('phamvane05@gmail.com','PhamVanE05','Pham Van E',5,4,'2023-04-03'),
						('phamvanf06@gmail.com','PhamVanF06','Pham Van F',6,3,'2023-03-01'),
						('phamvang07@gmail.com','PhamVanG07','Pham Van G',7,2,'2024-02-02'),
						('phamvanh08@gmail.com','PhamVanH08','Pham Van H',8,1,	NULL	),
						('phamvani09@gmail.com','PhamVanI09','Pham Van I',9,1,'2022-04-05'),
						('phamvank10@gmail.com','PhamVanK10','Pham Van K',10,2,'2021-07-05');
                      
-- Bảng 4:Group

DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group` (
GroupID 	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
GroupName 	VARCHAR(50) NOT NULL UNIQUE KEY,
CreatorID 	TINYINT UNSIGNED NOT NULL,
CreateDate 	DATETIME DEFAULT NOW(),
FOREIGN KEY(CreatorID) 	REFERENCES `Account`(AccountId)
);

INSERT INTO `Group`(GroupName,CreatorID,CreateDate) 
VALUES				  
					('Finance Department',1,'2019-04-05'),
					('Customer Support Team',2,'2022-05-09'),
					('Marketing Team',3,'2023-03-07'),
					('Product Development Department',4,'2021-05-05'),
					('IT Department',5,'2024-03-05'),
					('IT Support Team',6,'2022-03-05'),
					('Legal Department',7,'2022-03-09'),
					('R&D Department',8,'2024-05-05'),
					('Human Resources Department',9,'2024-09-05'),
					('Operations Department',10,'2021-04-08');

-- Bảng 5:GroupAccount

DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount (
GroupID 	TINYINT UNSIGNED NOT NULL,
AccountID 	TINYINT UNSIGNED NOT NULL,
JoinDate 	DATETIME DEFAULT NOW(),
FOREIGN KEY (GroupID) REFERENCES `Group`(GroupID),
FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID),
PRIMARY KEY (GroupID,AccountID)
);

INSERT INTO `GroupAccount`(GroupID,AccountID,JoinDate)
VALUES
						(1,1,'2019-04-05'),
						(1,2,'2022-05-09'),
						(3,3,'2023-03-07'),
						(3,4,'2021-05-05'),
						(5,5,'2024-03-05'),
						(1,3,'2022-03-05'),
						(1,7,'2022-03-09'),
						(8,3,'2024-05-05'),
						(1,9,'2024-09-05'),
						(10,10,'2021-04-08');

-- Bảng 6:TypeQuestion

DROP TABLE IF EXISTS TypeQuestion;  
CREATE TABLE TypeQuestion (
TypeID 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
TypeName 	ENUM('Essay', 'Multiple-Choice') NOT NULL UNIQUE KEY
);

INSERT INTO TypeQuestion(TypeName) 
VALUES 					('Essay'			), 
						('Multiple-Choice'	); 

-- Bảng 7:CategoryQuestion 

DROP TABLE IF EXISTS CategoryQuestion; 
CREATE TABLE CategoryQuestion (
CategoryID 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
CategoryName 	VARCHAR(50) NOT NULL UNIQUE KEY
);

INSERT INTO CategoryQuestion(CategoryName) 
VALUES				  
							('Java'),
							('ASP.NET'),
							('ADO.NET'),
							('SQL'),
							('Postman'),
							('Ruby'),
							('Python'),
							('C++'),
							('C Sharp'),
							('PHP');

-- Bảng 8:Question 

DROP TABLE IF EXISTS Question; 
CREATE TABLE Question (
QuestionID 		TINYINT UNSIGNED AUTO_INCREMENT,
Content 		VARCHAR(50) NOT NULL,
CategoryID 		TINYINT UNSIGNED NOT NULL,
TypeID 			TINYINT UNSIGNED NOT NULL,
CreatorID 		TINYINT UNSIGNED NOT NULL,
CreateDate 		DATETIME DEFAULT NOW(),
PRIMARY KEY (QuestionID,CategoryID,TypeID),
FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion (CategoryID),
FOREIGN KEY (TypeID) REFERENCES TypeQuestion (TypeID),
FOREIGN KEY(CreatorID) 	REFERENCES `Account`(AccountId)
);

INSERT INTO Question(Content,CategoryID,TypeID,CreatorID,CreateDate)
VALUES 				('Câu hỏi về Java',1,1,2,'2022-04-05'),
					('Câu Hỏi về PHP',10,2,2,'2022-04-05'),
					('Hỏi về C#',9,2,3,'2020-04-07'),
					('Hỏi về Ruby',6,1,4,'2020-04-08'),
					('Hỏi về Postman',5,1,5,'2021-04-06'),
					('Hỏi về ADO.NET',3,2,6,'2023-04-06'),
					('Hỏi về ASP.NET',2,1,7,'2024-04-06'),
					('Hỏi về C++',8,1,8,'2020-05-07'),
					('Hỏi về SQL',4,2,9,'2020-06-07'),
					('Hỏi về Python',7,1,10,'2023-04-07');

-- Bảng 9:Answer

DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer(
AnswerID		TINYINT UNSIGNED AUTO_INCREMENT,
Content			VARCHAR(50) NOT NULL,
QuestionID		TINYINT UNSIGNED NOT NULL,
isCorrect		BIT DEFAULT 1 NOT NULL,
PRIMARY KEY (AnswerID,QuestionID),
FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)		
);

INSERT INTO Answer(Content,QuestionID,isCorrect)
VALUES 				('Trả lời 01',1,0),
					('Trả lời 02',1,1),
                    ('Trả lời 03',1,0),
                    ('Trả lời 04',1,1),
                    ('Trả lời 05',2,1),
                    ('Trả lời 06',3,1),
                    ('Trả lời 07',4,0),
                    ('Trả lời 08',8,0),
                    ('Trả lời 09',9,1),
                    ('Trả lời 10',10,1);

-- Bảng 10:Exam

DROP TABLE IF EXISTS Exam;
CREATE TABLE  Exam (
ExamID			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
`Code`			NVARCHAR(200) NOT NULL,
Title 			NVARCHAR(200) NOT NULL,
CategoryID		TINYINT UNSIGNED NOT NULL,
Duration		TINYINT UNSIGNED NOT NULL,
CreatorID		TINYINT UNSIGNED NOT NULL,
CreateDate		DATETIME DEFAULT NOW(),
FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID),
FOREIGN KEY (CreatorID)	REFERENCES `Account`(AccountID) 
);

INSERT INTO Exam(`Code`, Title,CategoryID,Duration,CreatorID,CreateDate)
VALUES 			('VTIQ001','Đề thi C#',1,60,5,'2019-04-05'),
				('VTIQ002','Đề thi PHP',10,60,2,'2019-04-05'),
				('VTIQ003','Đề thi C++',9,120,2,'2019-04-07'),
				('VTIQ004','Đề thi Java',6,60,3,'2020-04-08'),
				('VTIQ005','Đề thi Ruby',5,120,4,'2020-04-10'),
				('VTIQ006','Đề thi Postman',3,60,6,'2020-04-05'),
				('VTIQ007','Đề thi SQL',2,60,7,'2020-04-05'),
				('VTIQ008','Đề thi Python',8,60,8,'2020-04-07'),
				('VTIQ009','Đề thi ADO.NET',4,90,9,'2020-04-07'),
				('VTIQ010','Đề thi ASP.NET',7,90,10,'2020-04-08');

-- Bảng 11:ExamQuestion

DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion (
ExamID			TINYINT UNSIGNED NOT NULL,
QuestionID		TINYINT UNSIGNED NOT NULL,
PRIMARY KEY(ExamID,QuestionID),
FOREIGN KEY (ExamID) REFERENCES Exam(ExamID),
FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);

INSERT INTO ExamQuestion(ExamID,QuestionID) 
VALUES 					(1,5),
						(2,10), 
						(3,4), 
						(4,3), 
						(5,7), 
						(6,10), 
						(7,2), 
						(8,10), 
						(9,9), 
						(10,8); 
                        
-- Câu 1:viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT * FROM `Account`;
SELECT * FROM Department;

SELECT * FROM `Account` a
INNER JOIN Department d On a.DepartmentID = d.DepartmentID;

-- Câu 2:viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
SELECT * FROM `Account`;
SELECT * FROM Department;

SELECT * FROM `Account` a
WHERE CreateDate > '2020-12-20';

-- Câu 3:viết lệnh để lấy ra tất cả các developer  
SELECT * FROM `Account` a
INNER JOIN 	Position d ON a.PositionID = d.PositionID
WHERE d.PositionName = 'Dev';


-- Câu 4:viết lệnh để lấy ra danh sách các phòng ban có > 3 nhân viên
-- B1: xác định các bảng dữ liệu liên quan: Account, Department
-- B2: xác định bảng dữ liệu gốc

SELECT a.DepartmentID, d.DepartmentName, COUNT(AccountID) `MEMBER` FROM `Account` a
INNER JOIN Department d On a.DepartmentID = d.DepartmentID
GROUP BY DepartmentID
HAVING COUNT(AccountID) >= 3;
                      
-- Câu 5:viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất 
SELECT * FROM Question;
SELECT * FROM ExamQuestion;

WITH cte_Amount_Question AS (
	SELECT COUNT(*) AS Amount FROM ExamQuestion GROUP BY QuestionID 
)
SELECT ex.QuestionID, q.Content, COUNT(*) FROM ExamQuestion ex
INNER JOIN Question q ON q.QuestionID = ex.QuestionID
GROUP BY QuestionID
HAVING COUNT(*) = (SELECT MAX(Amount) FROM cte_Amount_Question);

-- Câu 6:thống kê mỗi category Question được sử dụng trong bao nhiêu Question

SELECT a.CategoryName, COUNT(d.CategoryID) FROM CategoryQuestion a
INNER JOIN Question d ON a.CategoryID = d.CategoryID
GROUP BY d.CategoryID;


                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        