select * from employees;
select * from employee_salary;
select * from roles;
select * from roles_employee;
select * from salary;

--1. Вывести всех работников чьи зарплаты есть в базе, вместе с зарплатами.

SELECT 	employees.employee_name ,
		salary.monthly_salary 
FROM employee_salary 
INNER JOIN employees 
    ON employees.id = employee_salary.employee_id 
INNER JOIN salary 
    ON salary.id = employee_salary.salary_id; 
    
--2. Вывести всех работников у которых ЗП меньше 2000.

SELECT employees.employee_name ,
		salary.monthly_salary 
FROM employee_salary 
INNER JOIN employees 
    ON employees.id = employee_salary.employee_id 
INNER JOIN salary 
    ON salary.id = employee_salary.salary_id
where salary.monthly_salary <2000;

--3. Вывести все зарплатные позиции, но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)

SELECT roles.role_title,
		salary.monthly_salary 		
FROM roles 
full outer join roles_employee
on roles.id  = roles_employee.role_id 
full outer join employees
on roles_employee.employee_id = employees.id 
full outer join employee_salary
on employees.id = employee_salary.employee_id 
full outer join salary
on employee_salary.salary_id  = salary.id
where roles.role_title is not null 
	and salary.monthly_salary is not null;
	
--4. Вывести все зарплатные позиции  меньше 2000 но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)

SELECT roles.role_title,
		salary.monthly_salary 		
FROM roles 
full outer join roles_employee
on roles.id  = roles_employee.role_id 
full outer join employees
on roles_employee.employee_id = employees.id 
full outer join employee_salary
on employees.id = employee_salary.employee_id 
full outer join salary
on employee_salary.salary_id  = salary.id
where roles.role_title is not null 
	and salary.monthly_salary <2000;

--5. Найти всех работников кому не начислена ЗП.

select employees.id,
		employees.employee_name
from employees
left join employee_salary
on employees.id = employee_salary.employee_id 
left join salary
on employee_salary.salary_id = salary.id  
where salary.monthly_salary is null;

--6. Вывести всех работников с названиями их должности.

SELECT employees.employee_name ,
		roles.role_title 
FROM employees 
INNER JOIN roles_employee 
    ON employees.id = roles_employee.employee_id 
INNER JOIN roles  
    ON roles_employee.role_id = roles.id; 

--7. Вывести имена и должность только Java разработчиков.
    
SELECT employees.employee_name ,
		roles.role_title 
FROM employees 
INNER JOIN roles_employee 
    ON employees.id = roles_employee.employee_id 
INNER JOIN roles  
    ON roles_employee.role_id = roles.id 
where role_title like '%Java %';
    
--8. Вывести имена и должность только Python разработчиков.

SELECT employees.employee_name ,
		roles.role_title 
FROM employees 
INNER JOIN roles_employee 
    ON employees.id = roles_employee.employee_id 
INNER JOIN roles  
    ON roles_employee.role_id = roles.id 
where role_title like '%Python%';

--9. Вывести имена и должность всех QA инженеров.

SELECT employees.employee_name ,
		roles.role_title 
FROM employees 
INNER JOIN roles_employee 
    ON employees.id = roles_employee.employee_id 
INNER JOIN roles  
    ON roles_employee.role_id = roles.id 
where role_title like '%QA%';

--10. Вывести имена и должность ручных QA инженеров.

SELECT employees.employee_name ,
		roles.role_title 
FROM employees 
INNER JOIN roles_employee 
    ON employees.id = roles_employee.employee_id 
INNER JOIN roles  
    ON roles_employee.role_id = roles.id 
where role_title like '%Manual QA%';

--11. Вывести имена и должность автоматизаторов QA.

SELECT employees.employee_name ,
		roles.role_title 
FROM employees 
INNER JOIN roles_employee 
    ON employees.id = roles_employee.employee_id 
INNER JOIN roles  
    ON roles_employee.role_id = roles.id 
where role_title like '%Automation QA%';

--12. Вывести имена и зарплаты Junior специалистов.

SELECT employees.employee_name ,
		salary.monthly_salary  
FROM roles 
INNER JOIN roles_employee 
    ON roles.id = roles_employee.role_id 
INNER JOIN employees 
    ON roles_employee.employee_id = employees.id 
INNER JOIN employee_salary 
    ON employees.id = employee_salary.employee_id 
INNER JOIN salary 
    ON employee_salary.salary_id = salary.id  
where roles.role_title like '%Junior%';

--13. Вывести имена и зарплаты Middle специалистов.

SELECT employees.employee_name ,
		salary.monthly_salary  
FROM roles 
INNER JOIN roles_employee 
    ON roles.id = roles_employee.role_id 
