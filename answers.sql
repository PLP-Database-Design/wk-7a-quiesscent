-- Question 1: Achieving 1NF (First Normal Form)
-- The original table ProductDetail violates 1NF because the Products column contains multiple values.
-- We will create a new table that stores each product in a separate row for each order.

-- Step 1: Creating the ProductDetail table with multiple products for a single order
CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(255),
    Products VARCHAR(255)
);

-- Inserting the data for reference
INSERT INTO ProductDetail (OrderID, CustomerName, Products) VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

-- Step 2: Transforming the data into 1NF by splitting products into separate rows
-- New table to store products in separate rows
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255)
);

-- Inserting the transformed data (each product for an order is inserted in a separate row)
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- The table ProductDetail_1NF now satisfies 1NF as each row contains a single product for each order.


-- Question 2: Achieving 2NF (Second Normal Form)
-- The original OrderDetails table is in 1NF but violates 2NF because the CustomerName column depends only on OrderID, not the whole primary key.

-- Step 1: Create the new normalized tables

-- 1. A table to store order information, with OrderID as the primary key
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

-- 2. A table to store product details for each order
CREATE TABLE OrderDetails_2NF (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 2: Inserting data into the Orders table (remove CustomerName dependency from OrderDetails)
INSERT INTO Orders (OrderID, CustomerName)
VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Step 3: Inserting data into the OrderDetails_2NF table
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity)
VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- The data is now normalized to 2NF where non-key columns fully depend on the primary key (OrderID + Product).
