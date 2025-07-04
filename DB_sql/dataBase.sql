USE [master]
GO
DROP DATABASE [PRJ301_WORKSHOP02]
GO

CREATE DATABASE [PRJ301_WORKSHOP02]
GO

USE [PRJ301_WORKSHOP02]
GO

-- 1. Users Table: tblUsers
CREATE TABLE [dbo].[tblUsers](
	[username] [nvarchar](50) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[password] [nvarchar](255) NOT NULL,
	[role] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_tblUsers] PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- Add check constraint for role
ALTER TABLE [dbo].[tblUsers] WITH CHECK ADD CONSTRAINT [CK_tblUsers_role] 
CHECK ([role] IN ('Instructor', 'Student'))
GO

-- Insert sample users
INSERT [dbo].[tblUsers] ([username], [name], [password], [role]) VALUES (N'admin', N'Administrator', N'1', N'Instructor')
INSERT [dbo].[tblUsers] ([username], [name], [password], [role]) VALUES (N'teacher01', N'Nguyen Van A', N'pass123', N'Instructor')
INSERT [dbo].[tblUsers] ([username], [name], [password], [role]) VALUES (N'student01', N'Tran Thi B', N'student123', N'Student')
INSERT [dbo].[tblUsers] ([username], [name], [password], [role]) VALUES (N'student02', N'Le Van C', N'student456', N'Student')
INSERT [dbo].[tblUsers] ([username], [name], [password], [role]) VALUES (N'student03', N'Pham Thi D', N'student789', N'Student')
GO

