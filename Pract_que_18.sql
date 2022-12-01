create database trig;

use trig;

-- a) Write a update, delete trigger on clientmstr table. The System should keep track of the records that ARE BEING updated or deleted. 
-- The old value of updated or deleted records should be added in audit_trade table. 
-- (separate implementation using both row and statement triggers). 

create table clientmstr(
	cno int primary key,
    name varchar(25),
    city varchar(10)
);

insert into clientmstr values (1,"Yash","Pune"),(2,"Omkar","Satara"),(3,"Teja","Thane"),(4,"Shinde","Palghar");

create table audit_trade(
	cno int primary key,
    name varchar(25),
    city varchar(25),
    action varchar(25)
);

-- Mysql does not support statement level triggers, it facilitates only row level triggers.
delimiter //

create trigger trig1 after update on clientmstr for each row
begin

	insert into audit_trade values (old.cno,old.name,old.city,"Updated");

end //

create trigger trig2 after delete on clientmstr for each row 
begin

	insert into audit_trade values (old.cno,old.name,old.city,"Deleted");

end //

delimiter ;
set sql_safe_updates = 0;

update clientmstr modify set city = "Pune" where name in ("Teja","Shinde");

delete from clientmstr where city = "Satara";

select * from clientmstr;

select * from audit_trade;



-- b) Write a before trigger for Insert, update event considering following requirement: Emp(e_no, e_name, salary) I) 
-- Trigger action should be initiated when salary is tried to be inserted is less than Rs. 50,000/- II)
-- Trigger action should be initiated when salary is tried to be updated for value less than Rs. 50,000/- 
-- Action should be rejection of update or Insert operation by displaying appropriate error message.
-- Also the new values expected to be inserted will be stored in new table Tracking(e_no, salary).

create table Emp (
	e_no int primary key,
    e_name varchar(25),
    salary int
);

create table Tracking(
	e_no int,
    salary int
);

delimiter //
create trigger trig1 before insert on Emp for each row

begin

	if(new.salary < 50000) then
		insert into Tracking set e_no = new.e_no, salary = new.salary;
		signal sqlstate '45000'
        set message_text = "Salary of an employee cannot be less then 50,000/-";
    end if;

end //

drop trigger trig1;
delimiter //
create trigger trig2 after update on Emp for each row

begin

	if(new.salary < 50000) then
        insert into Tracking values(e_no,new.salary);
    end if;
	if(new.salary < 50000) then
		signal sqlstate '45000'
        set message_text = "Salary of an employee cannot be less then 50,000/-";
    end if;

end //

drop trigger trig2;


insert into Emp (e_no,e_name,salary) values (1,"Yash",25000);
insert into Emp values (2,"Satyam",55000);
insert into Emp (e_no,e_name,salary) values (4,"Shinde",60000);
insert into Emp values (5,"Swami",35000);

drop table Emp;
drop table Tracking;

update Emp modify set salary = 48000 where e_no = 2;

select * from Emp;

select * from Tracking;

delete from Emp;

delete from Tracking;

select @text;

