
/*****************************************************************************************************************
NAME:    LoadDFNB_p2
PURPOSE: [dbo].[tblTransactionTypeDim] 
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/21/2020   DARENA       1. Built this table for IT240
RUNTIME: 
Approx. 1 min
NOTES:
Creates[dbo].[tblTransactionTypeDim] 

LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
******************************************************************************************************************/

USE [DFNB2]
GO

/****** Object:  Table [dbo].[tblTransactionTypeDim]    Script Date: 11/18/2020 11:39:02 PM ******/
DROP TABLE [dbo].[tblTransactionTypeDim]
GO

/****** Object:  Table [dbo].[tblTransactionTypeDim]    Script Date: 11/18/2020 11:39:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblTransactionTypeDim](
	[tran_type_id] [smallint] NOT NULL,
	[tran_type_code] [varchar](5) NOT NULL,
	[tran_type_desc] [varchar](100) NOT NULL,
	[tran_fee_prct] [decimal](4, 3) NOT NULL,
	[cur_cust_req_ind] [varchar](1) NOT NULL
) ON [PRIMARY]
GO


