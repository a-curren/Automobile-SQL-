/* ALEXIS CURREN EXAM 1: AUTO MANAGEMENT SYSTEM */ 
/* Making sure to have a clean environment like in the class exercise */
USE master;
GO 

DROP DATABASE IF EXISTS DealershipDB 
GO 

/* Creation of DealershipDB*/ 
CREATE DATABASE DealershipDB;
GO 

USE DealershipDB;
GO

/* Two logical schemas (Student Reference Week 5) */ 
/* sales: vehicle, availoptions, dealer, inventory newveh, usedveh, instoptions, sales, testdrive */
CREATE	SCHEMA [Sales] 
GO 

/*service: cust, custveh, servrec, routserv, repserv */ 
CREATE SCHEMA [Service] 
GO 

/* User defined data types Currency, inventoryCode,  VINType Student Reference week 5 */ 
/* CREAT TYPE Name  FROM Data Type; */
CREATE TYPE Currency FROM DECIMAL(10,4) NOT NULL; 
CREATE TYPE InventoryCode FROM CHAR(7) NOT NULL;
CREATE TYPE VIN_Type FROM CHAR(17) NOT NULL; 

/* Make sure to add the schema values Sales. & Services. | Remember its a container for the tables */ 
/* put inside of tables to make sure they follow within the table In-class Excercise weeek 4*/ 
CREATE TABLE Sales.INVENTORY ( 
	InventoryCode CHAR(7), 
	DealerNumber CHAR(4),
	VinNumber CHAR(17),
	NewOrUsed CHAR(1),
	DateArrivedAtDealership DATE,
	DateAvailableInStock DATE, 
	DateSold DATE, 
	ListedPrice DECIMAL(10,4) NOT NULL,
	ExteriorColor VARCHAR(10),
	InteriorColor VARCHAR(10), 
	VehicleCode CHAR(7), 
	AvailableForSale BIT, 
	);

CREATE TABLE Sales.DEALER (
	DealerNumber ChAR(4),
	DealerName VARCHAR(30), 
	StreetNumber CHAR(5), 
	StreetLine1 VARCHAR(200), 
	StreetLine2 VARCHAR(200), 
	City VARCHAR(50), 
	State CHAR(2), 
	ZipCode CHAR(5), 
	OpenDate DATE, 
	); 

CREATE TABLE Sales.VEHICLE (
	VehicleCode CHAR(4),
	Year CHAR(4), 
	Make VARCHAR(15), 
	Model VARCHAR(15), 
	TrimLine VARCHAR(4), 
	DataModelIntroduced DATE, 
	MSRP DECIMAL(10,4), 
	); 

CREATE TABLE Sales.SALES (
	InventoryCode CHAR(7), 
	CustomerNumber CHAR(8), 
	SalesPrice DECIMAL(10,4), 
	SalesDate DATE, 
	TaxAmount DECIMAL(10,4), 
	PaymentMethod CHAR(1), 
	); 

CREATE TABLE Sales.TESTDRIVE (
	TestDriveCode CHAR(7),
	CustomerNumber CHAR(8), 
	DateOfTestDrive DATETIME, 
	DurationOfTestDrive DECIMAL(10,4), 
	InventoryCode CHAR(7),
	); 

CREATE TABLE Sales.INSTOPTIONS (
	InventoryCode CHAR(7), 
	OptionCode CHAR(4), 
	DealerInstalledFlag BIT, 
	); 

CREATE TABLE Sales.NEWVEH (
	InventoryCode CHAR(7), 
	MSRP DECIMAL(10,4), 
	InvoicePrice DECIMAL (10,4), 
	DateShipped Date, 
	); 

CREATE TABLE Sales.USEDVEH (
	InventoryCode CHAR(7), 
	PurchaseDate DATE, 
	PurchasePrice DECIMAL(10,4), 
	Mileage INT, 
	BlueBookValue DECIMAL(10,4), 
	TradeInFlag BIT, 
	); 

CREATE TABLE Sales.AVAILOPTIONS (
	OptionCode CHAR(4), 
	OptionCost DECIMAL(10,4), 
	OptionMSRP DECIMAL(10,4), 
	OptionDescription VARCHAR(200),
	VehicleCode CHAR(7), 
	); 

CREATE TABLE Service.CUST (
	CustomerNumber CHAR(8),
	LastName VARCHAR(20),
	FirstName VARCHAR(20),
	StreetNumber CHAR(5), 
	StreetLine1 VARCHAR(200), 
	StreetLine2 VARCHAR(200), 
	City VARCHAR(50), 
	State CHAR(2), 
	ZipCode CHAR(5), 
	DriversLicense CHAR(10), 
	DateOfBirth DATE, 
	); 

