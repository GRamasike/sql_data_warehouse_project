CREATE OR ALTER PROCEDURE bronze.load_erp_bronze AS

	BEGIN
		DECLARE @start_time DATETIME , @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME ;
		BEGIN TRY
		SET @batch_start_time = GETDATE();
			PRINT'=================================';
			PRINT'Loading ERP Bronze Layer'
			PRINT'=================================';

			PRINT '--------------------------------';
			PRINT 'Load ERP Tables';
			PRINT '--------------------------------';

			SET @start_time = GETDATE();
			PRINT '>> Truncating Table: bronze.erp_cust_az12 ';
			TRUNCATE TABLE bronze.erp_cust_az12;

			PRINT '>> Inserting data into Table:bronze.erp_cust_az12';
			BULK INSERT bronze.erp_cust_az12
			FROM 'C:\Users\grama\OneDrive\Desktop\Data With B\dbc9660c89a3480fa5eb9bae464d6c07\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
			WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);

			SET @end_time = GETDATE();
			PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';
			PRINT '----------------------------------';

			SET @start_time = GETDATE();
			PRINT '>> Truncating Table: bronze.erp_loc_a101 ';
			TRUNCATE TABLE bronze.erp_loc_a101;

			PRINT '>> Inserting data into Table:bronze.erp_loc_a101';
			BULK INSERT bronze.erp_loc_a101
			FROM 'C:\Users\grama\OneDrive\Desktop\Data With B\LOC_A101.csv'
			WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
			PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';
			PRINT '----------------------------------';

			SET @start_time = GETDATE();
			PRINT '>> Truncating Table:bronze.erp_px_cat_g1v2';
			TRUNCATE TABLE bronze.erp_px_cat_g1v2;

			PRINT '>> Inserting data into Table:bronze.erp_px_cat_g1v2';
			BULK INSERT bronze.erp_px_cat_g1v2
			FROM 'C:\Users\grama\OneDrive\Desktop\Data With B\PX_CAT_G1V2.csv'
			WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
			PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';
			PRINT '----------------------------------';

			SET @batch_end_time = GETDATE();
			PRINT '===================================';
			PRINT 'Loading ERP Bronze Layer is complete ';
			PRINT '-Total Load Duration: ' + CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR) + ' seconds -';
			PRINT '===================================';


			END TRY

			BEGIN CATCH
			PRINT '=============================';
			PRINT 'Error during data load in bronze layer';
			PRINT 'Error Message' + Error_Message();
			PRINT 'Error Message' + CAST (Error_Number() AS NVARCHAR);
			END CATCH

	END