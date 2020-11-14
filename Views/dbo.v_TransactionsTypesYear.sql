/*****************************************************************************************************************
NAME:    [dbo].[v_TransactionsTypesYear] 
PURPOSE: Table creation BranchDim
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/21/2020   DARENA       1. Built this table for IT240
RUNTIME: 
Approx. 1 min
NOTES:
Creates  [dbo].[v_TransactionsTypesYear] 
LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
********************************************************************************************************************/

USE [DFNB2]
GO

/****** Object:  View [dbo].[v_TransactionsTypesYear]    Script Date: 11/13/2020 11:30:52 PM ******/
DROP VIEW [dbo].[v_TransactionsTypesYear]
GO

/****** Object:  View [dbo].[v_TransactionsTypesYear]    Script Date: 11/13/2020 11:30:52 PM ******/
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


