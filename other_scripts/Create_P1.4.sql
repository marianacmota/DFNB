/*****************************************************************************************************************
NAME:    Create_P1.4
PURPOSE: Create Project 1.4

SUPPORT: Jaussi Consulting LLC
         www.jaussiconsulting.net
         jon@jaussiconsulting.net

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       11/02/2019   JJAUSSI      1. Built this script  for LDS BC IT 240


RUNTIME: 
30 sec

NOTES: 
This script is the final solution for Project 1.4: Create v1 of Prototype Script. It is designed so you can
run the entire script (F5) repeatedly 

LICENSE: 
This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.

******************************************************************************************************************/


-- 0) Drop contraints

IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblBranchDim_region_id_tblRegionDim_region_id'
           AND parent_object_id = OBJECT_ID(N'dbo.tblBranchDim')
)
    BEGIN

        ALTER TABLE dbo.tblBranchDim DROP CONSTRAINT FK_tblBranchDim_region_id_tblRegionDim_region_id;

END;


IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblBranchDim_area_id_tblAreaDim_area_id'
           AND parent_object_id = OBJECT_ID(N'dbo.tblBranchDim')
)
    BEGIN

        ALTER TABLE dbo.tblBranchDim DROP CONSTRAINT FK_tblBranchDim_area_id_tblAreaDim_area_id;

END;


IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblAccountCustomerDim_acct_cust_role_id_tblAccountCustomerRoleDim_acct_cust_role_id'
           AND parent_object_id = OBJECT_ID(N'dbo.tblAccountCustomerDim')
)
    BEGIN

        ALTER TABLE dbo.tblAccountCustomerDim DROP CONSTRAINT FK_tblAccountCustomerDim_acct_cust_role_id_tblAccountCustomerRoleDim_acct_cust_role_id;

END;


IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblAccountCustomerDim_cust_id_tblCustomerDim_cust_id'
           AND parent_object_id = OBJECT_ID(N'dbo.tblAccountCustomerDim')
)
    BEGIN

        ALTER TABLE dbo.tblAccountCustomerDim DROP CONSTRAINT FK_tblAccountCustomerDim_cust_id_tblCustomerDim_cust_id;

END;


IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblAccountCustomerDim_acct_id_tblAccountDim_acct_id'
           AND parent_object_id = OBJECT_ID(N'dbo.tblAccountCustomerDim')
)
    BEGIN

        ALTER TABLE dbo.tblAccountCustomerDim DROP CONSTRAINT FK_tblAccountCustomerDim_acct_id_tblAccountDim_acct_id;

END;


IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblBranchDim_branch_add_id_tblAddressDim_add_id'
           AND parent_object_id = OBJECT_ID(N'dbo.tblBranchDim')
)
    BEGIN

        ALTER TABLE dbo.tblBranchDim DROP CONSTRAINT FK_tblBranchDim_branch_add_id_tblAddressDim_add_id;

END;


IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblCustomerDim_pri_branch_id_tblBranchDim_branch_id'
           AND parent_object_id = OBJECT_ID(N'dbo.tblCustomerDim')
)
    BEGIN

        ALTER TABLE dbo.tblCustomerDim DROP CONSTRAINT FK_tblCustomerDim_pri_branch_id_tblBranchDim_branch_id;

END;


IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblAccountDim_branch_id_tblBranchDim_branch_id'
           AND parent_object_id = OBJECT_ID(N'dbo.tblAccountDim')
)
    BEGIN

        ALTER TABLE dbo.tblAccountDim DROP CONSTRAINT FK_tblAccountDim_branch_id_tblBranchDim_branch_id;

END;


IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblAccountFact_acct_id_tblAccountDim_acct_id'
           AND parent_object_id = OBJECT_ID(N'dbo.tblAccountFact')
)
    BEGIN

        ALTER TABLE dbo.tblAccountFact DROP CONSTRAINT FK_tblAccountFact_acct_id_tblAccountDim_acct_id;

END;


IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblAccountDim_prod_id_tblProductDim_prod_id'
           AND parent_object_id = OBJECT_ID(N'dbo.tblAccountDim')
)
    BEGIN

        ALTER TABLE dbo.tblAccountDim DROP CONSTRAINT FK_tblAccountDim_prod_id_tblProductDim_prod_id;

END;


IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblAccountDim_branch_id_tblBranchDim_branch_id'
           AND parent_object_id = OBJECT_ID(N'dbo.tblAccountDim')
)
    BEGIN

        ALTER TABLE dbo.tblAccountDim DROP CONSTRAINT FK_tblAccountDim_branch_id_tblBranchDim_branch_id;

END;


IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblAccountDim_pri_cust_id_tblCustomerDim_cust_id'
           AND parent_object_id = OBJECT_ID(N'dbo.tblAccountDim')
)
    BEGIN

        ALTER TABLE dbo.tblAccountDim DROP CONSTRAINT FK_tblAccountDim_pri_cust_id_tblCustomerDim_cust_id;

END;







-- 1) Create the empty table shells

-- 1.1) Account Customer Dimension

IF OBJECT_ID('dbo.tblAccountCustomerDim', 'U') IS NOT NULL
    BEGIN
        DROP TABLE dbo.tblAccountCustomerDim;
END; 

SELECT s.acct_id
     , s.cust_id
     , s.acct_cust_role_id
INTO dbo.tblAccountCustomerDim
  FROM dbo.stg_p1 AS s
 WHERE 1 = 2;



-- 1.2) Account Customer Role Dimension

IF OBJECT_ID('dbo.tblAccountCustomerRoleDim', 'U') IS NOT NULL
    BEGIN
        DROP TABLE dbo.tblAccountCustomerRoleDim;
END; 

SELECT s.acct_cust_role_id
     , CAST('Unknown' AS VARCHAR(50)) AS acct_cust_role_desc
INTO dbo.tblAccountCustomerRoleDim
  FROM dbo.stg_p1 AS s
 WHERE 1 = 2;



-- 1.3) Account Dimension

IF OBJECT_ID('dbo.tblAccountDim', 'U') IS NOT NULL
    BEGIN
        DROP TABLE dbo.tblAccountDim;
END; 

SELECT s.acct_id2 AS acct_id
     , s.prod_id
     , s.open_date
     , s.close_date
     , s.open_close_code
     , s.branch_id
     , s.pri_cust_id
     , s.loan_amt
INTO dbo.tblAccountDim
  FROM dbo.stg_p1 AS s
 WHERE 1 = 2;



-- 1.4) Branch Dimension

IF OBJECT_ID('dbo.tblBranchDim', 'U') IS NOT NULL
    BEGIN
        DROP TABLE dbo.tblBranchDim;
END; 

SELECT s.acct_branch_id AS branch_id
     , s.acct_branch_code AS branch_code
     , s.acct_branch_desc AS branch_desc
     , s.acct_branch_add_id AS branch_add_id
     , s.acct_region_id AS region_id
     , s.acct_area_id AS area_id
INTO dbo.tblBranchDim
  FROM dbo.stg_p1 AS s
 WHERE 1 = 2;



-- 1.5) Region Dimension

IF OBJECT_ID('dbo.tblRegionDim', 'U') IS NOT NULL
    BEGIN
        DROP TABLE dbo.tblRegionDim;
END; 

SELECT s.acct_region_id AS region_id
     , CAST('Unknown' AS VARCHAR(50)) AS region_desc
INTO dbo.tblRegionDim
  FROM dbo.stg_p1 AS s
 WHERE 1 = 2;



-- 1.6) Area Dimension

IF OBJECT_ID('dbo.tblAreaDim', 'U') IS NOT NULL
    BEGIN
        DROP TABLE dbo.tblAreaDim;
END; 

SELECT s.acct_area_id AS area_id
     , CAST('Unknown' AS VARCHAR(50)) AS area_desc
INTO dbo.tblAreaDim
  FROM dbo.stg_p1 AS s
 WHERE 1 = 2;



