-- DB 생성
CREATE DATABASE test; -- 만들고 싶은 데이터베이스명

-- DB 접근 / 선택
USE test; -- UI로 확인은 안 됨
SELECT * FROM employees; -- 접근 안 됨

USE dbsample;
SELECT * FROM employees; -- 접근 됨

-- DB 삭제
DROP DATABASE test;

-- 데이터베이스 수정 안 됨, 이름 바꾸고 싶으면 삭제하고 재생성해야 함
-- 삭제하고 되돌리기도 안 됨