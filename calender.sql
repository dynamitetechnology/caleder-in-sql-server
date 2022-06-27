CREATE OR ALTER PROCEDURE calender(@start_date DATE, @end_date DATE)
AS
BEGIN

	--DECLARE @start_date DATE = '2022-06-27';
	--DECLARE @end_date DATE = '2023-06-27';
	DECLARE @DateDiff INT;
	DECLARE @count INT;
	SET @count = 0; -- DAY ONE COUNT OF START DATE
	SET @DateDiff = DATEDIFF(DAY, @start_date, @end_date) -- DIFF BTW TWO DATE

	DROP TABLE IF EXISTS #temp_cal
	CREATE TABLE #temp_cal(
	id INT IDENTITY(1,1) PRIMARY KEY,
	d_date DATE, 
	end_date DATE
	)

	WHILE @count <= @DateDiff BEGIN
	INSERT INTO #temp_cal(d_date, end_date) VALUES(DATEADD(DAY, @count, @start_date), @end_date);
	 SET @count = @count + 1; 
	END

	SELECT DAY(d_date) AS 'DAY', MONTH(d_date) as 'MONTH', DATENAME(weekday, d_date) as 'DAY_NAME',
	DATENAME(month, d_date) as 'MONTH_NAME', DATENAME(year, d_date) as 'YEAR', d_date as 'DATE',
	DATENAME(week, d_date) as 'WEEK', DATEPART(DY, d_date) AS 'DAY_OF_YEAR',
	DATEPART(ISO_WEEK, d_date) AS 'ISO_WEEK', DATEPART(wk, d_date) AS 'US WEEK',
	DATEPART(wk, d_date) AS 'WEEK_OF_YEAR',
	DATEDIFF(DAY,d_date, end_date) AS 'NUMBER_OF_DAYS_IN_MONTH',
	DATEDIFF(WEEK,d_date,end_date) AS 'WEEKS_IN_YEAR',
	DATEDIFF(MONTH,d_date,end_date) AS 'MONTHS_IN_YEAR',
	FORMAT(d_date, 'D', 'en-US' ) 'CULTURES_FOR_US'  
	FROM #temp_cal
END

EXEC calender @start_date = '2023-01-01', @end_date = '2023-12-31';