CREATE TABLE Service.SERVREC (
	ServiceRecordNumber CHAR(8), 
	CustomerNumber CHAR(8), 
	VinNumber CHAR(17), 
	DealerNumber CHAR(4), 
	ServiceTypeCode CHAR(3), 
	DateBroughtIn DATETIME, 
	Mileage INT, 
	DateServiceCompleted DATETIME, 
	DateBilled DATETIME, 
	TotalServiceCost DECIMAL(10,4),
	); 

CREATE TABLE Service.CUSTVEH (
	CustomerNumber CHAR(8), 
	VinNumber CHAR(17), 
	VehicleCode CHAR(7), 
	FirstSeenDate DATE, 
	);

CREATE TABLE Service.ROUTSERV (
	ServiceRecordNumber CHAR(8), 
	ServiceTypeCode CHAR(3), 
	ListPrice DECIMAL(10,4), 
	Discount DECIMAL(10,4), 
	); 

CREATE TABLE Service.REPSERV (
	ServiceRecordNumber CHAR(8), 
	ServiceTypeCode CHAR(3), 
	PartsCost DECIMAL(10,4), 
	LaborHours DECIMAL(18,0), 
	LaborCost DECIMAL(10,4), 
	); 

/* Must do the NOT NULL values/ all primary keys before defining the Primary keys ALL SINGLE PRIMARY KEY NOT NULL COLUMNS */ 
ALTER TABLE Sales.INVENTORY ALTER COLUMN InventoryCode CHAR(7) NOT NULL;
ALTER TABLE Sales.DEALER ALTER COLUMN DealerNumber CHAR(4) NOT NULL; 
ALTER TABLE Sales.VEHICLE ALTER COLUMN VehicleCode CHAR(7) NOT NULL; 
ALTER TABLE Sales.TESTDRIVE ALTER COLUMN TestDriveCode CHAR(7) NOT NULL; 
ALTER TABLE Sales.AVAILOPTIONS ALTER COLUMN OptionCode CHAR(4) NOT NULL; 
ALTER TABLE Service.CUST ALTER COLUMN CustomerNumber CHAR(8) NOT NULL; 
ALTER TABLE Service.SERVREC ALTER COLUMN ServiceRecordNumber CHAR(8) NOT NULL;
ALTER TABLE Service.CUSTVEH ALTER COLUMN VinNumber CHAR(17) NOT NULL;

/* ALL Composite Key & Foreign Key NOT NULL COLUMNS */ 
ALTER TABLE Sales.INVENTORY ALTER COLUMN DealerNumber CHAR(4) NOT NULL;
ALTER TABLE Sales.INVENTORY ALTER COLUMN VehicleCode CHAR(7) NOT NULL;
ALTER TABLE Sales.SALES ALTER COLUMN InventoryCode CHAR(7) NOT NULL;
ALTER TABLE Sales.SALES ALTER COLUMN CustomerNumber CHAR(8) NOT NULL;
ALTER TABLE Sales.TESTDRIVE ALTER COLUMN CustomerNumber CHAR(8) NOT NULL;
ALTER TABLE Sales.TESTDRIVE ALTER COLUMN InventoryCode CHAR(7) NOT NULL;
ALTER TABLE Sales.INSTOPTIONS ALTER COLUMN InventoryCode CHAR(7) NOT NULL;
ALTER TABLE Sales.INSTOPTIONS ALTER COLUMN OptionCode CHAR(4) NOT NULL;
ALTER TABLE Sales.NEWVEH ALTER COLUMN InventoryCode CHAR(7) NOT NULL;
ALTER TABLE Sales.USEDVEH ALTER COLUMN InventoryCode CHAR(7) NOT NULL;
ALTER TABLE Sales.AVAILOPTIONS ALTER COLUMN VehicleCode CHAR(7) NOT NULL; 
ALTER TABLE Service.SERVREC ALTER COLUMN CustomerNumber CHAR(8) NOT NULL;
ALTER TABLE Service.SERVREC ALTER COLUMN VinNumber CHAR(17) NOT NULL;
ALTER TABLE Service.SERVREC ALTER COLUMN DealerNumber CHAR(4) NOT NULL;
ALTER TABLE Service.CUSTVEH ALTER COLUMN CustomerNumber CHAR(8) NOT NULL;
ALTER TABLE Service.CUSTVEH ALTER COLUMN VehicleCode CHAR(7) NOT NULL;
ALTER TABLE Service.ROUTSERV ALTER COLUMN ServiceRecordNumber CHAR(8) NOT NULL;
ALTER TABLE Service.REPSERV ALTER COLUMN ServiceRecordNumber CHAR(8) NOT NULL;

