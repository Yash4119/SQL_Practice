create database account;
use account;

create table acc(
	id int primary key,
    name varchar(255) unique,
    balance int,
    constraint acc_balance_chk check(balance>=1000)
);

insert into acc (id, name, balance) values 
	(001,"Yash Ambekar",2500),
    (002,"Krishna Kotgire",3000),
    (003,"Avdesh Vora",2750),
    (004,"Tejas Bhandvalkar",1724);
    
select * from acc;

-- will not enter this entry as the balance violates the constraint
insert into acc (id,name,balance)
values (005,"yash shinde",568);

insert into acc (id,name,balance)
values (005,"yash shinde",4568);

-- will not allow to enter duplicate entries as we have mentioned name to be unique
insert into acc (id,name,balance)
values (006,"Yash Ambekar",4568);

drop table acc;

create table acc(
	id int primary key,
    name varchar(255) unique,
    balance int not null default 0
);

insert into acc (id,name) values (001,"yash ambekar");
insert into acc (id,name,balance) values (002,"yash shinde",4000);

select * from acc;

-- ADD NEW COLUMN TO THE TABLE
ALTER TABLE ACC ADD INTEREST FLOAT NOT NULL DEFAULT 0;

-- MODIFY THE DATA TYPE OF AN ATTRIBUIE
ALTER TABLE ACC MODIFY INTEREST DOUBLE NOT NULL DEFAULT 0;

-- DESCRIBE THE ACC TABLE 
DESC ACC;

-- RENAME THE COLUMN
ALTER TABLE ACC CHANGE COLUMN INTEREST SAVINGS_INTEREST FLOAT NOT NULL DEFAULT 0;

-- DROP COLUMN
ALTER TABLE ACC DROP COLUMN SAVINGS_INTEREST;

-- RENAME THE TABLE 
ALTER TABLE ACC RENAME TO ACCOUNT_DETAILS;

DESC ACCOUNT_DETAILS;