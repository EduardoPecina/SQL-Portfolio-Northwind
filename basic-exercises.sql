-- ============================================
-- NORTHWIND SQL EXERCISES
-- ============================================

-- 1. Display a table with categories and their descriptions (8 rows expected)
SELECT CategoryName, Description
FROM Categories;
-- 2. Display a table with contact names, customer IDs, and company names
--    for all customers from London (6 rows expected)
SELECT CustomerID, CompanyName
FROM Customers 
WHERE City = 'London';
-- 3. Display all available columns from suppliers that have a fax number (13 rows expected)
SELECT SupplierID, CompanyName
FROM Suppliers 
WHERE Fax IS NOT NULL;
-- 4. Count the total number of orders from 1997 (Expected result: 408)
SELECT COUNT (OrderID)
FROM Orders 
WHERE OrderDate BETWEEN '1997-01-01' AND '1997-12-31'
------------------------------------------------------------------------------
SELECT COUNT (OrderID)
FROM Orders 
WHERE OrderDate >= '1997-01-01'AND OrderDate < '1998-01-01'
-- 5. Display a table with all contacts who are business owners
--    from Mexico, Norway, and Germany (5 rows expected)
SELECT ContactName, Phone 
FROM Customers 
WHERE ContactTitle = 'Owner' AND Country IN ('Mexico', 'Norway', 'Germany');
-- 6. Display the list of discontinued products (8 rows expected)
SELECT ProductID, ProductName
FROM Products
WHERE Discontinued = 1;
-- 7. Display categories that start with 'Co' (2 rows expected)
SELECT CategoryName
FROM Categories
WHERE CategoryName LIKE 'Co%';
-- 8. Display a list of company names, cities, countries, and postal codes
--    of suppliers whose address contains the word 'rue'
--    Order the result alphabetically by company name (5 rows expected)
SELECT CompanyName, City, PostalCode
FROM Suppliers 
WHERE Address LIKE '%rue%'
ORDER BY CompanyName ASC;
-- 9. Display the top 10 order IDs along with total units for each order (10 rows expected)
SELECT OrderID, SUM(Quantity) AS Total_Qty
FROM OrderDetails
GROUP BY OrderID
ORDER BY Total_Qty DESC 
LIMIT 10;
-- 10. Display the list of products in the 'Condiments' category (12 rows expected)
SELECT ProductID, ProductName
FROM Products P
JOIN Categories C
ON P.CategoryID = C.CategoryID 
WHERE CategoryName = 'Condiments'
ORDER BY ProductName ASC;
------------------------------------------------------------------------------
SELECT ProductID, ProductName
FROM Products P
JOIN Categories C
ON P.CategoryID = C.CategoryID 
WHERE C.CategoryID = 2
ORDER BY ProductName ASC;
-- 11. Select all employees with their full names who were 40 years or older
--     at the time of hiring (3 rows expected)
SELECT FirstName, LastName, (HireDate - BirthDate) AS Antiquity
FROM Employees 
WHERE Antiquity >= 40;
-- 12. Display contact names and addresses of customers who placed orders
--     shipped via 'Speedy Express' (249 rows expected)
SELECT ContactName, Address
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE ShipVia = 1
------------------------------------------------------------------------------
SELECT ContactName, Address 
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN Shippers S ON O.ShipVia = S.ShipperID
WHERE S.CompanyName = 'Speedy Express'
-- 13. Display the list of customers who have not made any purchases (4 rows expected)
SELECT ContactName 
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID 
WHERE O.OrderID IS NULL
-- 14. Display a list of products with total units in stock greater than 100
--     Name the total column as 'TotalUnits' (10 rows expected)
SELECT ProductName, SUM(UnitsInStock) AS TotalUnits 
FROM Products 
WHERE UnitsInStock > 100
GROUP BY ProductName
ORDER BY TotalUnits DESC;
-- 15. Display employees and customers involved in orders shipped to Brussels
--     via 'Speedy Express' (2 rows expected)
SELECT E.LastName ||' '|| E.FirstName AS Employee_Name, C.CompanyName AS Customer_Name
FROM Employees E
JOIN Orders O ON E.EmployeeID = O.EmployeeID 
JOIN Customers C ON C.CustomerID = O.CustomerID 
WHERE O.ShipCity = 'Bruxelles' AND O.ShipVia = 1;
-- 16. Select job title and full names of employees who sold at least one unit
--     of 'Queso Cabrales' or 'Tofu' (9 rows expected)
SELECT DISTINCT E.FirstName ||' '|| E.LastName AS EmployeeName, E.Title 
FROM Employees E 
JOIN Orders O ON E.EmployeeID = O.EmployeeID 
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
WHERE OD.ProductID = 11 OR OD.ProductID = 14;
-- 17. List employees' full names along with their managers' last names
--     (include NULLs where there is no manager) (9 rows expected)
SELECT E.FirstName ||' '|| E.LastName AS EmployeeName, EE.LastName AS BossSurname
FROM Employees E 
LEFT JOIN Employees EE ON EE.EmployeeID = E.ReportsTo
-- 18. Select DISTINCT contact names, product names, and supplier company names
--     for customers in London and suppliers named 'Karkki Oy' or 'Pavlova, Ltd.' (9 rows)
SELECT DISTINCT C.ContactName, P.ProductName, S.CompanyName 
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID 
JOIN OrderDetails OD ON O.OrderID = OD.OrderID 
JOIN Products P ON P.ProductID = OD.ProductID 
JOIN Suppliers S ON P.SupplierID = S.SupplierID
WHERE C.City = 'London' AND S.CompanyName IN ('Karkki Oy', 'Pavlova, Ltd.');
-- 19. Select product names for orders where either the customer or employee
--     is from London (76 rows expected)
SELECT DISTINCT P.ProductName
FROM Products P 
JOIN OrderDetails OD ON P.ProductID = OD.ProductID 
JOIN Orders O ON OD.OrderID = O.OrderID 
JOIN Customers C ON O.CustomerID = C.CustomerID 
JOIN Employees E ON O.EmployeeID = E.EmployeeID 
WHERE C.City = 'London' OR E.City = 'London';
-- 20. Display customers who bought products with a unit price lower than 3 (26 rows)
SELECT DISTINCT C.CompanyName 
FROM Customers C
JOIN Invoices I ON C.CustomerID = I.CustomerID 
WHERE I.UnitPrice < 3;
-- 21. Select full names of employees who have worked longer than any employee
--     from London (use CURRENT_DATE) (4 rows expected)
-- CTE
-- 1. Tenure of ALL employees
WITH total_tenure AS (SELECT FirstName ||' '|| LastName AS EmployeeName, CURRENT_DATE - HireDate AS Tenure FROM Employees),
-- 2. maximum tenure ONLY for London employees
max_per_place AS (SELECT MAX(CURRENT_DATE - HireDate) AS max_tenure_london FROM Employees WHERE City = 'London')
-- 3. employees whose tenure > that value
SELECT EmployeeName, total_tenure.Tenure
FROM total_tenure, max_per_place 
WHERE total_tenure.Tenure > max_per_place.max_tenure_london
-- 22. List the full names and the city where they live,
-- for all employees who have sold to customers from the same city [6 rows].
SELECT DISTINCT E.FirstName || ' ' || E.LastName AS EmployeeName, E.City AS EmployeeCity
FROM Employees E 
JOIN Orders O ON E.EmployeeID = O.EmployeeID 
JOIN Customers C ON C.CustomerID = O.CustomerID 
WHERE E.City = C.City;
-- 23. Display the average price for each category [8 rows].
SELECT C.CategoryName, AVG(P.UnitPrice) AS AVG_By_Category
FROM Products P
JOIN Categories C ON P.CategoryID = C.CategoryID 
GROUP BY C.CategoryName
ORDER BY AVG_By_Category DESC;
-- 24. List the company names of suppliers that provide more than 4 products [2 rows].
SELECT S.CompanyName, COUNT(P.ProductID) AS TotalProdSupplied
FROM Suppliers S 
JOIN Products P ON S.SupplierID = P.SupplierID
GROUP BY S.CompanyName
HAVING TotalProdSupplied > 4
-- 25. List employee IDs, their full names, and the number of distinct products they have sold. 
-- The result must be sorted in ascending order by employee ID [9 rows].
SELECT E.EmployeeID, E.FirstName ||' '|| E.LastName AS EmployeeName, COUNT(DISTINCT P.ProductID) AS Count_of_Different_Products_Sold
FROM Employees E 
JOIN Orders O ON E.EmployeeID = O.EmployeeID 
JOIN OrderDetails OD ON O.OrderID = OD.OrderID 
JOIN Products P ON OD.ProductID = P.ProductID 
GROUP BY E.EmployeeID
ORDER BY E.EmployeeID ASC;
-- 26. List employee IDs, their full names, and the total revenue generated by each one. 
-- The result must be sorted in ascending order by employee ID [9 rows].
SELECT E.EmployeeID, E.FirstName ||' '|| E.LastName AS EmployeeName, SUM(I.ExtendedPrice) AS TotalRevenue
FROM Employees E
JOIN Orders O ON E.EmployeeID = O.EmployeeID 
JOIN Invoices I ON O.OrderID = I.OrderID 
GROUP BY E.EmployeeID 
ORDER BY E.EmployeeID ASC;
-- 27. Display the top 5 shipping cities by total revenue [5 rows].
SELECT ShipCity, SUM(ExtendedPrice) AS TotalRevenue 
FROM Invoices 
GROUP BY ShipCity  
ORDER BY TotalRevenue DESC
LIMIT 5;
-- 28. Display the top 5 products by total units sold [5 rows].
SELECT P.ProductName, SUM(I.Quantity) AS TotalQtySold 
FROM Products P
JOIN OrderDetails OD ON P.ProductID = OD.ProductID 
JOIN Invoices I ON OD.OrderID = I.OrderID 
GROUP BY P.ProductID
ORDER BY TotalQtySold DESC
LIMIT 5;
-- 29. List the distinct customers who have purchased products in the 'Beverages' category [83 rows].
SELECT DISTINCT C.CompanyName, COUNT(O.OrderID) AS TotalProducts
FROM Customers C 
JOIN Orders O ON C.CustomerID = O.CustomerID 
JOIN OrderDetails OD ON O.OrderID = OD.OrderID 
JOIN Products P ON P.ProductID = OD.ProductID
JOIN Categories CC ON CC.CategoryID = P.CategoryID 
WHERE CC.CategoryName = 'Beverages'
GROUP BY C.CompanyName
ORDER BY TotalProducts DESC;
------------------------------------------------------------------------------
SELECT DISTINCT C.CompanyName, SUM(OD.Quantity) AS TotalProducts
FROM Customers C 
JOIN Orders O ON C.CustomerID = O.CustomerID 
JOIN OrderDetails OD ON O.OrderID = OD.OrderID 
JOIN Products P ON P.ProductID = OD.ProductID
JOIN Categories CC ON CC.CategoryID = P.CategoryID 
WHERE CC.CategoryName = 'Beverages'
GROUP BY C.CompanyName
ORDER BY TotalProducts DESC;
-- 30. Rank suppliers by the number of distinct products sold [29 rows].
SELECT S.CompanyName, COUNT(DISTINCT OD.ProductID) AS TotalDistinctProductsSold
FROM Suppliers S
JOIN Products P ON S.SupplierID = P.SupplierID 
JOIN OrderDetails OD ON P.ProductID = OD.ProductID 
GROUP BY S.CompanyName 
ORDER BY TotalDistinctProductsSold DESC;
-- 31. How many orders were placed in June 1997?
SELECT COUNT (O.OrderID) AS JuneTotalOrders
FROM Orders O
WHERE O.OrderDate >= '1997-06-01' AND O.OrderDate < '1997-07-01'
-- 32. What was the day with the highest number of orders in 1998?
SELECT COUNT (O.OrderID) AS TotalOrders, O.OrderDate
FROM Orders O
WHERE O.OrderDate >= '1998-01-01' AND O.OrderDate < '1999-01-01'
GROUP BY O.OrderDate
ORDER BY TotalOrders DESC
LIMIT 1;
-- 33. Which employee ID generated the highest total revenue?
SELECT E.EmployeeID, E.FirstName ||' '|| E.LastName AS EmployeeName, SUM(I.ExtendedPrice) AS TotalRevenue
FROM Employees E
JOIN Orders O ON E.EmployeeID = O.EmployeeID 
JOIN Invoices I ON O.OrderID = I.OrderID 
GROUP BY E.EmployeeID 
ORDER BY TotalRevenue DESC 
LIMIT 1;
-- 34. Which shipping country generated the highest total revenue from Freight?
SELECT Country, SUM(Freight) AS FreightRevenue 
FROM Invoices 
GROUP BY Country
ORDER BY FreightRevenue DESC
LIMIT 1;

