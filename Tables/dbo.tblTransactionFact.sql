
/*****************************************************************************************************************
NAME:    LoadDFNB_p2
PURPOSE: Table creation RegionDim
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/21/2020   DARENA       1. Built this table for IT240
RUNTIME: 
Approx. 1 min
NOTES:
Creates[dbo].[tblTransactionFact] 

LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
******************************************************************************************************************/

USE [DFNB2]
GO

/****** Object:  Table [dbo].[tblTransactionFact]    Script Date: 11/18/2020 11:37:33 PM ******/
DROP TABLE [dbo].[tblTransactionFact]
GO

/****** Object:  Table [dbo].[tblTransactionFact]    Script Date: 11/18/2020 11:37:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblTransactionFact](
	[acct_id] [int] NOT NULL,
	[branch_id] [smallint] NOT NULL,
	[tran_date] [date] NOT NULL,
	[tran_time] [time](7) NOT NULL,
	[tran_type_id] [smallint] NOT NULL,
	[tran_amt] [int] NOT NULL,
	[tran_fee_amt] [decimal](15, 3) NOT NULL,
	[tran_id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_tblTransactionFact] PRIMARY KEY CLUSTERED 
(
	[tran_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


