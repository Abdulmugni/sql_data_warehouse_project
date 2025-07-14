/*
==========================================================================================
Stored Procedure: Load Bronze Layer (Source->Bronze)
==========================================================================================
Script Purpose:
	This stored procedure loads data into the 'bronze' schema from external csv files.
	It performs the following actions:
		- Truncates the bronze tables before loading data.
		- Uses the `BULK INSERT` command to load data from csv files to bronze tables.
	
Parameters:
	None.
	This store Procedure does not accept any parameters or return any values.


Usage Example:
	EXEC bronze.load_bronze;

==========================================================================================
*/

CREATE OR ALTER PROCEDURE Bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME , @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '======================';
		PRINT 'Loading Bronze Layer';
		PRINT '======================';

		PRINT '----------------------';
		PRINT 'Loading CRM Tables';
		PRINT '----------------------';

		SET @start_time = GETDATE();

		PRINT 'Truncating Table : Bronze.crm_cust_info';
		TRUNCATE TABLE Bronze.crm_cust_info;

		PRINT 'Inserting data into : Bronze.crm_cust_info';
		BULK INSERT Bronze.crm_cust_info
			FROM 'D:\SQL 2025\sql-data-warehouse-project\GitRepo\sql_data_warehouse_project\dataset\source_crm\cust_info.csv'
		WITH 
			(
				FIRSTROW =2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
		SET @end_time = GETDATE();
		PRINT ' Load Duration : '+ CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR)+ ' Seconds';
		PRINT '------------------------------------------------------------------';	
	
		SET @start_time = GETDATE();
		PRINT 'Truncating Table : Bronze.crm_prd_info';

		TRUNCATE TABLE Bronze.crm_prd_info;
		PRINT 'Inserting data into : Bronze.crm_prd_info';
		BULK INSERT Bronze.crm_prd_info
			FROM 'D:\SQL 2025\sql-data-warehouse-project\GitRepo\sql_data_warehouse_project\dataset\source_crm\prd_info.csv'
		WITH
			(
				FIRSTROW =2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);

		SET @end_time = GETDATE();
		PRINT ' Load Duration : '+ CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR)+ ' Seconds';
		PRINT '------------------------------------------------------------------';	

		SET @start_time = GETDATE();
		PRINT 'Truncating Table : Bronze.crm_sales_details';

		TRUNCATE TABLE Bronze.crm_sales_details;
		PRINT 'Inserting data into : Bronze.crm_sales_details';
		BULK INSERT Bronze.crm_sales_details
			FROM 'D:\SQL 2025\sql-data-warehouse-project\GitRepo\sql_data_warehouse_project\dataset\source_crm\sales_details.csv'
		WITH
			(
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);

		SET @end_time = GETDATE();
		PRINT ' Load Duration : '+ CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR)+ ' Seconds';
		

		PRINT '----------------------';
		PRINT 'Loading CRM Tables';
		PRINT '----------------------';

		SET @start_time = GETDATE();
		PRINT 'Truncating Table : Bronze.erp_loc_a101';
		TRUNCATE TABLE Bronze.erp_loc_a101;
		PRINT 'Inserting data into : Bronze.erp_loc_a101';
		BULK INSERT Bronze.erp_loc_a101
			FROM 'D:\SQL 2025\sql-data-warehouse-project\GitRepo\sql_data_warehouse_project\dataset\source_erp\loc_a101.csv'
		WITH
			(
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);

		SET @end_time = GETDATE();
		PRINT ' Load Duration : '+ CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR)+ ' Seconds';
		PRINT '------------------------------------------------------------------';	
		
		SET @start_time = GETDATE();
		PRINT 'Truncating Table : Bronze.erp_cust_az12';
		TRUNCATE TABLE Bronze.erp_cust_az12;
		PRINT 'Inserting data into : Bronze.erp_cust_az12';
		BULK INSERT Bronze.erp_cust_az12 
			FROM 'D:\SQL 2025\sql-data-warehouse-project\GitRepo\sql_data_warehouse_project\dataset\source_erp\cust_az12.csv'
		WITH
			(
				FIRSTROW =2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
		
		SET @end_time = GETDATE();
		PRINT ' Load Duration : '+ CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR)+ ' Seconds';
		PRINT '------------------------------------------------------------------';	

		SET @start_time = GETDATE();
		PRINT 'Truncating Table : Bronze.erp_px_cat_g1v2';

		TRUNCATE TABLE Bronze.erp_px_cat_g1v2;
		PRINT 'Inserting data into : Bronze.erp_px_cat_g1v2';
		BULK INSERT Bronze.erp_px_cat_g1v2
			FROM 'D:\SQL 2025\sql-data-warehouse-project\GitRepo\sql_data_warehouse_project\dataset\source_erp\px_cat_g1v2.csv'
		WITH
			(
				FIRSTROW =2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
		SET @end_time = GETDATE();
		PRINT ' Load Duration : '+ CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR)+ ' Seconds';
		PRINT '------------------------------------------------------------------';	

		SET @batch_end_time = GETDATE();

		PRINT '==============================================================================================';
		PRINT 'Loading Bronze Layer is Completed';
		PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND,@batch_start_time,@batch_end_time) AS NVARCHAR) +' Seconds';
		PRINT '==============================================================================================';
	END TRY
	BEGIN CATCH
		PRINT '==========================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message ' + ERROR_MESSAGE();
		PRINT 'Error Number ' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error State ' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '==========================================';
		
	END CATCH
END