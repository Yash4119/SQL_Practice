create database plsql_block;

use plsql_block;

create table Stud (
	Roll int primary key,
    att int,
    status varchar(1) default ""
);

alter table Stud modify status varchar(2) default "";

insert into Stud (Roll,att) values (33,98),(20,67),(27,75),(34,74);
select * from Stud;

DELIMITER //

create procedure check_attendance (in roll_no int) 

begin     
	declare exit handler for sqlexception select "Error Ocurred, Perform the execution properly" Message;
    declare att_perc int;
    declare is_there int;
    
    set is_there = -1;
    
    select Roll into is_there from Stud where Roll=roll_no;
    
    if(is_there = -1) then
		select "Roll No Not in Database" as "Error Occurred";
	
    else 
    
    select att into att_perc from Stud where Roll = roll_no;
    
    if(att_perc < 75) then
		select "term not granted" as result;
        update Stud modify set status = 'D' where Roll = roll_no;
    
    else 
		select "term granted" as result;
        update Stud modify set status = 'ND' where Roll = roll_no;
    
	end if;
    end if;
end // 

delimiter //
drop procedure check_attendance//

delimiter ;
call check_attendance(31);




-- B sub question of 14th que

create table Account_Master (
	acc_no int primary key,
    name varchar(55),
    balance bigint default 0
);

delimiter ;
insert into Account_Master values (001,"Yash Ambekar",200),(002,"Teja Bhandvalkar",1000),(003,"Swami Ji",2000),(004,"Krishna",200);

delimiter //

create procedure withdraw(in num int,in amt int)
begin

	declare curr_bal int;
    select balance into curr_bal from Account_Master where acc_no = num;
    
    if(curr_bal < amt) then
		select "Current Account Balance Not Sufficient!!! Cannot Proccess Transaction" as "Error";
	
    else
    
		update Account_Master modify set balance = balance - amt where acc_no = num;
		select "Transaction Processed Successfully!" as "Message";
    
    end if;

end //

delimiter;
drop procedure withdraw;
drop procedure deposit;

delimiter //
create procedure deposit(in num int,in amt int)
begin

		update Account_Master modify set balance = balance + amt where acc_no = num;
		select "Transaction Processed Successfully!" as "Message";

end

delimiter ;
call deposit(001,1000);
call deposit(002,1000);
call deposit(003,1000);

call withdraw(004,500);
call withdraw(001,1200);
call withdraw(002,1500);

select * from Account_Master;