-- 2. Exam Categories Table: tblExamCategories  
CREATE TABLE [dbo].[tblExamCategories](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [nvarchar](50) NOT NULL,
	[description] [ntext] NULL,
 CONSTRAINT [PK_tblExamCategories] PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

-- Insert sample exam categories
INSERT [dbo].[tblExamCategories] ([category_name], [description]) VALUES (N'Quiz', N'Short assessment quizzes')
INSERT [dbo].[tblExamCategories] ([category_name], [description]) VALUES (N'Midterm', N'Mid-semester examinations')
INSERT [dbo].[tblExamCategories] ([category_name], [description]) VALUES (N'Final', N'Final semester examinations')
INSERT [dbo].[tblExamCategories] ([category_name], [description]) VALUES (N'Practice', N'Practice tests for preparation')
GO

-- 3. Exams Table: tblExams
CREATE TABLE [dbo].[tblExams](
	[exam_id] [int] IDENTITY(1,1) NOT NULL,
	[exam_title] [nvarchar](100) NOT NULL,
	[subject] [nvarchar](50) NOT NULL,
	[category_id] [int] NOT NULL,
	[total_marks] [int] NOT NULL,
	[duration] [int] NOT NULL,
 CONSTRAINT [PK_tblExams] PRIMARY KEY CLUSTERED 
(
	[exam_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- Add foreign key constraint
ALTER TABLE [dbo].[tblExams] WITH CHECK ADD CONSTRAINT [FK_tblExams_tblExamCategories] 
FOREIGN KEY([category_id]) REFERENCES [dbo].[tblExamCategories] ([category_id])
GO

-- Add check constraint for duration (must be positive)
ALTER TABLE [dbo].[tblExams] WITH CHECK ADD CONSTRAINT [CK_tblExams_duration] 
CHECK ([duration] > 0)
GO

-- Insert sample exams
INSERT [dbo].[tblExams] ([exam_title], [subject], [category_id], [total_marks], [duration]) VALUES (N'Java Programming Quiz 1', N'Programming', 1, 20, 30)
INSERT [dbo].[tblExams] ([exam_title], [subject], [category_id], [total_marks], [duration]) VALUES (N'Database Design Midterm', N'Database', 2, 100, 90)
INSERT [dbo].[tblExams] ([exam_title], [subject], [category_id], [total_marks], [duration]) VALUES (N'Web Development Final', N'Web Development', 3, 100, 120)
INSERT [dbo].[tblExams] ([exam_title], [subject], [category_id], [total_marks], [duration]) VALUES (N'SQL Practice Test', N'Database', 4, 50, 60)
INSERT [dbo].[tblExams] ([exam_title], [subject], [category_id], [total_marks], [duration]) VALUES (N'OOP Concepts Quiz', N'Programming', 1, 25, 45)
GO

-- 4. Questions Table: tblQuestions
CREATE TABLE [dbo].[tblQuestions](
	[question_id] [int] IDENTITY(1,1) NOT NULL,
	[exam_id] [int] NOT NULL,
	[question_text] [ntext] NOT NULL,
	[option_a] [nvarchar](100) NOT NULL,
	[option_b] [nvarchar](100) NOT NULL,
	[option_c] [nvarchar](100) NOT NULL,
	[option_d] [nvarchar](100) NOT NULL,
	[correct_option] [char](1) NOT NULL,
 CONSTRAINT [PK_tblQuestions] PRIMARY KEY CLUSTERED 
(
	[question_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

-- Add foreign key constraint
ALTER TABLE [dbo].[tblQuestions] WITH CHECK ADD CONSTRAINT [FK_tblQuestions_tblExams] 
FOREIGN KEY([exam_id]) REFERENCES [dbo].[tblExams] ([exam_id])
GO

-- Add check constraint for correct_option
ALTER TABLE [dbo].[tblQuestions] WITH CHECK ADD CONSTRAINT [CK_tblQuestions_correct_option] 
CHECK ([correct_option] IN ('A', 'B', 'C', 'D'))
GO

-- Insert sample questions
INSERT [dbo].[tblQuestions] ([exam_id], [question_text], [option_a], [option_b], [option_c], [option_d], [correct_option]) VALUES 
(1, N'What is the main method signature in Java?', N'public static void main(String args[])', N'public void main(String args[])', N'static void main(String args[])', N'public main(String args[])', N'A')

INSERT [dbo].[tblQuestions] ([exam_id], [question_text], [option_a], [option_b], [option_c], [option_d], [correct_option]) VALUES 
(1, N'Which keyword is used to create a class in Java?', N'create', N'class', N'new', N'define', N'B')

INSERT [dbo].[tblQuestions] ([exam_id], [question_text], [option_a], [option_b], [option_c], [option_d], [correct_option]) VALUES 
(2, N'What does SQL stand for?', N'Structured Query Language', N'Simple Query Language', N'Standard Query Language', N'System Query Language', N'A')

INSERT [dbo].[tblQuestions] ([exam_id], [question_text], [option_a], [option_b], [option_c], [option_d], [correct_option]) VALUES 
(2, N'Which SQL command is used to retrieve data?', N'GET', N'SELECT', N'RETRIEVE', N'FETCH', N'B')

INSERT [dbo].[tblQuestions] ([exam_id], [question_text], [option_a], [option_b], [option_c], [option_d], [correct_option]) VALUES 
(3, N'What is HTML?', N'HyperText Markup Language', N'High Tech Modern Language', N'Home Tool Markup Language', N'Hyperlink and Text Markup Language', N'A')

INSERT [dbo].[tblQuestions] ([exam_id], [question_text], [option_a], [option_b], [option_c], [option_d], [correct_option]) VALUES 
(4, N'What is a primary key?', N'A key that opens doors', N'A unique identifier for records', N'A password', N'A foreign key', N'B')

INSERT [dbo].[tblQuestions] ([exam_id], [question_text], [option_a], [option_b], [option_c], [option_d], [correct_option]) VALUES 
(5, N'What does OOP stand for?', N'Object Oriented Programming', N'Only One Program', N'Open Office Program', N'Original Operating Procedure', N'A')
GO

-- Create indexes for better performance
CREATE NONCLUSTERED INDEX [IX_tblExams_category_id] ON [dbo].[tblExams] ([category_id])
GO

CREATE NONCLUSTERED INDEX [IX_tblQuestions_exam_id] ON [dbo].[tblQuestions] ([exam_id])
GO
