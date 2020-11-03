/*****************************************************************************************************************
NAME:    DFNB2.sql
PURPOSE: Create the DFNB2 schema 
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/02/2020   DARENA       1. Built this table for LDS BC IT240
2.0     11/02/2020   DARENA       2. Views modified
RUNTIME: 
Approx. 1 min
NOTES:
 
******************************************************************************************************************/

USE [DFNB2]
GO
/****** Object:  View [dbo].[v_CustomersBristol]    Script Date: 11/2/2020 5:54:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_CustomersBristol] AS
SELECT sp.cust_id,sp.last_name, sp.first_name
FROM dbo.stg_p1 sp
WHERE sp.acct_branch_code = 'BR' 
GO
/****** Object:  View [dbo].[v_CustomersClinton]    Script Date: 11/2/2020 5:54:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_CustomersClinton] AS
SELECT sp.cust_id,sp.last_name, sp.first_name
FROM dbo.stg_p1 sp
WHERE sp.acct_branch_code = 'CL' 
GO
/****** Object:  View [dbo].[v_CustomersFairview]    Script Date: 11/2/2020 5:54:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_CustomersFairview] AS
SELECT sp.cust_id,sp.last_name, sp.first_name
FROM dbo.stg_p1 sp
WHERE sp.acct_branch_code = 'FV' 
GO
/****** Object:  View [dbo].[v_CustomersFranklin]    Script Date: 11/2/2020 5:54:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_CustomersFranklin] AS
SELECT sp.cust_id,sp.last_name, sp.first_name
FROM dbo.stg_p1 sp
WHERE sp.acct_branch_code = 'FR' 
GO
/****** Object:  View [dbo].[v_CustomersGeorgeTown]    Script Date: 11/2/2020 5:54:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_CustomersGeorgeTown] AS
SELECT sp.cust_id,sp.last_name, sp.first_name
FROM dbo.stg_p1 sp
WHERE sp.acct_branch_code = 'GT' 
GO
/****** Object:  View [dbo].[v_CustomersWashington]    Script Date: 11/2/2020 5:54:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_CustomersWashington] AS
SELECT sp.cust_id,sp.last_name, sp.first_name
FROM dbo.stg_p1 sp
WHERE sp.acct_branch_code = 'WA' 
GO
/****** Object:  Table [dbo].[tblAccountCustomerDim]    Script Date: 11/2/2020 5:54:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAccountCustomerDim](
	[acct_cust_id] [int] IDENTITY(1,1) NOT NULL,
	[acct_id] [int] NOT NULL,
	[cust_id] [smallint] NOT NULL,
	[acct_cust_role_id] [smallint] NOT NULL,
 CONSTRAINT [PK_tblAccountCustomerDim] PRIMARY KEY CLUSTERED 
(
	[acct_cust_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblAccountCustomerRoleDim]    Script Date: 11/2/2020 5:54:59 PM ******/
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
/****** Object:  Table [dbo].[tblAccountDim]    Script Date: 11/2/2020 5:54:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAccountDim](
	[acct_id] [int] NOT NULL,
	[pri_cust_id] [smallint] NOT NULL,
	[prod_id] [smallint] NOT NULL,
	[open_date] [date] NOT NULL,
	[close_date] [date] NOT NULL,
	[open_close_code] [varchar](1) NOT NULL,
	[branch_id] [smallint] NOT NULL,
	[loan_amt] [decimal](20, 4) NOT NULL,
 CONSTRAINT [PK_tblAccountDim] PRIMARY KEY CLUSTERED 
(
	[acct_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblAccountFact]    Script Date: 11/2/2020 5:54:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAccountFact](
	[acct_id] [int] NOT NULL,
	[as_of_date] [date] NOT NULL,
	[cur_bal] [decimal](20, 4) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblAddressDim]    Script Date: 11/2/2020 5:54:59 PM ******/
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
/****** Object:  Table [dbo].[tblAreaDim]    Script Date: 11/2/2020 5:54:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAreaDim](
	[area_id] [int] NOT NULL,
	[area_name] [varchar](50) NULL,
 CONSTRAINT [PK_tblAreaDim] PRIMARY KEY CLUSTERED 
(
	[area_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblBranchDim]    Script Date: 11/2/2020 5:54:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblBranchDim](
	[branch_id] [smallint] NOT NULL,
	[branch_code] [varchar](5) NOT NULL,
	[branch_desc] [varchar](100) NOT NULL,
	[add_id] [int] NOT NULL,
	[area_id] [int] NOT NULL,
	[region_id] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCustomerDim]    Script Date: 11/2/2020 5:54:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCustomerDim](
	[cust_id] [smallint] NOT NULL,
	[pri_branch_id] [smallint] NOT NULL,
	[last_name] [varchar](100) NOT NULL,
	[first_name] [varchar](100) NOT NULL,
	[gender] [varchar](1) NOT NULL,
	[birth_date] [date] NOT NULL,
	[cust_since_date] [date] NOT NULL,
 CONSTRAINT [PK_tblCustomerDim] PRIMARY KEY CLUSTERED 
(
	[cust_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblProductDim]    Script Date: 11/2/2020 5:54:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProductDim](
	[prod_id] [smallint] NOT NULL,
	[prod_name] [varchar](25) NULL,
 CONSTRAINT [PK_tblProductDim] PRIMARY KEY CLUSTERED 
(
	[prod_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRegionDim]    Script Date: 11/2/2020 5:54:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRegionDim](
	[region_id] [int] NOT NULL,
	[region_name] [varchar](50) NULL,
 CONSTRAINT [PK_tblRegionDim] PRIMARY KEY CLUSTERED 
(
	[region_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