-- 1.7) Product Dimension

IF OBJECT_ID('dbo.tblProductDim', 'U') IS NOT NULL
    BEGIN
        DROP TABLE dbo.tblProductDim;
END; 

SELECT s.prod_id
     , CAST('Unknown' AS VARCHAR(50)) AS prod_desc
INTO dbo.tblProductDim
  FROM dbo.stg_p1 AS s
 WHERE 1 = 2;



-- 1.8) Customer Dimension

IF OBJECT_ID('dbo.tblCustomerDim', 'U') IS NOT NULL
    BEGIN
        DROP TABLE dbo.tblCustomerDim;
END; 

SELECT s.cust_id2 AS cust_id
     , s.last_name
     , s.first_name
     , s.gender
     , s.birth_date
     , s.cust_since_date
     , s.pri_branch_id
     , s.cust_pri_branch_dist
     , s.cust_add_id
     , s.cust_lat
     , s.cust_lon
     , s.cust_rel_id
INTO dbo.tblCustomerDim
  FROM dbo.stg_p1 AS s
 WHERE 1 = 2;



-- 1.9) Account Fact

IF OBJECT_ID('dbo.tblAccountFact', 'U') IS NOT NULL
    BEGIN
        DROP TABLE dbo.tblAccountFact;
END; 

SELECT s.as_of_date
     , s.acct_id3 AS acct_id
     , s.cur_bal
INTO dbo.tblAccountFact
  FROM dbo.stg_p1 AS s
 WHERE 1 = 2;



-- 1.10) Address Dimension

IF OBJECT_ID('dbo.tblAddressDim', 'U') IS NOT NULL
    BEGIN
        DROP TABLE dbo.tblAddressDim;
END; 

SELECT s.acct_branch_add_id AS add_id
     , s.acct_branch_add_lat AS add_lat
     , s.acct_branch_add_lon AS add_lon
     , s.acct_branch_add_type AS add_type
INTO dbo.tblAddressDim
  FROM dbo.stg_p1 AS s
 WHERE 1 = 2;







-- 2) Load tables

-- 2.1) Account Customer Dimension

TRUNCATE TABLE dbo.tblAccountCustomerDim;

INSERT INTO dbo.tblAccountCustomerDim
SELECT DISTINCT 
       s.acct_id
     , s.cust_id
     , s.acct_cust_role_id
  FROM dbo.stg_p1 AS s
 ORDER BY 1
        , 2;


		
-- 2.2) Account Customer Role Dimension

TRUNCATE TABLE dbo.tblAccountCustomerRoleDim;

INSERT INTO dbo.tblAccountCustomerRoleDim
SELECT DISTINCT 
       s.acct_cust_role_id
     , CASE
           WHEN s.acct_cust_role_id = 1
           THEN 'Primary'
           WHEN s.acct_cust_role_id = 2
           THEN 'Secondary'
           ELSE 'Unknown'
       END AS acct_cust_role_desc
  FROM dbo.stg_p1 AS s
 ORDER BY 1
        , 2;



-- 2.3) Account Dimension

TRUNCATE TABLE dbo.tblAccountDim;

INSERT INTO dbo.tblAccountDim
SELECT DISTINCT 
       s.acct_id2 AS acct_id
     , s.prod_id
     , s.open_date
     , s.close_date
     , s.open_close_code
     , s.branch_id
     , s.pri_cust_id
     , s.loan_amt
  FROM dbo.stg_p1 AS s
 WHERE s.acct_cust_role_id = 1
 ORDER BY 1;


 
-- 2.4) Branch Dimension

TRUNCATE TABLE dbo.tblBranchDim;

INSERT INTO dbo.tblBranchDim
SELECT DISTINCT 
       s.acct_branch_id AS branch_id
     , s.acct_branch_code AS branch_code
     , s.acct_branch_desc AS branch_desc
     , s.acct_branch_add_id AS branch_add_id
     , s.acct_region_id AS region_id
     , s.acct_area_id AS area_id
  FROM dbo.stg_p1 AS s
 ORDER BY 1;



