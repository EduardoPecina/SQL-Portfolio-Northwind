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

-- 7. Display categories that start with 'Co' (2 rows expected)

-- 8. Display a list of company names, cities, countries, and postal codes
--    of suppliers whose address contains the word 'rue'
--    Order the result alphabetically by company name (5 rows expected)

-- 9. Display the top 10 order IDs along with total units for each order (10 rows expected)

-- 10. Display the list of products in the 'Condiments' category (12 rows expected)

-- 11. Select all employees with their full names who were 40 years or older
--     at the time of hiring (3 rows expected)

-- 12. Display contact names and addresses of customers who placed orders
--     shipped via 'Speedy Express' (249 rows expected)

-- 13. Display the list of customers who have not made any purchases (4 rows expected)

-- 14. Display a list of products with total units in stock greater than 100
--     Name the total column as 'TotalUnits' (10 rows expected)

-- 15. Display employees and customers involved in orders shipped to Brussels
--     via 'Speedy Express' (2 rows expected)

-- 16. Select job title and full names of employees who sold at least one unit
--     of 'Queso Cabrales' or 'Tofu' (9 rows expected)

-- 17. List employees' full names along with their managers' last names
--     (include NULLs where there is no manager) (9 rows expected)

-- 18. Select DISTINCT contact names, product names, and supplier company names
--     for customers in London and suppliers named 'Karkki Oy' or 'Pavlova, Ltd.' (9 rows)

-- 19. Select product names for orders where either the customer or employee
--     is from London (76 rows expected)

-- 20. Display customers who bought products with a unit price lower than 3 (26 rows)

-- 21. Select full names of employees who have worked longer than any employee
--     from London (use CURRENT_DATE) (4 rows expected)

-- 22. Display full names and city of employees who have sold to customers
--     from the same city (6 rows expected)

-- 23. Display the average price per category (8 rows expected)

-- 24. Display company names that supply more than 4 products (2 rows expected)

-- 25. Display employee IDs, full names, and number of distinct products sold
--     Order by employee ID ascending (9 rows expected)

-- 26. Display employee IDs, full names, and total sales amount per employee
--     Order by employee ID ascending (9 rows expected)

-- 27. Display the top 5 shipping cities by revenue (5 rows expected)

-- 28. Display the top 5 products by units sold (5 rows expected)

-- 29. Display distinct customers who bought products in the 'Beverages' category (83 rows)

-- 30. Rank suppliers by number of distinct products sold (29 rows expected)

-- 31. How many orders were made in June 1997?

-- 32. Which day had the highest number of orders in 1998?

-- 33. Which employee ID had the highest sales?

-- 34. Which shipping country generated the highest freight revenue?

-- 35. Calculate total sales by year (tabular + column chart)

-- 36. Calculate total sales by month for 1997 (tabular + line chart)

-- 37. Calculate total sales by year for the 'Condiments' category
--     (tabular + bar chart)

-- 38. Show how many orders were shipped by each company:
--     Speedy Express, United Package, Federal Shipping
--     (tabular + pie chart)

-- 39. Show monthly revenue for 1997 comparing 'Beverages' vs 'Confections'
--     Each row = month, each column = category (tabular + line chart)
``
