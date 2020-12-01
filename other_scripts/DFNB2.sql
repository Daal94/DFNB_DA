/*****************************************************************************************************************
NAME:    DFNB2.sql
PURPOSE: Create the DFNB2 schema 
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/02/2020   DARENA       1. Built this table for LDS BC IT240
2.0     11/02/2020   DARENA       2. Views modified
3.0		11/30/2020	 DARENA		  3. Future prescribed
RUNTIME: 
Approx. 1 min
NOTES:
 
******************************************************************************************************************/

USE [DFNB2]
GO
/****** Object:  Table [dbo].[tblTransactionFact]    Script Date: 11/30/2020 11:36:47 PM ******/
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
/****** Object:  Table [dbo].[tblCustomerDim]    Script Date: 11/30/2020 11:36:47 PM ******/
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
/****** Object:  Table [dbo].[tblBranchDim]    Script Date: 11/30/2020 11:36:47 PM ******/
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
/****** Object:  Table [dbo].[tblAccountDim]    Script Date: 11/30/2020 11:36:47 PM ******/
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
/****** Object:  View [dbo].[v_TopCustomers]    Script Date: 11/30/2020 11:36:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_TopCustomers] AS
 WITH
s1
as
(
SELECT tcd.cust_id
      ,tcd.first_name +' '+tcd.last_name AS 'Customer Name'
      ,tbd.branch_code
      ,COUNT(ttf.tran_id) AS 'Number of Transactions'
      ,RANK() OVER   
      (PARTITION BY tbd.branch_code ORDER BY count(ttf.tran_id) DESC) AS customer_branch_rank 
FROM dbo.tblTransactionFact ttf
JOIN dbo.tblAccountDim tad ON ttf.acct_id = tad.acct_id
JOIN dbo.tblCustomerDim tcd ON tad.pri_cust_id= tcd.cust_id
JOIN dbo.tblBranchDim tbd ON tad.branch_id = tbd.branch_id
--WHERE cust_id in (288, 399, 4323)
GROUP BY
 tcd.cust_id, tcd.first_name, tcd.last_name,tbd.branch_code
)
SELECT s1.*
FROM s1
WHERE s1.customer_branch_rank <= 10
AND
s1.branch_code <> 'UNK';
GO
/****** Object:  View [dbo].[v_NumberOfAccountsBranch]    Script Date: 11/30/2020 11:36:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_NumberOfAccountsBranch] as(
SELECT  tbd.branch_desc
     , COUNT(tad.acct_id) AS 'Count of Accounts'
  FROM dbo.tblAccountDim AS tad
       JOIN
       dbo.tblBranchDim AS tbd ON tad.branch_id = tbd.branch_id
GROUP BY tbd.branch_desc )
GO
/****** Object:  View [dbo].[v_TotalLoansByBranch]    Script Date: 11/30/2020 11:36:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_TotalLoansByBranch] AS (
SELECT tbd.branch_desc
     , COUNT(tad.pri_cust_id) AS 'Count Of Customers'
     , SUM(tad.loan_amt) AS 'Total Loan Amount'
  FROM dbo.tblAccountDim AS tad
       JOIN
       dbo.tblBranchDim AS tbd ON tad.branch_id = tbd.branch_id
WHERE year(tad.open_date) > 2017
 GROUP BY tbd.branch_desc)
GO
/****** Object:  View [dbo].[v_BranchSummary]    Script Date: 11/30/2020 11:36:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_BranchSummary] AS (
SELECT ad.branch_id AS 'Branch ID'
     , tbd.branch_desc AS 'Branch Name'
     , YEAR(ad.open_date) AS 'Year'
     , SUM(ad.loan_amt) AS 'Total Loan Amount'
  FROM dbo.tblAccountDim AS ad
       JOIN
       dbo.tblBranchDim AS tbd ON ad.branch_id = tbd.branch_id
 WHERE YEAR(ad.open_date) IN
                            (
                             2017
                           , 2018
                           , 2019
                            )
 GROUP BY ad.branch_id
        , tbd.branch_desc
        , YEAR(ad.open_date))
GO
/****** Object:  View [dbo].[v_RegionSummary]    Script Date: 11/30/2020 11:36:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_RegionSummary] AS (
 SELECT tbd.region_id AS 'Region ID'
     , YEAR(ad.open_date) AS 'Year'
     , SUM(ad.loan_amt) AS 'Total Loan Amount'
  FROM dbo.tblAccountDim AS ad
       JOIN
       dbo.tblBranchDim AS tbd ON ad.branch_id = tbd.branch_id
 WHERE YEAR(ad.open_date) IN
                            (
                             2017
                           , 2018
                           , 2019
                            )
 GROUP BY tbd.region_id
        , YEAR(ad.open_date)
);
GO
/****** Object:  View [dbo].[v_AreaSummary]    Script Date: 11/30/2020 11:36:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_AreaSummary] AS (
 SELECT tbd.area_id AS 'Area ID'
     , YEAR(ad.open_date) AS 'Year'
     , SUM(ad.loan_amt) AS 'Total Loan Amount'
  FROM dbo.tblAccountDim AS ad
       JOIN
       dbo.tblBranchDim AS tbd ON ad.branch_id = tbd.branch_id
 WHERE YEAR(ad.open_date) IN
                            (
                             2017
                           , 2018
                           , 2019
                            )
 GROUP BY tbd.area_id
        , YEAR(ad.open_date));
GO
/****** Object:  View [dbo].[v_TransactionsBranches]    Script Date: 11/30/2020 11:36:47 PM ******/
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
/****** Object:  Table [dbo].[tblTransactionTypeDim]    Script Date: 11/30/2020 11:36:47 PM ******/
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
/****** Object:  View [dbo].[v_TransactionsTypesYear]    Script Date: 11/30/2020 11:36:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_TransactionsTypesYear] AS
SELECT distinct 
tbd.branch_desc AS 'Name of Branch'
,tttd.tran_type_desc
,count(tf.tran_date) AS 'Number of Transactions'
,year(tf.tran_date) AS 'Year of Transaction'
FROM dbo.tblTransactionFact tf
INNER JOIN dbo.tblBranchDim tbd ON tbd.branch_id = tf.branch_id
INNER JOIN dbo.tblTransactionTypeDim tttd ON tf.tran_type_id = tttd.tran_type_id
GROUP BY
tbd.branch_desc
,tttd.tran_type_desc
,year(tf.tran_date)
GO
/****** Object:  View [dbo].[v_TotalAmaount]    Script Date: 11/30/2020 11:36:47 PM ******/
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
/****** Object:  View [dbo].[v_CustomersBristol]    Script Date: 11/30/2020 11:36:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_CustomersBristol] AS
SELECT sp.cust_id,sp.last_name, sp.first_name
FROM dbo.stg_p1 sp
WHERE sp.acct_branch_code = 'BR' 
GO
/****** Object:  View [dbo].[v_CustomersClinton]    Script Date: 11/30/2020 11:36:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_CustomersClinton] AS
SELECT sp.cust_id,sp.last_name, sp.first_name
FROM dbo.stg_p1 sp
WHERE sp.acct_branch_code = 'CL' 
GO
/****** Object:  View [dbo].[v_CustomersFairview]    Script Date: 11/30/2020 11:36:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_CustomersFairview] AS
SELECT sp.cust_id,sp.last_name, sp.first_name
FROM dbo.stg_p1 sp
WHERE sp.acct_branch_code = 'FV' 
GO
/****** Object:  View [dbo].[v_CustomersFranklin]    Script Date: 11/30/2020 11:36:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_CustomersFranklin] AS
SELECT sp.cust_id,sp.last_name, sp.first_name
FROM dbo.stg_p1 sp
WHERE sp.acct_branch_code = 'FR' 
GO
/****** Object:  View [dbo].[v_CustomersGeorgeTown]    Script Date: 11/30/2020 11:36:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_CustomersGeorgeTown] AS
SELECT sp.cust_id,sp.last_name, sp.first_name
FROM dbo.stg_p1 sp
WHERE sp.acct_branch_code = 'GT' 
GO
/****** Object:  View [dbo].[v_CustomersWashington]    Script Date: 11/30/2020 11:36:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_CustomersWashington] AS
SELECT sp.cust_id,sp.last_name, sp.first_name
FROM dbo.stg_p1 sp
WHERE sp.acct_branch_code = 'WA' 
GO
/****** Object:  Table [dbo].[tblAccountCustomerDim]    Script Date: 11/30/2020 11:36:47 PM ******/
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
/****** Object:  Table [dbo].[tblAccountCustomerRoleDim]    Script Date: 11/30/2020 11:36:47 PM ******/
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
/****** Object:  Table [dbo].[tblAccountFact]    Script Date: 11/30/2020 11:36:47 PM ******/
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
/****** Object:  Table [dbo].[tblAddressDim]    Script Date: 11/30/2020 11:36:47 PM ******/
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
/****** Object:  Table [dbo].[tblAreaDim]    Script Date: 11/30/2020 11:36:47 PM ******/
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
/****** Object:  Table [dbo].[tblBranchGoal]    Script Date: 11/30/2020 11:36:47 PM ******/
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
/****** Object:  Table [dbo].[tblProductDim]    Script Date: 11/30/2020 11:36:47 PM ******/
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
/****** Object:  Table [dbo].[tblRegionDim]    Script Date: 11/30/2020 11:36:47 PM ******/
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
