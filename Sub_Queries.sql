CREATE DATABASE SUB_QUERIES;

USE SUB_QUERIES;

CREATE TABLE PROJECT(
	ID INT PRIMARY KEY,
    EMP_ID INT,
    NAME CHAR(255),
    JOIN_DATE CHAR(255),
    CLIENT_ID INT
);

CREATE TABLE EMPLOYEE(
	EMP_ID INT,
    FNAME CHAR(255),
    LNAME CHAR(255),
    AGE INT,
    EMAIL CHAR(255),
    PHONE INT,
    CITY CHAR(255)
);

CREATE TABLE CLIENT(
	CLIENT_ID INT,
    FNAME CHAR(255),
    LNAME CHAR(255),
    AGE INT,
    EMAIL CHAR(255),
    PHONE INT,
    CITY CHAR(255),
    EMP_ID INT
);

DROP TABLE CLIENT;
DROP TABLE EMPLOYEE;

INSERT INTO PROJECT (ID,EMP_ID,NAME,JOIN_DATE,CLIENT_ID)
VALUES  (1,1,"A","2021-04-21",3),
		(2,2,"B","2021-03-12",1),
        (3,3,"C","2021-04-16",5),
        (4,3,"D","2021-04-27",2),
        (5,5,"E","2021-04-01",4);
        
INSERT INTO EMPLOYEE (EMP_ID,FNAME,LNAME,AGE,EMAIL,PHONE,CITY)
VALUES  (1,"AMAN","PROTO",32,"AMAN@GMAIL.COM",898,"DELHI"),
		(2,"YAGYA","NARAYAN",44,"YAGYA@GMAIL.COM",222,"PALAM"),
        (3,"RAHUL","BD",22,"RAHUL@GMAIL.COM",444,"KOLKATA"),
        (4,"JATIN","HATMIT",31,"JATIN@GMAIL.COM",666,"RAIPUR"),
        (5,"PK","PANDEY",21,"PK@GMAIL.COM",555,"JAIPUR");
        
INSERT INTO CLIENT (CLIENT_ID,FNAME,LNAME,AGE,EMAIL,PHONE,CITY,EMP_ID)
VALUES  (1,"MAC","ROGERS",47,"MAC@GMAIL.COM",333,"KOLKATA",3),
		(2,"MAX","POIREIR",27,"MAX@GMAIL.COM",222,"KOLKATA",3),
        (3,"PETER","JAIN",24,"PETER@GMAIL.COM",111,"DELHI",1),
		(4,"SUSHANT","AGARWAL",23,"SUSHANT@GMAIL.COM",45454,"HYDERABAD",5),
        (5,"PRATAP","SINGH",36,"PRATAP@GMAIL.COM",77767,"MUMBAI",2);
        
SELECT * FROM PROJECT;
SELECT * FROM EMPLOYEE;
SELECT * FROM CLIENT;

-- SUB QUERIES
-- WHERE clause same table
-- employee with age > 30
SELECT * FROM EMPLOYEE WHERE AGE IN (SELECT AGE FROM EMPLOYEE WHERE AGE > 30);

-- WHERE CLAUSE DIFFERENT TABLES
-- EMP DETAILSS WORKING IN MORE THAN 1 PROJECT
SELECT * FROM EMPLOYEE WHERE EMP_ID IN (
	SELECT EMP_ID FROM PROJECT GROUP BY EMP_ID HAVING COUNT(EMP_ID) > 1
);

-- single value subquery
-- emplloyee details having agge greater than the given average age
select avg(age) from employee;
select * from employee where age > (select avg(age) from employee);

-- FROM clause -> derieved tables
-- select max age person whose first name starts with a
select * from employee where age = (select max(age) from (select * from employee where fname like "%a%") as temp);

-- CORELATED SUB QUERY
-- USUALLY OUTER QUERY DEPENDS ON THE RESULT OF INNER QUERY
-- BUT WE HAVE QYERIES WHERE BOTH THE QUERIES ARE CORELATED WITH EACH OTHER
-- FIND THE THIRD OLDEST EMPLOYEE IN THE EMPLOYEE TABLE
SELECT *
FROM EMPLOYEE AS E1
WHERE 3 = (
	SELECT COUNT(E2.AGE)
    FROM EMPLOYEE AS E2
    WHERE E2.AGE >= E1.AGE
);
-- CORELATED SUBQUERIES ARE TIME CONSUMING THAN THAT OF JOINS
-- JOINS GIVE ALL CALCULATION BURDEN TO THE DBMS
-- JOINS ARE COMPLEX TO UNDERSTAND
-- CORELATED QUERIES IN WRITTEN PROPERLY CAN BE EFFICIENT


-- SQL VIEWS
-- MYSQL PROVIDES US WITH A WAY TO DEFINE VIEWS
-- WE CREATE A VIEW TO SHOW ONLY REQUIRED DETAILSA ND HENCE ADDING A LEVEL OF ABSTRACTION

-- LETS SEE HOW THE ORIGINAL EMPLOYEE TABLE LOOKS LIKE
SELECT * FROM EMPLOYEE;
-- NOW WE WILL CREATE A VIEW FOR THE EMPLOYEE TABLE
CREATE VIEW FIRST_VIEW AS SELECT FNAME,LNAME,EMAIL FROM EMPLOYEE;

SELECT * FROM FIRST_VIEW;

CREATE VIEW SECOND_VIEW AS SELECT EMP_ID,FNAME,PHONE FROM EMPLOYEE;

SELECT * FROM SECOND_VIEW;

-- ALTERING A VIEW
ALTER VIEW FIRST_VIEW AS SELECT FNAME,LNAME,AGE FROM EMPLOYEE;
SELECT * FROM FIRST_VIEW;

-- DROPPING A VIEW (DELETING)
DROP VIEW IF EXISTS SECOND_VIEW;