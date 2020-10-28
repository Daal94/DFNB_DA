/*****************************************************************************************************************
NAME:    LoadDFNB_p1
PURPOSE: Table creation AccountCustomerRoleDim
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/21/2020   DARENA       1. Built this table for IT240
RUNTIME: 
Approx. 1 min
NOTES:
Creates dbo.tblAccountCustomerRoleDim

LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
******************************************************************************************************************/

USE [DFNB2]
GO

/****** Object:  Table [dbo].[tblAccountCustomerRoleDim]    Script Date: 10/27/2020 5:38:17 PM ******/
DROP TABLE [dbo].[tblAccountCustomerRoleDim]
GO

/****** Object:  Table [dbo].[tblAccountCustomerRoleDim]    Script Date: 10/27/2020 5:38:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblAccountCustomerRoleDim](
	[acct_cust_role_id] [smallint] NOT NULL,
	[role_name] [varchar](50) NULL,
 CONSTRAINT [PK_tblAccountCustomerRoleDim] PRIMARY KEY CLUSTERED 
(
	[acct_cust_role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


