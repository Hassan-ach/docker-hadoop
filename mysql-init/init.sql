CREATE DATABASE IF NOT EXISTS sqoopdb;
USE sqoopdb;

CREATE TABLE IF NOT EXISTS employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10, 2),
    hire_date DATE,
    status VARCHAR(20)
);

INSERT INTO employees (name, department, salary, hire_date, status) VALUES
('Alice Johnson', 'Engineering', 85000.00, '2020-01-15', 'active'),
('Bob Smith', 'Marketing', 65000.00, '2019-06-20', 'active'),
('Carol White', 'Engineering', 92000.00, '2018-03-10', 'active'),
('David Brown', 'Sales', 72000.00, '2021-02-28', 'active'),
('Eve Davis', 'Engineering', 88000.00, '2020-09-05', 'active'),
('Frank Miller', 'HR', 58000.00, '2019-11-12', 'inactive'),
('Grace Lee', 'Marketing', 69000.00, '2020-07-22', 'active'),
('Henry Wilson', 'Sales', 75000.00, '2018-12-01', 'active'),
('Ivy Chen', 'Engineering', 95000.00, '2017-05-18', 'active'),
('Jack Taylor', 'HR', 61000.00, '2021-04-30', 'active');

CREATE TABLE IF NOT EXISTS orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    product VARCHAR(100),
    amount DECIMAL(10, 2),
    order_date DATE,
    status VARCHAR(20)
);

INSERT INTO orders (customer_name, product, amount, order_date, status) VALUES
('John Doe', 'Laptop', 1299.99, '2024-01-10', 'completed'),
('Jane Smith', 'Smartphone', 799.99, '2024-01-12', 'completed'),
('Mike Johnson', 'Tablet', 499.99, '2024-01-15', 'pending'),
('Sarah Williams', 'Headphones', 199.99, '2024-01-18', 'completed'),
('Tom Brown', 'Monitor', 349.99, '2024-01-20', 'shipped'),
('Lisa Anderson', 'Keyboard', 89.99, '2024-01-22', 'completed'),
('Chris Davis', 'Mouse', 49.99, '2024-01-25', 'pending'),
('Amy Wilson', 'Webcam', 79.99, '2024-01-28', 'completed');

GRANT ALL PRIVILEGES ON sqoopdb.* TO 'user'@'%';
FLUSH PRIVILEGES;
