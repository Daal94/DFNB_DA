/*****************************************************************************************************************
NAME:   DataOutputDFNB_p3
PURPOSE: Creates DataOutputDFNB_p3
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/21/2020   DARENA       1. Built this table for IT240
RUNTIME: 
Approx. 1 min
NOTES:
 
LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
******************************************************************************************************************/

USE [DFNB2]
GO
/****** Object:  View [dbo].[v_AreaSummary]    Script Date: 11/30/2020 11:34:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_AreaSummary] AS (
 SELECT tbd.area_id AS 'Area ID'
     , YEAR(ad.open_date) AS 'Year'
     , SUM(ad.loan_amt) AS 'Total Loan Amount'
  FROM dbo.tblAccountDim AS ad
       JOIN
       dbo.tblBranchDim AS tbd ON ad.branch_id = tbd.branch_id
 WHERE YEAR(ad.open_date) IN
                            (
                             2017
                           , 2018
                           , 2019
                            )
 GROUP BY tbd.area_id
        , YEAR(ad.open_date));
GO
/****** Object:  View [dbo].[v_BranchSummary]    Script Date: 11/30/2020 11:34:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_BranchSummary] AS (
SELECT ad.branch_id AS 'Branch ID'
     , tbd.branch_desc AS 'Branch Name'
     , YEAR(ad.open_date) AS 'Year'
     , SUM(ad.loan_amt) AS 'Total Loan Amount'
  FROM dbo.tblAccountDim AS ad
       JOIN
       dbo.tblBranchDim AS tbd ON ad.branch_id = tbd.branch_id
 WHERE YEAR(ad.open_date) IN
                            (
                             2017
                           , 2018
                           , 2019
                            )
 GROUP BY ad.branch_id
        , tbd.branch_desc
        , YEAR(ad.open_date))
GO
/****** Object:  View [dbo].[v_CustomersBristol]    Script Date: 11/30/2020 11:34:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_CustomersBristol] AS
SELECT sp.cust_id,sp.last_name, sp.first_name
FROM dbo.stg_p1 sp
WHERE sp.acct_branch_code = 'BR' 
GO
/****** Object:  View [dbo].[v_CustomersClinton]    Script Date: 11/30/2020 11:34:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_CustomersClinton] AS
SELECT sp.cust_id,sp.last_name, sp.first_name
FROM dbo.stg_p1 sp
WHERE sp.acct_branch_code = 'CL' 
GO
/****** Object:  View [dbo].[v_CustomersFairview]    Script Date: 11/30/2020 11:34:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_CustomersFairview] AS
SELECT sp.cust_id,sp.last_name, sp.first_name
FROM dbo.stg_p1 sp
WHERE sp.acct_branch_code = 'FV' 
GO
/****** Object:  View [dbo].[v_CustomersFranklin]    Script Date: 11/30/2020 11:34:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_CustomersFranklin] AS
SELECT sp.cust_id,sp.last_name, sp.first_name
FROM dbo.stg_p1 sp
WHERE sp.acct_branch_code = 'FR' 
GO
/****** Object:  View [dbo].[v_CustomersGeorgeTown]    Script Date: 11/30/2020 11:34:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_CustomersGeorgeTown] AS
SELECT sp.cust_id,sp.last_name, sp.first_name
FROM dbo.stg_p1 sp
WHERE sp.acct_branch_code = 'GT' 
GO
/****** Object:  View [dbo].[v_CustomersWashington]    Script Date: 11/30/2020 11:34:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_CustomersWashington] AS
SELECT sp.cust_id,sp.last_name, sp.first_name
FROM dbo.stg_p1 sp
WHERE sp.acct_branch_code = 'WA' 
GO
/****** Object:  View [dbo].[v_NumberOfAccountsBranch]    Script Date: 11/30/2020 11:34:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_NumberOfAccountsBranch] as(
SELECT  tbd.branch_desc
     , COUNT(tad.acct_id) AS 'Count of Accounts'
  FROM dbo.tblAccountDim AS tad
       JOIN
       dbo.tblBranchDim AS tbd ON tad.branch_id = tbd.branch_id
GROUP BY tbd.branch_desc )
GO
/****** Object:  View [dbo].[v_RegionSummary]    Script Date: 11/30/2020 11:34:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_RegionSummary] AS (
 SELECT tbd.region_id AS 'Region ID'
     , YEAR(ad.open_date) AS 'Year'
     , SUM(ad.loan_amt) AS 'Total Loan Amount'
  FROM dbo.tblAccountDim AS ad
       JOIN
       dbo.tblBranchDim AS tbd ON ad.branch_id = tbd.branch_id
 WHERE YEAR(ad.open_date) IN
                            (
                             2017
                           , 2018
                           , 2019
                            )
 GROUP BY tbd.region_id
        , YEAR(ad.open_date)
);
GO
/****** Object:  View [dbo].[v_TopCustomers]    Script Date: 11/30/2020 11:34:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_TopCustomers] AS
 WITH
s1
as
(
SELECT tcd.cust_id
      ,tcd.first_name +' '+tcd.last_name AS 'Customer Name'
      ,tbd.branch_code
      ,COUNT(ttf.tran_id) AS 'Number of Transactions'
      ,RANK() OVER   
      (PARTITION BY tbd.branch_code ORDER BY count(ttf.tran_id) DESC) AS customer_branch_rank 
FROM dbo.tblTransactionFact ttf
JOIN dbo.tblAccountDim tad ON ttf.acct_id = tad.acct_id
JOIN dbo.tblCustomerDim tcd ON tad.pri_cust_id= tcd.cust_id
JOIN dbo.tblBranchDim tbd ON tad.branch_id = tbd.branch_id
--WHERE cust_id in (288, 399, 4323)
GROUP BY
 tcd.cust_id, tcd.first_name, tcd.last_name,tbd.branch_code
)
SELECT s1.*
FROM s1
WHERE s1.customer_branch_rank <= 10
AND
s1.branch_code <> 'UNK';
GO
/****** Object:  View [dbo].[v_TotalAmaount]    Script Date: 11/30/2020 11:34:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_TotalAmaount] AS
SELECT tbd.branch_code
	,sum(ttf.tran_amt) AS 'Total Transfer Amount'
    ,sum(ttf.tran_fee_amt) AS ' Total Fee Amount'
	,sum(ttf.tran_amt) + sum(ttf.tran_fee_amt) as 'Total Amount Paid'
  FROM dbo.tblTransactionFact AS ttf
  INNER JOIN dbo.tblBranchDim tbd ON tbd.branch_id = ttf.branch_id
  group BY
	tbd.branch_code;
GO
/****** Object:  View [dbo].[v_TotalLoansByBranch]    Script Date: 11/30/2020 11:34:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_TotalLoansByBranch] AS (
SELECT tbd.branch_desc
     , COUNT(tad.pri_cust_id) AS 'Count Of Customers'
     , SUM(tad.loan_amt) AS 'Total Loan Amount'
  FROM dbo.tblAccountDim AS tad
       JOIN
       dbo.tblBranchDim AS tbd ON tad.branch_id = tbd.branch_id
WHERE year(tad.open_date) > 2017
 GROUP BY tbd.branch_desc)
GO
/****** Object:  View [dbo].[v_TransactionsBranches]    Script Date: 11/30/2020 11:34:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_TransactionsBranches] AS
SELECT distinct 
tf.branch_id
,tbd.branch_code
,tbd.branch_desc AS 'Name of Branch'
,count(tf.tran_date) AS 'Number of Transactions'
FROM dbo.tblTransactionFact tf
INNER JOIN dbo.tblBranchDim tbd ON tbd.branch_id = tf.branch_id
GROUP BY
tf.branch_id
,tbd.branch_code
,tbd.branch_desc;
GO
/****** Object:  View [dbo].[v_TransactionsTypesYear]    Script Date: 11/30/2020 11:34:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_TransactionsTypesYear] AS
SELECT distinct 
tbd.branch_desc AS 'Name of Branch'
,tttd.tran_type_desc
,count(tf.tran_date) AS 'Number of Transactions'
,year(tf.tran_date) AS 'Year of Transaction'
FROM dbo.tblTransactionFact tf
INNER JOIN dbo.tblBranchDim tbd ON tbd.branch_id = tf.branch_id
INNER JOIN dbo.tblTransactionTypeDim tttd ON tf.tran_type_id = tttd.tran_type_id
GROUP BY
tbd.branch_desc
,tttd.tran_type_desc
,year(tf.tran_date)
GO
