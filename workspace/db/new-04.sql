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

-- ------------------------------------

-- 5. HR 부서에서 예산 편성 문제로 급여 정보 보고서를 작성하려고 한다. 
--    사원정보(EMPLOYEES) 테이블에서 급여가 $7,000~$10,000 범위 이외인 사람의 
--    성과 이름(Name으로 별칭) 및 급여를 급여가 작은 순서로 출력하시오
SELECT CONCAT(first_name, ' ', last_name) Name, salary
FROM employees
-- WHERE salary < 7000 or salary > 10000
WHERE salary NOT BETWEEN 7000 AND 10000
ORDER BY salary ASC;

-- 6. 사원의 이름(last_name) 중에 ‘e’ 및 ‘o’ 글자가 포함된 사원을 출력하시오. 
--    이때 머리글은 ‘e and o Name’라고 출력하시오
SELECT last_name as "e and o Name"
FROM employees
WHERE last_name LIKE '%e%' AND last_name LIKE '%o%';

-- 7. 현재 날짜 타입을 날짜 함수를 통해 확인하고, 
--    1995년 05월 20일부터 1996년 05월 20일 사이에 고용된 사원들의 
--    성과 이름(Name으로 별칭), 사원번호, 고용일자를 입사일이 빠른 순으로 정렬해서 출력하시오.
SELECT SYSDATE(); 

SELECT employee_id, CONCAT(first_name, ' ', last_name) Name, hire_date 
FROM employees
WHERE hire_date BETWEEN '1995-05-20' AND '1996-05-20'
ORDER BY hire_date ASC;

-- 8. HR 부서에서는 급여(salary)와 수당율(commission_pct)에 대한 지출 보고서를 작성하려고 한다. 
--    이에 수당을 받는 모든 사원의 성과 이름(Name으로 별칭), 급여, 업무, 수당율을 출력하시오. 
--    이때 급여가 큰 순서대로 정렬하되, 급여가 같으면 수당율이 큰 순서대로 정렬하시오
SELECT employee_id, CONCAT(first_name, ' ', last_name) Name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY salary DESC, commission_pct DESC;
