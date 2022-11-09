create database ayush;
use ayush;
Create table project (project_id int primary key,project_name varchar(20),chief_arch varchar(20));

Create table employee( emp_id int primary key,emp_name varchar (20));

Create table Assigned_To(project_id int primary key,emp_id int);

Insert into project values(1,"C353","Ayush");
Insert into project values(2,"C555","Ram");
Insert into project values(3,"C354","Shayam");
Insert into employee values(1," Ayush");
Insert into employee values(2," Ram");
Insert into employee values(3,"Shayam");

Insert into Assigned_To values(1,1);
Insert into Assigned_To values(2,2);
Insert into Assigned_To values(3,3);

Select emp_id from Assigned_To where project_id in (select project_id from project where project_name="C353");

Select count(emp_id) from Assigned_To where project_id in (select project_id from project where project_name="C353");

Select emp_id from Assigned_To where project_id in (select project_id from project where project_name="C353") and project_id in (select project_id from project where project_name="C354");

