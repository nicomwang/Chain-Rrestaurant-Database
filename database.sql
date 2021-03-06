DROP TABLE IF EXISTS OrderPreparation_t;
DROP TABLE IF EXISTS EMPLOYEE_POSITION_t;
DROP TABLE IF EXISTS EMPLOYEE_t; 
DROP TABLE IF EXISTS OrderLine_t;
DROP TABLE IF EXISTS PRODUCT_t; 
DROP TABLE IF EXISTS ORDER_t; 
DROP TABLE IF EXISTS MEMBERSHIP_t;
DROP TABLE IF EXISTS View_t; 
DROP TABLE IF EXISTS RESTURANT_INFO_t; 
DROP TABLE IF EXISTS FEEDBACK_t; 
DROP TABLE IF EXISTS CUSTOMER_t;


CREATE TABLE CUSTOMER_t
(
		Customer_Id		INT(7)	NOT NULL,
        C_First_Name	VARCHAR(25),
		C_Last_Name     VARCHAR(25),
        DOB				DATE,
        VIP		        VARCHAR(3) NOT NULL,
		Promotion		VARCHAR(20),
        CONSTRAINT Customer_PK PRIMARY KEY (Customer_Id)
);

CREATE TABLE FEEDBACK_t
(
		Survey_ID		INT NOT NULL,
		Customer_Id		INT NOT NULL,
		Food_Comment	VARCHAR(50),
		Service_Comment	VARCHAR(50),
		CONSTRAINT FEEDBACK_PK PRIMARY KEY (Survey_ID),
		CONSTRAINT FEEDBACK_FK1 FOREIGN KEY (Customer_Id) REFERENCES CUSTOMER_t(Customer_Id)
);

CREATE TABLE RESTURANT_INFO_t
(
		Resturant_Id	INT  NOT NULL,
		Location	    VARCHAR(50),
		Hour			VARCHAR(25),
		Phone_Number	INT(14),
		CONSTRAINT RESTURANT_INFO_PK PRIMARY KEY (Resturant_Id)
);

CREATE TABLE VIEW_t
(
		Resturant_Id	INT  NOT NULL,
		Customer_Id		INT  NOT NULL,
		Times_Searched	INT,
		CONSTRAINT VIEW_PK PRIMARY KEY (Resturant_Id, Customer_Id),
		CONSTRAINT VIEW_FK1 FOREIGN KEY (Resturant_Id) REFERENCES RESTURANT_INFO_t(Resturant_Id),
		CONSTRAINT VIEW_FK2 FOREIGN KEY (Customer_Id) REFERENCES CUSTOMER_t(Customer_Id)
);


CREATE TABLE MEMBERSHIP_t
(
		Member_Id		INT   NOT NULL,
		Customer_Id		INT   NOT NULL,
		Date_Joined		DATE,
		Points			INT,
		CONSTRAINT MEMBERSHIP_PK PRIMARY KEY (Member_Id),
		CONSTRAINT MEMBERSHIP_FK1 FOREIGN KEY (Customer_Id) REFERENCES CUSTOMER_t(Customer_Id)
);


CREATE TABLE ORDER_t
(
		Order_Id 		INT NOT NULL,
    	Customer_Id		INT(7)	NOT NULL,
    	Member_Id		INT NOT NULL,
    	Order_Date		DATE,
    	Item			VARCHAR(50),
CONSTRAINT ORDER_PK PRIMARY KEY (Order_Id),
CONSTRAINT ORDER_FK1 FOREIGN KEY (Customer_Id) REFERENCES CUSTOMER_t (Customer_Id),
CONSTRAINT ORDER_FK2 FOREIGN KEY (Member_Id) REFERENCES MEMBERSHIP_t (Member_Id)
);


CREATE TABLE PRODUCT_t
(
		Product_Id    	  INT    NOT NULL,
        Product_Name      VARCHAR(50),
        Unit_Price        DECIMAL(6,2) ,
CONSTRAINT Product_PK PRIMARY KEY (Product_Id)
);


CREATE TABLE OrderLine_t
(	
		Order_Id            INT   NOT NULL,
        Product_Id          INT   NOT NULL,
        Ordered_Quantity    INT,
		Total_Amount		INT,
CONSTRAINT OrderLine_PK PRIMARY KEY (Order_Id, Product_Id),
CONSTRAINT OrderLine_FK1 FOREIGN KEY (Order_Id) REFERENCES ORDER_t(Order_Id),
CONSTRAINT OrderLine_FK2 FOREIGN KEY (Product_Id) REFERENCES PRODUCT_t(Product_Id)
);


