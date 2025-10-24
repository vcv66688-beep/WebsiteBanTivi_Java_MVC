IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'TiviShopDB')
    CREATE DATABASE TiviShopDB;
GO

USE TiviShopDB;
GO

-- Drop tables if exist (for clean reset)
IF OBJECT_ID('Review', 'U') IS NOT NULL DROP TABLE Review;
IF OBJECT_ID('Payment', 'U') IS NOT NULL DROP TABLE Payment;
IF OBJECT_ID('OrderDetail', 'U') IS NOT NULL DROP TABLE OrderDetail;
IF OBJECT_ID('[Order]', 'U') IS NOT NULL DROP TABLE [Order];
IF OBJECT_ID('Product', 'U') IS NOT NULL DROP TABLE Product;
IF OBJECT_ID('[User]', 'U') IS NOT NULL DROP TABLE [User];
GO

-- Create User table
CREATE TABLE [User] (
    id INT PRIMARY KEY IDENTITY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    full_name VARCHAR(100),
    role VARCHAR(10) DEFAULT 'USER',
    phone VARCHAR(20),
    address NVARCHAR(100)
);
GO

-- Create Product table
CREATE TABLE Product (
    id INT PRIMARY KEY IDENTITY,
    name NVARCHAR(100) NOT NULL UNIQUE,
    price DECIMAL(10,2) NOT NULL, -- Giá sau giảm
    original_price DECIMAL(10,2) NOT NULL, -- Giá gốc
    description NVARCHAR(100),
    image VARCHAR(200),
    images VARCHAR(500),
    quantity INT NOT NULL DEFAULT 0 CHECK (quantity >= 0),
    brand VARCHAR(50),
    CHECK (original_price >= price) -- Đảm bảo giá gốc không nhỏ hơn giá sau giảm
);
GO

