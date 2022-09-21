create database Cursors;

use Cursors;

create table N_Roll_Call (
roll_no int primary key
);

create table O_Roll_Call (
roll_no int primary key
);

insert into N_Roll_Call values (33),(34),(47),(27);
insert into O_Roll_Call values (24),(34),(20),(27);

select * from N_Roll_Call;
select * from O_Roll_Call;

delimiter //

create procedure Merge_Tables(IN Table1 varchar(100),IN Table2 varchar(100))
begin 

declare roll_ptr1 int;
declare size int;
declare ind int;
declare cur cursor for select o_roll_call.roll_no from o_roll_call where o_roll_call.roll_no not in (select roll_no from n_roll_call);
declare len cursor for select count(o_roll_call.roll_no) from o_roll_call where o_roll_call.roll_no not in (select roll_no from n_roll_call);

set ind=0;
open cur;
open len;
fetch len into size;
label1 : loop  
	Fetch cur into roll_ptr1;
    insert into n_roll_call values (roll_ptr1);
    set ind = ind+1;
    if(ind < size) then iterate label1; 
    end if; 
end loop label1;

select "Tables Are Been Merged";

close len;
close cur;
end//

insert into o_roll_call values(21),(49);
 insert into o_roll_call values(21),(13);

select roll_no from n_roll_call order by roll_no asc//
        
delimiter ;









