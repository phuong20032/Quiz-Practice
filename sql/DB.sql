
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'SWP391_G4')
	DROP DATABASE SWP391_G4
GO


CREATE DATABASE [SWP391_G4]
GO
USE [SWP391_G4]
GO
/****** Object:  Table [dbo].[answer]    Script Date: 10/23/2024 5:18:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[answer](
	[answer_id] [int] IDENTITY(1,1) NOT NULL,
	[answer_detail] [varchar](max) NULL,
	[created_at] [date] NULL,
	[updated_at] [date] NULL,
	[is_correct] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[answer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


/****** Object:  Table [dbo].[lesson]    Script Date: 10/23/2024 5:18:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lesson](
	[lesson_id] [int] IDENTITY(1,1) NOT NULL,
	[lesson_name] [varchar](max) NULL,
	[creator_id] [int] NULL,
	[updated_at] [date] NULL,
	[created_at] [date] NULL,
	[status] [int] NULL,
	[description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[lesson_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lesson_has_quiz]    Script Date: 10/23/2024 5:18:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lesson_has_quiz](
	[lesson_id] [int] NOT NULL,
	[quiz_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[lesson_id] ASC,
	[quiz_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[major]    Script Date: 10/23/2024 5:18:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[major](
	[major_id] [int] IDENTITY(1,1) NOT NULL,
	[major_name] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[major_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[question]    Script Date: 10/23/2024 5:18:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[question](
	[question_id] [int] IDENTITY(1,1) NOT NULL,
	[question_detail] [varchar](max) NULL,
	[status] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[question_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[question_has_answer]    Script Date: 10/23/2024 5:18:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[question_has_answer](
	[question_id] [int] NOT NULL,
	[answer_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[question_id] ASC,
	[answer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[quiz]    Script Date: 10/23/2024 5:18:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[quiz](
	[quiz_id] [int] IDENTITY(1,1) NOT NULL,
	[quiz_title] [varchar](max) NULL,
	[created_at] [date] NULL,
	[updated_at] [date] NULL,
	[creator_id] [int] NULL,
	[status] [int] NULL,
	[count_down] [int] NULL,
	[min_to_pass] [int] NULL,
	[attemp_time] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[quiz_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[quiz_has_question]    Script Date: 10/23/2024 5:18:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[quiz_has_question](
	[quiz_id] [int] NOT NULL,
	[question_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[quiz_id] ASC,
	[question_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[quiz_result]    Script Date: 10/23/2024 5:18:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[quiz_result](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[quiz_id] [int] NULL,
	[question_id] [int] NULL,
	[answer_choose] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[role]    Script Date: 10/23/2024 5:18:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[role](
	[role_id] [int] IDENTITY(1,1) NOT NULL,
	[role_name] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[subject]    Script Date: 10/23/2024 5:18:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[subject](
	[subject_id] [int] IDENTITY(1,1) NOT NULL,
	[subject_name] [varchar](max) NULL,
	[creator_id] [int] NULL,
	[created_at] [date] NULL,
	[updated_at] [date] NULL,
	[status] [int] NULL,
	[subject_img] [varchar](max) NULL,
	[major_id] [int] NULL,
	[subject_content] [varchar](max) NULL,
	[subject_title] [varchar](max) NULL,
	[owner_id] [int] NULL,
	[featured_flag] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[subject_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[subject_has_lesson]    Script Date: 10/23/2024 5:18:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[subject_has_lesson](
	[subject_id] [int] NOT NULL,
	[lesson_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[subject_id] ASC,
	[lesson_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user]    Script Date: 10/23/2024 5:18:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[userName] [varchar](255) NULL,
	[email] [varchar](max) NULL,
	[password] [varchar](max) NULL,
	[phone] [varchar](10) NULL,
	[gender] [int] NULL,
	[fullName] [varchar](max) NULL,
	[school] [varchar](max) NULL,
	[facebook] [varchar](max) NULL,
	[twitter] [varchar](max) NULL,
	[instagram] [varchar](max) NULL,
	[description] [varchar](max) NULL,
	[created_at] [date] NULL,
	[role_id] [int] NULL,
	[status] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_attemp_quiz]    Script Date: 10/23/2024 5:18:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_attemp_quiz](
	[user_id] [int] NULL,
	[quiz_id] [int] NULL,
	[times] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_has_done_quiz]    Script Date: 10/23/2024 5:18:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_has_done_quiz](
	[user_id] [int] NOT NULL,
	[quiz_id] [int] NOT NULL,
	[score] [float] NULL,
	[is_pass] [int] NULL,
	[time_done] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[quiz_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_has_subject]    Script Date: 10/23/2024 5:18:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_has_subject](
	[subject_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[subject_id] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[answer] ON 

INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (1, N'A variable is a storage location in programming.', CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 1)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (2, N'A variable is a mathematical symbol.', CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (3, N'The limit of x as x approaches 2 is 2.', CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (4, N'The limit of x as x approaches 2 is undefined.', CAST(N'2024-10-15' AS Date), CAST(N'2024-03-10' AS Date), 1)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (5, N'2', NULL, NULL, 1)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (6, N'3', NULL, NULL, 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (7, N'1', NULL, NULL, 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (8, N'4', NULL, NULL, 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (9, N'HyperTransfer Protocol', NULL, NULL, 1)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (10, N'HyperText  Protocol', NULL, NULL, 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (11, N'HyperText Transfer ', NULL, NULL, 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (12, N'HyperText Transfer Protocol', NULL, NULL, 1)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (13, N'2', NULL, NULL, 1)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (14, N'3', NULL, NULL, 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (15, N'1', NULL, NULL, 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (16, N'4', NULL, NULL, 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (17, N'HyperTransfer Protocol', NULL, NULL, 1)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (18, N'HyperText  Protocol', NULL, NULL, 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (19, N'HyperText Transfer ', NULL, NULL, 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (20, N'HyperText Transfer Protocol', NULL, NULL, 1)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (1005, N'Nam', NULL, NULL, 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (1006, N'Duy', NULL, NULL, 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (1007, N'Minh', NULL, NULL, 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (1008, N'Tuan', NULL, NULL, 1)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (1009, N'Nam', NULL, NULL, 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (1010, N'Duy', NULL, NULL, 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (1011, N'Minh', NULL, NULL, 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (1012, N'Tuan', NULL, NULL, 1)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (1013, N'2', NULL, NULL, 1)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (1014, N'3', NULL, NULL, 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (1015, N'1', NULL, NULL, 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (1016, N'4', NULL, NULL, 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (1017, N'4', NULL, NULL, 1)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (1018, N'5', NULL, NULL, 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (1019, N'6 ', NULL, NULL, 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (1020, N'7', NULL, NULL, 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (2013, N'Nam', NULL, NULL, 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (2014, N'Duy', NULL, NULL, 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (2015, N'Minh', NULL, NULL, 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (2016, N'Tuan', NULL, NULL, 1)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (2017, N'Nam', NULL, NULL, 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (2018, N'Duy', NULL, NULL, 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (2019, N'Minh', NULL, NULL, 0)
INSERT [dbo].[answer] ([answer_id], [answer_detail], [created_at], [updated_at], [is_correct]) VALUES (2020, N'Tuan', NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[answer] OFF
GO
SET IDENTITY_INSERT [dbo].[blog] ON 

INSERT [dbo].[blog] ([blog_id], [title], [author], [description], [created_at], [blog_img], [blog_content], [creator_id]) VALUES (1, N'Introduction to Microservices', N'Alice Johnson', N'An introductory guide to microservices architecture', CAST(N'2024-10-01T00:00:00.000' AS DateTime), N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWphenrFmicwysLQ7LtQdOxkPkS0EbrcckaA&s', N'Content about microservices...', 1)
INSERT [dbo].[blog] ([blog_id], [title], [author], [description], [created_at], [blog_img], [blog_content], [creator_id]) VALUES (2, N'Spring Boot Basics', N'Bob Smith', N'A beginner guide to Spring Boot', CAST(N'2023-02-01T00:00:00.000' AS DateTime), N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWphenrFmicwysLQ7LtQdOxkPkS0EbrcckaA&s', N'Content about Spring Boot...', 2)
INSERT [dbo].[blog] ([blog_id], [title], [author], [description], [created_at], [blog_img], [blog_content], [creator_id]) VALUES (3, N'PostgreSQL Performance Tuning', N'Carol White', N'Tips and tricks for optimizing PostgreSQL performance', CAST(N'2024-10-01T00:00:00.000' AS DateTime), N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWphenrFmicwysLQ7LtQdOxkPkS0EbrcckaA&s', N'Content about PostgreSQL tuning...', 1)
INSERT [dbo].[blog] ([blog_id], [title], [author], [description], [created_at], [blog_img], [blog_content], [creator_id]) VALUES (4, N'Docker for Beginners', N'David Brown', N'Getting started with Docker', CAST(N'2024-10-01T00:00:00.000' AS DateTime), N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWphenrFmicwysLQ7LtQdOxkPkS0EbrcckaA&s', N'Content about Docker...', 1)
INSERT [dbo].[blog] ([blog_id], [title], [author], [description], [created_at], [blog_img], [blog_content], [creator_id]) VALUES (5, N'Advanced Spring Boot', N'Eve Davis', N'Deep dive into advanced Spring Boot features', CAST(N'2024-10-01T00:00:00.000' AS DateTime), N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWphenrFmicwysLQ7LtQdOxkPkS0EbrcckaA&s', N'Content about advanced Spring Boot...', 1)
INSERT [dbo].[blog] ([blog_id], [title], [author], [description], [created_at], [blog_img], [blog_content], [creator_id]) VALUES (6, N'Microservices Security', N'Frank Harris', N'Ensuring security in a microservices architecture', CAST(N'2024-10-01T00:00:00.000' AS DateTime), N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWphenrFmicwysLQ7LtQdOxkPkS0EbrcckaA&s', N'Content about microservices security...', 1)
INSERT [dbo].[blog] ([blog_id], [title], [author], [description], [created_at], [blog_img], [blog_content], [creator_id]) VALUES (7, N'Database Design Best Practices', N'Grace King', N'Best practices for designing scalable databases', CAST(N'2024-10-01T00:00:00.000' AS DateTime), N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWphenrFmicwysLQ7LtQdOxkPkS0EbrcckaA&s', N'Content about database design...', 1)
INSERT [dbo].[blog] ([blog_id], [title], [author], [description], [created_at], [blog_img], [blog_content], [creator_id]) VALUES (8, N'API Development with Spring Boot', N'Henry Lee', N'Developing robust APIs with Spring Boot', CAST(N'2024-10-01T00:00:00.000' AS DateTime), N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWphenrFmicwysLQ7LtQdOxkPkS0EbrcckaA&s', N'Content about API development...', 1)
INSERT [dbo].[blog] ([blog_id], [title], [author], [description], [created_at], [blog_img], [blog_content], [creator_id]) VALUES (9, N'Effective Logging Strategies', N'Ivy Martinez', N'Strategies for effective logging in your applications', CAST(N'2024-10-01T00:00:00.000' AS DateTime), N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWphenrFmicwysLQ7LtQdOxkPkS0EbrcckaA&s', N'Content about logging strategies...', 1)
INSERT [dbo].[blog] ([blog_id], [title], [author], [description], [created_at], [blog_img], [blog_content], [creator_id]) VALUES (10, N'Understanding Docker Compose', N'Jack Nguyen', N'A comprehensive guide to Docker Compose', CAST(N'2024-10-01T00:00:00.000' AS DateTime), N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWphenrFmicwysLQ7LtQdOxkPkS0EbrcckaA&s', N'Content about Docker Compose...', 1)
SET IDENTITY_INSERT [dbo].[blog] OFF
GO
SET IDENTITY_INSERT [dbo].[lesson] ON 

INSERT [dbo].[lesson] ([lesson_id], [lesson_name], [creator_id], [updated_at], [created_at], [status], [description]) VALUES (1, N'What is a variable?>', 1, CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 1, N'ok mà')
INSERT [dbo].[lesson] ([lesson_id], [lesson_name], [creator_id], [updated_at], [created_at], [status], [description]) VALUES (2, N'What is the limit of x as x approaches 2?>>>>', 2, CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 1, NULL)
INSERT [dbo].[lesson] ([lesson_id], [lesson_name], [creator_id], [updated_at], [created_at], [status], [description]) VALUES (4, N'OK2', 6, CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 1, NULL)
INSERT [dbo].[lesson] ([lesson_id], [lesson_name], [creator_id], [updated_at], [created_at], [status], [description]) VALUES (5, N'Tao Thái nè', 6, CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 1, N'Tao la bo chung may')
INSERT [dbo].[lesson] ([lesson_id], [lesson_name], [creator_id], [updated_at], [created_at], [status], [description]) VALUES (32, N'What is a variable', 6, CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 1, N's')
INSERT [dbo].[lesson] ([lesson_id], [lesson_name], [creator_id], [updated_at], [created_at], [status], [description]) VALUES (33, N'What is a variable', 6, CAST(N'2024-10-15' AS Date), CAST(N'2024-07-17' AS Date), 1, N's')
SET IDENTITY_INSERT [dbo].[lesson] OFF
GO
INSERT [dbo].[lesson_has_quiz] ([lesson_id], [quiz_id]) VALUES (1, 2)
INSERT [dbo].[lesson_has_quiz] ([lesson_id], [quiz_id]) VALUES (1, 3)
INSERT [dbo].[lesson_has_quiz] ([lesson_id], [quiz_id]) VALUES (1, 4)
INSERT [dbo].[lesson_has_quiz] ([lesson_id], [quiz_id]) VALUES (2, 2)
INSERT [dbo].[lesson_has_quiz] ([lesson_id], [quiz_id]) VALUES (2, 3)
INSERT [dbo].[lesson_has_quiz] ([lesson_id], [quiz_id]) VALUES (2, 4)
INSERT [dbo].[lesson_has_quiz] ([lesson_id], [quiz_id]) VALUES (4, 2)
INSERT [dbo].[lesson_has_quiz] ([lesson_id], [quiz_id]) VALUES (4, 3)
GO
SET IDENTITY_INSERT [dbo].[major] ON 

INSERT [dbo].[major] ([major_id], [major_name]) VALUES (1, N'SE')
INSERT [dbo].[major] ([major_id], [major_name]) VALUES (2, N'AI')
INSERT [dbo].[major] ([major_id], [major_name]) VALUES (3, N'GD')
SET IDENTITY_INSERT [dbo].[major] OFF
GO
SET IDENTITY_INSERT [dbo].[question] ON 

INSERT [dbo].[question] ([question_id], [question_detail], [status]) VALUES (1, N'What is a variable?', 1)
INSERT [dbo].[question] ([question_id], [question_detail], [status]) VALUES (2, N'aa', 1)
INSERT [dbo].[question] ([question_id], [question_detail], [status]) VALUES (5, N'What is the result of 1 + 1? ', 1)
INSERT [dbo].[question] ([question_id], [question_detail], [status]) VALUES (6, N'What is HTTP stand for?', 0)
INSERT [dbo].[question] ([question_id], [question_detail], [status]) VALUES (7, N'What is the result of 1 + 1?? ', 0)
INSERT [dbo].[question] ([question_id], [question_detail], [status]) VALUES (8, N'What is HTTP stand for??', 0)
INSERT [dbo].[question] ([question_id], [question_detail], [status]) VALUES (1005, N'What is your name', 0)
INSERT [dbo].[question] ([question_id], [question_detail], [status]) VALUES (1006, N'What is your name?', 0)
INSERT [dbo].[question] ([question_id], [question_detail], [status]) VALUES (1007, N'1+1 ', 1)
INSERT [dbo].[question] ([question_id], [question_detail], [status]) VALUES (1008, N'2 * 2', 1)
INSERT [dbo].[question] ([question_id], [question_detail], [status]) VALUES (2007, N'What is your namessss', 1)
INSERT [dbo].[question] ([question_id], [question_detail], [status]) VALUES (2008, N'What is your name?sss', 1)
SET IDENTITY_INSERT [dbo].[question] OFF
GO
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (1, 1)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (2, 3)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (2, 4)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (5, 5)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (5, 6)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (5, 7)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (5, 8)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (6, 9)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (6, 10)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (6, 11)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (6, 12)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (7, 5)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (7, 6)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (7, 7)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (7, 8)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (8, 12)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (1005, 1005)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (1005, 1006)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (1005, 1007)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (1005, 1008)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (1006, 1005)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (1006, 1006)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (1006, 1007)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (1006, 1008)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (1007, 5)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (1007, 6)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (1007, 7)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (1007, 8)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (1008, 1017)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (1008, 1018)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (1008, 1019)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (1008, 1020)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (2007, 1005)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (2007, 1006)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (2007, 1007)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (2007, 1008)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (2008, 1005)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (2008, 1006)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (2008, 1007)
INSERT [dbo].[question_has_answer] ([question_id], [answer_id]) VALUES (2008, 1008)
GO
SET IDENTITY_INSERT [dbo].[quiz] ON 

INSERT [dbo].[quiz] ([quiz_id], [quiz_title], [created_at], [updated_at], [creator_id], [status], [count_down], [min_to_pass], [attemp_time]) VALUES (1, N'Programming Basics Quiz', CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 1, 1, 60, 80, 2)
INSERT [dbo].[quiz] ([quiz_id], [quiz_title], [created_at], [updated_at], [creator_id], [status], [count_down], [min_to_pass], [attemp_time]) VALUES (2, N'Calculus I Quiz', CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 2, 1, 60, 80, 2)
INSERT [dbo].[quiz] ([quiz_id], [quiz_title], [created_at], [updated_at], [creator_id], [status], [count_down], [min_to_pass], [attemp_time]) VALUES (3, N'ok33', CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 6, 1, 51, 75, 2)
INSERT [dbo].[quiz] ([quiz_id], [quiz_title], [created_at], [updated_at], [creator_id], [status], [count_down], [min_to_pass], [attemp_time]) VALUES (4, N'ok21', CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 6, 1, 10, 80, 4)
INSERT [dbo].[quiz] ([quiz_id], [quiz_title], [created_at], [updated_at], [creator_id], [status], [count_down], [min_to_pass], [attemp_time]) VALUES (5, N'ok334', CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 6, 1, 50, 90, 2)
INSERT [dbo].[quiz] ([quiz_id], [quiz_title], [created_at], [updated_at], [creator_id], [status], [count_down], [min_to_pass], [attemp_time]) VALUES (6, N'ok33e', CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 6, 1, 50, 30, 3)
INSERT [dbo].[quiz] ([quiz_id], [quiz_title], [created_at], [updated_at], [creator_id], [status], [count_down], [min_to_pass], [attemp_time]) VALUES (7, N'Programming', CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 6, 0, 1, 5, 1)
INSERT [dbo].[quiz] ([quiz_id], [quiz_title], [created_at], [updated_at], [creator_id], [status], [count_down], [min_to_pass], [attemp_time]) VALUES (8, N'Programming', CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 6, 1, 1, 5, 1)
INSERT [dbo].[quiz] ([quiz_id], [quiz_title], [created_at], [updated_at], [creator_id], [status], [count_down], [min_to_pass], [attemp_time]) VALUES (9, N'ok33', CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 6, 1, 3, 15, 2)
INSERT [dbo].[quiz] ([quiz_id], [quiz_title], [created_at], [updated_at], [creator_id], [status], [count_down], [min_to_pass], [attemp_time]) VALUES (10, N'ok33', CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 6, 1, 50, 5, 5)
INSERT [dbo].[quiz] ([quiz_id], [quiz_title], [created_at], [updated_at], [creator_id], [status], [count_down], [min_to_pass], [attemp_time]) VALUES (11, N'Programming', CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 6, 1, 5, 5, 5)
SET IDENTITY_INSERT [dbo].[quiz] OFF
GO
INSERT [dbo].[quiz_has_question] ([quiz_id], [question_id]) VALUES (1, 1)
INSERT [dbo].[quiz_has_question] ([quiz_id], [question_id]) VALUES (2, 2)
INSERT [dbo].[quiz_has_question] ([quiz_id], [question_id]) VALUES (3, 8)
INSERT [dbo].[quiz_has_question] ([quiz_id], [question_id]) VALUES (3, 1007)
INSERT [dbo].[quiz_has_question] ([quiz_id], [question_id]) VALUES (3, 1008)
INSERT [dbo].[quiz_has_question] ([quiz_id], [question_id]) VALUES (4, 1005)
INSERT [dbo].[quiz_has_question] ([quiz_id], [question_id]) VALUES (4, 1006)
INSERT [dbo].[quiz_has_question] ([quiz_id], [question_id]) VALUES (4, 2007)
INSERT [dbo].[quiz_has_question] ([quiz_id], [question_id]) VALUES (4, 2008)
GO
SET IDENTITY_INSERT [dbo].[quiz_result] ON 

INSERT [dbo].[quiz_result] ([id], [user_id], [quiz_id], [question_id], [answer_choose]) VALUES (60, 6, 2, 2, NULL)
INSERT [dbo].[quiz_result] ([id], [user_id], [quiz_id], [question_id], [answer_choose]) VALUES (61, 6, 3, 1007, 6)
INSERT [dbo].[quiz_result] ([id], [user_id], [quiz_id], [question_id], [answer_choose]) VALUES (62, 6, 3, 1008, 1019)
INSERT [dbo].[quiz_result] ([id], [user_id], [quiz_id], [question_id], [answer_choose]) VALUES (63, 6, 1, 1, 1)
INSERT [dbo].[quiz_result] ([id], [user_id], [quiz_id], [question_id], [answer_choose]) VALUES (64, 6, 4, 2007, 1006)
INSERT [dbo].[quiz_result] ([id], [user_id], [quiz_id], [question_id], [answer_choose]) VALUES (65, 6, 4, 2008, 1007)
INSERT [dbo].[quiz_result] ([id], [user_id], [quiz_id], [question_id], [answer_choose]) VALUES (66, 1007, 2, 2, NULL)
SET IDENTITY_INSERT [dbo].[quiz_result] OFF
GO
SET IDENTITY_INSERT [dbo].[role] ON 

INSERT [dbo].[role] ([role_id], [role_name]) VALUES (1, N'Student')
INSERT [dbo].[role] ([role_id], [role_name]) VALUES (2, N'Teacher')
INSERT [dbo].[role] ([role_id], [role_name]) VALUES (3, N'Manager')
INSERT [dbo].[role] ([role_id], [role_name]) VALUES (4, N'Admin')
SET IDENTITY_INSERT [dbo].[role] OFF
GO
SET IDENTITY_INSERT [dbo].[subject] ON 

INSERT [dbo].[subject] ([subject_id], [subject_name], [creator_id], [created_at], [updated_at], [status], [subject_img], [major_id], [subject_content], [subject_title], [owner_id], [featured_flag]) VALUES (1, N'CSI104', 2, CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 1, N'https://anhcocvang.com/static/media/CSI104.2184a7868fa678077f03.png', 3, N'This course provides an overview of the fundamentals of computer science.s', N'Introduction to computer science', 6, 0)
INSERT [dbo].[subject] ([subject_id], [subject_name], [creator_id], [created_at], [updated_at], [status], [subject_img], [major_id], [subject_content], [subject_title], [owner_id], [featured_flag]) VALUES (2, N'CEA201', 2, CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 1, N'https://anhcocvang.com/static/media/CEA201.726e8249a187ad5531b6.png', 1, N'This course covers the fundamental concepts and techniques used in the analysis of civil engineering projects.', N'Fundamentals of Civil Engineering Analysis', 6, 0)
INSERT [dbo].[subject] ([subject_id], [subject_name], [creator_id], [created_at], [updated_at], [status], [subject_img], [major_id], [subject_content], [subject_title], [owner_id], [featured_flag]) VALUES (3, N'MAE101', 2, CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 1, N'https://anhcocvang.com/static/media/MAE101.ee704482946a2485d1e5.png', 1, N'This course provides an introduction to the fundamental principles and practices of mechanical engineering.', N'Introduction to Mechanical Engineering', 6, 0)
INSERT [dbo].[subject] ([subject_id], [subject_name], [creator_id], [created_at], [updated_at], [status], [subject_img], [major_id], [subject_content], [subject_title], [owner_id], [featured_flag]) VALUES (4, N'SSL101c', 2, CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 1, N'https://anhcocvang.com/static/media/SSL101c.69595610330b2500eb3e.png', 2, N'This course offers an overview of the key concepts, theories, and methodologies in social sciences and law.', N'Introduction to Social Sciences and Law', 6, 0)
INSERT [dbo].[subject] ([subject_id], [subject_name], [creator_id], [created_at], [updated_at], [status], [subject_img], [major_id], [subject_content], [subject_title], [owner_id], [featured_flag]) VALUES (5, N'ENW492c', 2, CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 1, N'https://anhcocvang.com/static/media/ENW492c.0595e0ab868eb20523ad.png', 1, N' This course delves into advanced topics and methodologies in environmental engineering, focusing on current research and practical applications.', N'Advanced Studies in Environmental Engineering', 6, 0)
INSERT [dbo].[subject] ([subject_id], [subject_name], [creator_id], [created_at], [updated_at], [status], [subject_img], [major_id], [subject_content], [subject_title], [owner_id], [featured_flag]) VALUES (6, N'SSL', 6, CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 1, N'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?auto=compress&cs=tinysrgb&w=600', 2, N'ok', N'OK', 6, 0)
INSERT [dbo].[subject] ([subject_id], [subject_name], [creator_id], [created_at], [updated_at], [status], [subject_img], [major_id], [subject_content], [subject_title], [owner_id], [featured_flag]) VALUES (7, N'SSL2', 6, CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 1, N'https://didongmoi.com.vn/public/upload/images/product/samsung-galaxy-watch-4-40mm%20(1).jpg', 3, N'W', N'W', 6, 0)
INSERT [dbo].[subject] ([subject_id], [subject_name], [creator_id], [created_at], [updated_at], [status], [subject_img], [major_id], [subject_content], [subject_title], [owner_id], [featured_flag]) VALUES (8, N'11111', 6, CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 1, N'static/upload/Logo-FPT.webp', 1, N'ok', N'55555', 1, 0)
INSERT [dbo].[subject] ([subject_id], [subject_name], [creator_id], [created_at], [updated_at], [status], [subject_img], [major_id], [subject_content], [subject_title], [owner_id], [featured_flag]) VALUES (9, N'ok', 6, CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 1, N'https://didongmoi.com.vn/public/upload/images/product/samsung-galaxy-watch-4-40mm%20(1).jpg', 1, N'ok', N'ok', 2, 1)
INSERT [dbo].[subject] ([subject_id], [subject_name], [creator_id], [created_at], [updated_at], [status], [subject_img], [major_id], [subject_content], [subject_title], [owner_id], [featured_flag]) VALUES (10, N'ok', 6, CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 0, N'https://www.pexels.com/search/beautiful/', 1, N'ok', N'ok', 2, 0)
INSERT [dbo].[subject] ([subject_id], [subject_name], [creator_id], [created_at], [updated_at], [status], [subject_img], [major_id], [subject_content], [subject_title], [owner_id], [featured_flag]) VALUES (11, N'ok', 6, CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 1, N'static/upload/222.png', 1, N'ok', N'ok', 3, 0)
INSERT [dbo].[subject] ([subject_id], [subject_name], [creator_id], [created_at], [updated_at], [status], [subject_img], [major_id], [subject_content], [subject_title], [owner_id], [featured_flag]) VALUES (12, N'88', 6, CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 0, N'static/upload/..3.png', 1, N'ok', N'ok', 2, 0)
INSERT [dbo].[subject] ([subject_id], [subject_name], [creator_id], [created_at], [updated_at], [status], [subject_img], [major_id], [subject_content], [subject_title], [owner_id], [featured_flag]) VALUES (13, N'SWR302', 6, CAST(N'2024-10-15' AS Date), CAST(N'2024-10-15' AS Date), 1, N'static/upload/20ee1c6d6b246c6f19b055d81022d4e7.jpg', 1, N'Day la mon SWR', N'Software Requirements', 7, 1)
SET IDENTITY_INSERT [dbo].[subject] OFF
GO
INSERT [dbo].[subject_has_lesson] ([subject_id], [lesson_id]) VALUES (1, 1)
INSERT [dbo].[subject_has_lesson] ([subject_id], [lesson_id]) VALUES (1, 2)
INSERT [dbo].[subject_has_lesson] ([subject_id], [lesson_id]) VALUES (2, 2)
INSERT [dbo].[subject_has_lesson] ([subject_id], [lesson_id]) VALUES (7, 1)
INSERT [dbo].[subject_has_lesson] ([subject_id], [lesson_id]) VALUES (7, 2)
INSERT [dbo].[subject_has_lesson] ([subject_id], [lesson_id]) VALUES (7, 4)
GO
SET IDENTITY_INSERT [dbo].[user] ON 

INSERT [dbo].[user] ([user_id], [userName], [email], [password], [phone], [gender], [fullName], [school], [facebook], [twitter], [instagram], [description], [created_at], [role_id], [status]) VALUES (1, N'Teacher1', N'namvhhe180084@fpt.edu.vn', N'h0BkxvAK1EBmQ3e9wtbs/OGj+2k=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2024-09-25' AS Date), 4, 0)
INSERT [dbo].[user] ([user_id], [userName], [email], [password], [phone], [gender], [fullName], [school], [facebook], [twitter], [instagram], [description], [created_at], [role_id], [status]) VALUES (2, N'teach', N'quizpractice.swp@gmail.com', N'h0BkxvAK1EBmQ3e9wtbs/OGj+2k=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2024-09-25' AS Date), 2, 0)
INSERT [dbo].[user] ([user_id], [userName], [email], [password], [phone], [gender], [fullName], [school], [facebook], [twitter], [instagram], [description], [created_at], [role_id], [status]) VALUES (3, N'Teacher2', N'phuongnmhe186354@fpt.edu.vn', N'h0BkxvAK1EBmQ3e9wtbs/OGj+2k=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2024-09-25' AS Date), 2, 0)
INSERT [dbo].[user] ([user_id], [userName], [email], [password], [phone], [gender], [fullName], [school], [facebook], [twitter], [instagram], [description], [created_at], [role_id], [status]) VALUES (4, N'tien', N'thanhcucbeo233@gmail.com', N'h0BkxvAK1EBmQ3e9wtbs/OGj+2k=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(N'2024-09-25' AS Date), 2, 0)
INSERT [dbo].[user] ([user_id], [userName], [email], [password], [phone], [gender], [fullName], [school], [facebook], [twitter], [instagram], [description], [created_at], [role_id], [status]) VALUES (6, N'MANAGER', N'tientvhe181590@fpt.edu.vn', N'h0BkxvAK1EBmQ3e9wtbs/OGj+2k=', N'0337305098', 1, N'Tran van tien', N'FPT', N' ', N'', N'', NULL, CAST(N'2024-10-02' AS Date), 3, 0)
INSERT [dbo].[user] ([user_id], [userName], [email], [password], [phone], [gender], [fullName], [school], [facebook], [twitter], [instagram], [description], [created_at], [role_id], [status]) VALUES (7, N'giaovien', N'tien2309n@gmail.com', N'h0BkxvAK1EBmQ3e9wtbs/OGj+2k=', N'66655566', 1, N'tran van tien', NULL, NULL, NULL, NULL, NULL, CAST(N'2024-10-02' AS Date), 2, 0)
INSERT [dbo].[user] ([user_id], [userName], [email], [password], [phone], [gender], [fullName], [school], [facebook], [twitter], [instagram], [description], [created_at], [role_id], [status]) VALUES (1007, N'hocsinh', N'phuongn2804@gmail.com', N'h0BkxvAK1EBmQ3e9wtbs/OGj+2k=', NULL, 1, N'nguyen minh phuong', NULL, NULL, NULL, NULL, NULL, CAST(N'2024-10-02' AS Date), 1, 0)
INSERT [dbo].[user] ([user_id], [userName], [email], [password], [phone], [gender], [fullName], [school], [facebook], [twitter], [instagram], [description], [created_at], [role_id], [status]) VALUES (1008, N'thanhldhe181467', N'thanhldhe181467@fpt.edu.vn', N'h0BkxvAK1EBmQ3e9wtbs/OGj+2k=', N'0123456789', 1, N'Le Duc Thanh', NULL, NULL, NULL, NULL, NULL, CAST(N'2024-10-23' AS Date), 1, 0)
SET IDENTITY_INSERT [dbo].[user] OFF
GO
INSERT [dbo].[user_attemp_quiz] ([user_id], [quiz_id], [times]) VALUES (6, 3, 1)
INSERT [dbo].[user_attemp_quiz] ([user_id], [quiz_id], [times]) VALUES (1007, 2, 2)
INSERT [dbo].[user_attemp_quiz] ([user_id], [quiz_id], [times]) VALUES (6, 4, 1)
GO
INSERT [dbo].[user_has_done_quiz] ([user_id], [quiz_id], [score], [is_pass], [time_done]) VALUES (1, 1, 80, 1, 35.5)
INSERT [dbo].[user_has_done_quiz] ([user_id], [quiz_id], [score], [is_pass], [time_done]) VALUES (2, 2, 85, 1, 35.5)
INSERT [dbo].[user_has_done_quiz] ([user_id], [quiz_id], [score], [is_pass], [time_done]) VALUES (6, 1, 100, 1, 35.5)
INSERT [dbo].[user_has_done_quiz] ([user_id], [quiz_id], [score], [is_pass], [time_done]) VALUES (6, 2, 0, 0, 35.5)
INSERT [dbo].[user_has_done_quiz] ([user_id], [quiz_id], [score], [is_pass], [time_done]) VALUES (6, 3, 0, 0, 25)
INSERT [dbo].[user_has_done_quiz] ([user_id], [quiz_id], [score], [is_pass], [time_done]) VALUES (6, 4, 0, 0, 0.62999999523162842)
INSERT [dbo].[user_has_done_quiz] ([user_id], [quiz_id], [score], [is_pass], [time_done]) VALUES (1007, 2, 0, 0, 0)
GO
INSERT [dbo].[user_has_subject] ([subject_id], [user_id], [start_date], [end_date]) VALUES (1, 7, CAST(N'2024-10-2' AS Date), NULL)
INSERT [dbo].[user_has_subject] ([subject_id], [user_id], [start_date], [end_date]) VALUES (1, 1007, CAST(N'2024-10-2' AS Date), NULL)
INSERT [dbo].[user_has_subject] ([subject_id], [user_id], [start_date], [end_date]) VALUES (2, 6, CAST(N'2024-10-22' AS Date), NULL)
INSERT [dbo].[user_has_subject] ([subject_id], [user_id], [start_date], [end_date]) VALUES (4, 2, CAST(N'2024-10-2' AS Date), CAST(N'2024-05-17' AS Date))
INSERT [dbo].[user_has_subject] ([subject_id], [user_id], [start_date], [end_date]) VALUES (5, 2, CAST(N'2024-10-17' AS Date), CAST(N'2024-05-17' AS Date))
INSERT [dbo].[user_has_subject] ([subject_id], [user_id], [start_date], [end_date]) VALUES (6, 1007, CAST(N'2024-10-22' AS Date), NULL)
INSERT [dbo].[user_has_subject] ([subject_id], [user_id], [start_date], [end_date]) VALUES (7, 6, CAST(N'2024-10-03' AS Date), NULL)
INSERT [dbo].[user_has_subject] ([subject_id], [user_id], [start_date], [end_date]) VALUES (11, 1007, CAST(N'2024-10-22' AS Date), NULL)
GO
ALTER TABLE [dbo].[question] ADD  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[quiz_result] ADD  DEFAULT (NULL) FOR [answer_choose]
GO
ALTER TABLE [dbo].[subject] ADD  DEFAULT ((0)) FOR [featured_flag]
GO
ALTER TABLE [dbo].[user] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[blog]  WITH CHECK ADD FOREIGN KEY([creator_id])
REFERENCES [dbo].[user] ([user_id])
GO
ALTER TABLE [dbo].[comment]  WITH CHECK ADD FOREIGN KEY([blog_id])
REFERENCES [dbo].[blog] ([blog_id])
GO
ALTER TABLE [dbo].[lesson_has_quiz]  WITH CHECK ADD FOREIGN KEY([lesson_id])
REFERENCES [dbo].[lesson] ([lesson_id])
GO
ALTER TABLE [dbo].[lesson_has_quiz]  WITH CHECK ADD FOREIGN KEY([quiz_id])
REFERENCES [dbo].[quiz] ([quiz_id])
GO
ALTER TABLE [dbo].[question_has_answer]  WITH CHECK ADD FOREIGN KEY([answer_id])
REFERENCES [dbo].[answer] ([answer_id])
GO
ALTER TABLE [dbo].[question_has_answer]  WITH CHECK ADD FOREIGN KEY([question_id])
REFERENCES [dbo].[question] ([question_id])
GO
ALTER TABLE [dbo].[quiz_has_question]  WITH CHECK ADD FOREIGN KEY([question_id])
REFERENCES [dbo].[question] ([question_id])
GO
ALTER TABLE [dbo].[quiz_has_question]  WITH CHECK ADD FOREIGN KEY([quiz_id])
REFERENCES [dbo].[quiz] ([quiz_id])
GO
ALTER TABLE [dbo].[quiz_result]  WITH CHECK ADD FOREIGN KEY([answer_choose])
REFERENCES [dbo].[answer] ([answer_id])
GO
ALTER TABLE [dbo].[quiz_result]  WITH CHECK ADD FOREIGN KEY([question_id])
REFERENCES [dbo].[question] ([question_id])
GO
ALTER TABLE [dbo].[quiz_result]  WITH CHECK ADD FOREIGN KEY([quiz_id])
REFERENCES [dbo].[quiz] ([quiz_id])
GO
ALTER TABLE [dbo].[quiz_result]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[user] ([user_id])
GO
ALTER TABLE [dbo].[subject]  WITH CHECK ADD FOREIGN KEY([major_id])
REFERENCES [dbo].[major] ([major_id])
GO
ALTER TABLE [dbo].[subject]  WITH CHECK ADD FOREIGN KEY([owner_id])
REFERENCES [dbo].[user] ([user_id])
GO
ALTER TABLE [dbo].[subject]  WITH CHECK ADD  CONSTRAINT [fk_user] FOREIGN KEY([creator_id])
REFERENCES [dbo].[user] ([user_id])
GO
ALTER TABLE [dbo].[subject] CHECK CONSTRAINT [fk_user]
GO
ALTER TABLE [dbo].[subject_has_lesson]  WITH CHECK ADD FOREIGN KEY([lesson_id])
REFERENCES [dbo].[lesson] ([lesson_id])
GO
ALTER TABLE [dbo].[subject_has_lesson]  WITH CHECK ADD FOREIGN KEY([subject_id])
REFERENCES [dbo].[subject] ([subject_id])
GO
ALTER TABLE [dbo].[user]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [dbo].[role] ([role_id])
GO
ALTER TABLE [dbo].[user_has_done_quiz]  WITH CHECK ADD FOREIGN KEY([quiz_id])
REFERENCES [dbo].[quiz] ([quiz_id])
GO
ALTER TABLE [dbo].[user_has_done_quiz]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[user] ([user_id])
GO
ALTER TABLE [dbo].[user_has_subject]  WITH CHECK ADD FOREIGN KEY([subject_id])
REFERENCES [dbo].[subject] ([subject_id])
GO
ALTER TABLE [dbo].[user_has_subject]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[user] ([user_id])
GO
USE [master]
GO
ALTER DATABASE [SWP391_G4] SET  READ_WRITE 
GO
