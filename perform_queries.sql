-- Task 3: SQL for Data Analysis
-- a. Use SELECT, WHERE, ORDER BY, GROUP BY

-- 1. List all customers ordered by their last name
SELECT * FROM Customer ORDER BY LastName;

-- 2. Find customers who registered after 1995
SELECT * FROM Customer WHERE DOB > '1995-01-01';

-- 3. Count how many vendors are registered
SELECT COUNT(*) AS TotalVendors FROM Vendor;

-- 4. Group products by category
SELECT c.CategoryName, COUNT(p.ProductID) AS ProductCount
FROM Product p
JOIN Category c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName;

-- b. Use JOINS (INNER, LEFT, RIGHT)

-- 5. Get all vendor products along with vendor names
SELECT vp.*, v.Name AS VendorName 
FROM VendorProduct vp
INNER JOIN Vendor v ON vp.VendorID = v.VendorID;

-- 6. List all products and their categories (including those without products)
SELECT c.CategoryName, p.ProductName
FROM Category c
LEFT JOIN Product p ON c.CategoryID = p.CategoryID;

-- 7. List all cities with or without a ZipCode
SELECT c.CityName, z.ZipCodeID
FROM City c
LEFT JOIN ZipCode z ON c.CityID = z.CityID;

-- c. Write subqueries

-- 8. Find all products that are priced above the average price
SELECT ProductID, Price FROM VendorProduct
WHERE Price > (SELECT AVG(Price) FROM VendorProduct);

-- 9. Get customers who have made orders
SELECT * FROM Customer
WHERE CustomerID IN (SELECT CustomerID FROM Orders);

-- d. Use aggregate functions (SUM, AVG)

-- 10. Calculate total revenue from all orders
SELECT SUM(vp.Price * op.Quantity) AS TotalRevenue
FROM OrderedProduct op
JOIN VendorProduct vp ON op.VendorProductID = vp.VendorProductID;

-- 11. Average product price by vendor
SELECT v.Name, AVG(vp.Price) AS AvgPrice
FROM VendorProduct vp
JOIN Vendor v ON vp.VendorID = v.VendorID
GROUP BY v.Name;

-- e. Create views for analysis

-- 12. View of vendor performance (sales count and total revenue)
CREATE VIEW VendorPerformance AS
SELECT v.VendorID, v.Name AS VendorName,
       COUNT(op.OrderedProductID) AS SalesCount,
       SUM(vp.Price * op.Quantity) AS TotalRevenue
FROM Vendor v
JOIN VendorProduct vp ON v.VendorID = vp.VendorID
JOIN OrderedProduct op ON vp.VendorProductID = op.VendorProductID
GROUP BY v.VendorID, v.Name;

-- f. Optimize queries with indexes

-- 13. Add indexes to improve performance
CREATE INDEX idx_customer_email ON Customer(Email);
CREATE INDEX idx_product_category ON Product(CategoryID);
CREATE INDEX idx_order_customer ON Orders(CustomerID);
CREATE INDEX idx_order_address ON Orders(AddressID);