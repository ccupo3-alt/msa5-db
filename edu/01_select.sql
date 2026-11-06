-- SELECT 문
-- DML 중 하나로, 저장되어 있는 데이터를 조회하기 위해 사용하는 쿼리




-- 쿼리 작성 순서 기본틀
-- SELECT [DISTINCT] [컬럼명]
-- FROM [테이블명]
-- WHERE [쿼리 조건]
-- GROUP BY [컬럼명] HAVING [집계함수 조건]
-- ORDER BY [컬럼명 ASC || 컬럼명 DESC]
-- LIMIT [n] OFFSET [n]
-- ;




-- SELECT 절 : 조회한 데이터 중 특정 컬럼만 출력
SELECT
	emp_id
	, `name` -- 컬럼명 지을 때 예약어는 피하는 게 좋은데 어쩔 수 없이 써야하면 ``으로 감싸라
	, gender
FROM	employees -- 테이블 지정
;
-- 실행 : 전체 실행
-- 선택 실행 : 드래그로 선택 후 실행
-- 현재 쿼리 실행 : 커서를 기준으로 마지막 세미콜론까지 실행

-- Asterrisk (: *) : 모든 컬럼 조회
SELECT	
	*
FROM employees
;

-- WHERE 절 : 특정 컬럼의 값이 조건에 맞는 데이터만 조회(필터와 같은 기능)
-- ex 1) 사번이 10009인 사원의 모든 정보를 조회
SELECT	
	*
FROM employees
WHERE
	emp_id = 10009 -- 같다 표현 = 하나만 사용
;
-- 자동 형변환이 돼서 '10009'로 작성해도 조회는 되는데 권장하지 않음 왜 ? 데이터 유형이 안 맞을 경우 오류 뜰 수 있음

-- ex 2) 사원명이 "박보람"인 사원의 정보를 조회
SELECT
	*
FROM employees AS emp -- 별칭 설정 가능
WHERE
	`name` = "박보람" -- '박보람'이라고 입력해도 됨
;

-- ex 3) 생일이 2000-01-01 이후인 사원의 정보를 조회
SELECT	
	*
FROM	employees
WHERE
	birth >= '2000-01-01' -- birth는 date(연-월-일) 타입, 문자열로 입력 해야 함
;

-- ex 4) 퇴사하지 않은 사원의 정보를 조회
SELECT
	*
FROM employees
WHERE
	fire_at IS NULL -- 부등호가 아닌 is로 입력 해야 함
;

-- ex 5) 퇴사한 사원의 정보를 조회
SELECT
	*
FROM employees
WHERE
	fire_at IS NOT NULL
;

-- ex 6) 1990년생인 사원의 정보를 조회
SELECT
	*
FROM employees
WHERE
	birth >= '1990-01-01'
	AND birth <= '1990-12-31'
;

-- ex 7) 이름이 '김철수' 또는 '정유리'인 사원의 정보를 조회
SELECT
	*
FROM employees
WHERE
	`name` = "김철수"
	OR	`name` = "정유리"
;

-- ex 8) 1990년생 이거나, 이름이 '정유리'인 사원의 정보를 조회
SELECT
	*
FROM employees
WHERE
	(birth >= '1990-01-01'
	AND birth <= '1990-12-31') -- 먼저 연산 되어야 하는 식은 괄호()로 묶기
	OR `name` = "정유리"
;

-- ex 9) 1990년생 이상이면서, 이름이 '정유리' 또는 '박보람'인 사원의 정보를 조회
SELECT
	*
FROM employees
WHERE
	birth >= '1990-01-01'
	AND (`name` = "정유리"
	OR `name` = "박보람")
;




-- BETWEEN 연산자 : 지정한 범위 내의 데이터를 조회
-- ex 1) 1990년생인 사원의 정보를 조회
SELECT
	*
FROM employees
WHERE	
	birth BETWEEN	'1990-01-01' AND	'1990-12-31'
;




-- IN 연산자 : 다수의 지정한 값과 일치하는 데이터를 조회 (or와 같은 개념)
-- ex 1) 이름이 '정유리' 또는 '박보람'인 사원의 정보를 조회
SELECT
	*
FROM	employees
WHERE
	`name` IN("박보람", "정유리")
;

-- ex 2) 사번이 10001, 10005, 10006인 사원의 정보를 조회
SELECT
	*
FROM employees
WHERE
	emp_id IN(10001, 10005, 10006)
;




