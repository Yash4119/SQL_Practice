-- Creation of database and tables and then inserting values in the tables

create database Library2;

use Library2;

create table Borrower(
roll_no int primary key,
        doi date not null,
        nob varchar(100),
        status char(1)
);

create table Fine(
roll_no int not null,
    dor date not null,
    amount int not null,
    foreign key (roll_no) references Borrower(roll_no) on delete cascade on update cascade
);

insert into Borrower values
(33,'2022-09-21',"Data Structures and Algorithms","I"),
(34,'2022-09-1',"DBMS","I"),
(47,'2022-09-12',"CNS","I");

insert into Borrower values
(27, "2022-08-18","TOC","I"),
(21, "2022-08-01","SPOS","I");

insert into Borrower values
(24, "2022-07-18","MP","I"),
(20, "2022-06-01","OOP","I");


select * from Borrower;

delimiter /

-- Procedure to check if book is already returned

create procedure calc_fine(IN roll_no int ,IN nob varchar(100))
begin
    declare
     stat char(1);
     select Borrower.status into stat from Borrower where Borrower.roll_no = roll_no;
     
     if stat="R" 
     then
     select Fine.roll_no as Roll_No,Borrower.doi as Date_of_Issuing ,Fine.dor as Date_of_Returning,Fine.amount as Total_fine from Fine,Borrower where Borrower.roll_no = Fine.roll_no;
     elseif stat="I"
     then 
     call return_book(roll_no,nob);
     end if;
     end /

-- procedure to update the Fine table

create procedure return_book(IN roll_no int, IN nob varchar(100))
begin
declare late int;
    select datediff(curdate(),doi) into late
    from Borrower
    where Borrower.roll_no = roll_no; 
   
    if late > 15 and late <= 30
    then
    insert into Fine values
    (roll_no, curdate(), (late-15)*5);
    
    elseif late > 30
    then
    insert into Fine values
    (roll_no, curdate(), ((late-30)*50)+75);
    
    else
    insert into Fine values
    (roll_no, curdate(), 0);
   
    end if;
   
    update Borrower set Borrower.status = "R" where Borrower.roll_no = roll_no;
   
    select Fine.roll_no as Roll_No,Borrower.doi as Date_of_Issuing ,Fine.dor as Date_of_Returning,Fine.amount as Total_fine from Fine,Borrower where Borrower.roll_no = Fine.roll_no;
   
end /

-- Showing Data from the Tables 

select * from Fine;
select * from Borrower;

--  Procedure call to  return book as well as calculate fine

call calc_fine(27,"TOC");
call calc_fine(20,"OOP");
call calc_fine(21,"SPOS");
call calc_fine(24,"MP");

