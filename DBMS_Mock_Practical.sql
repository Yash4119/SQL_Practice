create database Mock_Test;

use Mock_Test;

create table Hotel(
	hotel_no int primary key,
    name char(255),
    city char(255)
);

create table Room(
	room_no int primary key,
    hotel_no int,
    type char(255),
    price int,
    foreign key(hotel_no) references Hotel(hotel_no)
);

create table guest(
	guest_no int primary key,
    guest_name char(255),
    guest_addr char(255)
);

create table Booking(
	hotel_no int,
    room_no int,
    guest_no int,
    date_from date,
    date_to date,
    foreign key(hotel_no) references Hotel(hotel_no),
    foreign key(room_no) references Room(room_no),
    foreign key(guest_no) references Guest(guest_no)
);

insert into hotel values 
	(1,"Jai Malhar","Pune"),
    (2,"Saat Bara" , "Satara"),
    (3,"Fariyas", "Pune"),
    (4,"Mizzle","Pune");
    
insert into Room values
	(10,1,"Normal",1000),
    (11,1,"Premium",2000),
    (21,2,"AC",1500),
    (31,3,"AC",2100),
    (32,3,"Luxurious",3000),
    (41,4,"Mizzle",1250);
    
insert into Guest values
	(100,"Yash Ambekar","Lonavla"),
    (101,"Tejas Bhandvalkar","Mumbai"),
    (102,"Satyam Sakore","Junnur"),
    (103,"Prathmesh Swami","Pimpri");
    
insert into Booking values 
	(1,10,100,'2022-11-02','2022-11-04'),
    (2,21,102,'2022-11-02','2022-11-05'),
    (3,32,103,'2022-11-03','2022-11-04');

-- Now we will be running the Queries

-- 1 List Full Details of all hotels
select * from Hotel;

-- 2 List full details of all hotels in Pune
select * from Hotel where city = "Pune";

-- 3 List all guests currently staying at the Fariyas Hotel
select * from Guest 
where guest_no = (
	select guest_no from Booking
    where hotel_no = (
		select hotel_no from Hotel
        where name = "Fariyas")
	);
-- 4 name and addresses of guests in london
select guest_name, guest_addr from Guest
where guest_no in (
	select guest_no from Booking where hotel_no in (
		select hotel_no from Hotel where city = "Pune"
    )
) order by guest_name ASC;

-- 5 Booking with no date_to
select * from Booking where date_to=null;

-- 6 Number of hotels
select count(hotel_no) as "Total number of Hotels" from Hotel;

-- 7 unoccuppied rooms
select room_no from Room where hotel_no not in (
	select hotel_no from Booking
)
and 
hotel_no in (
	select  hotel_no from Hotel where name = "Mizzle"
);

-- 8 lost income at each hotel
Select hotel_no, sum(price) from Room where room_no not in (select room_no from Booking)
group by hotel_no;

-- 9 create a index

create index Mock on Room (price);

-- 10 create a view

create view unoccupied as select hotel_no, room_no from room
where room_no not in (select room_no from Booking);

select * from unoccupied;