-- Create Order table
CREATE TABLE [Order] (
    id INT PRIMARY KEY IDENTITY,
    user_id INT NOT NULL,
    total_amount DECIMAL(15,2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    created_date DATETIME NOT NULL DEFAULT GETDATE(),
    address NVARCHAR(255) NOT NULL,
    billing_name NVARCHAR(100) NOT NULL,
    billing_phone VARCHAR(20) NOT NULL,
    billing_email VARCHAR(100) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES [User](id)
);
CREATE INDEX idx_order_user_id ON [Order](user_id);
CREATE INDEX idx_order_created_date ON [Order](created_date);
GO

-- Create OrderDetail table
CREATE TABLE OrderDetail (
    id INT PRIMARY KEY IDENTITY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    FOREIGN KEY (order_id) REFERENCES [Order](id),
    FOREIGN KEY (product_id) REFERENCES Product(id)
);
GO

-- Create Payment table
CREATE TABLE Payment (
    id INT PRIMARY KEY IDENTITY,
    order_id INT NOT NULL,
    amount DECIMAL(15,2) NOT NULL,
    transaction_id VARCHAR(100),
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    FOREIGN KEY (order_id) REFERENCES [Order](id)
);
GO

-- Create Review table
CREATE TABLE Review (
    id INT PRIMARY KEY IDENTITY,
    product_id INT NOT NULL,
    user_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment NVARCHAR(100),
    created_date DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (product_id) REFERENCES Product(id),
    FOREIGN KEY (user_id) REFERENCES [User](id)
);
GO

-- Insert sample data for User
-- Insert sample data for User
INSERT INTO [User] (username, password, email, full_name, role, phone, address) VALUES 
    ('admin', 'admin123', 'admin@gmail.com', 'Admin User1', 'ADMIN', '0975656565', N'Phường Láng, Hà Nội'),
    ('ad', 'ad', 'ad@gmail.com', 'Admin User2', 'ADMIN', '0975656565', N'Phường Láng, Hà Nội'),
    ('user1', 'user123', 'user1@gmail.com', 'Nguyen Van A', 'USER', '0975656565', N'Phường Láng, Hà Nội'),
    ('user2', 'user123', 'user2@gmail.com', 'Tran Thi B', 'USER', '0975656565', N'Phường Láng, Hà Nội'),
    ('uu', 'uu', 'uu@gmail.com', 'uu', 'USER', '0975656565', N'Phường Láng, Hà Nội'),
    ('user3', 'user123', 'user3@gmail.com', 'Pham Van C', 'USER', '0975656565', N'Phường Cầu Giấy, Hà Nội'),
    ('user4', 'user123', 'user4@gmail.com', 'Le Thi D', 'USER', '0975656565', N'Phường Trung Hòa, Hà Nội'),
    ('user5', 'user123', 'user5@gmail.com', 'Hoang Van E', 'USER', '0975656565', N'Phường Kim Mã, Hà Nội');
GO

-- Insert sample data for Product (đã thay đổi original_price)
INSERT INTO Product (name, price, original_price, description, image, images, quantity, brand) VALUES 
    (N'Smart TV Samsung QLED 4K', 11090000, 14000000, N'Vision AI 43 Inch QA43Q7FA', 'ss3.1.jpg', 'ss3.jpg,ss3.1.jpg,ss3.2.jpg,ss3.3.jpg,ss3.4.jpg', 7488, 'Samsung'),
    (N'Sony Google TV 4K LED', 18990000, 23000000, N'NỀN BRAVIA 2 II K-55S25VM2', 'sn2.1.jpg', 'sn2.jpg,sn2.1.jpg,sn2.2.jpg,sn2.3.jpg', 6384, 'Sony'),
    (N'Sony Google TV Mini LED', 13000000, 16000000, N'BRAVIA 5 K-55XR50', 'sn1.1.jpg', 'sn1.jpg,sn1.1.jpg,sn1.2.jpg,sn1.3.jpg', 3413, 'Sony'),
    (N'Sony Google TV OLED', 49990000, 61000000, N'NỀN BRAVIA 8 II K-55XR80M2', 'sn3.1.jpg', 'sn3.jpg,sn3.1.jpg,sn3.2.jpg', 1246, 'Sony'),
    (N'Google Tivi TCL QLED 4K', 11990000, 14500000, N'Màn 55 Inch 55P7K', 'tcl1.jpg', 'tcl1.jpg,tcl1.2.jpg', 6745, 'TCL'),
    (N'Smart Tivi LG AI 4K', 19490000, 23500000, N'65 Inch 65UA8450PSA', 'lg1.jpg', 'lg1.jpg,lg1.2.jpg', 3456, 'LG'),
    (N'Smart TV Samsung OLED 4K', 45990000, 56000000, N'Vision AI 65 Inch QA65S90F', 'ss2.1.jpg', 'ss2.jpg,ss2.1.jpg,ss2.2.jpg,ss2.3.jpg', 1243, 'Samsung'),
    (N'TV Samsung 4K', 15000000, 18500000, N'TV cao cấp 4K', 'samsung.jpg', 'samsung.jpg,samsung2.jpg,samsung3.jpg', 2456, 'Samsung'),
	(N'TV Samsung 4K2', 1000000, 1000000, N'TV cao cấp 4K', 'samsung.jpg', 'samsung.jpg,samsung2.jpg,samsung3.jpg', 2368, 'Samsung');
GO

-- Insert sample data for Order
INSERT INTO [Order] (user_id, total_amount, status, created_date, address, billing_name, billing_phone, billing_email) VALUES 
    (2, 15050000, 'PENDING', '2025-09-22', N'123 Đường Láng, Hà Nội', N'Nguyen Van A', '0901234567', 'user1@example.com'),
    (3, 20050000, 'CONFIRMED', '2025-09-22', N'456 Lê Lợi, TP.HCM', N'Tran Thi B', '0912345678', 'user2@example.com');
GO

-- Insert sample data for OrderDetail
INSERT INTO OrderDetail (order_id, product_id, quantity) VALUES 
    (1, 1, 1), -- Order 1: 1 TV Samsung 4K
    (2, 2, 1); -- Order 2: 1 TV LG OLED
GO

-- Insert sample data for Payment
INSERT INTO Payment (order_id, amount, transaction_id, status) VALUES 
    (1, 15050000, 'COD-TX-001', 'PENDING'),
    (2, 20050000, 'COD-TX-002', 'CONFIRMED');
GO

-- review
INSERT INTO Review (product_id, user_id, rating, comment) VALUES 
    (1, 3, 5, N'Màn hình OLED cực kỳ sắc nét, xem phim rất đã.'),
    (2, 4, 4, N'Tivi đẹp, âm thanh ổn nhưng hơi đắt.'),
    (3, 5, 5, N'Chất lượng hình ảnh tuyệt vời, đáng tiền.'),
    (4, 6, 3, N'Giá tốt nhưng giao diện hơi khó dùng.'),
    (5, 7, 4, N'Thiết kế đẹp, phù hợp phòng ngủ.'),
    (6, 5, 5, N'Tivi thông minh, điều khiển giọng nói rất tiện.'),
    (7, 3, 4, N'Hình ảnh ổn, kết nối mạng nhanh.'),
    (8, 8, 3, N'Phù hợp với nhu cầu cơ bản, giá hợp lý.');
GO

-- Kiểm tra dữ liệu
SELECT * FROM Product;
SELECT * FROM [Order];
SELECT * FROM OrderDetail;
SELECT * FROM Payment;
SELECT * FROM Review;
SELECT * FROM [User];
GO