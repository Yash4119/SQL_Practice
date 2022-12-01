create database company;

use company;

create table dept(
	dept_no int primary key,
    dept_name varchar(20),
    location varchar(25)
);

create table Emp(
	eno int primary key,
    ename varchar(50),
    job varchar(20),
    hire_date date,
    salary bigint,
    commission int,
    dept_no int,
    foreign key (dept_no) references dept(dept_no)
);

drop table Emp;

insert into dept values (1,"dev","Pune"),(2,"IB","Banglore"),(3,"Cloud","Noida");

insert into Emp values 
(1,"Yash Ambekar","SDE","2022-10-23",75000,0,1),
(2,"Tejas Bhandvalkar","SRE","2022-10-21",80000,0,1),
(3,"Krishna Kotgire","VP","2022-10-10",100000,0,2),
(4,"Prathmesh Swami","BA4","2022-09-10",75000,0,2),
(5,"Satyam Sakore","CA","2022-10-10",79000,0,3),
(6,"Yash Shinde","CA","2022-06-10",90000,0,3);

insert into Emp values (7,"Omkar","Intern","2022-10-23",30000,0,1);

select * from dept;
select * from Emp;

-- Query 1 :- Maximum salary paid

select max(salary) from Emp;
select max(salary) from Emp where job="CA";

-- Query 2 :- Name of Employee whose name starts with 'Y'

select ename from Emp where ename like 'Y%';

-- Query 3 :- Name of Employees selected before 30th Sept 2022

select * from Emp where hire_date < "2022-09-30";

-- Query 4 :- Display employee details in descending order of their basic salary

select * from Emp order by salary desc;

-- Query 5 :- Number of Employees and Average salary of employee in dept_no 2

select count(eno) as "Number of Employees", avg(salary) as "Average Salary" from Emp where dept_no = 2;

-- Query 6 :- avg_salary, minimum salary of employee hire_date wise from dept_no 10

select avg(salary) as "Average Salary", min(salary) as "Minimum Salary", hire_date from Emp where dept_no = 1 group by hire_date;

-- Query 7 :- list employee name and its department

select Emp.ename as "Name", dept.dept_name as "Department Name" from Emp,dept where dept.dept_no = Emp.dept_no;
select Emp.ename as "Name", dept.dept_name as "Department Name" from Emp inner join dept on dept.dept_no = Emp.dept_no;
select Emp.ename as "Name", dept.dept_name as "Department Name" from Emp natural join dept;

-- Query 8 :- Total Salary Paid by each Department

select dept.dept_name,sum(salary) from Emp,dept where dept.dept_no = Emp.dept_no group by Emp.dept_no;
select dept.dept_name, sum(salary) from Emp inner join dept on dept.dept_no = Emp.dept_no group by Emp.dept_no; 
select dept.dept_name,sum(salary)as  "Salary Paid" from Emp natural join dept group by dept.dept_no;

-- Query 9 :- Details of Employees working in "dev" department

select dept.dept_name, Emp.ename,Emp.salary from Emp,dept where dept.dept_no = Emp.dept_no and dept.dept_name = "dev";
select ename as "Name",salary from Emp inner join dept on dept.dept_no=Emp.dept_no and dept.dept_name = "dev";
select ename as "Name",salary from Emp natural join dept where dept.dept_name="dev";

-- Query 10 :- Salary Hike of 5% for all employees of dept_no :- 3

update Emp modify
set salary = salary + (salary*(5/100))
where dept_no = 3;

update Emp modify set salary = 65000 where ename = "Satyam Sakore";
update Emp modify set salary = 85000 where ename = "Yash Shinde";

set sql_safe_updates = 0;

select * from Emp where dept_no = 3;