/* ALTER TABLE for all tables to include a primary first  pull syntax from in-class exercise from the understanding of unique, default, and check */ 
/* Follow system of ALTER TABLE SchemaName. TableName, after use ADD CONSTRAINT PK_TableName PRIMARY KEY (Column); */ 
ALTER TABLE Sales.INVENTORY
ADD CONSTRAINT PK_INVENTORY PRIMARY KEY (InventoryCode); 

ALTER TABLE Sales.DEALER
ADD CONSTRAINT PK_DEALER PRIMARY KEY (DealerNumber); 

ALTER TABLE Sales.VEHICLE 
ADD CONSTRAINT PK_VEHICLE PRIMARY KEY (VehicleCode); 

ALTER TABLE Sales.SALES
ADD CONSTRAINT PK_SALES PRIMARY KEY (InventoryCode, CustomerNumber); 

ALTER TABLE Sales.TESTDRIVE 
ADD CONSTRAINT PK_TESTDRIVE PRIMARY KEY (TestDriveCode);

ALTER TABLE Sales.INSTOPTIONS
ADD CONSTRAINT PK_INSTOPTIONS PRIMARY KEY (InventoryCode, OptionCode);

ALTER TABLE Sales.NEWVEH 
ADD CONSTRAINT PK_NEWVEH PRIMARY KEY (InventoryCode);

ALTER TABLE Sales.USEDVEH
ADD CONSTRAINT PK_USEDVEH PRIMARY KEY (InventoryCode);

ALTER TABLE Sales.AVAILOPTIONS 
ADD CONSTRAINT PK_AVAILOPTIONS PRIMARY KEY (OptionCode); 

ALTER TABLE Service.SERVREC
ADD CONSTRAINT PK_SERVREC PRIMARY KEY (ServiceRecordNumber);

ALTER TABLE Service.CUST
ADD CONSTRAINT PK_CUST PRIMARY KEY (CustomerNumber);

ALTER TABLE Service.CUSTVEH 
ADD CONSTRAINT PK_CUSTVEH PRIMARY KEY (CustomerNumber, VinNumber); 

ALTER TABLE Service.ROUTSERV
ADD CONSTRAINT PK_ROUTSERV PRIMARY KEY (ServiceRecordNumber);

ALTER TABLE Service.REPSERV
ADD CONSTRAINT PK_REPSERV PRIMARY KEY (ServiceRecordNumber); 

/* Reference all of the primary and composite keys as foreign keys in other tables for relation */ 
ALTER TABLE Sales.INVENTORY
ADD CONSTRAINT FK_INVENTORY_DEALER 
FOREIGN KEY (DealerNumber) REFERENCES Sales.DEALER(DealerNumber);

ALTER TABLE Sales.INVENTORY 
ADD CONSTRAINT FK_INVENTORY_VEHICLE 
FOREIGN KEY (VehicleCode) REFERENCES Sales.VEHICLE(VehicleCode);

ALTER TABLE Sales.SALES 
ADD CONSTRAINT FK_SALES_INVENTORY
FOREIGN KEY (InventoryCode) REFERENCES Sales.INVENTORY(InventoryCode);

ALTER TABLE Sales.SALES 
ADD CONSTRAINT FK_SALES_CUST
FOREIGN KEY (CustomerNumber) REFERENCES Service.CUST(CustomerNumber);

ALTER TABLE Sales.TESTDRIVE 
ADD CONSTRAINT FK_TESTDRIVE_CUST
FOREIGN KEY (CustomerNumber) REFERENCES Service.CUST(CustomerNumber);

ALTER TABLE Sales.TESTDRIVE 
ADD CONSTRAINT FK_TESTDIRVE_INVENTORY 
FOREIGN KEY (InventoryCode) REFERENCES Sales.INVENTORY(InventoryCode);

ALTER TABLE Sales.INSTOPTIONS 
ADD CONSTRAINT FK_INSTOPTIONS_INVENTORY 
FOREIGN KEY (InventoryCode) REFERENCES Sales.INVENTORY(InventoryCode);

