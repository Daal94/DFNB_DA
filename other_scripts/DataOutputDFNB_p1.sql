/*****************************************************************************************************************
NAME:    DataOutput
PURPOSE: Data Output process for DFNB data
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/02/2020   DARENA       1. Built this table for LDS BC IT240
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
