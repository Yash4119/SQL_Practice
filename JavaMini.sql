create database JavaMini;

use JavaMini;

create table Book (
	id int primary key auto_increment,
    book_name varchar(255),
    edition int,
    price int
);

select * from Book;