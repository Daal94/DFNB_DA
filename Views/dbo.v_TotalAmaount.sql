/*****************************************************************************************************************
NAME:    [dbo].[v_TotalAmaount] 
PURPOSE: Table creation BranchDim
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/21/2020   DARENA       1. Built this table for IT240
RUNTIME: 
Approx. 1 min
NOTES:
Creates  [dbo].[v_TotalAmaount] 

LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
********************************************************************************************************************/

USE [DFNB2]
GO

/****** Object:  View [dbo].[v_TotalAmaount]    Script Date: 11/13/2020 11:22:18 PM ******/
DROP VIEW [dbo].[v_TotalAmaount]
GO

/****** Object:  View [dbo].[v_TotalAmaount]    Script Date: 11/13/2020 11:22:18 PM ******/
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


