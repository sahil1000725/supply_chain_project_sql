Create Database SupplyChain;
Use SupplyChain;

CREATE Table Suppliers(
Supplier_id INT PRIMARY KEY,
Supplier_Name VARCHAR (90),
Location VARCHAR (50),
Contact Varchar(20)
);

CREATE Table Products (
Product_id INT PRIMARY KEY,
Product_Name VARCHAR (90),
Price DECIMAL (10,2),
Supplier_id INT,
FOREIGN KEY (Supplier_id) REFERENCES Suppliers(Supplier_id)
);

CREATE TABLE Inventory (
Inventory_id INT PRIMARY KEY,
Product_id INT,
Quantity INT,
Warehouse VARCHAR(50),
FOREIGN KEY (Product_id) REFERENCES Products(Product_id)
);

CREATE TABLE Orders (
Order_id INT PRIMARY KEY,
Order_date DATE,
Supplier_id INT,
Total_amount DECIMAL(10,2),
FOREIGN KEY (Supplier_id) REFERENCES Suppliers(Supplier_id)
);

CREATE TABLE Order_Details (
Order_detail_id INT PRIMARY KEY,
Order_id INT,
Product_id INT,
Quantity INT,
FOREIGN KEY (Order_id) REFERENCES Orders(Order_id),
FOREIGN KEY (Product_id) REFERENCES Products(Product_id)
);

INSERT INTO Suppliers VALUES
(1, 'ABC Traders', 'Mumbai', '9876543210'),
(2, 'Global Supplies', 'Pune', '9123456780'),
(3, 'Fast Logistics', 'Delhi', '9988776655');

INSERT INTO Products VALUES
(101, 'Laptop', 55000, 1),
(102, 'Mouse', 500, 1),
(103, 'Keyboard', 1200, 2),
(104, 'Monitor', 8000, 3);

INSERT INTO Inventory VALUES
(1, 101, 30, 'Warehouse A'),
(2, 102, 150, 'Warehouse B'),
(3, 103, 60, 'Warehouse A'),
(4, 104, 15, 'Warehouse C');

INSERT INTO Orders VALUES
(201, '2024-01-10', 1, 60000),
(202, '2024-02-05', 2, 15000),
(203, '2024-03-12', 3, 20000);

INSERT INTO Order_Details VALUES
(1, 201, 101, 1),
(2, 201, 102, 10),
(3, 202, 103, 5),
(4, 203, 104, 2);

SELECT * FROM Suppliers;
SELECT * FROM Products;
SELECT * FROM Inventory;
SELECT * FROM Orders;
SELECT * FROM Order_Details;

-- 6. Display products with supplier name
SELECT p.product_name, s.supplier_name
FROM Products p
JOIN Suppliers s
ON p.supplier_id = s.supplier_id;

-- 7. Display inventory details with product name
SELECT p.product_name, i.quantity, i.warehouse
FROM Inventory i
JOIN Products p
ON i.product_id = p.product_id;

-- 8. Find products with stock less than 50
SELECT p.product_name, i.quantity
FROM Inventory i
JOIN Products p
ON i.product_id = p.product_id
WHERE i.quantity < 50;

-- 9. Count total number of products supplied by each supplier
SELECT s.supplier_name, COUNT(p.product_id) AS total_products
FROM Suppliers s
JOIN Products p
ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_name;

-- 10. Display orders with supplier name
SELECT o.order_id, o.order_date, s.supplier_name
FROM Orders o
JOIN Suppliers s
ON o.supplier_id = s.supplier_id;

-- 11. Find suppliers who have placed orders 
SELECT supplier_name
FROM Suppliers
WHERE supplier_id IN (
SELECT supplier_id
FROM Orders
);

-- 12. Find suppliers with total order amount greater than average (SUBQUERY)
SELECT supplier_name
FROM Suppliers
WHERE supplier_id IN (SELECT supplier_id FROM Orders
GROUP BY supplier_id
HAVING SUM(total_amount) >(SELECT AVG(total_amount) FROM Orders)
);











