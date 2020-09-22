Homework

/*Q1: By Order Quantity, what were the five most popular products sold in 2014?
Include these data points in the output:
Order Date Year
Product ID
Product Number
Product Color
Sales Order Count
Order Quantity
Sales Order Line total
*/

SELECT TOP 5 YEAR(soh.OrderDate) AS OrderYear
           , p.ProductID
           , p.Name AS ProductName
           , p.ProductNumber
           , p.Color
           , COUNT(sod.SalesOrderID) AS SalesOrderIDCount
           , SUM(sod.OrderQty) AS SumOrderQty
           , SUM(sod.LineTotal) AS SumLineTotal
  FROM Production.Product AS p
       JOIN
       Sales.SalesOrderDetail AS sod ON p.ProductID = sod.ProductID
       JOIN
       Sales.SalesOrderHeader AS soh ON sod.SalesOrderID = soh.SalesOrderID
 WHERE YEAR(soh.OrderDate) = 2014
 GROUP BY YEAR(soh.OrderDate)
        , p.ProductID
        , p.Name
        , p.ProductNumber
        , p.Color
 ORDER BY SumOrderQty DESC;

 
A1:
2014 870 Water Bottle - 30 oz. WB-H098 NULL  2273  2902  12900.317660
2014  712 AWC Logo Cap  CA-1098 Multi 1267  1950  14430.970952
2014  711 Sport-100 Helmet, Blue  HL-U509-B Blue  1221  1776  52353.591556
2014  873 Patch Kit/8 Patches PK-7098 NULL  1608  1761  3850.406000
2014  707 Sport-100 Helmet, Red HL-U509-R Red 1231  1717  51697.665517

 /*Q2: How long are the 7 longest Person names and to whom do they belong? Rank by Full Name length, Last Name Length, First Name Length

Include these data points in the output:
Business Entity ID
Full Name
Full Name Length
First Name
First Name Length
Middle Name
Last Name
Last Name Length*/

SELECT TOP 7 p.BusinessEntityID
           , p.FirstName + ' ' + p.MiddleName + ' ' + p.LastName AS FullName
           , LEN(p.FirstName + p.MiddleName + p.LastName) AS FullNameLength
           , p.FirstName
           , LEN(p.FirstName) AS FirstNameLength
           , p.MiddleName
           , LEN(p.MiddleName) AS MiddleNameLength
           , p.LastName
           , LEN(p.LastName) AS LastNameLength
  FROM Person.Person AS p
 ORDER BY FullNameLength DESC;

A2:
4388 Osarumwense Uwaifiokun Agbonile 29  Osarumwense 11  Uwaifiokun  10  Agbonile  8
272 Janaina Barreiro Gambaro Bueno  28  Janaina 7 Barreiro Gambaro  16  Bueno 5
2348  Janaina Barreiro Gambaro Bueno  28  Janaina 7 Barreiro Gambaro  16  Bueno 5
1979  Ranjit Rudra Varkey Chudukatil  28  Ranjit  6 Rudra 5 Varkey Chudukatil 17
1619  Paulo Sergio Da Silva Pinto 25  Paulo 5 Sergio Da Silva 15  Pinto 5
22  Sariya E Harnpadoungsataya  24  Sariya  6 E 1 Harnpadoungsataya 17
290 Ranjit R Varkey Chudukatil  24  Ranjit  6 R 1 Varkey Chudukatil 17
'

/*Q3: Which Department pays its female workers on average the most per year?
Include these fields:
Department ID
Department Name
Gender
Total Yearly Pay
Business Entity ID Count
Average Yearly Pay*/
WITH p1 
as (
SELECT d.DepartmentID
     , d.Name AS DepartmentName
     , e.Gender
     , e.SalariedFlag
     , eph.Rate
     , eph.PayFrequency
     , CASE
           WHEN e.SalariedFlag = 1
           THEN eph.Rate * 1000
           WHEN e.SalariedFlag = 0
           THEN eph.Rate * 2080
           ELSE 0
       END AS YearlyPay
     , COUNT(e.BusinessEntityID) AS BusinessEntityIDCount
   ,CASE
           WHEN e.SalariedFlag = 1
           THEN eph.Rate * 1000
           WHEN e.SalariedFlag = 0
           THEN eph.Rate * 2080
           ELSE 0
       END * COUNT(e.BusinessEntityID) AS TotalYearlyPay
  FROM HumanResources.Department AS d
       JOIN
       HumanResources.EmployeeDepartmentHistory AS edh ON d.DepartmentID = edh.DepartmentID
       JOIN
       HumanResources.EmployeePayHistory AS eph ON edh.BusinessEntityID = eph.BusinessEntityID
       JOIN
       HumanResources.Employee AS e ON edh.BusinessEntityID = e.BusinessEntityID
 WHERE e.Gender LIKE 'F'
 GROUP BY d.DepartmentID
        , d.Name
        , e.Gender
        , e.SalariedFlag
        , eph.Rate
        , eph.PayFrequency
      )
SELECT p.DepartmentID
     , p.DepartmentName
     , p.Gender
     , SUM(p.BusinessEntityIDCount) AS BusinessEntityIDCount
     , SUM(p.TotalYearlyPay) AS TotalYearlyPay
     , SUM(p.TotalYearlyPay) / SUM(p.BusinessEntityIDCount) AS AvgYearlyPay
  FROM p1 AS p
 GROUP BY p.DepartmentID
        , p.DepartmentName
        , p.Gender
 ORDER BY AvgYearlyPay DESC;

A:3
2  Tool Design F 1 52000.00  52000.00
16  Executive F 3 147713.90 49237.9666
1 Engineering F 3 128846.10 42948.70
10  Finance F 8 335985.40 41998.175
6 Research and Development  F 2 81730.80  40865.40
11  Information Services  F 4 144951.90 36237.975
9 Human Resources F 2 61639.32  30819.66
7 Production  F 46  1322464.00  28749.2173
5 Purchasing  F 6 164879.872  27479.9786
3 Sales F 7 186562.40 26651.7714
4 Marketing F 7 178359.936  25479.9908
12  Document Control  F 1 21320.00  21320.00
13  Quality Assurance F 3 62360.00  20786.6666
14  Facilities and Maintenance  F 2 38480.00  19240.00
15  Shipping and Receiving  F 2 37440.00  18720.00