-- 2.5) Region Dimension

TRUNCATE TABLE dbo.tblRegionDim;

INSERT INTO dbo.tblRegionDim
SELECT DISTINCT 
       s.acct_region_id AS region_id
     , 'Unknown' AS region_desc
  FROM dbo.stg_p1 AS s
 ORDER BY 1;



-- 2.6) Area Dimension

TRUNCATE TABLE dbo.tblAreaDim;

INSERT INTO dbo.tblAreaDim
SELECT DISTINCT 
       s.acct_area_id AS area_id
     , 'Unknown' AS area_desc
  FROM dbo.stg_p1 AS s
 ORDER BY 1;



-- 2.7) Product Dimension

TRUNCATE TABLE dbo.tblProductDim;

INSERT INTO dbo.tblProductDim
SELECT DISTINCT 
       s.prod_id
     , 'Unknown' AS prod_desc
  FROM dbo.stg_p1 AS s
 ORDER BY 1;



-- 2.8) Customer Dimension

TRUNCATE TABLE dbo.tblCustomerDim;

INSERT INTO dbo.tblCustomerDim
SELECT DISTINCT 
       s.cust_id2 AS cust_id
     , s.last_name
     , s.first_name
     , s.gender
     , s.birth_date
     , s.cust_since_date
     , s.pri_branch_id
     , s.cust_pri_branch_dist
     , s.cust_add_id
     , s.cust_lat
     , s.cust_lon
     , s.cust_rel_id
  FROM dbo.stg_p1 AS s
 ORDER BY 1;



-- 2.9) Account Fact

TRUNCATE TABLE dbo.tblAccountFact;

INSERT INTO dbo.tblAccountFact
SELECT DISTINCT 
       s.as_of_date
     , s.acct_id3 AS acct_id
     , s.cur_bal
  FROM dbo.stg_p1 AS s
 WHERE s.acct_cust_role_id = 1;



-- 2.10) Address Dimension

TRUNCATE TABLE dbo.tblAddressDim;

INSERT INTO dbo.tblAddressDim
SELECT s.acct_branch_add_id AS add_id
     , s.acct_branch_add_lat AS add_lat
     , s.acct_branch_add_lon AS add_lon
     , s.acct_branch_add_type AS add_type
  FROM dbo.stg_p1 AS s
UNION
SELECT s.cust_add_id AS add_id
     , s.cust_add_lat AS add_lat
     , s.cust_add_lon AS add_lon
     , s.cust_add_type AS add_type
  FROM dbo.stg_p1 AS s;







-- 3) Referential integrity


-- 3.1) Primary Keys


-- 3.1.1) Account Customer Dimension

IF EXISTS
(
    SELECT 1
      FROM sys.key_constraints
     WHERE type = 'PK'
           AND parent_object_id = OBJECT_ID('dbo.tblAccountCustomerDim')
)
    BEGIN
        ALTER TABLE dbo.tblAccountCustomerDim DROP CONSTRAINT PK_tblAccountCustomerDim;
END; 

ALTER TABLE dbo.tblAccountCustomerDim
ADD CONSTRAINT PK_tblAccountCustomerDim PRIMARY KEY(acct_id, cust_id);



-- 3.1.2) Account Customer Role Dimension

IF EXISTS
(
    SELECT 1
      FROM sys.key_constraints
     WHERE type = 'PK'
           AND parent_object_id = OBJECT_ID('dbo.tblAccountCustomerRoleDim')
)
    BEGIN
        ALTER TABLE dbo.tblAccountCustomerDim DROP CONSTRAINT PK_tblAccountCustomerRoleDim;
END; 

ALTER TABLE dbo.tblAccountCustomerRoleDim
ADD CONSTRAINT PK_tblAccountCustomerRoleDim PRIMARY KEY(acct_cust_role_id);



-- 3.1.3) Account Dimension

