-- Employee Performance Mapping - Course-End Project 1
-- Prepared by Heba Farouk | Sparrow Softech Pvt. Ltd.
-- ScienceQtech case study


-- ===== 01_database_setup.sql =====

CREATE DATABASE employee;
USE employee;

SHOW TABLES;
DESCRIBE emp_record_table;
SELECT * FROM emp_record_table LIMIT 10;



-- ===== 02_employee_department_details.sql =====

SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT
FROM emp_record_table;



-- ===== 03_performance_rating.sql =====

-- Rating less than 2
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM emp_record_table WHERE EMP_RATING < 2;

-- Rating between 2 and 4
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM emp_record_table WHERE EMP_RATING BETWEEN 2 AND 4;

-- Rating greater than 4
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM emp_record_table WHERE EMP_RATING > 4;



-- ===== 04_leadership_positions.sql =====

SELECT EMP_ID, FIRST_NAME, ROLE, DEPT
FROM emp_record_table
WHERE ROLE LIKE '%MANAGER%'
   OR ROLE LIKE '%PRESIDENT%'
   OR ROLE LIKE '%CEO%';



-- ===== 05_department_max_rating.sql =====

SELECT EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT, EMP_RATING,
       MAX(EMP_RATING) OVER (PARTITION BY DEPT) AS MAX_DEPT_RATING
FROM emp_record_table
ORDER BY DEPT, EMP_RATING DESC;



-- ===== 06_salary_min_max_by_role.sql =====

SELECT ROLE,
       MIN(SALARY) AS MIN_SALARY,
       MAX(SALARY) AS MAX_SALARY
FROM emp_record_table
GROUP BY ROLE
ORDER BY ROLE;



-- ===== 07_experience_rank.sql =====

SELECT EMP_ID, FIRST_NAME, LAST_NAME, ROLE, EXP,
       RANK() OVER (ORDER BY EXP DESC) AS EXPERIENCE_RANK
FROM emp_record_table;



-- ===== 08_salary_view.sql =====

CREATE VIEW employee_salary_above_6000 AS
SELECT EMP_ID, FIRST_NAME, LAST_NAME, COUNTRY, CONTINENT, ROLE, SALARY
FROM emp_record_table
WHERE SALARY > 6000;

SELECT * FROM employee_salary_above_6000;



-- ===== 09_country_salary_view.sql =====

SELECT COUNTRY, EMP_ID, FIRST_NAME, LAST_NAME, ROLE, SALARY
FROM employee_salary_above_6000
ORDER BY COUNTRY, SALARY DESC;



-- ===== 10_index_eric.sql =====

EXPLAIN
SELECT * FROM emp_record_table WHERE FIRST_NAME = 'Eric';

CREATE INDEX idx_emp_first_name
ON emp_record_table(FIRST_NAME);

EXPLAIN
SELECT * FROM emp_record_table WHERE FIRST_NAME = 'Eric';



-- ===== 11_average_salary_geography.sql =====

SELECT CONTINENT, COUNTRY,
       ROUND(AVG(SALARY), 2) AS AVG_SALARY
FROM emp_record_table
GROUP BY CONTINENT, COUNTRY
ORDER BY CONTINENT, COUNTRY;



-- ===== 12_max_salary.sql =====

SELECT EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT, SALARY
FROM emp_record_table
WHERE SALARY = (SELECT MAX(SALARY) FROM emp_record_table);



-- ===== 13_training_review.sql =====

SELECT EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT, EMP_RATING
FROM emp_record_table
WHERE EMP_RATING < 2
ORDER BY EMP_RATING ASC;



-- ===== 14_distinct_roles.sql =====

SELECT DISTINCT ROLE
FROM emp_record_table
ORDER BY ROLE;

