CREATE TABLE Customers (
    customer_email VARCHAR(100) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_email VARCHAR(100) NOT NULL,
    FOREIGN KEY (customer_email) REFERENCES Customers(customer_email)
);

CREATE TABLE Products (
    product_name VARCHAR(100) PRIMARY KEY,
    product_price DECIMAL(10,2) NOT NULL
);

CREATE TABLE Order_Details (
    order_id INT,
    product_name VARCHAR(100),
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_name),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_name) REFERENCES Products(product_name)
);

INSERT INTO Customers (customer_email, customer_name)
VALUES
('aarav@email', 'Aarav'),
('diya@email', 'Diya');

INSERT INTO Orders (order_id, customer_email)
VALUES
(1, 'aarav@email'),
(2, 'diya@email');

INSERT INTO Products (product_name, product_price)
VALUES
('Laptop', 65000),
('Mouse', 500),
('Keyboard', 1500);

INSERT INTO Order_Details (order_id, product_name, quantity)
VALUES
(1, 'Laptop', 1),
(1, 'Mouse', 2),
(2, 'Keyboard', 1);