-- [문제 0] 사원정보(EMPLOYEE) 테이블에서 
-- 사원번호, 이름, 급여, 업무, 입사일, 상사의 사원번호를 출력하시오. 
-- 이때 이름은 성과 이름을 연결하여 Name이라는 별칭으로 출력하시오
SELECT employee_id, concat(first_name,'',last_name) as 'Name', salary, job_id, hire_date, manager_id from employees;

-- [문제 1] 사원정보(EMPLOYEES) 테이블에서 
-- 사원의 성과 이름은 Name, 업무는 Job, 
-- 급여는 Salary, 
-- 연봉에 $100 보너스를 추가하여 계산한 값은 Increased Ann_Salary, 
-- 급여에 $100 보너스를 추가하여 계산한 연봉은 Increased Salary라는 별칭으로 출력하시오
SELECT employee_id, concat(first_name,'',last_name) as 'Name', 
		 job_title as Job,
         salary as Salary,
		 salary*12+100 as 'Increased Ann_Salary',
         salary+100 as 'Increased Salary'
from employees, jobs
where employees.job_id = jobs.job_id;

-- [문제 2] 사원정보(EMPLOYEE) 테이블에서 모든 사원의 이름(last_name)과 연봉을 “이름: 1 Year Salary = $연봉” 형식으로 출력하고, 
-- 1 Year Salary라는 별칭을 붙여 출력하시오
SELECT concat('이름: ', last_name, ' 1 Year Salary = $', salary*12) as '1 YEAR Salary'
FROM employees;

-- [문제 3] 부서별로 담당하는 업무를 한 번씩만 출력하시오
SELECT department_id, job_id
FROM employees
GROUP BY department_id
ORDER BY department_id; 

-- [문제 0] HR 부서에서 예산 편성 문제로 급여 정보 보고서를 작성하려고 한다. 
-- 사원정보(EMPLOYEES) 테이블에서 급여가 $7,000~$10,000 범위 이외인 사람의 성과 이름(Name으로 별칭) 및 급여를
-- 급여가 작은 순서로 출력하시오(75행).
SELECT concat(first_name,'',last_name) as 'Name'
FROM employees
WHERE salary not between 7000 and 10000
ORDER BY salary ASC;

-- [문제 1] 사원의 이름(last_name) 중에 ‘e’ 및 ‘o’ 글자가 포함된 사원을 출력하시오. 이때 머리글은 ‘e and o Name’라고 출력하시오 
select last_name as 'e and o Name'
from employees
where last_name like '%e%' and last_name like '%o%';

-- [문제 2] 현재 날짜 타입을 날짜 함수를 통해 확인하고, 
-- 2006년 05월 20일부터 2007년 05월 20일 사이에 고용된 사원들의 성과 이름(Name으로 별칭), 사원번호, 고용일자를 출력하시오. 
-- 단, 입사일이 빠른 순으로 정렬하시오
select concat(first_name,'',last_name) as 'Name', employee_id, date(hire_date)
from employees
where hire_date between '1996-05-20' and '1997-05-20'
order by hire_date;

-- [문제 3] HR 부서에서는 급여(salary)와 수당율(commission_pct)에 대한 지출 보고서를 작성하려고 한다. 
-- 이에 수당을 받는 모든 사원의 성과 이름(Name으로 별칭), 급여, 업무, 수당율을 출력하시오. 
-- 이때 급여가 큰 순서대로 정렬하되, 급여가 같으면 수당율이 큰 순서대로 정렬하시오
select concat(first_name,'',last_name) as 'Name', salary, department_id, commission_pct
from employees
order by salary desc, commission_pct desc;

-- [문제 0] 이번 분기에 60번 IT 부서에서는 신규 프로그램을 개발하고 보급하여 회사에 공헌하였다. 
-- 이에 해당 부서의 사원 급여를 12.3% 인상하기로 하였다. 
-- 60번 IT 부서 사원의 급여를 12.3% 인상하여 정수만(반올림) 표시하는 보고서를 작성하시오. 
-- 출력 형식은 사번, 이름과 성(Name으로 별칭), 급여, 인상된 급여(Increased Salary로 별칭)순으로 출력한다
select employee_id, concat(first_name,'',last_name) as 'Name', salary,
		ROUND(salary + salary/100*12.3 ) as 'Increased Salary'
