CREATE TABLE goods (
	CODE VARCHAR(100) PRIMARY KEY,
	NAME VARCHAR(100),
	price INT,
	stock INT,
	category VARCHAR(100)
);

CREATE TABLE orders (
	NO INT AUTO_INCREMENT PRIMARY KEY,
	customer VARCHAR(100),
	productcode VARCHAR(100) REFERENCES goods(CODE),
	amount INT,
	iscanceled BOOLEAN DEFAULT 0
);

DROP TABLE goods;
DROP TABLE orders;