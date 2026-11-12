-- 1. 사원의 사원번호, 이름, 직급코드를 출력해 주세요.
SELECT
	emp.emp_id
	, emp.`name`
	, tiem.title_code	
FROM employees emp
	JOIN title_emps tiem
		ON emp.emp_id = tiem.emp_id
			AND emp.fire_at IS NULL
;

-- 2. 사원의 사원번호, 성별, 현재 연봉을 출력해 주세요.
SELECT
	emp.emp_id
	, emp.`name`
	, sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL
			AND emp.fire_at IS NULL
;

-- 3. 10010 사원의 이름과 과거부터 현재까지 연봉 이력을 출력해 주세요.
SELECT
	emp.`name`
	, sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND emp.emp_id = 10010
;

-- 4. 사원의 사원번호, 이름, 소속부서명을 출력해 주세요.
SELECT
	emp.emp_id
	, emp.`name`
	, dep.dept_name
FROM employees emp
	JOIN department_emps depe
		ON emp.emp_id = depe.emp_id
			AND depe.end_at IS null
	JOIN departments dep
		ON depe.dept_code = dep.dept_code
WHERE emp.fire_at IS NULL 
;

-- 5. 현재 연봉의 상위 10위까지 사원의 사번, 이름, 연봉을 출력해 주세요.
SELECT
	emp.emp_id
	, emp.`name`
	, sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND emp.fire_at IS null
			AND sal.end_at IS null
ORDER BY sal.salary DESC 
LIMIT	10
;

-- 6. 현재 각 부서의 부서장의 부서명, 이름, 입사일을 출력해 주세요.
SELECT
	dep.dept_name
	, emp.`name`
	, emp.hire_at
FROM employees emp
	JOIN department_managers depm
		ON emp.emp_id = depm.emp_id
			AND emp.fire_at IS null
	JOIN departments dep
		ON depm.dept_code = dep.dept_code
			AND depm.end_at IS NULL
;

-- 7. 현재 직급이 "부장"인 사원들의 연봉 평균을 출력해 주세요.
SELECT
	AVG(salary)
FROM salaries sal
	JOIN employees emp
		ON sal.emp_id = emp.emp_id
		AND sal.end_at IS null
	JOIN title_emps tiem
		ON emp.emp_id = tiem.emp_id
		AND emp.fire_at IS null
	JOIN titles tis
		ON tiem.title_code = tis.title_code
		AND tiem.end_at IS null
WHERE
	tis.title = '부장'
GROUP BY sal.emp_id
;

SELECT
	tite.emp_id
	, AVG(sal.salary) avg_sal
;

-- 7-1. (보너스)현재 각 부장별 이름, 연봉평균
SELECT
	emp.`name`
	, AVG(sal.salary)
FROM employees emp
	JOIN title_emps tiem
		ON emp.emp_id = tiem.emp_id
			AND emp.fire_at IS null
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
		AND sal.end_at IS null
WHERE
	emp.fire_at IS null
GROUP BY sal.emp_id
;

-- 8. 부서장직을 역임했던 모든 사원의 이름과 입사일, 사번, 부서번호를 출력해 주세요.
SELECT
	emp.`name`
	, emp.hire_at
	, emp.emp_id
	, depm.dept_code
FROM employees emp
	JOIN department_managers depm
		ON emp.emp_id = depm.emp_id
			AND emp.fire_at IS NULL
;

-- 9. 현재 각 직급별 평균연봉 중 60,000,000이상인 직급의 직급명, 평균연봉(정수)를을 평균연봉 내림차순으로 출력해 주세요.
SELECT
	tis.title
	, ceil(AVG(sal.salary))
FROM title_emps tiem
	JOIN employees emp
		ON tiem.emp_id = emp.emp_id
			AND emp.fire_at IS null
	JOIN salaries sal
		ON tiem.emp_id = sal.emp_id
			AND sal.end_at IS null
	JOIN titles tis
		ON tiem.title_code = tis.title_code
			AND tiem.end_at IS null
GROUP BY tiem.title_code
	HAVING AVG(sal.salary) >= 60000000
ORDER BY AVG(sal.salary) desc
;

-- 10. 성별이 여자인 사원들의 직급별 사원수를 출력해 주세요.
SELECT
	tiem.title_code
	, COUNT(tiem.emp_id)
FROM title_emps tiem
	JOIN employees emp
		ON tiem.emp_id = emp.emp_id
			AND emp.gender = "F"
			AND emp.fire_at IS null
GROUP BY title_code
;


-- ------------------------------
-- 전체 평균 급여보다 높은 급여를 받는 사원의 사번, 이름, 현재급여를 조회
SELECT
	emp.emp_id
	, emp.`name`
	, sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND emp.fire_at IS null
			AND sal.end_at IS null
WHERE
	sal.salary >= (
	select
		AVG(salary)
	FROM salaries
	WHERE
		end_at IS null)
ORDER BY sal.salary ASC -- 풀이과정에서 결과 비교를 위해 추가
;

-- 가장 높은 급여를 받은 이력이 있는 사원의 사번과 급여를 조회
SELECT
	emp.emp_id
	, sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND emp.fire_at IS null
WHERE sal.salary = (
	select
		MAX(salary)
	FROM salaries
)
;

-- 풀이) salaries 테이블에 사번과 급여가 있어서 조인이 필요가 없음
SELECT
	emp_id
	, salary
FROM salaries sal
WHERE
	salary = (
		select
			MAX(salary)
		FROM salaries
	)
;