INNER JOIN employees 
    ON roles_employee.employee_id = employees.id 
INNER JOIN employee_salary 
    ON employees.id = employee_salary.employee_id 
INNER JOIN salary 
    ON employee_salary.salary_id = salary.id  
where roles.role_title like '%Middle%';

--14. Вывести имена и зарплаты Senior специалистов.

SELECT employees.employee_name ,
		salary.monthly_salary  
FROM roles 
INNER JOIN roles_employee 
    ON roles.id = roles_employee.role_id 
INNER JOIN employees 
    ON roles_employee.employee_id = employees.id 
INNER JOIN employee_salary 
    ON employees.id = employee_salary.employee_id 
INNER JOIN salary 
    ON employee_salary.salary_id = salary.id  
where roles.role_title like '%Senior%';

--15. Вывести зарплаты Java разработчиков.

insert into roles_employee(employee_id, role_id)
values (30, 1),
		(29, 2),
		(28, 3),
		(27, 4),
		(26, 5),
		(25, 6),
		(24, 7),
		(23, 8),
		(22, 9),
		(21, 10);
	
select * from roles_employee;

SELECT salary.monthly_salary  
FROM roles 
INNER JOIN roles_employee 
    ON roles.id = roles_employee.role_id 
INNER JOIN employees 
    ON roles_employee.employee_id = employees.id 
INNER JOIN employee_salary 
    ON employees.id = employee_salary.employee_id 
INNER JOIN salary 
    ON employee_salary.salary_id = salary.id  
where roles.role_title like '%Java%';

--16. Вывести зарплаты Python разработчиков.

SELECT salary.monthly_salary  
FROM roles 
INNER JOIN roles_employee 
    ON roles.id = roles_employee.role_id 
INNER JOIN employees 
    ON roles_employee.employee_id = employees.id 
INNER JOIN employee_salary 
    ON employees.id = employee_salary.employee_id 
INNER JOIN salary 
    ON employee_salary.salary_id = salary.id  
where roles.role_title like '%Python%';

--17. Вывести имена и зарплаты Junior Python разработчиков.

SELECT employees.employee_name ,
		salary.monthly_salary  
FROM roles 
INNER JOIN roles_employee 
    ON roles.id = roles_employee.role_id 
INNER JOIN employees 
    ON roles_employee.employee_id = employees.id 
INNER JOIN employee_salary 
    ON employees.id = employee_salary.employee_id 
INNER JOIN salary 
    ON employee_salary.salary_id = salary.id  
where roles.role_title like '%Junior Python%';

--18. Вывести имена и зарплаты Middle JS разработчиков.

SELECT employees.employee_name ,
		salary.monthly_salary  
FROM roles 
INNER JOIN roles_employee 
    ON roles.id = roles_employee.role_id 
INNER JOIN employees 
    ON roles_employee.employee_id = employees.id 
INNER JOIN employee_salary 
    ON employees.id = employee_salary.employee_id 
INNER JOIN salary 
    ON employee_salary.salary_id = salary.id  
where roles.role_title like '%Middle JavaScript%';

--19. Вывести имена и зарплаты Senior Java разработчиков.

SELECT employees.employee_name ,
		salary.monthly_salary  
FROM roles 
INNER JOIN roles_employee 
    ON roles.id = roles_employee.role_id 
INNER JOIN employees 
    ON roles_employee.employee_id = employees.id 
INNER JOIN employee_salary 
    ON employees.id = employee_salary.employee_id 
INNER JOIN salary 
    ON employee_salary.salary_id = salary.id  
where roles.role_title like '%Senior JavaScript%';

--20. Вывести зарплаты Junior QA инженеров.

SELECT salary.monthly_salary  
FROM roles 
INNER JOIN roles_employee 
    ON roles.id = roles_employee.role_id 
INNER JOIN employees 
    ON roles_employee.employee_id = employees.id 
INNER JOIN employee_salary 
    ON employees.id = employee_salary.employee_id 
INNER JOIN salary 
    ON employee_salary.salary_id = salary.id  
where roles.role_title like '%Junior%QA%';

--21. Вывести среднюю зарплату всех Junior специалистов.

SELECT avg(salary.monthly_salary) as avg_salary  
FROM roles 
INNER JOIN roles_employee 
    ON roles.id = roles_employee.role_id 
INNER JOIN employees 
    ON roles_employee.employee_id = employees.id 
INNER JOIN employee_salary 
    ON employees.id = employee_salary.employee_id 
INNER JOIN salary 
    ON employee_salary.salary_id = salary.id  
where roles.role_title like '%Junior%QA%';

--22. Вывести сумму зарплат JS разработчиков.

