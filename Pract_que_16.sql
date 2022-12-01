create database que_16;

use que_16;

-- A :- The bank manager has decided to activate all those accounts which were previously marked as inactive for performing no transaction in last 365 days. 
-- Write a PL/SQ block (using implicit cursor) to update the status of account, display an approximate message based on the no. of rows affected by the update.  
-- (Use of %FOUND, %NOTFOUND, %ROWCOUNT)

create table Account(
	acc_no int primary key,
    name varchar(30),
    status varchar(15)
);

insert into Account values (001,"Yash","Active"),(002,"Krishna","Inactive"),(003,"Teja","Inactive"),(004,"Satyam","Active");

delimiter //

create procedure change_status()

begin

declare rows_affected int;
declare ct int;
declare Acc int;
declare c1 cursor for select acc_no from Account where status = "Inactive"; 

select count(acc_no) into ct from Account where status = "Inactive";
set rows_affected = ct;
open c1;

main : loop 

	fetch c1 into Acc;
    update Account modify set status="Active";
    set ct = ct-1;
    if(ct=0) then leave main;
    else iterate main;
    end if;

end loop main;

close c1;
select rows_affected as "Number of Rows updated";

end //

select * from Account;
select row_count();
set sql_safe_updates = 0;
call change_status();


-- B :- Organization has decided to increase the salary of employees by 10% of existing salary, who are having salary less than average salary of organization, 
-- Whenever such salary updates takes place, a record for the same is maintained in the increment_salary table. 

create table employee (
	eno int primary key,
    name varchar(25),
    salary int
);

alter table employee modify name varchar(25);

insert into employee values (1,"Yash",10000),(2,"Tejas",40000),(3,"Prathmesh",15000),(4,"Satyam",10000);

select * from employee;

create table incr_salary(
	name varchar(25),
    old_salary int,
    new_salary int
);

alter table incr_salary add eno int primary key;
alter table incr_salary add foreign key (eno) references employee(eno);

delimiter //

create procedure increment()
begin

declare average int;
declare ct int;
declare done int;
declare no int;
declare name varchar(25);
declare sal int;
declare cur cursor for select eno,name,salary from employee;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
open cur;
select avg(salary) into average from employee;
select  count(eno) into ct from employee;

main : loop
	if(done = 1) then leave main;
    end if;
	fetch cur into no, name, sal;
	set ct = ct-1;
	if(sal<average) then
		update employee modify set salary = sal + (sal*(0.1)) where eno = no;
		if(exists (select eno from incr_salary where eno = no)) then
			update incr_salary modify set new_salary = sal + (sal*(0.1)) where eno = no;
		else insert into incr_salary (eno,name,old_salary,new_salary) values (no,name,sal,sal + (sal*(0.1)));
        end if;
	elseif(ct=0) then
		leave main;
	end if;

end loop main; 

select "Records updated" as "Message";

close cur;
end //


drop procedure increment;

update employee modify set salary = salary +30000 where eno =3;

select * from employee;
select * from incr_salary;
call increment();



