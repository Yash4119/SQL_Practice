create database Stud_Marks;

 use Stud_Marks;

create table Stud_Marks (
 roll_no int primary key,
 name varchar(30) not null,
 total_marks int default 0
);

create table Result(
roll_no int,
class varchar(20) not null,
foreign key (roll_no)
references Stud_Marks(roll_no)
on delete cascade
on update cascade
);
delimiter //

create procedure proc_Grade(IN roll_no Integer, IN Name_1 varchar(30), IN tot_Marks Integer)
begin 

insert into Stud_Marks values (roll_no,Name_1,tot_Marks); 

if(tot_Marks <= 1500 and tot_Marks >= 990) then
 insert into Result values (roll_no, "Distinction");
 
elseif (tot_Marks <= 989 and tot_Marks >= 900) then
 insert into Result values (roll_no, "First Class");
 
elseif (tot_Marks >= 825 and tot_Marks <= 899) then
 insert into Result values (roll_no, "Higher Second Class");
   
end if;
end
//

call proc_Grade(34,"Satyam",990)//
call proc_Grade(33,"Ambekar",1002)//
call proc_Grade(27,"Teja",825)//
call proc_Grade(47,"Prathmesh",900)//

 select * from Stud_Marks//
select * from Result//
delimiter ;