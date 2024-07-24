-- 1. 모든 사원의 이름, 부서번호, 부서 이름을 조회
select concat(e.first_name,'',e.last_name) as Name, e.department_id, d.department_name
from employees as e, departments as d
where e.department_id = d.department_id;

-- 2. 부서번호 80에 속하는 모든 업무의 고유 목록을 작성하고 출력결과에 부서의 위치를 출력하세요
select l.street_address
from departments d, locations l
where d.location_id = l.location_id and d.department_id = 80;

-- 3. 커미션을 받는 사원의 이름, 부서 이름, 위치번호와 도시명을 조회하세요
select concat(e.first_name,'',e.last_name) Name, d.department_name, l.city, e.commission_pct
from employees e, departments d, locations l
where e.department_id = d.department_id and d.location_id = l.location_id and e.commission_pct is not null;

-- 4. 이름에 a(소문자)가 포함된 모든 사원의 이름과 부서명을 조회하세요.
select concat(e.first_name,'',e.last_name) Name, d.department_name
from employees e, departments d
where e.department_id = d.department_id and e.last_name like '%a%';

-- 5. 'Toronto'에서 근무하는 모든 사원의 이름, 업무, 부서 번호 와 부서명을 조회하세요
select concat(e.first_name,'',e.last_name) Name, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id and d.location_id = l.location_id and l.city = 'Toronto';

-- 6. 사원의 이름 과 사원번호를 관리자의 이름과 관리자 아이디와 함께 표시하고
-- 각각의 컬럼명을 Employee, Emp#, Manger, Mgr#으로 지정하세요
select concat(e1.first_name,'',e1.last_name) 'Employee', e1.employee_id as 'Emp#', 
		concat(e2.first_name,'',e2.last_name) 'Manager', e2.employee_id as 'Mgr#'
from employees e1, employees e2
where e1.manager_id = e2.employee_id;

-- 7. 사장인'King'을 포함하여 관리자가 없는 모든 사원을 조회하세요 (사원번호를 기준으로 정렬하세요)
select *
from employees
where manager_id is null
order by employee_id;

-- 8. 지정한 사원의 이름, 부서 번호 와 지정한 사원과 동일한 부서에서 근무하는 모든 사원을 조회하세요
select *
from employees e1, employees e2
where e1.last_name = e2.last_name and e1.department_id = e2.department_id and e1.department_id = '90';

-- 9. JOB_GRADRES 테이블을 생성하고 모든 사원의 이름, 업무,부서이름, 급여 , 급여등급을 조회하세요
CREATE TABLE job_grades(
    grade_level char(1) primary key,
    lowest_sal int,
    highest_sal int
);
insert into job_grades values('A',1000,2999);
insert into job_grades values('B',3000,5999);
insert into job_grades values('C',6000,9999);
insert into job_grades values('D',10000,14999);
insert into job_grades values('E',15000,24999);
insert into job_grades values('F',25000,40000);
COMMIT;
select * from job_grades;

select * from employees;

select concat(e.first_name,' ',e.last_name) Name, e.job_id, d.department_name, e.salary, jg.grade_level
from employees e, job_grades jg, departments d
where e.department_id = d.department_id and e.salary between jg.lowest_sal and jg.highest_sal;
