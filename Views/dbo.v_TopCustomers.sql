/*****************************************************************************************************************
NAME:    [dbo].[v_TopCustomers]
PURPOSE: Table creation BranchDim
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/21/2020   DARENA       1. Built this table for IT240
RUNTIME: 
Approx. 1 min
NOTES:
Creates  [dbo].[v_TopCustomers]

LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
********************************************************************************************************************/

USE [DFNB2]
GO

/****** Object:  View [dbo].[v_TopCustomers]    Script Date: 11/13/2020 11:19:15 PM ******/
DROP VIEW [dbo].[v_TopCustomers]
GO

/****** Object:  View [dbo].[v_TopCustomers]    Script Date: 11/13/2020 11:19:15 PM ******/
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


