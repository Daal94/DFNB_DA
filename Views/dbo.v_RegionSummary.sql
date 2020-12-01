/*****************************************************************************************************************
NAME:    [v_RegionSummary]
PURPOSE: View creation [v_RegionSummary]
MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/21/2020   DARENA       1. Built this table for IT240
RUNTIME: 
Approx. 1 min
NOTES:
Creates [v_RegionSummary]

LICENSE: This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
 
******************************************************************************************************************/


USE [DFNB2]
GO

/****** Object:  View [dbo].[v_RegionSummary]    Script Date: 11/30/2020 11:32:28 PM ******/
DROP VIEW [dbo].[v_RegionSummary]
GO

/****** Object:  View [dbo].[v_RegionSummary]    Script Date: 11/30/2020 11:32:28 PM ******/
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


