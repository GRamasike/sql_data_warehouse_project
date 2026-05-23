CREATE OR ALTER PROCEDURE bronze.load_crm_bronze AS

BEGIN 
DECLARE @start_time DATETIME , @end_time DATETIME ,@batch_start_time DATETIME, @batch_end_time DATETIME ;

SET @batch_start_time = GETDATE();

PRINT '=========================';
PRINT 'Loading CRM Bronze Layer';
PRINT '==========================';

PRINT '-----------------------------';
PRINT 'Load CRM Tables' ;
PRINT '-----------------------------';

BEGIN TRY
SET @start_time = GETDATE();
PRINT '>> Trancating Table:bronze.crm_cust_info ';
TRUNCATE TABLE bronze.crm_cust_info;

PRINT '>> Inserting data into Table : bronze.crm_cust_info ';
BULK INSERT bronze.crm_cust_info
FROM 'C:\Users\grama\OneDrive\Desktop\Data With B\cust_info.csv'
WITH(
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);
SET @end_time = GETDATE();
PRINT '>> Load Duration ' + CAST (DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';


PRINT '-------------------------------------';
PRINT '>> Trancating Table:bronze.crm_prd_info ';
SET @start_time = GETDATE();
TRUNCATE TABLE bronze.crm_prd_info;

PRINT '>> Inserting data into Table : bronze.crm_prd_info ';
BULK INSERT bronze.crm_prd_info
FROM 'C:\Users\grama\OneDrive\Desktop\Data With B\prd_info.csv'
WITH(
FIRSTROW = 2 ,
FIELDTERMINATOR = ',',
TABLOCK
);

SET @end_time = GETDATE();
PRINT '>> Load Duration : ' + CAST (DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';
PRINT '----------------------------------------';
--Sales details
PRINT '>> Truncating Table bronze.crm_sales_details '
SET @start_time = GETDATE();
TRUNCATE TABLE bronze.crm_sales_details;

PRINT '>> Inserting data into Table: bronze.crm_sales_details '
BULK INSERT bronze.crm_sales_details
FROM 'C:\Users\grama\OneDrive\Desktop\Data With B\sales_details.csv'
WITH(
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);

SET @end_time = GETDATE ();
PRINT 'Load Duration: ' + CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
PRINT '---------------------------------------------------';

SET @batch_end_time = GETDATE();
PRINT'=====================================================';
PRINT 'Loading CRM data is complete';
PRINT 'Total Load Duration : ' + CAST (DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR) + ' second';
PRINT '======================================================';
END TRY


BEGIN CATCH
PRINT '==============================';
PRINT 'Error during loading crm data';
PRINT 'Error Message :' + Error_Message();
PRINT 'Error Number : ' + CAST (Error_Number() AS NVARCHAR ); 
PRINT '===============================';
END CATCH

END;
