-- SELECT 문
-- DML 중 하나로, 저장되어 있는 데이터를 조회하기 위해 사용하는 쿼리

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