CREATE TABLE EMPLOYEE_t
(
		Employee_Id		INT  NOT NULL,
		E_First_Name    VARCHAR(25),
		E_Last_Name     VARCHAR(25),
		Start_date		DATE,
		Salary			INT,
		CONSTRAINT EMPLOYEE_PK PRIMARY KEY (Employee_Id)
);


CREATE TABLE EMPLOYEE_POSITION_t
(
		Employee_Id  		INT NOT NULL,
		Primary_Position	VARCHAR(25) NOT NULL,
		Secondary_Position	VARCHAR(25),
		CONSTRAINT EMPLOYEE_PK PRIMARY KEY (Employee_Id)
);


CREATE TABLE OrderPreparation_t
(	
		Order_Id            INT   NOT NULL,
        Employee_Id     	INT   NOT NULL,
		Time_Assigned		TIME,
CONSTRAINT OrderPreparation_PK PRIMARY KEY (Order_Id, Employee_Id),
CONSTRAINT OrderPreparation_FK1 FOREIGN KEY (Order_Id) REFERENCES ORDER_t(Order_ID),
CONSTRAINT OrderPreparation_FK2 FOREIGN KEY (Employee_Id) REFERENCES EMPLOYEE_t(Employee_Id)
);

INSERT INTO customer_t VALUES
('0000001','Christiano','Ronaldo','1985.02.05','Yes','50% off on dessert'),
('1000011','Zhiyi','Fan','1969.11.6','Yes','50% off on dessert'),
('0000021','Lebron','James','1984.12.30','No','10% off of next meal'),
('0000234','Kobe','Bryant','1981.4.3','No','10% off of next meal'),
('0000002','Xiaopeng','Li','1975.6.20','Yes','50% off on dessert');

INSERT INTO feedback_t VALUES
('1','0000234','food is good', 'service was awesome, a great restaurant, must come'),
('2','0000001','food is decilious','great'),
('3','0000002','amazing','good service');

INSERT INTO resturant_info_t VALUES
('1','Shanghai, China','05:00pm-01:00am','4008517517'),
('2','Boston, MA, USA','05:00pm-01:00am','617777777'),
('3','New York, NY, USA','05:00pm-01:00am','2127777777');

INSERT INTO view_t VALUES
('1','0000002','2010,10,8'),
('3','0000234','2013,10,9'),
('2','1000011','2012,12,12');

INSERT INTO membership_t VALUES
('12345','1','2019.9,6','3000'),
('11111','1000011','1999.12.16','5000000'),
('12344','0000002','1999.12.16','3000000');

INSERT into order_t VALUES
('12234','1000011','11111','2017.9.6','30'),
-- ('12345','234','No','2019,10,19','99'),
('11111','2','12344','2016.9.11','20');

INSERT into product_t VALUES
('1','Buddha jumps over the wall','200'),
('2','Manchu Han Imperial Feast','300'),
('3','Filet Mignon & Specialty wine','50'),
('4','Peking duck with Tsar Nicoulai caviar','88');

INSERT INTO ORDERLINE_t VALUES
('12234','1','2','400');

INSERT INTO employee_t VALUES
('0123','Bo','Huang','2019.9.6','20000'),
('234','Shaw','Luo','2019.9.6','2000'),
('345','Lei','Huang','2019.9.6','20000'),
('456','Honglei','Sun','2019.9.6','10000'),
('567','Lay','Zhang','2019.9.6','50000');

INSERT INTO employee_position_t VALUES
('0123','Manager','Chief'),
('234','Waiter','runner'),
('345','Chief','Assistance Manager'),
('456','Secondary Chief','Waitress'),
('567','Manager','runner');

INSERT INTO orderpreparation_t VALUES
('12234','234','19:30'),
('11111','567','19:30');

ALTER TABLE employee_t
ADD COLUMN Resturant_Id int;

ALTER TABLE employee_t
ADD CONSTRAINT employee_PK3
FOREIGN KEY (resturant_id) REFERENCES resturant_info_t(resturant_id);


ALTER TABLE order_t
ADD CONSTRAINT order_PK3
FOREIGN KEY (resturant_id) REFERENCES resturant_info_t(resturant_id);