-- LIKE 절 : 문자열의 내용을 조회 (문자열 데이터에서만 사용 권장)
-- % : 글자 수와 상관 없이 조회할 때 사용
-- ex 1) 이름이 '우'로 끝나는 사원의 정보를 조회
SELECT
	*
FROM employees
WHERE
	`name` LIKE	"%우"
;

-- ex 2) 이름이 '우'로 시작하는 사원의 정보를 조회
SELECT
	*
FROM employees
WHERE
	`name` LIKE	"우%"
;

-- ex 3) 이름에 '우'가 포함된 사원의 정보를 조회
SELECT
	*
FROM employees
WHERE
	`name` LIKE	"%우%"
;




-- _ : 언더바의 개수만큼 글자 수를 허용해서 조회
-- ex 1) 이름의 가운데 글자가 '우'인 사원의 정보를 조회
SELECT
	*
FROM employees
WHERE
	`name` LIKE	"_우_"
;

-- ex 2) 이름의 두번째 글자가 '우'인 사원의 정보를 조회
SELECT
	*
FROM employees
WHERE
	`name` LIKE	"_우%"
;




-- ORDER BY 절 : 조회한 데이터를 정렬
-- ex 1) 이름 기준 오름차순 정렬
SELECT
	*
FROM employees
ORDER BY	`name` ASC -- ASC는 생략 가능한데 기본값으로 오름차순 정렬 됨
;

-- ex 2) 이름 기준 내림차순 정렬
SELECT
	*
FROM employees
ORDER BY	`name` DESC	
;

-- ex 3) 이름 기준 오름차순 정렬 후, 동명이인은 생일 순으로 오름차순 정렬
SELECT
	*
FROM employees
ORDER BY	`name`, birth
;
-- (NULL)이 허용된 값일 경우, 가장 우선순위로 가져옴




-- LIMIT 절, OFFSET 절 : 출력의 개수를 제한
SELECT
	*
FROM employees
LIMIT 5 OFFSET 10 -- OFFSET => 앞 10개를 건너뛰고, LIMIT => 5개를 출력
;
-- LIMIT 10,5 로 입력해도 됨




-- 집계함수
-- SUM(컬럼명) : 조회된 해당 컬럼의 모든 값의 합계를 반환
-- ex 1) 전 사원의 현재 급여 합계를 조회
SELECT
	SUM(salary)
FROM	salaries
WHERE	
	end_at IS NULL
;

-- MAX(컬럼명) : 조회된 값 중 가장 큰 값을 반환
-- ex 1) 가장 많은 급여를 조회
SELECT
	MAX(salary)
FROM	salaries
WHERE	
	end_at IS NULL
;

-- MIN(컬럼명) : 조회된 값 중 가장 작은 값을 반환
-- ex 1) 가장 적은 급여를 조회
SELECT
	MIN(salary)
FROM	salaries
WHERE	
	end_at IS NULL
;

-- AVG(컬럼명) : 조회된 해당 컬럼의 모든 값의 평균 값을 반환
-- ex 1) 전 사원의 현재 급여의 평균 값을 조회
SELECT
	AVG(salary)
FROM	salaries
WHERE	
	end_at IS NULL
;
-- COUNT(컬럼명)
-- ex 1) 현재 재직 중인 사원 수를 조회
SELECT
	COUNT(`name`), -- 검색 결과 중 해당 칼럼의 값이 NULL이 아닌 레코드의 총 수를 출력
	COUNT(*) cnt
FROM	employees
WHERE
	fire_at IS NULL
;




-- DISTINCT 키워드 : 검색 결과에서 중복된 레코드 없이 출력
SELECT DISTINCT
	`name`
	, emp_id
FROM employees
ORDER BY	`name`
;




-- GROUP BY 절, HAVING 절 : 그룹으로 묶어서 조회
-- ex 1) 부서별 사원 수 조회
SELECT	
	-- SELECT 절에 작성하는 컬럼은 GROUP BY 절에서 사용한 컬럼과 집계함수만 작성해야 함 (SQL 표준 문법)
	dept_code
	, COUNT(dept_emp_id) cnt_epms
FROM	department_emps
WHERE	
	end_at IS NULL
GROUP BY dept_code
;

-- ex 2) 직급별 사원 수가 10000명 이상인 직급을 조회
SELECT
	title_code
	, COUNT(*) cnt
FROM title_emps
WHERE
	end_at IS NULL
GROUP BY title_code
	HAVING cnt >= 10000
;
-- SELECT는 출력할 내용을 적음