ALTER TABLE Sales.INSTOPTIONS 
ADD CONSTRAINT FK_INSTOPTIONs_AVAILOPTIONS 
FOREIGN KEY (OptionCode) REFERENCES Sales.AVAILOPTIONS(OptionCode);

ALTER TABLE Sales.NEWVEH 
ADD CONSTRAINT FK_NEWVEH_INVENTORY
FOREIGN KEY (InventoryCode) REFERENCES Sales.INVENTORY(InventoryCode);

ALTER TABLE Sales.USEDVEH
ADD CONSTRAINT FK_USEDVEH_INVENTORY
FOREIGN KEY (InventoryCode) REFERENCES Sales.INVENTORY(InventoryCode);

ALTER TABLE Sales.AVAILOPTIONS 
ADD CONSTRAINT FK_AVAILOPTIONS_VEHICLE
FOREIGN KEY (VehicleCode) REFERENCES Sales.VEHICLE(VehicleCode);

ALTER TABLE Service.SERVREC
ADD CONSTRAINT FK_SERVREC_CUST
FOREIGN KEY (CustomerNumber) REFERENCES Service.CUST(CustomerNumber);

ALTER TABLE Service.SERVREC
ADD CONSTRAINT FK_SERVREC_CUSTVEH
FOREIGN KEY (CustomerNumber, VinNumber) REFERENCES Service.CUSTVEH(CustomerNumber, VinNumber);

ALTER TABLE Service.SERVREC
ADD CONSTRAINT FK_SERVREC_DEALER 
FOREIGN KEY (DealerNumber) REFERENCES Sales.DEALER(DealerNumber);

ALTER TABLE Service.CUSTVEH
ADD CONSTRAINT FK_CUSTVEH_CUST
FOREIGN KEY (CustomerNumber) REFERENCES Service.CUST(CustomerNumber);

ALTER TABLE Service.CUSTVEH
ADD CONSTRAINT FK_CUSTVEH_VEHICLE
FOREIGN KEY (VehicleCode) REFERENCES Sales.VEHICLE(VehicleCode);

ALTER TABLE Service.ROUTSERV
ADD CONSTRAINT FK_ROUTSERV_SERVREC
FOREIGN KEY (ServiceRecordNumber) REFERENCES Service.SERVREC(ServiceRecordNumber);

ALTER TABLE Service.REPSERV
ADD CONSTRAINT FK_REPSERV_SERVREC
FOREIGN KEY (ServiceRecordNumber) REFERENCES Service.SERVREC(ServiceRecordNumber);

/* Unique constraints vin,license; default for available for sale, new or use, and sale date */
/* in class exercise and constraints ppt to review the syntax */ 
ALTER TABLE Sales.INVENTORY
ADD CONSTRAINT UQ_INVENTORY_VIN
UNIQUE (VinNumber);

ALTER TABLE Service.CUST
ADD CONSTRAINT UQ_CUST_DRIVERSLICENSE
UNIQUE (DriversLicense);

/* Default constraints make sure to have the values to help understanding */
ALTER TABLE Sales.INVENTORY
ADD CONSTRAINT DF_INVENTORY_AVAILABLEFORSALE
/* 1 means true and 0 means false */
DEFAULT (1) FOR AvailableForSale;

ALTER TABLE Sales.INVENTORY
ADD CONSTRAINT DF_INVENTORY_NEWORUSED
/* N means New as the default for those split tables */
DEFAULT ('N') FOR NewOrUsed;

ALTER TABLE Sales.SALES
ADD CONSTRAINT DF_SALES_SALESDATE
DEFAULT (GETDATE()) FOR SalesDate;

/* Business logic/ check constraints to make sure everything is complaint */ 
ALTER TABLE Sales.INVENTORY
ADD CONSTRAINT CHK_VIN_LENGTH
CHECK (LEN(VinNumber) = 17);

ALTER TABLE Sales.INVENTORY
ADD CONSTRAINT CHK_INVENTORY_DEPENDENCY
CHECK (NOT (DateSold IS NOT NULL AND AvailableForSale = 1));

ALTER TABLE Service.CUST
ADD CONSTRAINT CHK_CUST_AGE
CHECK (DATEDIFF(YEAR, DateOfBirth, GETDATE()) >= 18);

ALTER TABLE Service.SERVREC
ADD CONSTRAINT CHK_SERVREC_DATES
CHECK (DateServiceCompleted >= DateBroughtIn);

