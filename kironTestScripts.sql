USE [master]
GO
/****** Object:  Database [KironTest]    Script Date: 2023/07/22 02:09:47 ******/
CREATE DATABASE [KironTest]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'KironTest', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER01\MSSQL\DATA\KironTest.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'KironTest_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER01\MSSQL\DATA\KironTest_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [KironTest] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [KironTest].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [KironTest] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [KironTest] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [KironTest] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [KironTest] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [KironTest] SET ARITHABORT OFF 
GO
ALTER DATABASE [KironTest] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [KironTest] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [KironTest] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [KironTest] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [KironTest] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [KironTest] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [KironTest] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [KironTest] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [KironTest] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [KironTest] SET  DISABLE_BROKER 
GO
ALTER DATABASE [KironTest] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [KironTest] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [KironTest] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [KironTest] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [KironTest] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [KironTest] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [KironTest] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [KironTest] SET RECOVERY FULL 
GO
ALTER DATABASE [KironTest] SET  MULTI_USER 
GO
ALTER DATABASE [KironTest] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [KironTest] SET DB_CHAINING OFF 
GO
ALTER DATABASE [KironTest] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [KironTest] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [KironTest] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'KironTest', N'ON'
GO
ALTER DATABASE [KironTest] SET QUERY_STORE = OFF
GO
USE [KironTest]
GO
/****** Object:  UserDefinedTableType [dbo].[BankHolidayType]    Script Date: 2023/07/22 02:09:48 ******/
CREATE TYPE [dbo].[BankHolidayType] AS TABLE(
	[HolidayId] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[BankHolidayTypes]    Script Date: 2023/07/22 02:09:48 ******/
CREATE TYPE [dbo].[BankHolidayTypes] AS TABLE(
	[Name] [nvarchar](100) NULL,
	[Date] [date] NULL,
	[Region] [nvarchar](100) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[StringList]    Script Date: 2023/07/22 02:09:48 ******/
CREATE TYPE [dbo].[StringList] AS TABLE(
	[Item] [nvarchar](max) NULL
)
GO
/****** Object:  Table [dbo].[HolidayRegion]    Script Date: 2023/07/22 02:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HolidayRegion](
	[HolidayId] [int] NOT NULL,
	[RegionId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[HolidayId] ASC,
	[RegionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Holidays]    Script Date: 2023/07/22 02:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Holidays](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Date] [date] NOT NULL,
	[Region] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Navigation]    Script Date: 2023/07/22 02:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Navigation](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Text] [varchar](50) NOT NULL,
	[ParentID] [int] NOT NULL,
 CONSTRAINT [PK_Navigation] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Regions]    Script Date: 2023/07/22 02:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Regions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2023/07/22 02:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](100) NOT NULL,
	[PasswordHash] [varbinary](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Holidays] ON 

INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (1, N'New Year’s Day', CAST(N'2018-01-01' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (2, N'Good Friday', CAST(N'2018-03-30' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (3, N'Easter Monday', CAST(N'2018-04-02' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (4, N'Early May bank holiday', CAST(N'2018-05-07' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (5, N'Spring bank holiday', CAST(N'2018-05-28' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (6, N'Summer bank holiday', CAST(N'2018-08-27' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (7, N'Christmas Day', CAST(N'2018-12-25' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (8, N'Boxing Day', CAST(N'2018-12-26' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (9, N'New Year’s Day', CAST(N'2019-01-01' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (10, N'Good Friday', CAST(N'2019-04-19' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (11, N'Easter Monday', CAST(N'2019-04-22' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (12, N'Early May bank holiday', CAST(N'2019-05-06' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (13, N'Spring bank holiday', CAST(N'2019-05-27' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (14, N'Summer bank holiday', CAST(N'2019-08-26' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (15, N'Christmas Day', CAST(N'2019-12-25' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (16, N'Boxing Day', CAST(N'2019-12-26' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (17, N'New Year’s Day', CAST(N'2020-01-01' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (18, N'Good Friday', CAST(N'2020-04-10' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (19, N'Easter Monday', CAST(N'2020-04-13' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (20, N'Early May bank holiday (VE day)', CAST(N'2020-05-08' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (21, N'Spring bank holiday', CAST(N'2020-05-25' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (22, N'Summer bank holiday', CAST(N'2020-08-31' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (23, N'Christmas Day', CAST(N'2020-12-25' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (24, N'Boxing Day', CAST(N'2020-12-28' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (25, N'New Year’s Day', CAST(N'2021-01-01' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (26, N'Good Friday', CAST(N'2021-04-02' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (27, N'Easter Monday', CAST(N'2021-04-05' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (28, N'Early May bank holiday', CAST(N'2021-05-03' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (29, N'Spring bank holiday', CAST(N'2021-05-31' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (30, N'Summer bank holiday', CAST(N'2021-08-30' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (31, N'Christmas Day', CAST(N'2021-12-27' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (32, N'Boxing Day', CAST(N'2021-12-28' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (33, N'New Year’s Day', CAST(N'2022-01-03' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (34, N'Good Friday', CAST(N'2022-04-15' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (35, N'Easter Monday', CAST(N'2022-04-18' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (36, N'Early May bank holiday', CAST(N'2022-05-02' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (37, N'Spring bank holiday', CAST(N'2022-06-02' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (38, N'Platinum Jubilee bank holiday', CAST(N'2022-06-03' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (39, N'Summer bank holiday', CAST(N'2022-08-29' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (40, N'Bank Holiday for the State Funeral of Queen Elizabeth II', CAST(N'2022-09-19' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (41, N'Boxing Day', CAST(N'2022-12-26' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (42, N'Christmas Day', CAST(N'2022-12-27' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (43, N'New Year’s Day', CAST(N'2023-01-02' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (44, N'Good Friday', CAST(N'2023-04-07' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (45, N'Easter Monday', CAST(N'2023-04-10' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (46, N'Early May bank holiday', CAST(N'2023-05-01' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (47, N'Bank holiday for the coronation of King Charles III', CAST(N'2023-05-08' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (48, N'Spring bank holiday', CAST(N'2023-05-29' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (49, N'Summer bank holiday', CAST(N'2023-08-28' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (50, N'Christmas Day', CAST(N'2023-12-25' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (51, N'Boxing Day', CAST(N'2023-12-26' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (52, N'New Year’s Day', CAST(N'2024-01-01' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (53, N'Good Friday', CAST(N'2024-03-29' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (54, N'Easter Monday', CAST(N'2024-04-01' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (55, N'Early May bank holiday', CAST(N'2024-05-06' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (56, N'Spring bank holiday', CAST(N'2024-05-27' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (57, N'Summer bank holiday', CAST(N'2024-08-26' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (58, N'Christmas Day', CAST(N'2024-12-25' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (59, N'Boxing Day', CAST(N'2024-12-26' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (60, N'New Year’s Day', CAST(N'2025-01-01' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (61, N'Good Friday', CAST(N'2025-04-18' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (62, N'Easter Monday', CAST(N'2025-04-21' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (63, N'Early May bank holiday', CAST(N'2025-05-05' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (64, N'Spring bank holiday', CAST(N'2025-05-26' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (65, N'Summer bank holiday', CAST(N'2025-08-25' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (66, N'Christmas Day', CAST(N'2025-12-25' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (67, N'Boxing Day', CAST(N'2025-12-26' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (68, N'New Year’s Day', CAST(N'2018-01-01' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (69, N'2nd January', CAST(N'2018-01-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (70, N'Good Friday', CAST(N'2018-03-30' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (71, N'Early May bank holiday', CAST(N'2018-05-07' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (72, N'Spring bank holiday', CAST(N'2018-05-28' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (73, N'Summer bank holiday', CAST(N'2018-08-06' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (74, N'St Andrew’s Day', CAST(N'2018-11-30' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (75, N'Christmas Day', CAST(N'2018-12-25' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (76, N'Boxing Day', CAST(N'2018-12-26' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (77, N'New Year’s Day', CAST(N'2019-01-01' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (78, N'2nd January', CAST(N'2019-01-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (79, N'Good Friday', CAST(N'2019-04-19' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (80, N'Early May bank holiday', CAST(N'2019-05-06' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (81, N'Spring bank holiday', CAST(N'2019-05-27' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (82, N'Summer bank holiday', CAST(N'2019-08-05' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (83, N'St Andrew’s Day', CAST(N'2019-12-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (84, N'Christmas Day', CAST(N'2019-12-25' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (85, N'Boxing Day', CAST(N'2019-12-26' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (86, N'New Year’s Day', CAST(N'2020-01-01' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (87, N'2nd January', CAST(N'2020-01-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (88, N'Good Friday', CAST(N'2020-04-10' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (89, N'Early May bank holiday (VE day)', CAST(N'2020-05-08' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (90, N'Spring bank holiday', CAST(N'2020-05-25' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (91, N'Summer bank holiday', CAST(N'2020-08-03' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (92, N'St Andrew’s Day', CAST(N'2020-11-30' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (93, N'Christmas Day', CAST(N'2020-12-25' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (94, N'Boxing Day', CAST(N'2020-12-28' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (95, N'New Year’s Day', CAST(N'2021-01-01' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (96, N'2nd January', CAST(N'2021-01-04' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (97, N'Good Friday', CAST(N'2021-04-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (98, N'Early May bank holiday', CAST(N'2021-05-03' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (99, N'Spring bank holiday', CAST(N'2021-05-31' AS Date), N'scotland')
GO
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (100, N'Summer bank holiday', CAST(N'2021-08-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (101, N'St Andrew’s Day', CAST(N'2021-11-30' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (102, N'Christmas Day', CAST(N'2021-12-27' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (103, N'Boxing Day', CAST(N'2021-12-28' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (104, N'New Year’s Day', CAST(N'2022-01-03' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (105, N'2nd January', CAST(N'2022-01-04' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (106, N'Good Friday', CAST(N'2022-04-15' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (107, N'Early May bank holiday', CAST(N'2022-05-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (108, N'Spring bank holiday', CAST(N'2022-06-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (109, N'Platinum Jubilee bank holiday', CAST(N'2022-06-03' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (110, N'Summer bank holiday', CAST(N'2022-08-01' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (111, N'Bank Holiday for the State Funeral of Queen Elizabeth II', CAST(N'2022-09-19' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (112, N'St Andrew’s Day', CAST(N'2022-11-30' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (113, N'Boxing Day', CAST(N'2022-12-26' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (114, N'Christmas Day', CAST(N'2022-12-27' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (115, N'New Year’s Day', CAST(N'2023-01-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (116, N'2nd January', CAST(N'2023-01-03' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (117, N'Good Friday', CAST(N'2023-04-07' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (118, N'Early May bank holiday', CAST(N'2023-05-01' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (119, N'Bank holiday for the coronation of King Charles III', CAST(N'2023-05-08' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (120, N'Spring bank holiday', CAST(N'2023-05-29' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (121, N'Summer bank holiday', CAST(N'2023-08-07' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (122, N'St Andrew’s Day', CAST(N'2023-11-30' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (123, N'Christmas Day', CAST(N'2023-12-25' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (124, N'Boxing Day', CAST(N'2023-12-26' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (125, N'New Year’s Day', CAST(N'2024-01-01' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (126, N'2nd January', CAST(N'2024-01-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (127, N'Good Friday', CAST(N'2024-03-29' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (128, N'Early May bank holiday', CAST(N'2024-05-06' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (129, N'Spring bank holiday', CAST(N'2024-05-27' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (130, N'Summer bank holiday', CAST(N'2024-08-05' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (131, N'St Andrew’s Day', CAST(N'2024-12-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (132, N'Christmas Day', CAST(N'2024-12-25' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (133, N'Boxing Day', CAST(N'2024-12-26' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (134, N'New Year’s Day', CAST(N'2025-01-01' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (135, N'2nd January', CAST(N'2025-01-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (136, N'Good Friday', CAST(N'2025-04-18' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (137, N'Early May bank holiday', CAST(N'2025-05-05' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (138, N'Spring bank holiday', CAST(N'2025-05-26' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (139, N'Summer bank holiday', CAST(N'2025-08-04' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (140, N'St Andrew’s Day', CAST(N'2025-12-01' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (141, N'Christmas Day', CAST(N'2025-12-25' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (142, N'Boxing Day', CAST(N'2025-12-26' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (143, N'New Year’s Day', CAST(N'2018-01-01' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (144, N'St Patrick’s Day', CAST(N'2018-03-19' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (145, N'Good Friday', CAST(N'2018-03-30' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (146, N'Easter Monday', CAST(N'2018-04-02' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (147, N'Early May bank holiday', CAST(N'2018-05-07' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (148, N'Spring bank holiday', CAST(N'2018-05-28' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (149, N'Battle of the Boyne (Orangemen’s Day)', CAST(N'2018-07-12' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (150, N'Summer bank holiday', CAST(N'2018-08-27' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (151, N'Christmas Day', CAST(N'2018-12-25' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (152, N'Boxing Day', CAST(N'2018-12-26' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (153, N'New Year’s Day', CAST(N'2019-01-01' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (154, N'St Patrick’s Day', CAST(N'2019-03-18' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (155, N'Good Friday', CAST(N'2019-04-19' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (156, N'Easter Monday', CAST(N'2019-04-22' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (157, N'Early May bank holiday', CAST(N'2019-05-06' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (158, N'Spring bank holiday', CAST(N'2019-05-27' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (159, N'Battle of the Boyne (Orangemen’s Day)', CAST(N'2019-07-12' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (160, N'Summer bank holiday', CAST(N'2019-08-26' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (161, N'Christmas Day', CAST(N'2019-12-25' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (162, N'Boxing Day', CAST(N'2019-12-26' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (163, N'New Year’s Day', CAST(N'2020-01-01' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (164, N'St Patrick’s Day', CAST(N'2020-03-17' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (165, N'Good Friday', CAST(N'2020-04-10' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (166, N'Easter Monday', CAST(N'2020-04-13' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (167, N'Early May bank holiday (VE day)', CAST(N'2020-05-08' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (168, N'Spring bank holiday', CAST(N'2020-05-25' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (169, N'Battle of the Boyne (Orangemen’s Day)', CAST(N'2020-07-13' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (170, N'Summer bank holiday', CAST(N'2020-08-31' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (171, N'Christmas Day', CAST(N'2020-12-25' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (172, N'Boxing Day', CAST(N'2020-12-28' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (173, N'New Year’s Day', CAST(N'2021-01-01' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (174, N'St Patrick’s Day', CAST(N'2021-03-17' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (175, N'Good Friday', CAST(N'2021-04-02' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (176, N'Easter Monday', CAST(N'2021-04-05' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (177, N'Early May bank holiday', CAST(N'2021-05-03' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (178, N'Spring bank holiday', CAST(N'2021-05-31' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (179, N'Battle of the Boyne (Orangemen’s Day)', CAST(N'2021-07-12' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (180, N'Summer bank holiday', CAST(N'2021-08-30' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (181, N'Christmas Day', CAST(N'2021-12-27' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (182, N'Boxing Day', CAST(N'2021-12-28' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (183, N'New Year’s Day', CAST(N'2022-01-03' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (184, N'St Patrick’s Day', CAST(N'2022-03-17' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (185, N'Good Friday', CAST(N'2022-04-15' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (186, N'Easter Monday', CAST(N'2022-04-18' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (187, N'Early May bank holiday', CAST(N'2022-05-02' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (188, N'Spring bank holiday', CAST(N'2022-06-02' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (189, N'Platinum Jubilee bank holiday', CAST(N'2022-06-03' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (190, N'Battle of the Boyne (Orangemen’s Day)', CAST(N'2022-07-12' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (191, N'Summer bank holiday', CAST(N'2022-08-29' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (192, N'Bank Holiday for the State Funeral of Queen Elizabeth II', CAST(N'2022-09-19' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (193, N'Boxing Day', CAST(N'2022-12-26' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (194, N'Christmas Day', CAST(N'2022-12-27' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (195, N'New Year’s Day', CAST(N'2023-01-02' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (196, N'St Patrick’s Day', CAST(N'2023-03-17' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (197, N'Good Friday', CAST(N'2023-04-07' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (198, N'Easter Monday', CAST(N'2023-04-10' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (199, N'Early May bank holiday', CAST(N'2023-05-01' AS Date), N'northern-ireland')
GO
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (200, N'Bank holiday for the coronation of King Charles III', CAST(N'2023-05-08' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (201, N'Spring bank holiday', CAST(N'2023-05-29' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (202, N'Battle of the Boyne (Orangemen’s Day)', CAST(N'2023-07-12' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (203, N'Summer bank holiday', CAST(N'2023-08-28' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (204, N'Christmas Day', CAST(N'2023-12-25' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (205, N'Boxing Day', CAST(N'2023-12-26' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (206, N'New Year’s Day', CAST(N'2024-01-01' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (207, N'St Patrick’s Day', CAST(N'2024-03-18' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (208, N'Good Friday', CAST(N'2024-03-29' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (209, N'Easter Monday', CAST(N'2024-04-01' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (210, N'Early May bank holiday', CAST(N'2024-05-06' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (211, N'Spring bank holiday', CAST(N'2024-05-27' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (212, N'Battle of the Boyne (Orangemen’s Day)', CAST(N'2024-07-12' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (213, N'Summer bank holiday', CAST(N'2024-08-26' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (214, N'Christmas Day', CAST(N'2024-12-25' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (215, N'Boxing Day', CAST(N'2024-12-26' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (216, N'New Year’s Day', CAST(N'2025-01-01' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (217, N'St Patrick’s Day', CAST(N'2025-03-17' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (218, N'Good Friday', CAST(N'2025-04-18' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (219, N'Easter Monday', CAST(N'2025-04-21' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (220, N'Early May bank holiday', CAST(N'2025-05-05' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (221, N'Spring bank holiday', CAST(N'2025-05-26' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (222, N'Battle of the Boyne (Orangemen’s Day)', CAST(N'2025-07-14' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (223, N'Summer bank holiday', CAST(N'2025-08-25' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (224, N'Christmas Day', CAST(N'2025-12-25' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (225, N'Boxing Day', CAST(N'2025-12-26' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (226, N'New Year’s Day', CAST(N'2018-01-01' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (227, N'Good Friday', CAST(N'2018-03-30' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (228, N'Easter Monday', CAST(N'2018-04-02' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (229, N'Early May bank holiday', CAST(N'2018-05-07' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (230, N'Spring bank holiday', CAST(N'2018-05-28' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (231, N'Summer bank holiday', CAST(N'2018-08-27' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (232, N'Christmas Day', CAST(N'2018-12-25' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (233, N'Boxing Day', CAST(N'2018-12-26' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (234, N'New Year’s Day', CAST(N'2019-01-01' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (235, N'Good Friday', CAST(N'2019-04-19' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (236, N'Easter Monday', CAST(N'2019-04-22' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (237, N'Early May bank holiday', CAST(N'2019-05-06' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (238, N'Spring bank holiday', CAST(N'2019-05-27' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (239, N'Summer bank holiday', CAST(N'2019-08-26' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (240, N'Christmas Day', CAST(N'2019-12-25' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (241, N'Boxing Day', CAST(N'2019-12-26' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (242, N'New Year’s Day', CAST(N'2020-01-01' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (243, N'Good Friday', CAST(N'2020-04-10' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (244, N'Easter Monday', CAST(N'2020-04-13' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (245, N'Early May bank holiday (VE day)', CAST(N'2020-05-08' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (246, N'Spring bank holiday', CAST(N'2020-05-25' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (247, N'Summer bank holiday', CAST(N'2020-08-31' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (248, N'Christmas Day', CAST(N'2020-12-25' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (249, N'Boxing Day', CAST(N'2020-12-28' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (250, N'New Year’s Day', CAST(N'2021-01-01' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (251, N'Good Friday', CAST(N'2021-04-02' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (252, N'Easter Monday', CAST(N'2021-04-05' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (253, N'Early May bank holiday', CAST(N'2021-05-03' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (254, N'Spring bank holiday', CAST(N'2021-05-31' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (255, N'Summer bank holiday', CAST(N'2021-08-30' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (256, N'Christmas Day', CAST(N'2021-12-27' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (257, N'Boxing Day', CAST(N'2021-12-28' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (258, N'New Year’s Day', CAST(N'2022-01-03' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (259, N'Good Friday', CAST(N'2022-04-15' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (260, N'Easter Monday', CAST(N'2022-04-18' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (261, N'Early May bank holiday', CAST(N'2022-05-02' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (262, N'Spring bank holiday', CAST(N'2022-06-02' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (263, N'Platinum Jubilee bank holiday', CAST(N'2022-06-03' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (264, N'Summer bank holiday', CAST(N'2022-08-29' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (265, N'Bank Holiday for the State Funeral of Queen Elizabeth II', CAST(N'2022-09-19' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (266, N'Boxing Day', CAST(N'2022-12-26' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (267, N'Christmas Day', CAST(N'2022-12-27' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (268, N'New Year’s Day', CAST(N'2023-01-02' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (269, N'Good Friday', CAST(N'2023-04-07' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (270, N'Easter Monday', CAST(N'2023-04-10' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (271, N'Early May bank holiday', CAST(N'2023-05-01' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (272, N'Bank holiday for the coronation of King Charles III', CAST(N'2023-05-08' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (273, N'Spring bank holiday', CAST(N'2023-05-29' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (274, N'Summer bank holiday', CAST(N'2023-08-28' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (275, N'Christmas Day', CAST(N'2023-12-25' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (276, N'Boxing Day', CAST(N'2023-12-26' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (277, N'New Year’s Day', CAST(N'2024-01-01' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (278, N'Good Friday', CAST(N'2024-03-29' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (279, N'Easter Monday', CAST(N'2024-04-01' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (280, N'Early May bank holiday', CAST(N'2024-05-06' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (281, N'Spring bank holiday', CAST(N'2024-05-27' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (282, N'Summer bank holiday', CAST(N'2024-08-26' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (283, N'Christmas Day', CAST(N'2024-12-25' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (284, N'Boxing Day', CAST(N'2024-12-26' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (285, N'New Year’s Day', CAST(N'2025-01-01' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (286, N'Good Friday', CAST(N'2025-04-18' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (287, N'Easter Monday', CAST(N'2025-04-21' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (288, N'Early May bank holiday', CAST(N'2025-05-05' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (289, N'Spring bank holiday', CAST(N'2025-05-26' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (290, N'Summer bank holiday', CAST(N'2025-08-25' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (291, N'Christmas Day', CAST(N'2025-12-25' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (292, N'Boxing Day', CAST(N'2025-12-26' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (293, N'New Year’s Day', CAST(N'2018-01-01' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (294, N'2nd January', CAST(N'2018-01-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (295, N'Good Friday', CAST(N'2018-03-30' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (296, N'Early May bank holiday', CAST(N'2018-05-07' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (297, N'Spring bank holiday', CAST(N'2018-05-28' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (298, N'Summer bank holiday', CAST(N'2018-08-06' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (299, N'St Andrew’s Day', CAST(N'2018-11-30' AS Date), N'scotland')
GO
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (300, N'Christmas Day', CAST(N'2018-12-25' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (301, N'Boxing Day', CAST(N'2018-12-26' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (302, N'New Year’s Day', CAST(N'2019-01-01' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (303, N'2nd January', CAST(N'2019-01-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (304, N'Good Friday', CAST(N'2019-04-19' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (305, N'Early May bank holiday', CAST(N'2019-05-06' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (306, N'Spring bank holiday', CAST(N'2019-05-27' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (307, N'Summer bank holiday', CAST(N'2019-08-05' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (308, N'St Andrew’s Day', CAST(N'2019-12-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (309, N'Christmas Day', CAST(N'2019-12-25' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (310, N'Boxing Day', CAST(N'2019-12-26' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (311, N'New Year’s Day', CAST(N'2020-01-01' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (312, N'2nd January', CAST(N'2020-01-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (313, N'Good Friday', CAST(N'2020-04-10' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (314, N'Early May bank holiday (VE day)', CAST(N'2020-05-08' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (315, N'Spring bank holiday', CAST(N'2020-05-25' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (316, N'Summer bank holiday', CAST(N'2020-08-03' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (317, N'St Andrew’s Day', CAST(N'2020-11-30' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (318, N'Christmas Day', CAST(N'2020-12-25' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (319, N'Boxing Day', CAST(N'2020-12-28' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (320, N'New Year’s Day', CAST(N'2021-01-01' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (321, N'2nd January', CAST(N'2021-01-04' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (322, N'Good Friday', CAST(N'2021-04-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (323, N'Early May bank holiday', CAST(N'2021-05-03' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (324, N'Spring bank holiday', CAST(N'2021-05-31' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (325, N'Summer bank holiday', CAST(N'2021-08-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (326, N'St Andrew’s Day', CAST(N'2021-11-30' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (327, N'Christmas Day', CAST(N'2021-12-27' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (328, N'Boxing Day', CAST(N'2021-12-28' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (329, N'New Year’s Day', CAST(N'2022-01-03' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (330, N'2nd January', CAST(N'2022-01-04' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (331, N'Good Friday', CAST(N'2022-04-15' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (332, N'Early May bank holiday', CAST(N'2022-05-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (333, N'Spring bank holiday', CAST(N'2022-06-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (334, N'Platinum Jubilee bank holiday', CAST(N'2022-06-03' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (335, N'Summer bank holiday', CAST(N'2022-08-01' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (336, N'Bank Holiday for the State Funeral of Queen Elizabeth II', CAST(N'2022-09-19' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (337, N'St Andrew’s Day', CAST(N'2022-11-30' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (338, N'Boxing Day', CAST(N'2022-12-26' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (339, N'Christmas Day', CAST(N'2022-12-27' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (340, N'New Year’s Day', CAST(N'2023-01-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (341, N'2nd January', CAST(N'2023-01-03' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (342, N'Good Friday', CAST(N'2023-04-07' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (343, N'Early May bank holiday', CAST(N'2023-05-01' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (344, N'Bank holiday for the coronation of King Charles III', CAST(N'2023-05-08' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (345, N'Spring bank holiday', CAST(N'2023-05-29' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (346, N'Summer bank holiday', CAST(N'2023-08-07' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (347, N'St Andrew’s Day', CAST(N'2023-11-30' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (348, N'Christmas Day', CAST(N'2023-12-25' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (349, N'Boxing Day', CAST(N'2023-12-26' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (350, N'New Year’s Day', CAST(N'2024-01-01' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (351, N'2nd January', CAST(N'2024-01-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (352, N'Good Friday', CAST(N'2024-03-29' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (353, N'Early May bank holiday', CAST(N'2024-05-06' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (354, N'Spring bank holiday', CAST(N'2024-05-27' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (355, N'Summer bank holiday', CAST(N'2024-08-05' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (356, N'St Andrew’s Day', CAST(N'2024-12-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (357, N'Christmas Day', CAST(N'2024-12-25' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (358, N'Boxing Day', CAST(N'2024-12-26' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (359, N'New Year’s Day', CAST(N'2025-01-01' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (360, N'2nd January', CAST(N'2025-01-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (361, N'Good Friday', CAST(N'2025-04-18' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (362, N'Early May bank holiday', CAST(N'2025-05-05' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (363, N'Spring bank holiday', CAST(N'2025-05-26' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (364, N'Summer bank holiday', CAST(N'2025-08-04' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (365, N'St Andrew’s Day', CAST(N'2025-12-01' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (366, N'Christmas Day', CAST(N'2025-12-25' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (367, N'Boxing Day', CAST(N'2025-12-26' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (368, N'New Year’s Day', CAST(N'2018-01-01' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (369, N'St Patrick’s Day', CAST(N'2018-03-19' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (370, N'Good Friday', CAST(N'2018-03-30' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (371, N'Easter Monday', CAST(N'2018-04-02' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (372, N'Early May bank holiday', CAST(N'2018-05-07' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (373, N'Spring bank holiday', CAST(N'2018-05-28' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (374, N'Battle of the Boyne (Orangemen’s Day)', CAST(N'2018-07-12' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (375, N'Summer bank holiday', CAST(N'2018-08-27' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (376, N'Christmas Day', CAST(N'2018-12-25' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (377, N'Boxing Day', CAST(N'2018-12-26' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (378, N'New Year’s Day', CAST(N'2019-01-01' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (379, N'St Patrick’s Day', CAST(N'2019-03-18' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (380, N'Good Friday', CAST(N'2019-04-19' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (381, N'Easter Monday', CAST(N'2019-04-22' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (382, N'Early May bank holiday', CAST(N'2019-05-06' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (383, N'Spring bank holiday', CAST(N'2019-05-27' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (384, N'Battle of the Boyne (Orangemen’s Day)', CAST(N'2019-07-12' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (385, N'Summer bank holiday', CAST(N'2019-08-26' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (386, N'Christmas Day', CAST(N'2019-12-25' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (387, N'Boxing Day', CAST(N'2019-12-26' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (388, N'New Year’s Day', CAST(N'2020-01-01' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (389, N'St Patrick’s Day', CAST(N'2020-03-17' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (390, N'Good Friday', CAST(N'2020-04-10' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (391, N'Easter Monday', CAST(N'2020-04-13' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (392, N'Early May bank holiday (VE day)', CAST(N'2020-05-08' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (393, N'Spring bank holiday', CAST(N'2020-05-25' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (394, N'Battle of the Boyne (Orangemen’s Day)', CAST(N'2020-07-13' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (395, N'Summer bank holiday', CAST(N'2020-08-31' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (396, N'Christmas Day', CAST(N'2020-12-25' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (397, N'Boxing Day', CAST(N'2020-12-28' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (398, N'New Year’s Day', CAST(N'2021-01-01' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (399, N'St Patrick’s Day', CAST(N'2021-03-17' AS Date), N'northern-ireland')
GO
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (400, N'Good Friday', CAST(N'2021-04-02' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (401, N'Easter Monday', CAST(N'2021-04-05' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (402, N'Early May bank holiday', CAST(N'2021-05-03' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (403, N'Spring bank holiday', CAST(N'2021-05-31' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (404, N'Battle of the Boyne (Orangemen’s Day)', CAST(N'2021-07-12' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (405, N'Summer bank holiday', CAST(N'2021-08-30' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (406, N'Christmas Day', CAST(N'2021-12-27' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (407, N'Boxing Day', CAST(N'2021-12-28' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (408, N'New Year’s Day', CAST(N'2022-01-03' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (409, N'St Patrick’s Day', CAST(N'2022-03-17' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (410, N'Good Friday', CAST(N'2022-04-15' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (411, N'Easter Monday', CAST(N'2022-04-18' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (412, N'Early May bank holiday', CAST(N'2022-05-02' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (413, N'Spring bank holiday', CAST(N'2022-06-02' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (414, N'Platinum Jubilee bank holiday', CAST(N'2022-06-03' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (415, N'Battle of the Boyne (Orangemen’s Day)', CAST(N'2022-07-12' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (416, N'Summer bank holiday', CAST(N'2022-08-29' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (417, N'Bank Holiday for the State Funeral of Queen Elizabeth II', CAST(N'2022-09-19' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (418, N'Boxing Day', CAST(N'2022-12-26' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (419, N'Christmas Day', CAST(N'2022-12-27' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (420, N'New Year’s Day', CAST(N'2023-01-02' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (421, N'St Patrick’s Day', CAST(N'2023-03-17' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (422, N'Good Friday', CAST(N'2023-04-07' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (423, N'Easter Monday', CAST(N'2023-04-10' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (424, N'Early May bank holiday', CAST(N'2023-05-01' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (425, N'Bank holiday for the coronation of King Charles III', CAST(N'2023-05-08' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (426, N'Spring bank holiday', CAST(N'2023-05-29' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (427, N'Battle of the Boyne (Orangemen’s Day)', CAST(N'2023-07-12' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (428, N'Summer bank holiday', CAST(N'2023-08-28' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (429, N'Christmas Day', CAST(N'2023-12-25' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (430, N'Boxing Day', CAST(N'2023-12-26' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (431, N'New Year’s Day', CAST(N'2024-01-01' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (432, N'St Patrick’s Day', CAST(N'2024-03-18' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (433, N'Good Friday', CAST(N'2024-03-29' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (434, N'Easter Monday', CAST(N'2024-04-01' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (435, N'Early May bank holiday', CAST(N'2024-05-06' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (436, N'Spring bank holiday', CAST(N'2024-05-27' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (437, N'Battle of the Boyne (Orangemen’s Day)', CAST(N'2024-07-12' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (438, N'Summer bank holiday', CAST(N'2024-08-26' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (439, N'Christmas Day', CAST(N'2024-12-25' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (440, N'Boxing Day', CAST(N'2024-12-26' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (441, N'New Year’s Day', CAST(N'2025-01-01' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (442, N'St Patrick’s Day', CAST(N'2025-03-17' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (443, N'Good Friday', CAST(N'2025-04-18' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (444, N'Easter Monday', CAST(N'2025-04-21' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (445, N'Early May bank holiday', CAST(N'2025-05-05' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (446, N'Spring bank holiday', CAST(N'2025-05-26' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (447, N'Battle of the Boyne (Orangemen’s Day)', CAST(N'2025-07-14' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (448, N'Summer bank holiday', CAST(N'2025-08-25' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (449, N'Christmas Day', CAST(N'2025-12-25' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (450, N'Boxing Day', CAST(N'2025-12-26' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (451, N'New Year’s Day', CAST(N'2018-01-01' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (452, N'Good Friday', CAST(N'2018-03-30' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (453, N'Easter Monday', CAST(N'2018-04-02' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (454, N'Early May bank holiday', CAST(N'2018-05-07' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (455, N'Spring bank holiday', CAST(N'2018-05-28' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (456, N'Summer bank holiday', CAST(N'2018-08-27' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (457, N'Christmas Day', CAST(N'2018-12-25' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (458, N'Boxing Day', CAST(N'2018-12-26' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (459, N'New Year’s Day', CAST(N'2019-01-01' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (460, N'Good Friday', CAST(N'2019-04-19' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (461, N'Easter Monday', CAST(N'2019-04-22' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (462, N'Early May bank holiday', CAST(N'2019-05-06' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (463, N'Spring bank holiday', CAST(N'2019-05-27' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (464, N'Summer bank holiday', CAST(N'2019-08-26' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (465, N'Christmas Day', CAST(N'2019-12-25' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (466, N'Boxing Day', CAST(N'2019-12-26' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (467, N'New Year’s Day', CAST(N'2020-01-01' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (468, N'Good Friday', CAST(N'2020-04-10' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (469, N'Easter Monday', CAST(N'2020-04-13' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (470, N'Early May bank holiday (VE day)', CAST(N'2020-05-08' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (471, N'Spring bank holiday', CAST(N'2020-05-25' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (472, N'Summer bank holiday', CAST(N'2020-08-31' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (473, N'Christmas Day', CAST(N'2020-12-25' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (474, N'Boxing Day', CAST(N'2020-12-28' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (475, N'New Year’s Day', CAST(N'2021-01-01' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (476, N'Good Friday', CAST(N'2021-04-02' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (477, N'Easter Monday', CAST(N'2021-04-05' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (478, N'Early May bank holiday', CAST(N'2021-05-03' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (479, N'Spring bank holiday', CAST(N'2021-05-31' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (480, N'Summer bank holiday', CAST(N'2021-08-30' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (481, N'Christmas Day', CAST(N'2021-12-27' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (482, N'Boxing Day', CAST(N'2021-12-28' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (483, N'New Year’s Day', CAST(N'2022-01-03' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (484, N'Good Friday', CAST(N'2022-04-15' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (485, N'Easter Monday', CAST(N'2022-04-18' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (486, N'Early May bank holiday', CAST(N'2022-05-02' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (487, N'Spring bank holiday', CAST(N'2022-06-02' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (488, N'Platinum Jubilee bank holiday', CAST(N'2022-06-03' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (489, N'Summer bank holiday', CAST(N'2022-08-29' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (490, N'Bank Holiday for the State Funeral of Queen Elizabeth II', CAST(N'2022-09-19' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (491, N'Boxing Day', CAST(N'2022-12-26' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (492, N'Christmas Day', CAST(N'2022-12-27' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (493, N'New Year’s Day', CAST(N'2023-01-02' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (494, N'Good Friday', CAST(N'2023-04-07' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (495, N'Easter Monday', CAST(N'2023-04-10' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (496, N'Early May bank holiday', CAST(N'2023-05-01' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (497, N'Bank holiday for the coronation of King Charles III', CAST(N'2023-05-08' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (498, N'Spring bank holiday', CAST(N'2023-05-29' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (499, N'Summer bank holiday', CAST(N'2023-08-28' AS Date), N'england-and-wales')
GO
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (500, N'Christmas Day', CAST(N'2023-12-25' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (501, N'Boxing Day', CAST(N'2023-12-26' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (502, N'New Year’s Day', CAST(N'2024-01-01' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (503, N'Good Friday', CAST(N'2024-03-29' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (504, N'Easter Monday', CAST(N'2024-04-01' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (505, N'Early May bank holiday', CAST(N'2024-05-06' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (506, N'Spring bank holiday', CAST(N'2024-05-27' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (507, N'Summer bank holiday', CAST(N'2024-08-26' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (508, N'Christmas Day', CAST(N'2024-12-25' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (509, N'Boxing Day', CAST(N'2024-12-26' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (510, N'New Year’s Day', CAST(N'2025-01-01' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (511, N'Good Friday', CAST(N'2025-04-18' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (512, N'Easter Monday', CAST(N'2025-04-21' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (513, N'Early May bank holiday', CAST(N'2025-05-05' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (514, N'Spring bank holiday', CAST(N'2025-05-26' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (515, N'Summer bank holiday', CAST(N'2025-08-25' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (516, N'Christmas Day', CAST(N'2025-12-25' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (517, N'Boxing Day', CAST(N'2025-12-26' AS Date), N'england-and-wales')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (518, N'New Year’s Day', CAST(N'2018-01-01' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (519, N'2nd January', CAST(N'2018-01-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (520, N'Good Friday', CAST(N'2018-03-30' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (521, N'Early May bank holiday', CAST(N'2018-05-07' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (522, N'Spring bank holiday', CAST(N'2018-05-28' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (523, N'Summer bank holiday', CAST(N'2018-08-06' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (524, N'St Andrew’s Day', CAST(N'2018-11-30' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (525, N'Christmas Day', CAST(N'2018-12-25' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (526, N'Boxing Day', CAST(N'2018-12-26' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (527, N'New Year’s Day', CAST(N'2019-01-01' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (528, N'2nd January', CAST(N'2019-01-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (529, N'Good Friday', CAST(N'2019-04-19' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (530, N'Early May bank holiday', CAST(N'2019-05-06' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (531, N'Spring bank holiday', CAST(N'2019-05-27' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (532, N'Summer bank holiday', CAST(N'2019-08-05' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (533, N'St Andrew’s Day', CAST(N'2019-12-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (534, N'Christmas Day', CAST(N'2019-12-25' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (535, N'Boxing Day', CAST(N'2019-12-26' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (536, N'New Year’s Day', CAST(N'2020-01-01' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (537, N'2nd January', CAST(N'2020-01-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (538, N'Good Friday', CAST(N'2020-04-10' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (539, N'Early May bank holiday (VE day)', CAST(N'2020-05-08' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (540, N'Spring bank holiday', CAST(N'2020-05-25' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (541, N'Summer bank holiday', CAST(N'2020-08-03' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (542, N'St Andrew’s Day', CAST(N'2020-11-30' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (543, N'Christmas Day', CAST(N'2020-12-25' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (544, N'Boxing Day', CAST(N'2020-12-28' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (545, N'New Year’s Day', CAST(N'2021-01-01' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (546, N'2nd January', CAST(N'2021-01-04' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (547, N'Good Friday', CAST(N'2021-04-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (548, N'Early May bank holiday', CAST(N'2021-05-03' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (549, N'Spring bank holiday', CAST(N'2021-05-31' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (550, N'Summer bank holiday', CAST(N'2021-08-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (551, N'St Andrew’s Day', CAST(N'2021-11-30' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (552, N'Christmas Day', CAST(N'2021-12-27' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (553, N'Boxing Day', CAST(N'2021-12-28' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (554, N'New Year’s Day', CAST(N'2022-01-03' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (555, N'2nd January', CAST(N'2022-01-04' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (556, N'Good Friday', CAST(N'2022-04-15' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (557, N'Early May bank holiday', CAST(N'2022-05-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (558, N'Spring bank holiday', CAST(N'2022-06-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (559, N'Platinum Jubilee bank holiday', CAST(N'2022-06-03' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (560, N'Summer bank holiday', CAST(N'2022-08-01' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (561, N'Bank Holiday for the State Funeral of Queen Elizabeth II', CAST(N'2022-09-19' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (562, N'St Andrew’s Day', CAST(N'2022-11-30' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (563, N'Boxing Day', CAST(N'2022-12-26' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (564, N'Christmas Day', CAST(N'2022-12-27' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (565, N'New Year’s Day', CAST(N'2023-01-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (566, N'2nd January', CAST(N'2023-01-03' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (567, N'Good Friday', CAST(N'2023-04-07' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (568, N'Early May bank holiday', CAST(N'2023-05-01' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (569, N'Bank holiday for the coronation of King Charles III', CAST(N'2023-05-08' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (570, N'Spring bank holiday', CAST(N'2023-05-29' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (571, N'Summer bank holiday', CAST(N'2023-08-07' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (572, N'St Andrew’s Day', CAST(N'2023-11-30' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (573, N'Christmas Day', CAST(N'2023-12-25' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (574, N'Boxing Day', CAST(N'2023-12-26' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (575, N'New Year’s Day', CAST(N'2024-01-01' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (576, N'2nd January', CAST(N'2024-01-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (577, N'Good Friday', CAST(N'2024-03-29' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (578, N'Early May bank holiday', CAST(N'2024-05-06' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (579, N'Spring bank holiday', CAST(N'2024-05-27' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (580, N'Summer bank holiday', CAST(N'2024-08-05' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (581, N'St Andrew’s Day', CAST(N'2024-12-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (582, N'Christmas Day', CAST(N'2024-12-25' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (583, N'Boxing Day', CAST(N'2024-12-26' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (584, N'New Year’s Day', CAST(N'2025-01-01' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (585, N'2nd January', CAST(N'2025-01-02' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (586, N'Good Friday', CAST(N'2025-04-18' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (587, N'Early May bank holiday', CAST(N'2025-05-05' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (588, N'Spring bank holiday', CAST(N'2025-05-26' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (589, N'Summer bank holiday', CAST(N'2025-08-04' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (590, N'St Andrew’s Day', CAST(N'2025-12-01' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (591, N'Christmas Day', CAST(N'2025-12-25' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (592, N'Boxing Day', CAST(N'2025-12-26' AS Date), N'scotland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (593, N'New Year’s Day', CAST(N'2018-01-01' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (594, N'St Patrick’s Day', CAST(N'2018-03-19' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (595, N'Good Friday', CAST(N'2018-03-30' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (596, N'Easter Monday', CAST(N'2018-04-02' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (597, N'Early May bank holiday', CAST(N'2018-05-07' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (598, N'Spring bank holiday', CAST(N'2018-05-28' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (599, N'Battle of the Boyne (Orangemen’s Day)', CAST(N'2018-07-12' AS Date), N'northern-ireland')
GO
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (600, N'Summer bank holiday', CAST(N'2018-08-27' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (601, N'Christmas Day', CAST(N'2018-12-25' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (602, N'Boxing Day', CAST(N'2018-12-26' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (603, N'New Year’s Day', CAST(N'2019-01-01' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (604, N'St Patrick’s Day', CAST(N'2019-03-18' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (605, N'Good Friday', CAST(N'2019-04-19' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (606, N'Easter Monday', CAST(N'2019-04-22' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (607, N'Early May bank holiday', CAST(N'2019-05-06' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (608, N'Spring bank holiday', CAST(N'2019-05-27' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (609, N'Battle of the Boyne (Orangemen’s Day)', CAST(N'2019-07-12' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (610, N'Summer bank holiday', CAST(N'2019-08-26' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (611, N'Christmas Day', CAST(N'2019-12-25' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (612, N'Boxing Day', CAST(N'2019-12-26' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (613, N'New Year’s Day', CAST(N'2020-01-01' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (614, N'St Patrick’s Day', CAST(N'2020-03-17' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (615, N'Good Friday', CAST(N'2020-04-10' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (616, N'Easter Monday', CAST(N'2020-04-13' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (617, N'Early May bank holiday (VE day)', CAST(N'2020-05-08' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (618, N'Spring bank holiday', CAST(N'2020-05-25' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (619, N'Battle of the Boyne (Orangemen’s Day)', CAST(N'2020-07-13' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (620, N'Summer bank holiday', CAST(N'2020-08-31' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (621, N'Christmas Day', CAST(N'2020-12-25' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (622, N'Boxing Day', CAST(N'2020-12-28' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (623, N'New Year’s Day', CAST(N'2021-01-01' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (624, N'St Patrick’s Day', CAST(N'2021-03-17' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (625, N'Good Friday', CAST(N'2021-04-02' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (626, N'Easter Monday', CAST(N'2021-04-05' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (627, N'Early May bank holiday', CAST(N'2021-05-03' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (628, N'Spring bank holiday', CAST(N'2021-05-31' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (629, N'Battle of the Boyne (Orangemen’s Day)', CAST(N'2021-07-12' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (630, N'Summer bank holiday', CAST(N'2021-08-30' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (631, N'Christmas Day', CAST(N'2021-12-27' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (632, N'Boxing Day', CAST(N'2021-12-28' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (633, N'New Year’s Day', CAST(N'2022-01-03' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (634, N'St Patrick’s Day', CAST(N'2022-03-17' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (635, N'Good Friday', CAST(N'2022-04-15' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (636, N'Easter Monday', CAST(N'2022-04-18' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (637, N'Early May bank holiday', CAST(N'2022-05-02' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (638, N'Spring bank holiday', CAST(N'2022-06-02' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (639, N'Platinum Jubilee bank holiday', CAST(N'2022-06-03' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (640, N'Battle of the Boyne (Orangemen’s Day)', CAST(N'2022-07-12' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (641, N'Summer bank holiday', CAST(N'2022-08-29' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (642, N'Bank Holiday for the State Funeral of Queen Elizabeth II', CAST(N'2022-09-19' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (643, N'Boxing Day', CAST(N'2022-12-26' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (644, N'Christmas Day', CAST(N'2022-12-27' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (645, N'New Year’s Day', CAST(N'2023-01-02' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (646, N'St Patrick’s Day', CAST(N'2023-03-17' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (647, N'Good Friday', CAST(N'2023-04-07' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (648, N'Easter Monday', CAST(N'2023-04-10' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (649, N'Early May bank holiday', CAST(N'2023-05-01' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (650, N'Bank holiday for the coronation of King Charles III', CAST(N'2023-05-08' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (651, N'Spring bank holiday', CAST(N'2023-05-29' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (652, N'Battle of the Boyne (Orangemen’s Day)', CAST(N'2023-07-12' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (653, N'Summer bank holiday', CAST(N'2023-08-28' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (654, N'Christmas Day', CAST(N'2023-12-25' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (655, N'Boxing Day', CAST(N'2023-12-26' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (656, N'New Year’s Day', CAST(N'2024-01-01' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (657, N'St Patrick’s Day', CAST(N'2024-03-18' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (658, N'Good Friday', CAST(N'2024-03-29' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (659, N'Easter Monday', CAST(N'2024-04-01' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (660, N'Early May bank holiday', CAST(N'2024-05-06' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (661, N'Spring bank holiday', CAST(N'2024-05-27' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (662, N'Battle of the Boyne (Orangemen’s Day)', CAST(N'2024-07-12' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (663, N'Summer bank holiday', CAST(N'2024-08-26' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (664, N'Christmas Day', CAST(N'2024-12-25' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (665, N'Boxing Day', CAST(N'2024-12-26' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (666, N'New Year’s Day', CAST(N'2025-01-01' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (667, N'St Patrick’s Day', CAST(N'2025-03-17' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (668, N'Good Friday', CAST(N'2025-04-18' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (669, N'Easter Monday', CAST(N'2025-04-21' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (670, N'Early May bank holiday', CAST(N'2025-05-05' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (671, N'Spring bank holiday', CAST(N'2025-05-26' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (672, N'Battle of the Boyne (Orangemen’s Day)', CAST(N'2025-07-14' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (673, N'Summer bank holiday', CAST(N'2025-08-25' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (674, N'Christmas Day', CAST(N'2025-12-25' AS Date), N'northern-ireland')
INSERT [dbo].[Holidays] ([Id], [Name], [Date], [Region]) VALUES (675, N'Boxing Day', CAST(N'2025-12-26' AS Date), N'northern-ireland')
SET IDENTITY_INSERT [dbo].[Holidays] OFF
SET IDENTITY_INSERT [dbo].[Navigation] ON 

INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (1, N'Football', -1)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (2, N'Golf', -1)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (3, N'Rouch Racing', -1)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (4, N'Horse Racing', -1)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (5, N'Team', 1)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (6, N'Players', 5)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (7, N'Coaching Staff', 5)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (8, N'Medical Staff', 5)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (9, N'Stadium', 5)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (10, N'Training Ground', 5)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (11, N'Christiano Ronaldo', 6)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (12, N'Lionel Messi', 6)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (13, N'Paul Scholes', 6)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (14, N'Andries Iniesta', 6)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (15, N'Oliver Khan', 6)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (16, N'Luis Figo', 6)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (17, N'Robbie Fowler', 6)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (18, N'Alan Shearer', 6)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (19, N'Roy Keane', 6)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (20, N'Nemanja Vidic', 6)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (21, N'Zlatan Ibrahimovic', 6)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (22, N'Alex Ferguson', 7)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (23, N'Carlo Ancelotti', 7)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (24, N'Pep Guardiola', 7)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (25, N'Dr Joaquim Rodrigues', 8)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (26, N'Dr Viren Pillay', 8)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (27, N'Dr Martijn Vreugde', 8)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (28, N'Field', 9)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (29, N'Seats', 9)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (30, N'Roof', 9)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (31, N'Cameras', 9)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (32, N'Camera 1', 31)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (33, N'Camera 2', 31)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (34, N'Camera 3', 31)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (35, N'Camera 4', 31)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (36, N' Tommy Aaron', 2)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (37, N' Pat Abbott', 2)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (38, N' Ludvig Åberg', 2)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (39, N' Warren Abery', 2)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (40, N' Roach 1 ', 3)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (41, N' Roach 2 ', 3)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (42, N' Roach 3 ', 3)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (43, N' Roach 4 ', 3)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (44, N' Roach 5 ', 3)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (45, N' Roach 6 ', 3)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (46, N'Secretariat', 4)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (47, N' Man o'' War ', 4)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (48, N' Seattle Slew ', 4)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (49, N' Seabiscuit ', 4)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (50, N' Black Caviar ', 4)
INSERT [dbo].[Navigation] ([ID], [Text], [ParentID]) VALUES (51, N' Eclipse ', 4)
SET IDENTITY_INSERT [dbo].[Navigation] OFF
SET IDENTITY_INSERT [dbo].[Regions] ON 

INSERT [dbo].[Regions] ([Id], [Name]) VALUES (3, N'england-and-wales')
INSERT [dbo].[Regions] ([Id], [Name]) VALUES (4, N'scotland')
INSERT [dbo].[Regions] ([Id], [Name]) VALUES (5, N'northern-ireland')
SET IDENTITY_INSERT [dbo].[Regions] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [Username], [PasswordHash]) VALUES (1, N'TestUser', 0x8776F108E247AB1E2B323042C049C266407C81FBAD41BDE1E8DFC1BB66FD267E)
INSERT [dbo].[Users] ([UserId], [Username], [PasswordHash]) VALUES (2, N'TestUser1', 0x849F1575CCFBF3A4D6CF00E6C5641B7FD4DA2ED3E212C2D79BA9161A5A432FF0)
SET IDENTITY_INSERT [dbo].[Users] OFF
ALTER TABLE [dbo].[HolidayRegion]  WITH CHECK ADD FOREIGN KEY([HolidayId])
REFERENCES [dbo].[Holidays] ([Id])
GO
ALTER TABLE [dbo].[HolidayRegion]  WITH CHECK ADD FOREIGN KEY([RegionId])
REFERENCES [dbo].[Regions] ([Id])
GO
/****** Object:  StoredProcedure [dbo].[SaveBankHolidays]    Script Date: 2023/07/22 02:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SaveBankHolidays]
    @BankHolidays dbo.BankHolidayTypes READONLY
AS
BEGIN
    INSERT INTO Holidays (Name, Date, Region)
    SELECT Name, Date, Region
    FROM @BankHolidays;
END
GO
/****** Object:  StoredProcedure [dbo].[spt_CreateUser]    Script Date: 2023/07/22 02:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spt_CreateUser]
    @Username NVARCHAR(50),
    @PasswordHash VARBINARY(100) 
AS
BEGIN
    INSERT INTO Users (Username, PasswordHash)
    VALUES (@Username, @PasswordHash);
END
GO
/****** Object:  StoredProcedure [dbo].[spt_DeleteBankHolidaysForRegion]    Script Date: 2023/07/22 02:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spt_DeleteBankHolidaysForRegion]
    @RegionId INT
AS
BEGIN
    DELETE FROM RegionBankHolidays
    WHERE RegionId = @RegionId;
END
GO
/****** Object:  StoredProcedure [dbo].[spt_GetAllNavigations]    Script Date: 2023/07/22 02:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spt_GetAllNavigations]
AS
BEGIN
    SELECT * FROM Navigation;
END
GO
/****** Object:  StoredProcedure [dbo].[spt_GetAllRegions]    Script Date: 2023/07/22 02:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spt_GetAllRegions]
AS
BEGIN
    SELECT * FROM Regions;
END
GO
/****** Object:  StoredProcedure [dbo].[spt_GetBankHolidaysForRegion]    Script Date: 2023/07/22 02:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spt_GetBankHolidaysForRegion]
    @RegionId INT
AS
BEGIN
    SELECT * FROM RegionBankHolidays WHERE RegionId = @RegionId;
END
GO
/****** Object:  StoredProcedure [dbo].[spt_GetCachedCoinStats]    Script Date: 2023/07/22 02:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spt_GetCachedCoinStats]
AS
BEGIN
    SELECT TOP 1 *
    FROM CoinStats;
END
GO
/****** Object:  StoredProcedure [dbo].[spt_GetHashedPasswordByUsername]    Script Date: 2023/07/22 02:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spt_GetHashedPasswordByUsername]
    @Username NVARCHAR(50)
AS
BEGIN
    SELECT PasswordHash FROM Users WHERE Username = @Username;
END
GO
/****** Object:  StoredProcedure [dbo].[spt_GetHolidaysWithRegions]    Script Date: 2023/07/22 02:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spt_GetHolidaysWithRegions]
AS
BEGIN
    SELECT 
        h.Id AS HolidayId, 
        h.Name AS HolidayName, 
        h.Date AS HolidayDate, 
        r.Id AS RegionId, 
        r.Name AS RegionName
    FROM Holidays h
    LEFT JOIN HolidayRegion hr ON h.Id = hr.HolidayId
    LEFT JOIN Regions r ON hr.RegionId = r.Id;
END
GO
/****** Object:  StoredProcedure [dbo].[spt_GetRegionBankHolidays]    Script Date: 2023/07/22 02:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spt_GetRegionBankHolidays]
    @RegionId INT
AS
BEGIN
    SELECT *
    FROM RegionBankHolidays
    WHERE RegionId = @RegionId
END
GO
/****** Object:  StoredProcedure [dbo].[spt_GetRegionById]    Script Date: 2023/07/22 02:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spt_GetRegionById]
    @Id INT
AS
BEGIN
    SELECT * FROM Regions WHERE Id = @Id;
END
GO
/****** Object:  StoredProcedure [dbo].[spt_GetRegionByName]    Script Date: 2023/07/22 02:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spt_GetRegionByName]
    @Name NVARCHAR(255)
AS
BEGIN
    SELECT * FROM Regions WHERE Name = @Name;
END
GO
/****** Object:  StoredProcedure [dbo].[spt_GetUserByUsername]    Script Date: 2023/07/22 02:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spt_GetUserByUsername]
    @Username NVARCHAR(50)
AS
BEGIN
    SELECT * FROM Users WHERE Username = @Username;
END
GO
/****** Object:  StoredProcedure [dbo].[spt_InsertBankHolidaysForRegion]    Script Date: 2023/07/22 02:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spt_InsertBankHolidaysForRegion]
    @RegionId INT,
    @Name NVARCHAR(100),
    @Date DATE
AS
BEGIN
    INSERT INTO Holidays (Name, Date, Region)
    VALUES (@Name, @Date, @RegionId);
END
GO
/****** Object:  StoredProcedure [dbo].[spt_InsertRegion]    Script Date: 2023/07/22 02:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spt_InsertRegion]
    @Name NVARCHAR(100)
AS
BEGIN
    INSERT INTO Regions (Name)
    VALUES (@Name);
    SELECT CAST(SCOPE_IDENTITY() as int);
END
GO
/****** Object:  StoredProcedure [dbo].[spt_RegionsWithBankHolidays]    Script Date: 2023/07/22 02:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spt_RegionsWithBankHolidays]
    @RegionId INT,
    @Regions dbo.StringList READONLY
AS
BEGIN
    INSERT INTO RegionBankHolidays (RegionId, HolidayId)
    SELECT @RegionId, Id
    FROM Holidays
    WHERE Region IN (SELECT Item FROM @Regions);
END
GO
/****** Object:  StoredProcedure [dbo].[spt_SaveBankHolidays]    Script Date: 2023/07/22 02:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spt_SaveBankHolidays]
    @BankHolidays dbo.BankHolidayTypes READONLY
AS
BEGIN
    INSERT INTO Holidays (Name, Date, Region)
    SELECT Name, Date, Region
    FROM @BankHolidays;
END
GO
/****** Object:  StoredProcedure [dbo].[spt_SaveCoinStats]    Script Date: 2023/07/22 02:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spt_SaveCoinStats]
    @CoinName NVARCHAR(100),
    @Price DECIMAL(18, 2),
    @MarketCap DECIMAL(18, 2)
AS
BEGIN
    INSERT INTO CoinStats (CoinName, Price, MarketCap) 
    VALUES (@CoinName, @Price, @MarketCap);
END
GO
/****** Object:  StoredProcedure [dbo].[spt_UpdateRegion]    Script Date: 2023/07/22 02:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spt_UpdateRegion]
    @Id INT,
    @Name NVARCHAR(100)
AS
BEGIN
    UPDATE Regions
    SET Name = @Name
    WHERE Id = @Id;
END

GO
USE [master]
GO
ALTER DATABASE [KironTest] SET  READ_WRITE 
GO
