-- SubQuery


-- [WHERE 절에서 사용]

-- 1. 단일 행 서브쿼리
-- : 서브쿼리가 단일 행 비교 연산자와 함께 사용할 때는 반드시 서브쿼리의 결과 수가 1건 이하여야 함. 만약 2건 이상일 경우 오류 발생
-- ex 1) D001 부서장의 사번과 이름을 출력(테이블 2개)
SELECT
	emp.emp_id -- emp_id가 두 테이블에 있어서 어떤 테이블의 emp_id인지 적어야 함
	, emp.`name`
FROM employees emp -- 사번과 이름이 있는 테이블 (emp는 별칭)
-- 테이블명이 길 때 별칭을 많이 사용하는데 보편적으로는 3~4자로 설정
WHERE
	emp.emp_id = (
			-- D001 부서의 현재 부서장 사번 구하기
		SELECT
			depm.emp_id
		FROM department_managers depm
		WHERE
			depm.dept_code = 'D001'
			AND depm.end_at IS NULL
	)
;


-- 2. 다중 행 서브쿼리
-- : 서브쿼리의 결과가 2건 이상을 반환할 경우, 반드시 다중 행 비교 연산자를 사용해야 함(IN, ALL, ANY, SOME, EXISTS 등)
-- ex 1) 현재 부서장인 사원의 사번과 이름을 출력
SELECT
	emp.emp_id
	,emp.`name`
FROM employees emp
WHERE
	emp.emp_id IN (
		SELECT
			depm.emp_id
		FROM department_managers depm
		WHERE
			depm.end_at IS null
	)
;


-- 3. 다중 열 서브쿼리
-- ex 1) 현재 'D002' 부서장이 해당 부서에 소속된 날짜를 출력
SELECT
	depe.start_at
FROM department_emps depe
WHERE
	(depe.emp_id, depe.dept_code) IN (
		SELECT
			depm.emp_id
			, depm.dept_code
		FROM department_managers depm
		WHERE
			depm.dept_code = 'D002'
			AND depm.end_at IS NULL
	)
;


-- 4. 연관 서브쿼리
-- : 서브쿼리 내에서 메인쿼리의 컬럼이 사용된 서브쿼리
-- ex 1) 부서장 경력이 있는 사원의 정보를 출력
SELECT
	emp.*
 FROM employees emp
 where
	emp.emp_id IN (
		select
			depm.emp_id
		FROM department_managers depm
		where
			depm.emp_id = emp.emp_id
	)
;





-- [SELECT 절에서 사용]

-- ex 1) 사원별 역대 전체 급여 평균
SELECT
	emp.emp_id
	, (
		select
			AVG(sal.salary)
		FROM salaries sal
		WHERE sal.emp_id = emp.emp_id
	) avg_sal
FROM employees emp
;




-- [FROM 절에서 사용]

-- ex 1) 퇴사한 사원의 사번과 이름만 조회
SELECT
	tmp.*
FROM (
	SELECT
		emp.emp_id
		, emp.`name`
	FROM employees emp
	where
		fire_at IS NOT NULL
) tmp
;




-- [INSERT 문에서 사용]

-- ex 1) 새로운 사원 등록
INSERT INTO employees (
	employees.emp_id
	, employees.`name`
	, employees.birth
	, employees.gender
	, employees.hire_at
)
VALUES (
	(SELECT MAX(emp.emp_id) + 1 FROM employees emp) -- 현재 가장 큰 숫자의 사번 + 1
	, '둘리'
	, '1980-01-01'
	, 'M'
	, NOW()
)
;




-- [UPDATE 문에서 사용]

-- ex 1) 직급 테이블의 직급 종료일을 퇴사일로 갱신 (사원테이블에서 더블클릭하여 임의로 오늘 날짜로 퇴사일 설정)
UPDATE title_emps
SET
	title_emps.end_at = (
		SELECT employees.fire_at
		FROM employees
		where
			employees.emp_id = 100017
	)
WHERE
	title_emps.emp_id = 100017
	AND title_emps.end_at IS NULL
;









