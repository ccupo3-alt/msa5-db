-- JOIN 문 : 복수의 테이블을 묶어서 하나의 결과 집합으로 출력

-- 1. INNER JOIN : 복수의 테이블이 공통적으로 만족하는 레코드를 출력
-- ex 1) 전 사원의 사번, 이름 , 현재 급여를 출력 (테이블 2개 연결)
SELECT
	emp.emp_id
	, emp.`name`
	, sal.salary
FROM employees emp
	INNER JOIN salaries sal -- inner 생략 가능
		ON emp.emp_id = sal.emp_id
		AND sal.end_at IS NULL
;

-- ex 2) 재직 중인 사원의 사번, 이름, 생일, 부서명 출력 (테이블 3개 연결)
SELECT
	emp.emp_id
	, emp.`name`
	, emp.birth
	, dep.dept_name
FROM employees emp
	JOIN department_emps depe
		ON emp.emp_id = depe.emp_id
			AND emp.fire_at IS null
	JOIN departments dep
		ON depe.dept_code = dep.dept_code
			AND depe.end_at IS NULL
;
		
-- join 할 때 PK 여부는 상관이 없음
-- FK는 데이터베이스의 제약조건,  없어도 사용할 수 있음, 실수를 줄이기 위해 사용




-- 2. LEFT JOIN : 왼쪽 테이블을 기준 테이블로 두고 JOIN을 실행
-- ex 1) 재직 중인 전 사원 정보를 출력하되, 현재 부서장인 사원은 부서코드도 같이 출력
SELECT
	emp.emp_id
	, emp.`name`
	, demp.dept_code
FROM employees emp
	LEFT JOIN department_managers demp
		ON emp.emp_id = demp.emp_id
			AND emp.fire_at IS NULL
			AND demp.end_at IS NULL
ORDER BY demp.dept_code DESC -- 부서코드가 있는 사람부터 나옴
;
-- (부서장 검증 과정)
SELECT * FROM department_managers WHERE end_at IS NULL;


-- ex 2-1) 재직 중인 전 사원 정보를 출력하되, 현재 부서장인 사원은 부서코드, 부서명도 같이 출력
SELECT
	emp.emp_id
	, emp.`name`
	, tmp_manager.dept_code
	, tmp_manager.dept_name
FROM employees emp
	LEFT JOIN (
		select
			demp.emp_id
			, dep.dept_code
			, dep.dept_name
		FROM departments dep
			JOIN department_managers demp
				ON dep.dept_code = demp.dept_code
					AND demp.end_at IS NULL
	) tmp_manager
		ON emp.emp_id = tmp_manager.emp_id
			AND emp.fire_at IS NULL
ORDER BY tmp_manager.dept_code DESC
;

-- ex 2-2) 재직 중인 전 사원 정보를 출력하되, 현재 부서장인 사원은 부서코드, 부서명도 같이 출력
SELECT
	emp.emp_id
	, emp.`name`
	, demp.dept_code
	, dep.dept_name
FROM employees emp
	LEFT JOIN department_managers demp
		ON emp.emp_id = demp.emp_id
			AND emp.fire_at IS NULL
			AND demp.end_at IS NULL
	LEFT JOIN departments dep
		ON dep.dept_code = demp.dept_code
ORDER BY demp.dept_code IS NULL, demp.dept_code
;




-- 3. RIGHT JOIN : 오른쪽 테이블을 기준 테이블로 두고 JOIN을 실행
-- LEFT JOIN과 테이블 위치의 차이라 예제 생략




-- 4. UNION : 두 개 이상의 쿼리의 결과를 합쳐서 출력

-- 1) UNION : 중복 레코드를 제거
SELECT * FROM employees WHERE emp_id IN (1, 3)
UNION
SELECT * FROM employees WHERE emp_id IN (1, 5)
; -- 1, 3, 5번이 출력됨

-- 2) UNION ALL : 중복 레코드 제거하지 않음
SELECT * FROM employees WHERE emp_id IN (1, 3)
UNION ALL
SELECT * FROM employees WHERE emp_id IN (1, 5)
; -- 1, 3, 1, 5번이 출력됨




-- 5. SELF JOIN : 같은 테이블끼리 조인
-- ex 1) 현재 슈퍼바이저인 사원 정보 출력
SELECT
	emp.emp_id junior_emp_id
	, emp.`name` junior_name
	, sup.emp_id sup_id
	, sup.`name` sup_name
FROM employees emp
	JOIN employees sup
		ON emp.sup_id = sup.emp_id
			AND emp.sup_id IS NOT NULL
;
