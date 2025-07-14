/*
============================
Create database and schemas
============================

Scripts Purpose:
	This script creates a new database named 'DataWareHouse' after checking if it already exists.
	If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas
	within the database: 'Bronze', 'Sliver' and 'Gold'.

WARNING:
	Running this script will drop the entire 'DataWarehouse' Database if it exists.
	All data in the database will be permanently deleted. Proceed with caution
	and ensure you have proper backups before running this script.

*/


-- Create Database 'DataWareHouse'
USE master

GO

--Drop and Recreate the 'Datawarehouse' Databse
IF EXISTS (SELECT 1 FROM sys.databases WHERE name='DataWareHouse')

BEGIN
	ALTER DATABASE DataWareHouse SET SIGNLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWareHouse;
END;
GO

--Create the 'DataWareHouse' Database

CREATE DATABASE DataWareHouse;
GO
USE DataWareHouse;
GO

--Create Schemas

CREATE SCHEMA Bronze;
GO
CREATE SCHEMA Silver;
GO
CREATE SCHEMA Gold;
GO

