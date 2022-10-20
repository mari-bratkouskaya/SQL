--������� salary
--������� ������� salary
-- 	- id Serial  primary key,
--	- monthly_salary Int not null
--��������� ������� salary 15 ��������:

create table salary(
	id Serial primary key,
	monthly_salary Int not null
);

select * from salary;

insert into salary(monthly_salary)
values (1000),
		(1100),
		(1200),
		(1300),
		(1400),
		(1500),
		(1600),
		(1700),
		(1800),
		(1900),
		(2000),
		(2100),
		(2200),
		(2300),
		(2400);
	
--������� roles
--������� ������� roles
--	- id Serial  primary key,
--	- role_title varchar(50) not null unique
--��������� ������� roles 20 ��������:

	
create table roles(
	id Serial  primary key,
	role_title varchar(50) not null unique
);

select * from roles;

insert into roles(role_title)
values ('Junior Python developer'),
	('Middle Python developer'),
	('Senior Python developer'),
	('Junior Java developer'),
	('Middle Java developer'),
	('Senior Java developer'),
	('Junior JavaScript developer'),
	('Middle JavaScript developer'),
	('Senior JavaScript developer'),
	('Junior Manual QA engineer'),
	('Middle Manual QA engineer'),
	('Senior Manual QA engineer'),
	('Project Manager'),
	('Designer'),
	('HR'),
	('CEO'),
	('Sales manager'),
	('Junior Automation QA engineer'),
	('Middle Automation QA engineer'),
	('Senior Automation QA engineer');

--������� employees
--������� ������� employees
--	- id. serial,  primary key,
--	- employee_name. Varchar(50), not null
--��������� ������� employee 70 ��������.

create table employees(
	id Serial  primary key,
	employee_name varchar(50) not null
);

select * from employees;
	
insert into employees(employee_name)
values ('�������'),
	('������'),
	('��������'),
	('�������'),
	('�����'),
	('�������'),
	('������'),
	('�������'),
	('�������'),
	('������'),
	('������'),
	('��������'),
	('��������'),
	('������'),
	('������'),
	('������'),
	('�������'),
	('����������'),
	('��������'),
	('��������'),
	('Ը�����'),
	('��������'),
	('������'),
	('�������'),
	('�����'),
	('�������'),
	('�����'),
	('������'),
	('�������'),
	('�������'),
	('������'),
	('�����'),
	('�����'),
	('�����'),
	('�������'),
	('���������'),
	('�������'),
	('�������'),
	('��������'),
	('��������'),
	('�������'),
	('�������'),
	('�������'),
	('�������'),
	('�������'),
	('�������'),
	('������'),
	('���������'),
	('��������'),
	('���������'),
	('�������'),
	('��������'),
	('�����'),
	('�������'),
	('�������'),
	('�����'),
	('�������'),
	('�������'),
	('�������'),
	('�����'),
	('������'),
	('�������'),
	('��������'),
	('������'),
	('��������'),
	('�������'),
	('������'),
	('��������'),
	('�������'),
	('��������');

--������� employee_salary
--������� ������� employee_salary
--	- id. Serial  primary key,
--	- employee_id. Int, not null, unique
--	- salary_id. Int, not null
--��������� ������� employee_salary 40 ��������:
--	- � ������ �������� �������������� salary_id

create table employee_salary(
	id serial primary key,
	employee_id Int not null unique,
	salary_id Int not null,
	foreign key(employee_id)
		references employees(id),
	foreign key(salary_id)
		references salary(id)
);
	
select * from employee_salary;

insert into employee_salary(employee_id, salary_id)
values (1, 15),
	(2, 14),
	(3, 13),
	(4, 12),
	(5, 11),
	(6, 10),
	(7, 9),
	(8, 8),
	(9, 7),
	(10, 6),
	(11, 5),
	(12, 4),
	(13, 3),
	(14, 2),
	(15, 1),
	(16, 15),
	(17, 14),
	(18, 13),
	(19, 12),
	(20, 11),
	(21, 10),
	(22, 9),
	(23, 8),
	(24, 7),
	(25, 6),
	(26, 5),
	(27, 4),
	(28, 3),
	(29, 2),
	(30, 1),
	(31, 15),
	(32, 14),
	(33, 13),
	(34, 12),
	(35, 11),
	(36, 10),
	(37, 9),
	(38, 8),
	(39, 7),
	(40, 6);
	
select * from employee_salary;

insert into employee_salary(employee_id, salary_id)
values (41, 16);


--������� roles_employee
--������� ������� roles_employee
--	- id. Serial  primary key,
--	- employee_id. Int, not null, unique (������� ���� ��� ������� employees, ���� id)
--	- role_id. Int, not null (������� ���� ��� ������� roles, ���� id)
--��������� ������� roles_employee 40 ��������:

create table roles_employee(
	id serial primary key,
	employee_id Int not null unique,
	role_id Int not null,
	foreign key(employee_id)
		references employees(id),
	foreign key(role_id)
		references roles(id)
);
	
select * from roles_employee;

insert into roles_employee(employee_id, role_id)
values (70, 1),
	(69, 2),
	(68, 3),
	(67, 4),
	(66, 5),
	(65, 6),
	(64, 7),
	(63, 8),
	(62, 9),
	(61, 10),
	(60, 11),
	(59, 12),
	(58, 13),
	(57, 14),
	(56, 15),
	(55, 16),
	(54, 17),
	(53, 18),
	(52, 19),
	(51, 20),
	(50, 1),
	(49, 2),
	(48, 3),
	(47, 4),
	(46, 5),
	(45, 6),
	(44, 7),
	(43, 8),
	(42, 9),
	(41, 10),
	(40, 11),
	(39, 12),
	(38, 13),
	(37, 14),
	(36, 15),
	(35, 16),
	(34, 17),
	(33, 18),
	(32, 19),
	(31, 20);
	
select * from roles_employee;