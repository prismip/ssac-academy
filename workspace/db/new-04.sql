USE hr;

-- 1. 사원정보(EMPLOYEES) 테이블에서 사원번호, 이름, 급여, 업무, 입사일, 상사의 사원 번호를 출력하시오. 
--    이름은 성과 이름을 연결하여 Name이라는 별칭으로 출력하시오
DESC employees;

SELECT 
	employee_id, 
    concat(first_name, ' ', last_name) name,
    salary, 
    job_id,
    hire_date,
    manager_id
FROM
	employees;
   
-- 2. 사원정보(EMPLOYEES) 테이블에서 
-- 		사원의 성과 이름은 Name, 
-- 		업무는 Job, 
-- 		급여는 Salary, 
-- 		연봉에 $100 보너스를 추가하여 계산한 값은 Increased Ann_Salary, 
-- 		급여에 $100 보너스를 추가하여 계산한 연봉은 “Increased Salary”
--    라는 별칭으로 출력하시오

SELECT 
	employee_id ID, 
    concat(first_name, ' ', last_name) Name,
    salary Salary, 
    job_id Job,
    salary * 12 + 100 as "Increased Ann_Salary",
    (salary + 100) * 12 as "Increased Salary"
FROM
	employees;

-- 3. 사원정보(EMPLOYEE) 테이블에서 모든 사원의 이름(last_name)과 연봉을 
--    “이름: 1Year Salary = $연봉” 형식으로 출력하고, “1 Year Salary”라는 별칭을 붙이시오
SELECT CONCAT(last_name, ": 1Year Salary = $", salary * 12) AS "1 Year Salary"
FROM employees;

-- 4. 부서별로 담당하는 업무를 한 번씩만 출력하시오
SELECT distinct department_id, job_id FROM employees;