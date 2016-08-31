-- 1) Write a query to return all category names with their descriptions from the Categories table.

SELECT CategoryName, Description FROM Categories;

--2) Write a query to return the contact name, customer id, company name and city name of all Customers in London

SELECT ContactName, CustomerID, CompanyName, City FROM Customers;

--3) Write a query to return all available columns in the Suppliers tables for the marketing managers and sales representatives that have a FAX number

SELECT ContactName FROM Suppliers WHERE ContactTitle = 'Marketing Manager' OR ContactTitle = 'Sales Representative';

--4) Write a query to return a list of customer id's from the Orders table with required dates between Jan 1, 
--   1997 and Dec 31, 1997 and with freight under 100 units.

SELECT CustomerID FROM Orders WHERE RequiredDate BETWEEN '1997-01-01' AND '1997-12-31' AND Freight < 100;

--5) Write a query to return a list of company names and contact names of all customers from Mexico, Sweden and Germany.

SELECT CompanyName, ContactName FROM Customers WHERE Country IN ('Mexico', 'Sweden', 'Germany');

--6) Write a query to return a count of the number of discontinued products in the Products table.

SELECT COUNT(Discontinued) FROM Products WHERE Discontinued = 'True';

--7) Write a query to return a list of category names and descriptions of all categories 
--   beginning with 'Co' from the Categories table.

SELECT CategoryName, Description FROM Categories WHERE CategoryName LIKE 'Co%';

--8) Write a query to return all the company names, city, country and postal code 
--   from the Suppliers table with the word 'rue' in their address. The list should ordered alphabetically by company name.

SELECT CompanyName, City, Country, PostalCode FROM Suppliers WHERE Address LIKE '%rue%';

--9) Write a query to return the product id and the quantity ordered for each product labelled 
--   as 'Quantity Purchased' in the Order Details table ordered by the Quantity Purchased in descending order.

SELECT ProductID, Quantity AS 'Quntity Purchased' FROM [Order Details] ORDER BY Quantity DESC;

--10) Write a query to return the company name, address, city, postal code and country of 
--    all customers with orders that shipped using Speedy Express, along with the date that the order was made.

SELECT ShipName, ShipAddress, ShipCity, ShipPostalCode, ShipCountry, OrderDate FROM Orders WHERE ShipVia = 3;

--11) Write a query to return a list of Suppliers containing company name, contact name, contact title and region description.
--  REVIEW AGAIN

SELECT CompanyName, ContactName, ContactTitle, Region FROM Suppliers;

--12) Write a query to return all product names from the Products table that are condiments.

SELECT ProductName FROM Products WHERE CategoryID  = 2;

--13) Write a query to return a list of customer names who have no orders in the Orders table.

SELECT Customers.CompanyName 
FROM Customers LEFT OUTER JOIN Orders 
ON Customers.CustomerID=Orders.CustomerID
WHERE Orders.CustomerID IS NULL; 

--14) Write a query to add a shipper named 'Amazon' to the Shippers table using SQL.

INSERT INTO Shippers (CompanyName) VALUES ('Amazon');

--15) Write a query to change the company name from 'Amazon' to 'Amazon Prime Shipping' in the Shippers table using SQL.

UPDATE Shippers 
SET CompanyName = 'Amazon Prime Shipping'
WHERE CompanyName = 'Amazon';

--16) Write a query to return a complete list of company names from the Shippers table. Include freight totals 
--    rounded to the nearest whole number for each shipper from the Orders table for those shippers with orders.

Select Shippers.CompanyName, SUM(ROUND(Orders.Freight,0))
FROM Shippers
JOIN Orders
ON Shippers.ShipperID = Orders.ShipVia
GROUP BY Shippers.CompanyName;

--17) Write a query to return all employee first and last names from the Employees table by combining 
--    the 2 columns aliased as 'DisplayName'. The combined format should be 'LastName, FirstName'.

SELECT CONCAT(LastName, ' ', FirstName)
AS 'DisplayName'
FROM Employees;

--18) Write a query to add yourself to the Customers table with an order for 'Grandma's Boysenberry Spread'.

DECLARE @OrderID int

INSERT INTO Customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, PostalCode, Country, Phone) 
VALUES ('RMDC',
		'Repertus Industries',
		'Robert Martin del Campo',
		'Owner',
		'303 Avenida Marlina',
		'Chula Vista',
		'91914',
		'USA',
		'915-203-7887')

INSERT INTO	Orders (CustomerID, OrderDate, RequiredDate, ShipVia, ShipName, ShipAddress, ShipCity, ShipPostalCode, ShipCountry)
VALUES ('RMDC',
		'2016-08-29',
		'2016-09-01',
		3,
		'Repertus Industries',
		'303 Avenida Marlina',
		'Chula Vista',
		'91914',
		'USA')	

SET @OrderID = SCOPE_IDENTITY()

INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
Values (@OrderID,6, 25, 1, 0);

--19) Write a query to remove yourself and your order from the database.

DELETE FROM [Order Details]
WHERE [Order Details].OrderID = 11080;

DELETE FROM Orders
WHERE Orders.OrderID = 11080;

DELETE FROM Customers
WHERE CustomerID = 'RMDC';

--20) Write a query to return a list of products from the Products table along with the total 
--    units in stock for each product. Include only products with TotalUnits greater than 100.

SELECT ProductName, SUM(UnitsInStock + UnitsOnOrder) AS TotalUnits 
FROM Products
WHERE UnitsInStock + UnitsOnOrder > 100
Group BY ProductName;