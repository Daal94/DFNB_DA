/*****************************************************************************************************************
NAME:    LoadDFNB_p1
PURPOSE: Table creation AddressDim
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/21/2020   DARENA       1. Built this table for IT240
RUNTIME: 
Approx. 1 min
NOTES:
Creates dbo.tblAddressDim

LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
******************************************************************************************************************/

USE [DFNB2]
GO

/****** Object:  Table [dbo].[tblAddressDim]    Script Date: 10/27/2020 5:18:34 PM ******/
DROP TABLE [dbo].[tblAddressDim]
GO

/****** Object:  Table [dbo].[tblAddressDim]    Script Date: 10/27/2020 5:18:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblAddressDim](
	[add_id] [int] NOT NULL,
	[add_lat] [decimal](16, 12) NOT NULL,
	[add_lon] [decimal](16, 12) NOT NULL,
	[add_type] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tblAddressDim] PRIMARY KEY CLUSTERED 
(
	[add_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