-- =========================================================================================
-- VISUALIZATIONS SECTION 
-- =========================================================================================

-- 35. Calculate total sales by year (tabular + column chart)
SELECT strftime('%Y', I.OrderDate) AS Year, SUM(I.ExtendedPrice) AS TotalSales
FROM Invoices I 
GROUP BY Year
ORDER BY Year DESC;
-- 36. Calculate total sales by month for 1997 (tabular + line chart)
SELECT strftime ('%m', I.OrderDate) AS Month, SUM (I.ExtendedPrice) AS TotalSales
FROM Invoices I 
WHERE strftime('%Y', I.OrderDate) = '1997'
GROUP BY Month
ORDER BY Month ASC;
-- 37. Calculate total sales by year for the 'Condiments' category
--     (tabular + bar chart)
SELECT strftime('%Y', I.OrderDate) AS Year, SUM(I.ExtendedPrice) AS TotalSales
FROM Invoices I 
JOIN OrderDetails OD ON I.OrderID = OD.OrderID 
JOIN Products P ON OD.ProductID = P.ProductID
JOIN Categories C ON P.CategoryID = C.CategoryID 
WHERE C.CategoryName = 'Condiments'
GROUP BY Year
ORDER BY Year DESC;
-- 38. Show how many orders were shipped by each company:
--     Speedy Express, United Package, Federal Shipping
--     (tabular + pie chart)
SELECT S.CompanyName, COUNT(O.OrderID) AS TotalOrders 
FROM Orders O 
JOIN Shippers S ON O.ShipVia = S.ShipperID 
WHERE S.CompanyName IN ('Speedy Express', 'United Package', 'Federal Shipping')
GROUP BY S.CompanyName
-- 39. Show monthly revenue for 1997 comparing 'Beverages' vs 'Confections'
--     Each row = month, each column = category (tabular + line chart)
SELECT strftime ('%m', I.OrderDate) AS Month, 

SUM(CASE 
WHEN C.CategoryName = 'Beverages' 
THEN I.ExtendedPrice 
ELSE 0 
END) AS Beverages,  

SUM(CASE 
WHEN C.CategoryName = 'Confections' 
THEN I.ExtendedPrice 
ELSE 0 
END) AS Confections

FROM Invoices I 
JOIN OrderDetails OD ON I.OrderID = OD.OrderID 
JOIN Products P ON OD.ProductID = P.ProductID 
JOIN Categories C ON P.CategoryID = C.CategoryID 
WHERE strftime('%Y', I.OrderDate) = '1997' AND C.CategoryName IN ('Beverages', 'Confections')
GROUP BY Month
ORDER BY Month ASC;
