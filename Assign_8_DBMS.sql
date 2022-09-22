create database Triggers;

use Triggers;

create table Library(
		roll_no int primary key,
        doi date not null,
        nob varchar(100),
        status char(1)
);

insert into Library values
(33,'2022-09-21',"Data Structures and Algorithms","I"),
(34,'2022-09-1',"DBMS","I"),
(47,'2022-09-12',"CNS","I");

create table Library_Audit(
	roll_no int,
	doi date not null,
	nob varchar(100),
	status char(1)
);

drop table Library_Audit//


delimiter //

-- Trigger for insertion of OLD data before UPDATION

create trigger trig1 after update 
on Library for each row 
begin 
	
	insert into Library_Audit values (old.roll_no,old.doi,old.nob,old.status);
end //

create trigger trig1 after update 
on Library for each row 
begin 
	delete from Library_Audit where roll_no = old.roll_no;
	insert into Library_Audit values (old.roll_no,old.doi,old.nob,old.status);
end //

drop trigger trig1//

-- Trigger for insertion of OLD data after DELETION;

create trigger trig2 before delete 
on Library for each row 
begin 
 
	insert into Library_Audit values (old.roll_no,old.doi,old.nob,old.status);

end//

drop trigger trig2//












