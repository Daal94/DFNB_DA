/*****************************************************************************************************************
NAME:    dbo.v_CustomersFairview
PURPOSE: Table creation BranchDim
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/21/2020   DARENA       1. Built this table for IT240
RUNTIME: 
Approx. 1 min
NOTES:
Creates  dbo.v_CustomersFairview

LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
******************************************************************************************************************/

USE [DFNB2]
GO

/****** Object:  View [dbo].[v_CustomersFairview]    Script Date: 10/28/2020 12:54:15 AM ******/
DROP VIEW [dbo].[v_CustomersFairview]
GO

/****** Object:  View [dbo].[v_CustomersFairview]    Script Date: 10/28/2020 12:54:15 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create View [dbo].[v_CustomersFairview] AS
SELECT sp.cust_id,sp.last_name, sp.first_name
FROM dbo.stg_p1 sp
WHERE sp.acct_branch_code = 'FV' 
GO


