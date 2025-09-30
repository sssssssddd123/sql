SELECT *
FROM employees;

SELECT *
FROM departments;

SELECT *
FROM locations;

SELECT *
FROM countries;

SELECT *
FROM jobs;
--------------------------------------------------------------------------------
-- 1. 
SELECT last_name, salary, department_id
FROM employees
WHERE last_name LIKE 'H%'
AND salary BETWEEN 7000 AND 12000;
--------------------------------------------------------------------------------
-- 2.
SELECT employee_id
     , first_name
     , last_name
     , job_id
     , salary
     , department_id

FROM employees
WHERE salary > 5000
AND department_id BETWEEN 50 AND 60;
--------------------------------------------------------------------------------
-- 3.
SELECT employee_id,
    CASE WHEN salary BETWEEN 0 AND 5000 THEN salary * 1.2
         WHEN salary BETWEEN 5001 AND 10000 THEN salary * 1.15
         WHEN salary BETWEEN 10001 AND 15000 THEN salary * 1.1
    ELSE salary
    END AS "인상된 급여"
FROM employees
WHERE employee_id = &employee_id;
--------------------------------------------------------------------------------
-- 4.
SELECT d.department_id
     , d.department_name
     , l.city
FROM departments d
JOIN locations l
ON d.location_id = l.location_id;
--------------------------------------------------------------------------------
-- 5.
SELECT *
FROM employees;

SELECT *
FROM departments;

SELECT *
FROM jobs;

SELECT employee_id
     , last_name
     , job_id
FROM employees e
WHERE department_id = (SELECT department_id
                       FROM departments d
                       WHERE department_name = 'IT');
--------------------------------------------------------------------------------
-- 6.
SELECT employee_id
     , first_name
     , last_name
     , email
     , phone_number
     , to_char(hire_date, 'dd-mon-yy') AS "HIRE_DATE"
     , job_id
FROM employees
WHERE job_id = 'ST_CLERK'
AND hire_date < '2004-01-01';
--------------------------------------------------------------------------------
-- 7.
SELECT last_name
     , job_id
     , salary
     , commission_pct
FROM employees 
WHERE commission_pct IS NOT NULL
ORDER BY commission_pct DESC;
--------------------------------------------------------------------------------
-- 8.
CREATE TABLE PROF(
    PROFNO NUMBER(4),
    NAME VARCHAR2(15) NOT NULL,
    ID VARCHAR2(15) NOT NULL,
    HIREDATE DATE,
    PAY NUMBER(4)
    );

SELECT * 
FROM prof;
--------------------------------------------------------------------------------
-- 9-1.
INSERT INTO prof(profno, name, id, hiredate, pay)
VALUES(1001, 'Mark', 'm1001', '2007/03/01', 800);

INSERT INTO prof(profno, name, id, hiredate)
VALUES(1003, 'Adam', 'a1003', '2011/03/02');

-- 9-2.
UPDATE prof
SET pay = 1200
WHERE profno = 1001;

-- 9-3.
DELETE FROM prof
WHERE profno = 1003;

SELECT * 
FROM prof;
--------------------------------------------------------------------------------
-- 10-1.
ALTER TABLE prof
ADD CONSTRAINT profno_pk PRIMARY KEY (profno);

-- 10-2.
ALTER TABLE prof
ADD GENDER CHAR(3);

-- 10-3.
ALTER TABLE prof
MODIFY name VARCHAR2(20);