from employees
where department_id;

-- [문제 1] 각 사원의 성(last_name)이 ‘s’로 끝나는 사원의 이름과 업무를 아래의 예와 같이 출력하고자 한다. 
-- 출력 시 성과 이름은 첫 글자가 대문자, 업무는 모두 대문자로 출력하고 머리글은 Employee JOBs로 표시하시오(18행).
-- 예 James Landry is a ST_CLERK
select concat (
	upper(LEFT(first_name, 1)), LOWER(SUBSTRING(first_name,2)), ' ',
	upper(LEFT(last_name, 1)), LOWER(SUBSTRING(last_name,2)), ' is a ',
	job_id
) as 'Employee JOBs'
from employees
where last_name like '%s';

-- [문제 2] 모든 사원의 연봉을 표시하는 보고서를 작성하려고 한다. 
-- 보고서에 사원의 성과 이름(Name으로별칭), 급여, 수당여부에 따른 연봉을 포함하여 출력하시오. 
-- 수당여부는 수당이 있으면 “Salary +Commission”, 수당이 없으면 “Salary only”라고 표시하고, 별칭은 적절히 붙인다. 
-- 또한 출력 시 연봉이 높은 순으로 정렬한다(107행).
select concat(first_name,'',last_name) as 'Name', salary,
		IF(commission_pct is not null, salary*12 + salary*commission_pct*12, salary*12) 
			as 'Salary with Commission'
from employees
order by salary*12 desc;

-- [문제 3] 모든 사원들 성과 이름(Name으로 별칭), 입사일 그리고 입사일이 어떤 요일이였는지 출력하시오. 
-- 이때 주(week)의 시작인 일요일부터 출력되도록 정렬하시오(107행).
select concat(first_name,'',last_name) as 'Name', 
	case 
		when weekday(hire_date) = 0 then 'Monday'
		when weekday(hire_date) = 1 then 'Tuesday'
		when weekday(hire_date) = 2 then 'Wednesay'
		when weekday(hire_date) = 3 then 'Thursday'
		when weekday(hire_date) = 4 then 'Friday'
		when weekday(hire_date) = 5 then 'Saturday'
		when weekday(hire_date) = 6 then 'Sunday'
    End as hire_date
from employees
order by weekday(hire_date) desc;

select * from employees order by hire_date limit 3;
select * from employees order by hire_date desc limit 10;

-- [문제 0] 모든 사원은 직속 상사 및 직속 직원을 갖는다. 
-- 단, 최상위 또는 최하위 직원은 직속 상사 및 직원이 없다. 
-- 소속된 사원들 중 어떤 사원의 상사로 근무 중인 사원의 총 수를 출력하시오
select count(manager_id) from employees;

-- [문제 1] 각 사원이 소속된 부서별로 급여 합계, 급여 평균, 급여 최대값, 급여 최소값을 집계하고자 한다. 
-- 계산된 출력값은 6자리와 세 자리 구분기호, $ 표시와 함께 출력하고 부서번호의 오름차순 정렬하시오. 
-- 단, 부서에 소속되지 않은 사원에 대한 정보는 제외하고 출력시 머리글은 아래 예시처럼 별칭(alias) 처리하시오
select 
	concat('$', format(sum(salary), 2)) as 'Total Salary',
	concat('$', format(avg(salary), 2)) as 'Average Salary',
	concat('$', format(max(salary), 2)) as 'Max Salary',
	concat('$', format(min(salary), 2)) as 'Min Salary'
from employees;

-- [문제 2] 사원들의 업무별 전체 급여 평균이 $10,000보다 큰 경우를 조회하여 업무, 급여 평균을 출력하시오. 
-- 단 업무에 사원(CLERK)이 포함된 경우는 제외하고 전체 급여 평균이 높은 순서대로 출력하시오
select job_id, ROUND(avg(salary)) as 'Average Salary'
from employees
where first_name not like '%CLERK%' and last_name not like '%CLERK%'
group by job_id
HAVING avg(salary) > 10000
order by ROUND(avg(salary)) desc;