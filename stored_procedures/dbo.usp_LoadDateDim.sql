USE [DFNB3]
GO

/****** Object:  StoredProcedure [dbo].[usp_LoadDateDim]    Script Date: 11/17/2019 6:06:29 PM ******/
DROP PROCEDURE [dbo].[usp_LoadDateDim]
GO

/****** Object:  StoredProcedure [dbo].[usp_LoadDateDim]    Script Date: 11/17/2019 6:06:29 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_LoadDateDim] (@v_num_years as INT)
AS
BEGIN
/*****************************************************************************************************************
NAME:    dbo.usp_LoadDateDim
PURPOSE: Load the Date Dimension table

SUPPORT: Jaussi Consulting LLC
         www.jaussiconsulting.net
         jon@jaussiconsulting.net

MODIFICATION LOG:
Ver       Date         Author       Description
-------   ----------   ----------   -----------------------------------------------------------------------------
1.0       11/17/2019   JJAUSSI      1. Built this starter script for LDS BC IT 243


RUNTIME: 
1 sec

NOTES: 
Load the Date Dimension - inspired by the Kimball Group's Calendar Date Dimension

LICENSE: 
This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.

******************************************************************************************************************/

-- Q1: Where to get the sample data from?
-- A1: Here it is...dump it to Excel > Date Dimension - sample v1.0.xlsx

--SELECT d.*
--  FROM RPT.dbo.datedim AS d
-- WHERE d.year_number = 2019
--       OR date_id IN
--                    (
--                     18500101
--                   , 99991231
--                    );



-- Q2: What are the first and last dates in the Date Dimension?
-- A2: Here they are > 99991231 is the go to default date > 250 years total

--SELECT MIN(d.date_id)
--     , MAX(d.date_id)
--  FROM RPT.dbo.datedim AS d;

--SELECT COUNT(1)
--  FROM RPT.dbo.DateDim AS dd;
---- 91,677 = 250 years + 1 day

--SELECT TOP 2 *
--  FROM RPT.dbo.DateDim AS dd
-- ORDER BY dd.date_id DESC;

-- 18500101 -- First day
-- 21001231 -- Last day
-- 99991231 -- Default day

--SELECT d.*
--  FROM RPT.dbo.datedim AS d
-- WHERE d.day_date = format((GETDATE() + n.n), 'yyyy-MM-dd');



-- Q3: How to load the Date Dimension
-- A3: Use dbo.Nums and figure it out

TRUNCATE TABLE dbo.DateDim;

INSERT INTO dbo.DateDim
SELECT TOP 10 
          --n.n
            CONVERT(VARCHAR, (GETDATE() + n.n), 112) AS date_id
           , FORMAT((GETDATE() + n.n), 'yyyy-MM-dd') AS day_date
           , DATEPART(WEEKDAY, (GETDATE() + n.n)) AS day_number_in_week
           , DAY((GETDATE() + n.n)) AS day_number_in_month
           , DATEPART(dayofyear, (GETDATE() + n.n)) AS day_number_in_year
           , DATENAME(WEEKDAY, (GETDATE() + n.n)) AS day_name
           , FORMAT((GETDATE() + n.n), 'ddd') AS day_abbreviation
           , 1 AS process_day_ind
           , DATENAME(WEEK, (GETDATE() + n.n)) AS week_number_in_year
           , FORMAT(DATEADD(dd, -(DATEPART(dw, (GETDATE() + n.n)) - 1), (GETDATE() + n.n)), 'yyyy-MM-dd') AS week_start_date
           , CONVERT(VARCHAR, DATEADD(dd, -(DATEPART(dw, (GETDATE() + n.n)) - 1), (GETDATE() + n.n)), 112) AS week_start_date_id
           , FORMAT(DATEADD(dd, 7 - DATEPART(dw, (GETDATE() + n.n)), (GETDATE() + n.n)), 'yyyy-MM-dd') AS week_end_date
           , CONVERT(VARCHAR, DATEADD(dd, 7 - DATEPART(dw, (GETDATE() + n.n)), (GETDATE() + n.n)), 112) AS week_end_date_id
           , '' AS weekday_flag
           , '' AS weekend_flag
           , '' AS last_day_in_week_flag
           , '' AS month_number
           , '' AS month_name
           , '' AS month_abbreviation
           , '' AS month_last_day_number
           , '' AS month_start_date
           , '' AS month_start_date_id
           , '' AS month_end_date
           , '' AS month_end_date_id
           , '' AS month_end_date_previous
           , '' AS month_end_date_previous_id
           , '' AS last_day_in_month_flag
           , '' AS quarter_number
           , '' AS quarter_name
           , '' AS quarter_code
           , '' AS quarter_start_date
           , '' AS quarter_start_date_id
           , '' AS quarter_end_date
           , '' AS quarter_end_date_id
           , '' AS last_day_in_quarter_flag
           , '' AS year_number
           , '' AS year_start_date
           , '' AS year_start_date_id
           , '' AS year_end_date
           , '' AS year_end_date_id
           , '' AS yyyymm
           , '' AS last_day_in_year_flag
           , '' AS holiday_ind
           , '' AS holiday_name
  FROM dbo.Nums AS n;

  END;
GO


