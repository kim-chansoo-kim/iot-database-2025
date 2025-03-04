
CREATE TABLE Book
(
	bookid               INTEGER NOT NULL,
	bookname             VARCHAR(40) NULL,
	price                INTEGER NULL,
	pubname              VARCHAR(40) NULL
);



ALTER TABLE Book
ADD PRIMARY KEY (bookid);



CREATE TABLE Customer
(
	name                 VARCHAR(40) NOT NULL,
	addr                 VARCHAR(40) NULL,
	custid               INTEGER NOT NULL,
	phone                VARCHAR(20) NULL
);



ALTER TABLE Customer
ADD PRIMARY KEY (custid);



CREATE TABLE Orders
(
	orderid              INTEGER NOT NULL,
	orderdate            DATE NULL,
	saleprice            INTEGER NULL,
	bookid               INTEGER NULL,
	custid               INTEGER NULL
);



ALTER TABLE Orders
ADD PRIMARY KEY (orderid);



CREATE TABLE Publisher
(
	pubname              VARCHAR(40) NOT NULL,
	stname               VARCHAR(40) NOT NULL,
	officephone          VARCHAR(30) NOT NULL
);



ALTER TABLE Publisher
ADD PRIMARY KEY (pubname);



ALTER TABLE Book
ADD FOREIGN KEY R_7 (pubname) REFERENCES Publisher (pubname);



ALTER TABLE Orders
ADD FOREIGN KEY R_13 (bookid) REFERENCES Book (bookid);



ALTER TABLE Orders
ADD FOREIGN KEY R_14 (custid) REFERENCES Customer (custid);


