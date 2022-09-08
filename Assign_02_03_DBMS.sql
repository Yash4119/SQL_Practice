create database assign_2;

use assign_2;

create table Account(
Acc_no int primary key,
    branch_name varchar(255),
    balance int not null,
    foreign key (branch_name) references branch(branch_name) on delete cascade on update cascade
);

drop table Account;
drop table branch;

create table branch(
branch_name varchar(255) primary key,
    branch_city varchar(255) not null,
assets int
);

create table customer (
cust_name varchar(255) primary key,
    cust_street varchar(255) not null,
    cust_city varchar(255) not null
);

create table depositor(
	cust_name varchar(255),
    Acc_no int,
    foreign key (cust_name) references customer(cust_name)  on delete cascade on update cascade,
    foreign key (Acc_no) references Account(Acc_no)  on delete cascade on update cascade
);

create table loan(
loan_no int primary key,
    branch_name varchar(255),
    amount int not null,
    foreign key (branch_name) references branch(branch_name)  on delete cascade on update cascade
);

create table Borrower(
cust_name varchar(255),
    loan_no int,
    foreign key (cust_name) references customer(cust_name)  on delete cascade on update cascade,
    foreign key (loan_no) references loan(loan_no)  on delete cascade on update cascade
);

show tables;

insert into branch(branch_name,branch_city,assets) values
("Lonavla","Pune",100000),
    ("Bokar","Nanded",123411),
    ("Talegaon","Pune",2317428);
   
select * from branch;

insert into Account(Acc_no,branch_name,balance) values
(001,"Lonavla",10002),
    (002,"Talegaon",1003),
    (003,"Bokar",32512),
    (004,"Talegaon",3451),
    (005,"Talegaon",346521);
   
select * from account;

insert into customer(cust_name,cust_street,cust_city) values
("Yash Ambekar","Malavali","Pune"),
    ("Krishna Kotgire","Valhabnagar","Nanded"),
    ("Avdesh Vora","Chankan","Pune"),
    ("Satyam Sakhore","Shirur","Pune"),
    ("Prathmesh","bhosri","Pune");
   
select * from customer;

insert into depositor(cust_name,Acc_no) values
("Yash Ambekar",001),
    ("Avdesh Vora",002),
    ("Krishna Kotgire",003),
    ("Satyam Sakhore",004),
    ("Prathmesh",005);

drop table depositor;
select * from depositor;

insert into loan(loan_no,branch_name,amount) values
(001,"Lonavla",2000),
    (002,"Bokar",3000),
    (003,"Talegaon",4000);
   
select * from loan;

insert into borrower(cust_name,loan_no) values
("Yash Ambekar",001),
    ("Krishna Kotgire",002),
    ("Satyam Sakhore",003);
   
select * from borrower;

-- Running Queries Given to Us on The Databse Created Above

-- 1. Names of All branches from Loan table
	select branch_name from loan;


-- 2. Loan numbers of loans made at the pimpri branch where loan amount > 12000
	select * from loan where branch_name = "Pimpri" and amount > 12000;
    
insert into branch(branch_name,branch_city,assets) values
("Pimpri","Pune",1235323);
   
insert into Account(Acc_no,branch_name,balance) values
(007,"Pimpri",1234);
   
insert into Account(Acc_no,branch_name,balance) values
(009,"Pimpri",1234),  
    (008,"Pimpri",34532),  
    (0010,"Pimpri",15323);

insert into depositor(cust_name,acc_no) values
("Yash Ambekar",007),
    ("Avdesh Vora",009),
    ("Krishna Kotgire",008),
    ("Satyam Sakhore",0010);

insert into loan(loan_no,branch_name,amount) values
(004,"Pimpri",13000),
    (005,"Pimpri",14999),
    (006,"Pimpri",11999);
   
insert into borrower(cust_name,loan_no) values
("Yash Ambekar",004),
    ("Avdesh Vora",005),
    ("Krishna Kotgire",006);

-- 3. Name, Loan_no, Amount of loan taken from banks

select loan.loan_no, borrower.cust_name, loan.amount
from loan
left join
borrower on
loan.loan_no = borrower.loan_no;

-- Query in order to avoid the usage of joins

	select loan.loan_no, Borrower.cust_name, loan.amount from loan,Borrower where loan.loan_no = Borrower.loan_no;

-- 4.all customers in alphabetical order and loan from pimpri branch

	select Borrower.cust_name from Borrower,loan where loan.branch_name="Pimpri" and Borrower.loan_no = loan.loan_no order by 	Borrower.cust_name asc;

-- 5. find all customers who have account or loan or both in a bank

	select cust_name from Borrower union select cust_name from depositor;

-- 6. find all customers who have both account and loan in a bank

	select distinct Borrower.cust_name from Borrower,depositor where Borrower.cust_name = depositor.cust_name;
	
	select distinct customer.cust_name from customer inner join Borrower on(customer.cust_name = Borrower.cust_name);

-- 7.all customers who have account but no loan at the bank

	select cust_name from depositor where cust_name not in (select cust_name from Borrower);

-- 8. average account balance at the branch

	select avg(Account.balance) from Account where branch_name="lonavla";

-- 9.average account balance at each branch

	select branch_name,avg(balance) from Account group by branch_name;

-- 10. find no of depositors at each branch

	select branch_name,count(branch_name) from Account group by branch_name;

-- 11. branch name where average account balance is > 12000

	select branch_name,avg(balance) from Account group by branch_name having avg(balance)>12000;

-- 12. no of tuples in the customer relation

	select count(*) from customer;

-- 13. total loan amount given by a bank

	select loan.branch_name,sum(loan.amount) from loan group by branch_name;

-- 14. delete all loans from with loan amount between 1300 and 1500

	delete from loan where loan.amount between 2300 and 3500;

-- 15. delete all tuples where every branch located in pimpri

	delete from Account where exists (select * from branch where branch_name = "Pimpri" and Account.branch_name = branch.branch_name);

-- 17. create a sequence roll_seq and use in student table for roll_no column

	create table student (roll_no int primary key auto_increment, name varchar(25));
    
    insert into student(name) values
    ("Yash Jayram Ambekar"),
    ("Krishna Gajanan Korgire"),
    ("Tejas Bhandvalkar"),
    ("Yash Shinde");
    
	select * from student;
	
	
	