IF EXISTS
(
    SELECT 1
      FROM sys.key_constraints
     WHERE type = 'PK'
           AND parent_object_id = OBJECT_ID('dbo.tblAccountDim')
)
    BEGIN
        ALTER TABLE dbo.tblAccountDim DROP CONSTRAINT PK_tblAccountDim;
END; 

ALTER TABLE dbo.tblAccountDim
ADD CONSTRAINT PK_tblAccountDim PRIMARY KEY(acct_id);



-- 3.1.4) Branch Dimension

IF EXISTS
(
    SELECT 1
      FROM sys.key_constraints
     WHERE type = 'PK'
           AND parent_object_id = OBJECT_ID('dbo.tblBranchDim')
)
    BEGIN
        ALTER TABLE dbo.tblBranchDim DROP CONSTRAINT PK_tblBranchDim;
END; 

ALTER TABLE dbo.tblBranchDim
ADD CONSTRAINT PK_tblBranchDim PRIMARY KEY(branch_id);



-- 3.1.5) Region Dimension

IF EXISTS
(
    SELECT 1
      FROM sys.key_constraints
     WHERE type = 'PK'
           AND parent_object_id = OBJECT_ID('dbo.tblRegionDim')
)
    BEGIN
        ALTER TABLE dbo.tblRegionDim DROP CONSTRAINT PK_tblRegionDim;
END; 

ALTER TABLE dbo.tblRegionDim
ADD CONSTRAINT PK_tblRegionDim PRIMARY KEY(region_id);



-- 3.1.6) Area Dimension

IF EXISTS
(
    SELECT 1
      FROM sys.key_constraints
     WHERE type = 'PK'
           AND parent_object_id = OBJECT_ID('dbo.tblAreaDim')
)
    BEGIN
        ALTER TABLE dbo.tblAreaDim DROP CONSTRAINT PK_tblAreaDim;
END; 

ALTER TABLE dbo.tblAreaDim
ADD CONSTRAINT PK_tblAreaDim PRIMARY KEY(area_id);



-- 3.1.7) Product Dimension

IF EXISTS
(
    SELECT 1
      FROM sys.key_constraints
     WHERE type = 'PK'
           AND parent_object_id = OBJECT_ID('dbo.tblProductDim')
)
    BEGIN
        ALTER TABLE dbo.tblProductDim DROP CONSTRAINT PK_tblProductDim;
END; 

ALTER TABLE dbo.tblProductDim
ADD CONSTRAINT PK_tblProductDim PRIMARY KEY(prod_id);



-- 3.1.8) Customer Dimension

IF EXISTS
(
    SELECT 1
      FROM sys.key_constraints
     WHERE type = 'PK'
           AND parent_object_id = OBJECT_ID('dbo.tblCustomerDim')
)
    BEGIN
        ALTER TABLE dbo.tblCustomerDim DROP CONSTRAINT PK_tblCustomerDim;
END; 

ALTER TABLE dbo.tblCustomerDim
ADD CONSTRAINT PK_tblCustomerDim PRIMARY KEY(cust_id);



-- 3.1.9) Account Fact

IF EXISTS
(
    SELECT 1
      FROM sys.key_constraints
     WHERE type = 'PK'
           AND parent_object_id = OBJECT_ID('dbo.tblAccountFact')
)
    BEGIN
        ALTER TABLE dbo.tblAccountFact DROP CONSTRAINT PK_tblAccountFact;
END; 

ALTER TABLE dbo.tblAccountFact
ADD CONSTRAINT PK_tblAccountFact PRIMARY KEY(as_of_date, acct_id);



-- 3.1.10) Address Dimension

IF EXISTS
(
    SELECT 1
      FROM sys.key_constraints
     WHERE type = 'PK'
           AND parent_object_id = OBJECT_ID('dbo.tblAddressDim')
)
    BEGIN
        ALTER TABLE dbo.tblAddressDim DROP CONSTRAINT PK_tblAddressDim;
END; 

ALTER TABLE dbo.tblAddressDim
ADD CONSTRAINT PK_tblAddressDim PRIMARY KEY(add_id);