/* Bulk Insert make sure to do the parent tables before doing the child tables to make sure the relationship works */
BULK INSERT Sales.VEHICLE 
FROM "C:\Users\ALEXI\Desktop\EXAM 1 FILES\vehicle (1).csv"
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', FIRSTROW = 1);

BULK INSERT Service.CUST 
FROM "C:\Users\ALEXI\Desktop\EXAM 1 FILES\customers (2).csv"
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', FIRSTROW = 1);

INSERT INTO Sales.DEALER
(DealerNumber, DealerName, StreetNumber, StreetLine1, StreetLine2, City, State, ZipCode, OpenDate)
VALUES
('D001', 'AutoNation', '100', '123 Main St', NULL, 'Atlanta', 'GA', '30301', '2000-01-01'),
('D002', 'CarMax', '200', '456 Oak Ave', NULL, 'Dallas', 'TX', '75201', '2005-06-15'),
('D003', 'Hendrick', '300', '789 Pine Rd', NULL, 'Charlotte', 'NC', '28201', '1998-03-20');

BULK INSERT Sales.INVENTORY 
FROM "C:\Users\ALEXI\Desktop\EXAM 1 FILES\inventory.csv"
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', FIRSTROW = 1);

INSERT INTO Sales.AVAILOPTIONS 
(OptionCode, OptionCost, OptionMSRP, OptionDescription,VehicleCode)
VALUES 
('OPT1', 500.0000, 750.0000, 'Sunroof', 'VEH0001'),
('OPT2', 300.0000, 450.0000, 'Heated Seats', 'VEH0002'),
('OPT3', 200.0000, 350.0000, 'Backup Camera', 'VEH0003'),
('OPT4', 400.0000, 600.0000, 'Navigation', 'VEH0004'),
('OPT5', 150.0000, 250.0000, 'Floor Mats', 'VEH0005');

INSERT INTO Service.CUSTVEH
(CustomerNumber, VinNumber, VehicleCode, FirstSeenDate)
VALUES
('CUST0001', '11111111111111111', 'VEH0001', '2024-01-20'),
('CUST0002', '22222222222222222', 'VEH0002', '2024-02-05'),
('CUST0003', '33333333333333333', 'VEH0003', '2024-02-15'),
('CUST0004', '44444444444444444', 'VEH0004', '2024-03-01'),
('CUST0005', '55555555555555555', 'VEH0005', '2024-03-10');

INSERT INTO Sales.NEWVEH
(InventoryCode, MSRP, InvoicePrice, DateShipped)
VALUES
('INV0001', 45000.0000, 42000.0000, '2024-01-10'),
('INV0002', 28000.0000, 25000.0000, '2024-01-15'),
('INV0003', 47000.0000, 44000.0000, '2024-02-01'),
('INV0005', 42000.0000, 39000.0000, '2024-02-20'),
('INV0007', 30000.0000, 27000.0000, '2024-03-10');

INSERT INTO Sales.USEDVEH
(InventoryCode, PurchaseDate, PurchasePrice, Mileage, BlueBookValue, TradeInFlag)
VALUES
('INV0004', '2022-06-01', 18000.0000, 32000, 19500.0000, 0),
('INV0006', '2021-11-15', 22000.0000, 45000, 23000.0000, 1),
('INV0008', '2023-01-20', 15000.0000, 28000, 16000.0000, 0);

INSERT INTO Sales.INSTOPTIONS
(InventoryCode, OptionCode, DealerInstalledFlag)
VALUES
('INV0001', 'OPT1', 1),
('INV0002', 'OPT2', 0),
('INV0003', 'OPT3', 1),
('INV0005', 'OPT4', 1),
('INV0007', 'OPT5', 0);

INSERT INTO Sales.TESTDRIVE
(TestDriveCode, CustomerNumber, DateOfTestDrive, DurationOfTestDrive, InventoryCode)
VALUES
('TD00001', 'CUST0001', '2024-03-01 10:00:00', 1, 'INV0001'),
('TD00002', 'CUST0002', '2024-03-02 14:00:00', 2, 'INV0002'),
('TD00003', 'CUST0003', '2024-03-09 11:00:00', 1, 'INV0003'),
('TD00004', 'CUST0004', '2024-03-16 09:00:00', 1, 'INV0005'),
('TD00005', 'CUST0005', '2024-03-23 13:00:00', 2, 'INV0007');

BULK INSERT Sales.SALES
FROM "C:\Users\ALEXI\Desktop\EXAM 1 FILES\sales (1).csv"
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', FIRSTROW = 1);

