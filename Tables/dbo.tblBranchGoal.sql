/*****************************************************************************************************************
NAME:    [tblBranchGoal]
PURPOSE: Table creation [tblBranchGoal]
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/21/2020   DARENA       1. Built this table for IT240
RUNTIME: 
Approx. 1 min
NOTES:
Creates [tblBranchGoal]

LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
******************************************************************************************************************/



USE [DFNB2]
GO

/****** Object:  Table [dbo].[tblBranchGoal]    Script Date: 11/30/2020 11:28:34 PM ******/
DROP TABLE [dbo].[tblBranchGoal]
GO

/****** Object:  Table [dbo].[tblBranchGoal]    Script Date: 11/30/2020 11:28:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblBranchGoal](
	[branch_goal_id] [int] IDENTITY(1,1) NOT NULL,
	[branch_id] [smallint] NOT NULL,
	[branch_desc] [varchar](100) NOT NULL,
	[goal] [int] NULL,
 CONSTRAINT [PK_tblBranchGoal] PRIMARY KEY CLUSTERED 
(
	[branch_goal_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