-- 3.2) Foreign Keys


-- 3.2.1) Account Customer Dimension

IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblAccountCustomerDim_cust_id_tblCustomerDim_cust_id'
           AND parent_object_id = OBJECT_ID(N'dbo.tblAccountCustomerDim')
)
    BEGIN

        ALTER TABLE dbo.tblAccountCustomerDim DROP CONSTRAINT FK_tblAccountCustomerDim_cust_id_tblCustomerDim_cust_id;

END;

ALTER TABLE dbo.tblAccountCustomerDim
ADD CONSTRAINT FK_tblAccountCustomerDim_cust_id_tblCustomerDim_cust_id FOREIGN KEY(cust_id) REFERENCES dbo.tblCustomerDim(cust_id);


IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblAccountCustomerDim_acct_id_tblAccountDim_acct_id'
           AND parent_object_id = OBJECT_ID(N'dbo.tblAccountCustomerDim')
)
    BEGIN

        ALTER TABLE dbo.tblAccountCustomerDim DROP CONSTRAINT FK_tblAccountCustomerDim_acct_id_tblAccountDim_acct_id;

END;

ALTER TABLE dbo.tblAccountCustomerDim
ADD CONSTRAINT FK_tblAccountCustomerDim_acct_id_tblAccountDim_acct_id FOREIGN KEY(acct_id) REFERENCES dbo.tblAccountDim(acct_id);


IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblAccountCustomerDim_acct_cust_role_id_tblAccountCustomerRoleDim_acct_cust_role_id'
           AND parent_object_id = OBJECT_ID(N'dbo.tblAccountCustomerDim')
)
    BEGIN

        ALTER TABLE dbo.tblAccountCustomerDim DROP CONSTRAINT FK_tblAccountCustomerDim_acct_cust_role_id_tblAccountCustomerRoleDim_acct_cust_role_id;

END;

ALTER TABLE dbo.tblAccountCustomerDim
ADD CONSTRAINT FK_tblAccountCustomerDim_acct_cust_role_id_tblAccountCustomerRoleDim_acct_cust_role_id FOREIGN KEY(acct_cust_role_id) REFERENCES dbo.tblAccountCustomerRoleDim(acct_cust_role_id);



-- 3.2.2) Account Customer Role Dimension



-- 3.2.3) Account Dimension

IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblAccountDim_prod_id_tblProductDim_prod_id'
           AND parent_object_id = OBJECT_ID(N'dbo.tblAccountDim')
)
    BEGIN

        ALTER TABLE dbo.tblAccountDim DROP CONSTRAINT FK_tblAccountDim_prod_id_tblProductDim_prod_id;

END;

ALTER TABLE dbo.tblAccountDim
ADD CONSTRAINT FK_tblAccountDim_prod_id_tblProductDim_prod_id FOREIGN KEY(prod_id) REFERENCES dbo.tblProductDim(prod_id);


IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblAccountDim_branch_id_tblBranchDim_branch_id'
           AND parent_object_id = OBJECT_ID(N'dbo.tblAccountDim')
)
    BEGIN

        ALTER TABLE dbo.tblAccountDim DROP CONSTRAINT FK_tblAccountDim_branch_id_tblBranchDim_branch_id;

END;

ALTER TABLE dbo.tblAccountDim
ADD CONSTRAINT FK_tblAccountDim_branch_id_tblBranchDim_branch_id FOREIGN KEY(branch_id) REFERENCES dbo.tblBranchDim(branch_id);


IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblAccountDim_pri_cust_id_tblCustomerDim_cust_id'
           AND parent_object_id = OBJECT_ID(N'dbo.tblAccountDim')
)
    BEGIN

        ALTER TABLE dbo.tblAccountDim DROP CONSTRAINT FK_tblAccountDim_pri_cust_id_tblCustomerDim_cust_id;

END;

