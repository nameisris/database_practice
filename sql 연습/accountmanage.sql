-- MySQL 계정 생성
-- root 계정에서만 계정 생성 가능
-- create user 계정명 identified by '비밀번호'
CREATE user kosta IDENTIFIED BY '1234';

-- kosta 계정 비밀번호 변경
ALTER user kosta IDENTIFIED BY '2345';

-- 계정 삭제
DROP user kosta;

-- testdb의 모든 테이블에 대해 조회, 삽입, 수정 권한을 kosta 계정에게 부여
GRANT SELECT, INSERT, UPDATE ON testdb.* TO 'kosta';

-- testdb의 모든 테이블에 대해 모든 권한을 kosta 계정에게 부여
GRANT ALL PRIVILEGES ON testdb.* TO 'kosta';

-- 모든 DB에 대해 모든 권한을 kosta 계정에게 부여
GRANT ALL PRIVILEGES ON *.* TO 'kosta';

-- kosta 계정에 부여된 권한 확인
SHOW GRANTS FOR 'kosta';

-- kosta 계정에서 update 권한 삭제
REVOKE UPDATE ON testdb.* FROM 'kosta';

-- kosta 계정에서 testdb에 대한 모든 권한 삭제
REVOKE ALL PRIVILEGES ON testdb.* FROM 'kosta';

-- kosta 계정에서 모든 db에 대한 모든 권한 삭제
REVOKE ALL PRIVILEGES ON *.* FROM 'kosta';

-- kosta 계정에서 확인 (부여된 권한 확인)
SELECT * FROM ACCOUNT;
DELETE FROM ACCOUNT WHERE id = '10001'; -- error: delete 권한 없음