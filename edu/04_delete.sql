-- DELETE 문 : DML 중 하나로 저장되어 있는 기존 데이터를 삭제하기 위해 사용하는 쿼리
-- DELETE FROM 테이블명
-- [WHERE 조건];
DELETE FROM title_emps
WHERE	
	start_at >= "2026-11-09"
;
-- WHERE 절 먼저 적는 게 좋음 왜 ? 작성하다가 실수로 실행해버리면 데이터 싹 날라감