ALTER TABLE dbo.tblAccountDim
ADD CONSTRAINT FK_tblAccountDim_pri_cust_id_tblCustomerDim_cust_id FOREIGN KEY(pri_cust_id) REFERENCES dbo.tblCustomerDim(cust_id);



-- 3.2.4) Branch Dimension

IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblBranchDim_branch_add_id_tblAddressDim_add_id'
           AND parent_object_id = OBJECT_ID(N'dbo.tblBranchDim')
)
    BEGIN

        ALTER TABLE dbo.tblBranchDim DROP CONSTRAINT FK_tblBranchDim_branch_add_id_tblAddressDim_add_id;

END;

ALTER TABLE dbo.tblBranchDim
ADD CONSTRAINT FK_tblBranchDim_branch_add_id_tblAddressDim_add_id FOREIGN KEY(branch_add_id) REFERENCES dbo.tblAddressDim(add_id);


IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblBranchDim_region_id_tblRegionDim_region_id'
           AND parent_object_id = OBJECT_ID(N'dbo.tblBranchDim')
)
    BEGIN

        ALTER TABLE dbo.tblBranchDim DROP CONSTRAINT FK_tblBranchDim_region_id_tblRegionDim_region_id;

END;

ALTER TABLE dbo.tblBranchDim
ADD CONSTRAINT FK_tblBranchDim_region_id_tblRegionDim_region_id FOREIGN KEY(region_id) REFERENCES dbo.tblRegionDim(region_id);


IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblBranchDim_area_id_tblAreaDim_area_id'
           AND parent_object_id = OBJECT_ID(N'dbo.tblBranchDim')
)
    BEGIN

        ALTER TABLE dbo.tblBranchDim DROP CONSTRAINT FK_tblBranchDim_area_id_tblAreaDim_area_id;

END;

ALTER TABLE dbo.tblBranchDim
ADD CONSTRAINT FK_tblBranchDim_area_id_tblAreaDim_area_id FOREIGN KEY(area_id) REFERENCES dbo.tblAreaDim(area_id);





-- 3.2.5) Region Dimension



-- 3.2.6) Area Dimension



-- 3.2.7) Product Dimension



-- 3.2.8) Customer Dimension

IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblCustomerDim_pri_branch_id_tblBranchDim_branch_id'
           AND parent_object_id = OBJECT_ID(N'dbo.tblCustomerDim')
)
    BEGIN

        ALTER TABLE dbo.tblCustomerDim DROP CONSTRAINT FK_tblCustomerDim_pri_branch_id_tblBranchDim_branch_id;

END;

ALTER TABLE dbo.tblCustomerDim
ADD CONSTRAINT FK_tblCustomerDim_pri_branch_id_tblBranchDim_branch_id FOREIGN KEY(pri_branch_id) REFERENCES dbo.tblBranchDim(branch_id);


IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblCustomerDim_cust_add_id_tblAddressDim_add_id'
           AND parent_object_id = OBJECT_ID(N'dbo.tblCustomerDim')
)
    BEGIN

        ALTER TABLE dbo.tblCustomerDim DROP CONSTRAINT FK_tblCustomerDim_cust_add_id_tblAddressDim_add_id;

END;

ALTER TABLE dbo.tblCustomerDim
ADD CONSTRAINT FK_tblCustomerDim_cust_add_id_tblAddressDim_add_id FOREIGN KEY(cust_add_id) REFERENCES dbo.tblAddressDim(add_id);



-- 3.2.9) Account Fact

IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblAccountFact_acct_id_tblAccountDim_acct_id'
           AND parent_object_id = OBJECT_ID(N'dbo.tblAccountFact')
)
    BEGIN

        ALTER TABLE dbo.tblAccountFact DROP CONSTRAINT FK_tblAccountFact_acct_id_tblAccountDim_acct_id;

END;

ALTER TABLE dbo.tblAccountFact
ADD CONSTRAINT FK_tblAccountFact_acct_id_tblAccountDim_acct_id FOREIGN KEY(acct_id) REFERENCES dbo.tblAccountDim(acct_id);



-- 3.2.10) Address Dimension