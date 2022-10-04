-- Создание базы данных
USE master 

-- Если есть БД с заданным именем,
-- то удаляем и создаем новую
IF DB_ID('AutorepairShop') IS NOT NULL
	alter database AutorepairShop set single_user with rollback immediate
	DROP DATABASE AutorepairShop;

CREATE DATABASE AutorepairShop;

GO

USE AutorepairShop;

-- Создание таблиц
-- Таблица названия должностей(квалификация) для механиков
CREATE TABLE dbo.Qualifications(
	QualificationId int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Name nvarchar(50) NOT NULL,
	Salary int NOT NULL
	)
-- Таблица механики
CREATE TABLE dbo.Mechanics(
	MechanicId int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	FirstName nvarchar(20) NOT NULL,
	MiddleName nvarchar(30) NOT NULL,
	LastName nvarchar(30) NOT NULL,
	QualificationId int NOT NULL,
	Experience int NOT NULL,

	FOREIGN KEY (QualificationId)
	REFERENCES Qualifications(QualificationId)
	ON DELETE CASCADE
	ON UPDATE CASCADE 
	)
-- Таблица владельцы авто
CREATE TABLE dbo.Owners(
	OwnerId int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	FirstName nvarchar(20) NOT NULL,
	MiddleName nvarchar(30) NOT NULL,
	LastName nvarchar(30) NOT NULL,
	DriverLicenseNumber int NOT NULL,
	Address nvarchar(60) NOT NULL,
	Phone bigint NOT NULL
	)
-- Таблица автомобилей
CREATE TABLE dbo.Cars(
	CarId int IDENTITY(1,1) NOT NULL PRIMARY KEY, 
	Brand nvarchar(50) NOT NULL,
	Power int NOT NULL,
	Color nvarchar(20) NOT NULL,
	StateNumber nvarchar(10) NOT NULL,
	OwnerId int NOT NULL,
	Year int NOT NULL, 
	VIN nvarchar(20) NOT NULL,
	EngineNumber nvarchar(20) NOT NULL,
	AdmissionDate date NOT NULL,

	FOREIGN KEY (OwnerId)
	REFERENCES Owners(OwnerId)
	ON DELETE CASCADE
	ON UPDATE CASCADE 
	)
-- Таблица платежей
CREATE TABLE dbo.Payments(
	PaymentId int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	CarId int NOT NULL,
	Date date NOT NULL,
	Cost int NOT NULL,
	MechanicId int NOT NULL,
	ProgressReport nvarchar(50),
	
	FOREIGN KEY (CarId)
	REFERENCES Cars(CarId)
	ON DELETE CASCADE
	ON UPDATE CASCADE,

	FOREIGN KEY (MechanicId)
	REFERENCES Mechanics(MechanicId)
	ON DELETE CASCADE
	ON UPDATE CASCADE
	)