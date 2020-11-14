/*****************************************************************************************************************
NAME:    [v_TransactionsBranches]
PURPOSE: Table creation BranchDim
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/21/2020   DARENA       1. Built this table for IT240
RUNTIME: 
Approx. 1 min
NOTES:
Creates  [v_TransactionsBranches]

LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
********************************************************************************************************************/

USE [DFNB2]
GO

/****** Object:  View [dbo].[v_TransactionsBranches]    Script Date: 11/13/2020 11:25:27 PM ******/
DROP VIEW [dbo].[v_TransactionsBranches]
GO

/****** Object:  View [dbo].[v_TransactionsBranches]    Script Date: 11/13/2020 11:25:27 PM ******/
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