SELECT sum(salary.monthly_salary) as sum_salary  
FROM roles 
INNER JOIN roles_employee 
    ON roles.id = roles_employee.role_id 
INNER JOIN employees 
    ON roles_employee.employee_id = employees.id 
INNER JOIN employee_salary 
    ON employees.id = employee_salary.employee_id 
INNER JOIN salary 
    ON employee_salary.salary_id = salary.id  
where roles.role_title like '%JavaScript%';

--23. Вывести минимальную ЗП QA инженеров.

SELECT min(salary.monthly_salary) as min_salary  
FROM roles 
INNER JOIN roles_employee 
    ON roles.id = roles_employee.role_id 
INNER JOIN employees 
    ON roles_employee.employee_id = employees.id 
INNER JOIN employee_salary 
    ON employees.id = employee_salary.employee_id 
INNER JOIN salary 
    ON employee_salary.salary_id = salary.id  
where roles.role_title like '%QA%';

--24. Вывести максимальную ЗП QA инженеров.

SELECT max(salary.monthly_salary) as max_salary  
FROM  roles 
INNER JOIN roles_employee 
    ON roles.id = roles_employee.role_id 
INNER JOIN employees 
    ON roles_employee.employee_id = employees.id 
INNER JOIN employee_salary 
    ON employees.id = employee_salary.employee_id 
INNER JOIN salary 
    ON employee_salary.salary_id = salary.id 
where roles.role_title like '%QA%';

--25. Вывести количество QA инженеров.

SELECT count(role_title) as count_role  
from roles
where role_title like '%QA%';

--26. Вывести количество Middle специалистов.

SELECT count(role_title) as count_role  
from roles
where role_title like '%Middle%';

--27. Вывести количество разработчиков.

SELECT count(role_title) as count_role  
from roles
where role_title like '%developer%'

--28. Вывести фонд (сумму) зарплаты разработчиков.

SELECT sum(salary.monthly_salary) as fund_salary  
FROM  roles 
INNER JOIN roles_employee 
    ON roles.id = roles_employee.role_id 
INNER JOIN employees 
    ON roles_employee.employee_id = employees.id 
INNER JOIN employee_salary 
    ON employees.id = employee_salary.employee_id 
INNER JOIN salary 
    ON employee_salary.salary_id = salary.id 
where roles.role_title like '%developer%';

--29. Вывести имена, должности и ЗП всех специалистов по возрастанию.

SELECT employees.employee_name ,
		roles.role_title,
		salary.monthly_salary  
FROM roles 
INNER JOIN roles_employee 
    ON roles.id = roles_employee.role_id 
INNER JOIN employees 
    ON roles_employee.employee_id = employees.id 
INNER JOIN employee_salary 
    ON employees.id = employee_salary.employee_id 
INNER JOIN salary 
    ON employee_salary.salary_id = salary.id  
order by employees.employee_name, roles.role_title, salary.monthly_salary;

--30. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП от 1700 до 2300.

SELECT employees.employee_name ,
		roles.role_title,
		salary.monthly_salary  
FROM roles 
INNER JOIN roles_employee 
    ON roles.id = roles_employee.role_id 
INNER JOIN employees 
    ON roles_employee.employee_id = employees.id 
INNER JOIN employee_salary 
    ON employees.id = employee_salary.employee_id 
INNER JOIN salary 
    ON employee_salary.salary_id = salary.id  
where salary.monthly_salary >= 1700 and salary.monthly_salary <= 2300
order by employees.employee_name, roles.role_title, salary.monthly_salary;

--31. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП меньше 2300.

SELECT employees.employee_name ,
		roles.role_title,
		salary.monthly_salary  
FROM roles 
INNER JOIN roles_employee 
    ON roles.id = roles_employee.role_id 
INNER JOIN employees 
    ON roles_employee.employee_id = employees.id 
INNER JOIN employee_salary 
    ON employees.id = employee_salary.employee_id 
INNER JOIN salary 
    ON employee_salary.salary_id = salary.id  
where salary.monthly_salary < 2300
order by employees.employee_name, roles.role_title, salary.monthly_salary;

--32. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП равна 1100, 1500, 2000.

SELECT employees.employee_name ,
		roles.role_title,
		salary.monthly_salary  
FROM roles 
INNER JOIN roles_employee 
    ON roles.id = roles_employee.role_id 
INNER JOIN employees 
    ON roles_employee.employee_id = employees.id 
INNER JOIN employee_salary 
    ON employees.id = employee_salary.employee_id 
INNER JOIN salary 
    ON employee_salary.salary_id = salary.id  
where salary.monthly_salary = 1100 or salary.monthly_salary = 1500 or salary.monthly_salary = 2200
order by employees.employee_name, roles.role_title, salary.monthly_salary;
