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
WHERE commission_pct IS NOT NULL -- commission_pct <> NULL (x)
ORDER BY salary DESC, commission_pct DESC;

-- 9. 이번 분기에 60번 IT 부서에서는 신규 프로그램을 개발하고 보급하여 회사에 공헌하여 해당 부서의 사원 급여를 12.3% 인상하기로 하였다. 
--    60번 IT 부서 사원의 급여를 12.3% 인상하여 정수만(반올림) 표시하는 보고서를 작성하시오. 
--    출력 형식은 사번, 이름과 성(Name으로 별칭), 급여, 인상된 급여(Increased Salary로 별칭)순으로 출력한다

SELECT 
	employee_id, CONCAT(first_name, ' ', last_name) Name, 
	salary, ROUND(salary * 1.123, 0) "Increased Salary"
FROM employees
WHERE department_id = 60;

-- 10. 각 이름이 ‘s’로 끝나는 사원들의 이름과 업무를 아래의 예와 같이 출력하고자 한다. 
-- 	출력 시 성과 이름은 첫 글자가 대문자, 업무는 모두 대문자로 출력하고 머리글은 Employee JOBs.로 표시하시오

-- 	예) Sigal Tobias is a PU_CLERK

SELECT CONCAT(first_name, ' ', last_name, ' is a ', UPPER(job_id)) AS "Employee JOBs."
FROM employees
WHERE LOWER(first_name) LIKE '%s';

-- 11. 모든 사원의 연봉을 표시하는 보고서를 작성하려고 한다. 
-- 	보고서에 사원의 성과 이름(Name으로 별칭), 급여, 수당여부에 따른 연봉을 포함하여 출력하시오. 
-- 	수당여부는 수당이 있으면 “Salary + Commission”, 수당이 없으면 “Salary only”라고 표시하고, 별칭은 적절히 붙인다. 
-- 	또한 출력 시 연봉이 높은 순으로 정렬한다

SELECT 
	employee_id, CONCAT(first_name, ' ', last_name) Name, 
    salary, 
    (salary * 12) + (salary * 12 * IFNULL(commission_pct, 0)) "Annual Salary",
    IF(commission_pct IS NULL, "Salary only", "Salary + Commission") "Annual Salary Type"
--  CASE
-- 		WHEN commission_pct IS NULL THEN "Salary only"
--      ELSE "Salary + Commission"
-- 	END "Annual Salary Type"
FROM employees
ORDER BY salary DESC;


-- 12. 모든 사원들 성과 이름(Name으로 별칭), 입사일 그리고 입사일이 어떤 요일이였는지 출력하시오. 
-- 	이때 주(week)의 시작인 일요일부터 출력되도록 정렬하시오
SELECT 
	employee_id, CONCAT(first_name, ' ', last_name) Name,
    hire_date, DATE_FORMAT(hire_date, "%W") "Day of Week"
FROM employees
ORDER BY DATE_FORMAT(hire_date, "%w");

-- 13. 모든 사원은 직속 상사 및 직속 직원을 갖는다. 단, 최상위 또는 최하위 직원은 직속 상사 및 직원이 없다. 
-- 	소속된 사원들 중 어떤 사원의 상사로 근무 중인 사원의 총 수를 출력하시오

SELECT COUNT(distinct manager_id) "Count of Manager"
FROM employees
WHERE manager_id IS NOT NULL;


-- 14. 각 사원이 소속된 부서별로 급여 합계, 급여 평균, 급여 최대값, 급여 최소값을 집계하고자 한다. 
-- 	계산된 출력값은 부서번호의 오름차순 정렬해서 $ 표시와 함께 출력하시오.  
-- 	단, 부서에 소속되지 않은 사원에 대한 정보는 제외하시요

SELECT 
	department_id, 
    concat('$', FORMAT(sum(salary), 0)) "총급여", -- Format : 천 단위, 표시 + 소수점 개수 
    concat('$', FORMAT(avg(salary), 2)) "평균급여", 
    concat('$', FORMAT(max(salary), 0)) "최대급여", 
    concat('$', FORMAT(min(salary), 0)) "최소급여"
FROM employees
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY department_id
ORDER BY department_id;

-- 15. 사원들의 업무별 전체 급여 평균이 $10,000보다 큰 경우를 조회하여 업무, 급여 평균을 출력하시오.
-- 	단 업무에 사원(CLERK)이 포함된 경우는 제외하고 전체 급여 평균이 높은 순서대로 출력하시오
SELECT job_id, avg(salary) "급여평균"
FROM employees
WHERE job_id NOT LIKE '%CLERK%' -- AND AVG(SALARY) > 10000 --> 오류 : GROUP BY의 집계함수를 WHERE절에서 사용할 수 없습니다.  
GROUP BY job_id
HAVING AVG(SALARY) > 10000
ORDER BY AVG(salary) DESC;

