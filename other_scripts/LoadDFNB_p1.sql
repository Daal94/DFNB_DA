/*****************************************************************************************************************
NAME:    LoadDFNB_p1
PURPOSE: Load DFNB project 1
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/21/2020   DARENA       1. Built this table for IT240
RUNTIME: 
Approx. 1 min
NOTES:
These sre scripts to load data into DFNB

LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
******************************************************************************************************************/

--Load table CustomerDim

TRUNCATE TABLE dbo.tblCustomerDim;

INSERT INTO dbo.tblCustomerDim
SELECT DISTINCT 
       sp.cust_id
     , sp.pri_branch_id
     , sp.last_name
     , sp.first_name
     , sp.gender
     , sp.birth_date
     , sp.cust_since_date
     , sp.cust_rel_id
  FROM dbo.stg_p1 AS sp;
--Load table ProdDim

TRUNCATE TABLE dbo.tblProductDim;

INSERT INTO dbo.tblProductDim
SELECT DISTINCT 
       sp.prod_id
     , sp.prod_name
  FROM dbo.stg_p1 AS sp;
-- Load Table AreaDim

TRUNCATE TABLE dbo.tblAreaDim;

SELECT DISTINCT 
       sp.acct_area_id AS area_id
INTO dbo.tblAreaDim
  FROM dbo.stg_p1 AS sp;

-- Load Table RegionDim

TRUNCATE TABLE dbo.tblRegionDim;

SELECT DISTINCT 
       sp.acct_region_id AS region_id
INTO dbo.tblRegionDim
  FROM dbo.stg_p1 AS sp;

--Load Table AddressDim

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

--Load Table BranchDim

TRUNCATE TABLE dbo.tblBranchDim;

INSERT INTO dbo.tblBranchDim
SELECT DISTINCT 
       s.branch_id
     , s.acct_branch_code AS branch_code
     , s.acct_branch_desc AS branch_desc
     , s.acct_branch_add_id AS add_id
     , s.acct_area_id AS area_id
     , s.acct_region_id AS region_id
  FROM dbo.stg_p1 AS s;

-- Load Table AccountCustomerRoleDim

TRUNCATE TABLE dbo.tblAccountCustomerRoleDim;

INSERT INTO dbo.tblAccountCustomerRoleDim
SELECT DISTINCT 
       s.acct_cust_role_id
  FROM dbo.stg_p1 AS s;

-- Load Table AccountDim

TRUNCATE TABLE dbo.tblAccountDim;

INSERT INTO dbo.tblAccountDim
SELECT DISTINCT 
      s.acct_id 
     , s.pri_cust_id
     , s.prod_id
     , s.open_date
     , s.close_date
     , s.open_close_code
     , s.branch_id
     , s.loan_amt
  FROM dbo.stg_p1 AS s
  WHERE s.acct_cust_role_id <> 2
  ORDER BY s.acct_id;
--Load Table AccountCustomerDim

TRUNCATE TABLE dbo.tblAccountCustomerDim;

INSERT INTO dbo.tblAccountCustomerDim
SELECT DISTINCT 
       s.acct_id
     , s.cust_id
     , s.acct_cust_role_id
  FROM dbo.stg_p1 AS s
 ORDER BY s.acct_id;

--Load Table AccountFact

TRUNCATE TABLE dbo.tblAccountFact;

INSERT INTO dbo.tblAccountFact
SELECT DISTINCT 
       sp.acct_id
     , sp.as_of_date
     , sp.cur_bal
  FROM dbo.stg_p1 AS sp
 WHERE sp.acct_cust_role_id <> 2
 ORDER BY sp.acct_id
        , sp.as_of_date;