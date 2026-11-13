-- [TRANSACTION]

-- 1. TRANSACTION 시작
START TRANSACTION;

INSERT INTO employees(
	`name`
	,birth
	,gender
	,hire_at
)
VALUES(
	'미어캣'
	,'1990-02-23'
	,'M'
	,NOW()
);

COMMIT;
ROLLBACK; -- 둘 중 하나 하면 됨