BULK INSERT Service.SERVREC
FROM "C:\Users\ALEXI\Desktop\EXAM 1 FILES\servrec (1).csv"
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', FIRSTROW = 1);

INSERT INTO Service.ROUTSERV
(ServiceRecordNumber, ServiceTypeCode, ListPrice, Discount)
VALUES
('SREC0001', 'R01', 150.0000, 10.0000),
('SREC0002', 'R02', 200.0000, 15.0000),
('SREC0004', 'R03', 100.0000, 5.0000),
('SREC0006', 'R01', 150.0000, 10.0000),
('SREC0007', 'R02', 200.0000, 15.0000);

INSERT INTO Service.REPSERV
(ServiceRecordNumber, ServiceTypeCode, PartsCost, LaborHours, LaborCost)
VALUES
('SREC0003', 'P01', 500.0000, 3, 300.0000),
('SREC0005', 'P02', 750.0000, 5, 500.0000),
('SREC0008', 'P03', 250.0000, 2, 200.0000);

GO
/* Creation of the view using the view lecture slides */ 
CREATE OR ALTER VIEW Sales.vw_AvailableInventory
AS
SELECT 
	v.Year,
	v.Make,
	v.Model,
	i.ListedPrice
FROM Sales.INVENTORY i 
JOIN Sales.VEHICLE v ON i.VehicleCode = v.VehicleCode
WHERE i.AvailableForSale = 1;
GO

GO
CREATE VIEW Service.vw_CustomerVehicleHistory
AS 
SELECT 
	c.CustomerNumber,
	c.LastName,
	c.FirstName,
	c.City,
	c.State,
	cv.VinNumber,
	cv.FirstSeenDate,
	v.Year,
	v.Make,
	v.Model
FROM Service.CUST c 
JOIN Service.CUSTVEH cv ON c.CustomerNumber = cv.CustomerNumber
JOIN Sales.VEHICLE v ON cv.VehicleCode = v.VehicleCode
GO

/* Analytical Business Reporting*/ 

/* Market Research to find Ford or Toyota models that are available in inventory under 35grand */
SELECT Year, Make, Model, ListedPrice
FROM Sales.vw_AvailableInventory
WHERE (Make = 'Ford' or Make = 'Toyota')
AND ListedPrice < 35000;

/* City Analytics for total sales count and avg price per customer city (where count> 2) */
SELECT 
	c.City, 
	COUNT(s.InventoryCode) AS TotalSales, 
	AVG (s.SalesPrice) AS AvgSalesPrice 
FROM Sales.SALES s 
JOIN Service.CUST c ON s.CustomerNumber = c.CustomerNumber
GROUP BY c.City
HAVING COUNT(s.InventoryCode) > 2; 

/* Revenue for total revenue and tax per payment_method for the past year */
SELECT 
	PaymentMethod, 
	SUM(SalesPrice) AS TotalRevenue, 
	SUM(TaxAmount) AS TotalTax
FROM Sales.SALES
WHERE YEAR(SalesDate) = YEAR(GETDATE()) -1 
GROUP BY PaymentMethod;

/* Loyalty to find customer last name with >1 service record */ 
SELECT 
	c.LastName, 
	COUNT(sr.ServiceRecordNumber) AS ServiceCount
FROM Service.CUST c
JOIN Service.SERVREC sr ON c.CustomerNumber = sr.CustomerNumber
GROUP BY c.LastName
HAVING COUNT(sr.ServiceRecordNumber) >1;

/* Pattern search to find the avg cost for services where service_type_code starts with R dont forget the wildcards */
SELECT 
	ServiceTypeCode, 
	AVG(TotalServiceCost) AS AvgCost
FROM Service.SERVREC
WHERE ServiceTypeCode LIKE '%R%'
GROUP BY ServiceTypeCode;


/* Test drive logic to find distinct count of customers who test drove on weekends in the past 6 months */
SELECT COUNT(DISTINCT CustomerNumber) AS WeekendTestDrivers
FROM Sales.TESTDRIVE 
WHERE DATEPART(WEEKDAY, DateOfTestDrive) IN (1,7)
AND DATEDIFF(MONTH, DateOfTestDrive, GETDATE()) <=6;

/* mileage tiers to find the count used for vehicle mileage when purchased by the dealer in the past 2 years */
SELECT COUNT(*) AS UsedVehicleCount
FROM Sales.USEDVEH
WHERE Mileage BETWEEN 10000 AND 50000 
AND DATEDIFF(YEAR, PurchaseDate, GETDATE()) <= 2;