-- 16. HR 데이터베이스에 존재하는 Employees, Departments, Locations 테이블의 구조를 파악한 후
-- 	Oxford에 근무하는 사원의 성과 이름(Name으로 별칭), 업무, 부서명, 도시명을 출력하시오. 
-- 	이때 첫 번째 열은 회사명인 ‘SSAC’이라는 상수값이 출력되도록 하시오

SELECT * FROM locations WHERE city = 'Oxford';

-- ANSI SQL
SELECT 'SSAC' AS COMPANY, e.employee_id, CONCAT(e.first_name, ' ', e.last_name) Name, e.job_id, d.department_name, l.city 
FROM locations l
INNER JOIN departments d
ON l.location_id = d.location_id
INNER JOIN employees e
ON e.department_id = d.department_id
WHERE l.city = 'Oxford';
-- MySQL
SELECT 'SSAC' AS COMPANY, e.employee_id, CONCAT(e.first_name, ' ', e.last_name) Name, e.job_id, d.department_name, l.city 
FROM locations l, departments d, employees e
WHERE l.location_id = d.location_id 
	  AND 
      e.department_id = d.department_id 
      AND 
      l.city = 'Oxford';

-- 17. HR 데이터베이스에 있는 Employees, Departments 테이블의 구조를 파악한 후 
-- 	사원수가 5명 이상인 부서의 부서명과 사원수를 사원수가 많은 순으로 정렬해서 출력하시오.
SELECT d.department_name, count(e.employee_id)
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
GROUP BY d.department_name
HAVING count(e.employee_id) >= 5
ORDER BY count(e.employee_id) DESC;

-- 18. 각 사원의 급여에 따른 급여 등급을 보고하려고 한다. 
-- 	급여 등급은 JOB_GRADES 테이블에 표시된다. 
-- 	해당 테이블의 구조를 살펴본 후 사원의 성과 이름(Name으로 별칭), 업무, 부서명, 입사일, 급여, 급여등급을 출력하시오
SELECT * FROM job_grades;
SELECT 
	e.employee_id, CONCAT(e.first_name, ' ', e.last_name) Name, e.job_id, 
	d.department_name, e.hire_date, e.salary, j.grade_level -- , j.lowest_sal, j.highest_sal
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
CROSS JOIN job_grades j
WHERE e.salary BETWEEN j.lowest_sal AND j.highest_sal;

-- 19. 각 사원과 직속 상사와의 관계를 이용하여 다음과 같은 형식의 보고서를 작성하고자 한다.

-- 	예) 홍길동은 허균에게 보고한다 → Eleni Zlotkey report to Steven King

-- 	어떤 사원이 어떤 사원에서 보고하는지를 위 예를 참고하여 출력하시오. 
-- 	단, 보고할 상사가 없는 사원이 있다면 그 정보도 포함하여 출력하고, 상사의 이름은 대문자로 출력하시오

SELECT 
--	   e2.employee_id, 
--     CONCAT(e2.first_name, ' ', e2.last_name) "Employee Name", 
--     e1.employee_id,
--     CONCAT(e1.first_name, ' ', e1.last_name) "Manager Name"
    CONCAT(e2.first_name, ' ', e2.last_name, ' report to ', IFNULL(e1.first_name, ' '), ' ', IFNULL(e1.last_name, ' ')) "Relation"
FROM employees e1
RIGHT OUTER JOIN employees e2
ON e1.employee_id = e2.manager_id;

-- 20. HR 부서의 어떤 사원은 급여정보를 조회하는 업무를 맡고 있다. 
-- 	Tucker 사원(last_name)보다 급여를 많이 받고 있는 사원의 성과 이름(Name으로 별칭), 업무, 급여를 출력하시오

-- 21. 사원의 급여 정보 중 업무별 최소 급여를 받고 있는 사원의 성과 이름(Name으로 별칭), 업무, 급여, 입사일을 출력하시오

-- 22. 소속 부서의 평균 급여보다 많은 급여를 받는 사원에 대하여 사원의 성과 이름(Name으로 별칭), 급여, 부서번호, 업무를 출력하시오

-- 23. 사원들의 지역별 근무 현황을 조회하고자 한다. 
-- 	도시 이름이 영문 'O' 로 시작하는 지역에 살고 있는 사원의 사번, 이름, 업무, 입사일을 출력하시오

-- 24. 모든 사원의 소속부서 평균연봉을 계산하여 사원별로 
-- 	성과 이름(Name으로 별칭), 업무, 급여, 부서번호, 부서 평균연봉(Department Avg Salary로 별칭)을 출력하시오

