--Create Table ERP Tables

IF OBJECT_ID ('bronze.erp_cust_az12') IS NULL

BEGIN
CREATE TABLE bronze.erp_cust_az12(
cid NVARCHAR (50),
bdate DATE,
gen NVARCHAR(50)
)
END

SELECT *
FROM bronze.erp_cust_az12;

IF OBJECT_ID ('bronze.erp_loc_a101') IS NULL

BEGIN
CREATE TABLE bronze.erp_loc_a101(
cid NVARCHAR (50),
cntry NVARCHAR (50)
)
END

SELECT *
FROM bronze.erp_loc_a101;

IF OBJECT_ID ('bronze.erp_px_cat_g1v2') IS NULL

BEGIN
CREATE TABLE bronze.erp_px_cat_g1v2(
id NVARCHAR (50),
cat NVARCHAR (50),
subcat NVARCHAR (50),
maintenance NVARCHAR (50)
)
END

SELECT *
FROM bronze.erp_px_cat_g1v2;