/*****************************************************************************************************************
NAME:    DataOutput
PURPOSE: Data Output process for DFNB data
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/02/2020   DARENA       1. Built this table for LDS BC IT240
2.0		11/13/2020	 DARENA		  2. "
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
/****** Object:  View [dbo].[v_CustomersBristol]    Script Date: 11/2/2020 5:57:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_CustomersBristol] AS
SELECT sp.cust_id,sp.last_name, sp.first_name
FROM dbo.stg_p1 sp
WHERE sp.acct_branch_code = 'BR' 
GO
/****** Object:  View [dbo].[v_CustomersClinton]    Script Date: 11/2/2020 5:57:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_CustomersClinton] AS
SELECT sp.cust_id,sp.last_name, sp.first_name
FROM dbo.stg_p1 sp
WHERE sp.acct_branch_code = 'CL' 
GO
/****** Object:  View [dbo].[v_CustomersFairview]    Script Date: 11/2/2020 5:57:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_CustomersFairview] AS
SELECT sp.cust_id,sp.last_name, sp.first_name
FROM dbo.stg_p1 sp
WHERE sp.acct_branch_code = 'FV' 
GO
/****** Object:  View [dbo].[v_CustomersFranklin]    Script Date: 11/2/2020 5:57:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_CustomersFranklin] AS
SELECT sp.cust_id,sp.last_name, sp.first_name
FROM dbo.stg_p1 sp
WHERE sp.acct_branch_code = 'FR' 
GO
/****** Object:  View [dbo].[v_CustomersGeorgeTown]    Script Date: 11/2/2020 5:57:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_CustomersGeorgeTown] AS
SELECT sp.cust_id,sp.last_name, sp.first_name
FROM dbo.stg_p1 sp
WHERE sp.acct_branch_code = 'GT' 
GO
/****** Object:  View [dbo].[v_CustomersWashington]    Script Date: 11/2/2020 5:57:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_CustomersWashington] AS
SELECT sp.cust_id,sp.last_name, sp.first_name
FROM dbo.stg_p1 sp
WHERE sp.acct_branch_code = 'WA' 
GO
/****** Object:  View [dbo].[v_TopCustomers]    Script Date: 11/13/2020 9:59:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_TopCustomers] AS
SELECT TOP 10 tcd.first_name +' '+tcd.last_name AS 'Customer Name',
count(ttf.tran_date) AS 'Number of Transactions'
FROM dbo.tblTransactionFact ttf
JOIN dbo.tblAccountDim tad ON ttf.acct_id = tad.acct_id
JOIN dbo.tblCustomerDim tcd ON tad.pri_cust_id= tcd.cust_id
JOIN dbo.tblBranchDim tbd ON tad.branch_id = tbd.branch_id
GROUP BY 
tcd.first_name, tcd.last_name
ORDER BY count(ttf.tran_date) desc;
GO
/****** Object:  View [dbo].[v_TotalAmaount]    Script Date: 11/13/2020 9:59:05 PM ******/
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
/****** Object:  View [dbo].[v_TransactionsBranches]    Script Date: 11/13/2020 9:59:05 PM ******/
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
/****** Object:  View [dbo].[v_TransactionsTypesYear]    Script Date: 11/13/2020 9:59:05 PM ******/
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