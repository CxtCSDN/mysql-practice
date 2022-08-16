#1.查询和Zlotkey相同部门的员工姓名和工资 
SELECT last_name,salary
FROM employees
WHERE department_id = (
	SELECT department_id
	FROM employees
	WHERE last_name = 'Zlotkey'
);

#2.查询工资比公司平均工资高的员工的员工号，姓名和工资。 
SELECT employee_id,last_name,salary
FROM employees
WHERE salary > (
	SELECT AVG(salary)
	FROM employees
);

#3.选择工资大于所有JOB_ID = 'SA_MAN'的员工的工资的员工的last_name, job_id, salary 
SELECT last_name,job_id,salary
FROM employees
WHERE salary > ALL(
	SELECT salary
	FROM employees
	WHERE job_id = 'SA_MAN'
);

#4.查询和姓名中包含字母u的员工在相同部门的员工的员工号和姓名 
SELECT employee_id,last_name
FROM employees
WHERE department_id IN (
	SELECT department_id
	FROM employees
	WHERE last_name LIKE '%u%'
);

#5.查询在部门的location_id为1700的部门工作的员工的员工号 
SELECT e.employee_id
FROM employees e JOIN departments d
ON e.`department_id` = d.`department_id`
WHERE location_id = ALL(
	SELECT location_id
	FROM departments
	WHERE location_id = 1700
);

#6.查询管理者是King的员工姓名和工资 
SELECT emp.last_name,emp.salary
FROM employees emp JOIN employees mgr
ON emp.`manager_id` = mgr.`employee_id`
WHERE mgr.last_name = 'King';

SELECT last_name,salary
FROM employees
WHERE manager_id = (
	SELECT employee_id
	FROM employees
	WHERE last_name = 'King' && manager_id IS NULL
);

#7.查询工资最低的员工信息: last_name, salary 
SELECT last_name,salary
FROM employees
WHERE salary <= (
	SELECT MIN(salary)
	FROM employees
);

#8.查询平均工资最低的部门信息 ***
SELECT *
FROM departments  
WHERE department_id= (
	SELECT department_id
	FROM employees
	GROUP BY department_id 
	HAVING AVG(salary) = (
		SELECT MIN(dept_avgsal) 
		FROM (
			SELECT AVG(salary) dept_avgsal 
			FROM employees 
			GROUP BY department_id 
		) avg_sal 
	) 
);

#9.查询平均工资最低的部门信息和该部门的平均工资（相关子查询）***
SELECT d.*,(SELECT AVG(salary) FROM employees e WHERE e.department_id = d.`department_id`)
FROM departments d 
WHERE d.`department_id` = (
	SELECT department_id
	FROM employees
	GROUP BY department_id
	HAVING AVG(salary) = (
		SELECT MIN(dept_avg_sal)
		FROM(
			SELECT AVG(salary) dept_avg_sal
			FROM employees
			GROUP BY department_id
		) avg_sal
	)
);
 
#10.查询平均工资最高的 job 信息 
SELECT *
FROM employees
WHERE job_id = (
	SELECT job_id
	FROM employees
	HAVING AVG(salary) = (
		SELECT MAX(avg_sal)
		FROM(
			SELECT AVG(salary) avg_sal
			FROM employees
		)t_avg
	)
);

#11.查询平均工资高于公司平均工资的部门有哪些? 
SELECT department_id,department_name
FROM departments
WHERE department_id IN(
	SELECT department_id
	FROM employees
	GROUP BY department_id
	HAVING AVG(salary) > (
		SELECT AVG(salary)
		FROM employees
	)
);

#12.查询出公司中所有 manager 的详细信息 **
SELECT DISTINCT emp.*
FROM employees emp JOIN employees mgr
WHERE emp.`employee_id` = mgr.`manager_id`;

#13.各个部门中 最高工资中最低的那个部门的 最低工资是多少? *****
SELECT MIN(salary)
FROM employees
WHERE department_id = (
	SELECT department_id
	FROM employees
	GROUP BY department_id
	HAVING MAX(salary) = (
		SELECT MIN(max_sal)
		FROM (
			SELECT MAX(salary) max_sal
			FROM employees
			GROUP BY department_id
		)dept_max_sal
	)
);

#14.查询平均工资最高的部门的 manager 的详细信息: last_name, department_id, email, salary 


#15. 查询部门的部门号，其中不包括job_id是"ST_CLERK"的部门号 
#16. 选择所有没有管理者的员工的last_name 
#17．查询员工号、姓名、雇用时间、工资，其中员工的管理者为 'De Haan' 
#18.查询各部门中工资比本部门平均工资高的员工的员工号, 姓名和工资（相关子查询） 
#19.查询每个部门下的部门人数大于 5 的部门名称（相关子查询） 
#20.查询每个国家下的部门个数大于 2 的国家编号（相关子查询）