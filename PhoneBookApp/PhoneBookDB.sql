CREATE DATABASE [PhoneBookDB]
GO

USE [PhoneBookDB]
GO

-- Должность
CREATE TABLE [dbo].[Role](
       [Id]       [int] IDENTITY(1,1) NOT NULL,
       [RoleName] [varchar](50) NOT NULL      
       CONSTRAINT [pkRole] PRIMARY KEY ([Id])
)
GO

-- Подразделение
CREATE TABLE [dbo].[Department](
       [Id]    [int] IDENTITY(1,1) NOT NULL,
       [DeptName] [varchar](50) NOT NULL     
       CONSTRAINT [pkDept] PRIMARY KEY ([Id])
)
GO

-- Сотрудник
CREATE TABLE [dbo].[Person](
       [Id]          [int] IDENTITY(1,1) NOT NULL,
	   [LastName]    [varchar](50) NOT NULL,
       [FirstName]   [varchar](50) NOT NULL,     
	   [SecondName]  [varchar](50),
       [RoleId]     [int] NOT NULL,
	   [DeptId]     [int] NOT NULL
       CONSTRAINT  [pkPerson] PRIMARY KEY ([Id]),
       CONSTRAINT  [fkRole] FOREIGN KEY ([RoleId])
                   REFERENCES  [dbo].[Role]([Id]),
	   CONSTRAINT  [fkDept] FOREIGN KEY ([DeptId])
                   REFERENCES  [dbo].[Department]([Id])
)
GO

-- Телефонный справочник
CREATE TABLE [dbo].[PhoneBook](
       [Id]        [int] IDENTITY(1,1) NOT NULL,
       [PersonId]  [int] NOT NULL,
       [Phone]  [varchar](20)
       CONSTRAINT  [pkPhoneBook] PRIMARY KEY ([Id]),
       CONSTRAINT  [fkPhoneBook] FOREIGN KEY([PersonId])
                   REFERENCES [dbo].[Person] ([Id])      
)
GO

INSERT INTO [dbo].[Role]([RoleName]) 
       VALUES ('Генеральный директор'),
              ('Начальник'),
              ('Инженер'),
              ('Ведущий инженер'),
              ('Диспетчер')
GO

INSERT INTO [dbo].[Department]([DeptName]) 
       VALUES ('Дирекция'),
              ('Юридический отдел'),
              ('Отдел ИТ'),
              ('Производство')              
GO

INSERT INTO [dbo].[Person]([LastName], [FirstName], [SecondName], [RoleId], [DeptId]) 
       VALUES ('Иванов', 'Иван', 'Иванович', 2, 2),
              ('Федоров', 'Геннадий', 'Павлович', 1, 1),
              ('Андреева', 'Елена', 'Викторовна', 5, 4),
              ('Анисимова', 'Виктория', 'Константиновна', 3, 3),
              ('Сергеев', 'Сильвестр', 'Андреевич', 4, 3)            
GO

-- Добавление новой записи
CREATE OR ALTER PROCEDURE [dbo].[spAddPhoneBook]
				 @LastName    varchar(50),
                 @FirstName   varchar(50), 
				 @SecondName  varchar(50),
				 @RoleName    varchar(50), 
                 @DeptName    varchar(50), 
                 @Phone       varchar(20) AS
BEGIN    
    DECLARE @Id as Int, @PersonId as Int, @RoleId as Int, @DeptId as Int;
	SET @RoleId = (SELECT Id
				   FROM [dbo].[Role]
				   WHERE RoleName = @RoleName);

	SET @DeptId = (SELECT Id
				   FROM [dbo].[Department]
				   WHERE DeptName = @DeptName);	
	
	MERGE INTO [dbo].[Person] as target
	USING (SELECT @FirstName as FirstName,
				  @LastName as LastName,
				  @SecondName as SecondName) as source
	ON (target.[FirstName] = source.FirstName AND target.[LastName] = source.LastName
		AND target.SecondName = source.SecondName)
	WHEN NOT MATCHED THEN
		INSERT (FirstName, LastName, SecondName, RoleId, DeptId)
		VALUES (@FirstName, @LastName, @SecondName, @RoleId, @DeptId);

	SET @PersonId = (SELECT Id
			   FROM [dbo].[Person]
			   WHERE FirstName = @FirstName
			     AND LastName = @LastName
				   AND SecondName = @SecondName);

	MERGE INTO [dbo].[PhoneBook] as target
	USING (SELECT @PersonId as PersonId,
				  @Phone as Phone) as source
	ON (target.PersonId = source.PersonId AND target.Phone = source.Phone)
	WHEN NOT MATCHED THEN
		INSERT (PersonId, Phone)
		VALUES (@PersonId, @Phone);

    SET @Id = (SELECT Id
			   FROM [dbo].[PhoneBook]
			   WHERE PersonId = @PersonId
			     AND Phone = @Phone);   
    SELECT @Id AS phoneId;
END
GO

-- Обновление существующей записи
CREATE OR ALTER PROCEDURE [dbo].[spUpdatePhoneBook]
				 @Id          int,
				 @LastName    varchar(50),
                 @FirstName   varchar(50), 
				 @SecondName  varchar(50),
				 @RoleName    varchar(50), 
                 @DeptName    varchar(50), 
                 @Phone       varchar(20) AS
BEGIN    
    DECLARE @PersonId as Int, @RoleId as Int, @DeptId as Int;
	SET @RoleId = (SELECT Id
				   FROM [dbo].[Role]
				   WHERE RoleName = @RoleName);

	SET @DeptId = (SELECT Id
				   FROM [dbo].[Department]
				   WHERE DeptName = @DeptName);

	SET @PersonId = (SELECT PersonId
					 FROM [dbo].[PhoneBook]
					 WHERE Id = @Id);
	
	UPDATE [dbo].[Person]
	SET FirstName = @FirstName,
		LastName = @LastName,
		SecondName = @SecondName,
		RoleId = @RoleId,
		DeptId = @DeptId
	WHERE Id = @PersonId;


	UPDATE [dbo].[PhoneBook]
	SET Phone = @Phone
	WHERE Id = @Id;
END
GO