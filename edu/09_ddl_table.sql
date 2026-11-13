CREATE DATABASE test;

USE test;

-- >>>>> 개념적 설계 : 테이블과 필요한 속성들이 무엇일까 ? <<<<<

-- 유저테이블
-- PK, 이메일, PW, 이름, 생년월일, 전화번호, 성별, 프로필, 주소, 가입일, 탈퇴일, 작성일, 수정일, 삭제일
CREATE TABLE users (
	id					BIGINT 			PRIMARY KEY AUTO_INCREMENT
	, email 			VARCHAR(100) 	NOT NULL
	, `password` 	VARCHAR(255) 	NOT NULL
	, user_name 	VARCHAR(30) 	NOT NULL
	, birth 			DATE 				NOT NULL
	, phone 			CHAR(13) 		NOT NULL COMMENT '\'010-0000-0000\', 하이픈 포함 13자리' -- \ : 이스케이프 문자, 바로 뒤에 오는 문자를 문법 기호가 아니라 그냥 글자로 취급
	, gender 		CHAR(1) 			NOT NULL COMMENT '\'M\', \'F\''
	, addr_number 	CHAR(5)
	, addr1 			VARCHAR(50)
	, addr2 			VARCHAR(50)
	, `profile` 	VARCHAR(100)
	, hired_at 		DATE 				NOT NULL DEFAULT (CURRENT_DATE()) -- NOW()로 입력하면 스키마가 만들어진 시간이 입력됨
	, withdrawn_at DATE 				DEFAULT NULL
	, created_at 	DATETIME 		NOT NULL DEFAULT CURRENT_TIMESTAMP()
	, updated_at 	DATETIME 		NOT NULL DEFAULT CURRENT_TIMESTAMP()
	, deleted_at 	DATETIME 		DEFAULT NULL 
	
	-- constraint 키워드로 이름을 별도로 지정
	, CONSTRAINT uk_users_email UNIQUE (email)
);


-- 게시글 테이블
-- PK, 제목, 본문, 이미지, 작성자, 게시글 삭제일, 작성일, 수정일, 삭제일
CREATE TABLE posts (
	id 				BIGINT 			PRIMARY KEY AUTO_INCREMENT
	, user_id 		BIGINT 			NOT NULL
	, title 			VARCHAR(100)	NOT NULL
	, content 		VARCHAR(500) 	
	, image 			VARCHAR(100) 	NOT NULL
	, deactived_at DATE 				DEFAULT NULL
	, created_at 	DATETIME 		NOT NULL DEFAULT CURRENT_TIMESTAMP()
	, updated_at 	DATETIME 		NOT NULL DEFAULT CURRENT_TIMESTAMP()
	, deleted_At 	DATETIME 		DEFAULT NULL
	
	-- , CONSTRAINT fk_posts_user_id FOREIGN KEY (user_id) REFERENCES users(id)
	-- 참조하려는 테이블이 위에서 먼저 생성되어야 함 그래서 테이블 생성할 때 FK를 만들지 않고, 마지막에 한 번에 추가 
);




-- [테이블 수정]
-- 1. 컬럼 추가
-- ALTER TABLE [테이블명] ADD COLUMN [컬럼명] [타입] [제약조건] [AFTER 기존 컬럼명];
-- ex 1) birth_month 컬럼 추가
ALTER TABLE users
ADD COLUMN birth_month CHAR(2) NOT NULL COMMENT '\'MM\' 양식' AFTER birth;
-- 기본으로 맨 밑에 추가되는데 AFTER 컬럼명 입력하면 입력한 컬럼 밑에 생성됨

-- 2. 컬럼 수정
-- ALTER TABLE [테이블명] MODIFY COLUMN [컬럼명] [타입] [제약조건];
-- ex 1) birth_month 컬럼 not null 빼기
ALTER TABLE users
MODIFY COLUMN birth_month CHAR(2) COMMENT '\'MM\' 양식';

-- 3. 컬럼 삭제
-- ALTER TABLE [테이블명] DROP COLUMN [컬럼명] [타입] [제약조건];
-- ex 1) birth_month 컬럼 삭제
ALTER TABLE users
DROP COLUMN birth_month;
-- 컬럼 삭제하면 데이터도 삭제됨

-- 4. 제약조건(CONSTRAINT) 추가
-- ex 1) posts 테이블에 fk 제약조건 추가
ALTER TABLE posts -- ALTER, 수정할 스키마, 수정할 테이블, 키워드(추가는 add), 수정할 내용
ADD CONSTRAINT fk_posts_user_id
FOREIGN KEY (user_id) REFERENCES users(id) ;

-- 5. 제약조건(CONSTRAINT) 제거
-- ex 1) posts 테이블 fk 제약조건 제거
ALTER TABLE posts
DROP CONSTRAINT fk_posts_user_id;
-- 인덱스는 따로 삭제해야 함
ALTER TABLE posts
DROP INDEX fk_posts_user_id;




-- [AUTO INCREMENT 값 변경]
ALTER TABLE users AUTO_INCREMENT = 1;




-- [TRUNCATE 문] : 테이블의 모든 데이터를 깨끗하게 제거하는 문
TRUNCATE TABLE title_emps;




-- [테이블 삭제]
DROP TABLE posts, users;
