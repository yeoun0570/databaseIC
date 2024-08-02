use moviedb;

create table movietbl(
	movie_id int,
    movie_title varchar(30),
    movie_director varchar(20),
    movie_star varchar(20),
    movie_script longtext,
    movie_film longblob
) DEFAULT CHARSET = UTF8mb4;


INSERT INTO movietbl VALUES(
1,'쉰들러리스트','스티븐 스필버그','리암 니슨',
LOAD_FILE('C:/study/database/movies/Schindler.txt'),
LOAD_FILE('C:/study/database/movies/Schindler.txt/Schindler.mp4')
);

select * from movietbl;

show variables like 'max_allowed_packet';
show variables like 'secure_file_priv';

truncate movietbl;
INSERT INTO movietbl VALUES(
1,'쉰들러리스트','스티븐 스필버그','리암 니슨',
LOAD_FILE('C:/study/database/movies/Schindler.txt'),
LOAD_FILE('C:/study/database/movies/Schindler.mp4')
);
select * from movietbl;

INSERT INTO movietbl VALUES(
2,'쇼생크탈출','프랭크 다라본트','팀 로빈스',
LOAD_FILE('C:/study/database/movies/Shawshank.txt'),
LOAD_FILE('C:/study/database/movies/Shawshank.mp4')
);

INSERT INTO movietbl VALUES(
3,'라스트 모히칸','마히클 만','다니엘 데이 루이스',
LOAD_FILE('C:/study/database/movies/Mohican.txt'),
LOAD_FILE('C:/study/database/movies/Mohican.mp4')
);

-- 다운로드 하기
select movie_script from movietbl where movie_id = 1
		into outfile 'C:/study/database/movies/Schindler_out.txt'
        lines terminated by '\\n'; -- 줄바꿈 문자 그대로 다운받아서 저장한다.
        
        
-- movie_film 다운로드 받기
-- LONGBLOB 형식인 동영상 INTO DUMPFILE문 이용 --> 바이너리 파일로 내려받는다.
SELECT movie_film FROM movietbl WHERE movie_id=3
		INTO DUMPFILE 'C:/study/database/movies/Mohican_out.mp4';
        
        
/*
피봇 : 한 열에 포함된 여러값을 출력하고, 그 값을 여러 열로 변환해서 테이블로 반환하는 식을 회전하고 필요하면 집계까지 수행하는 과정을 의미한다.
*/

use modeldb;

create table pivotTest(
	uName char(5),	-- 판매자 (김진수, 윤민수)
    season char(2), -- 시즌
    amount int		-- 수량
);

INSERT INTO pivotTest VALUES
('김진수', '겨울', 10),
('윤민수', '여름', 15),
('김진수', '봄', 25),
('윤민수', '가을', 37),
('김진수', '겨울', 40),
('윤민수', '겨울', 22),
('김진수', '봄', 3),
('윤민수','가을', 12),
('김진수', '가을', 26);

commit;

select * from pivottest;

-- 판매자별로 판매 계절, 판매수량 : sum(), if() 함수 활용해서 피봇테이블 생성
select uName,
		SUM(IF(season='봄',amount,0)) as '봄',
		SUM(IF(season='여름',amount,0)) as '여름',
		SUM(IF(season='가을',amount,0)) as '가을',
		SUM(IF(season='겨울',amount,0)) as '겨울',
		SUM(amount) as '합계'
FROM pivotTest
GROUP BY uName;

-- 계절별로 판매자의 판매수량을 집계하여 출력하는 피벗테이블을 생성해주세요
select season,
		SUM(IF(uName='김진수',amount,0)) as '김진수',
		SUM(IF(uName='윤민수',amount,0)) as '윤민수',
		SUM(amount) as '합계'
FROM pivotTest
GROUP BY season;

/* JSON
{
	"userName" : "김삼순",
    "birthYear" : 2002,
    "address" : "서울 성도구 북가좌동",
    "mobile" : "01012348989"
} ==> 김삼순 회원의 정보, 이 자체를 객체로 저장해서 관리하겠다는 소리
*/

use bookmarket;
select * from usertbl;

SELECT JSON_OBJECT('name', name, 'height', height) as '키 180이상 회원의 정보'
FROM usertbl
WHERE height >= 180;

-- JSON을 위한 MySQL은 다양한 내장함수를 제공한다.
SET @json = '{
		"usertbl1" : [
				{"name": "임재범", "height": 182}, 
                {"name": "이승기", "height": 182}, 
                {"name": "성시경", "height": 186}
        ]
}';

-- JSON_VALID : 문자열이 JSON 형식을 만족하면 1, 만족하지 않으면 0을 반환
SELECT JSON_VALID(@json) AS JSON_VALID;
-- JSON_SEARCH
SELECT JSON_SEARCH(@json, 'one', '성시경') AS JSON_SEARCH;  
-- JSON_INSERT
SELECT JSON_INSERT(@json, '$.usertbl1[0].mDate', '2024-07-29') AS JSON_INSERT;  
-- JSON_REPLACE
SELECT JSON_REPLACE(@json, '$.usertbl1[0].name', '임영웅') AS JSON_REPLACE; 
-- JSON_REMOVE 
SELECT JSON_REMOVE(@json, '$.usertbl1[1]') AS JSON_REMOVE; 


-- 제어흐름 함수, 문자열 함수, 수학함수, 날짜/시간 함수, 전체 텍스트 검색 함수, 형변환 함수
-- 1. 제어흐름 함수
-- IF(), IFNULL(), NULLIF(), CASE~WHEN~ELSE~END()

-- 1-1. IF(수식) : 수식이 참인지 거짓인지 결과에 따라 분기
SELECT IF(100>200,'참','거짓');

-- 1-2. IFNULL(수식1, 수식2) : 수식1이 NULL이 아니면 수식1이 반환, 수식1이 NULL이면 수식2 반환
SELECT IFNULL(NULL, '널이네'), IFNULL(100, '널이군요');

-- 1-3. NULLIF(수식1, 수식2) : 수식1과 수식2가 같으면 NULL 반환, 다르면 수식1 반환
SELECT NULLIF(100,100), NULLIF(200,100);

-- 1-4. CASE~WHEN~ELSE~END : 함수는 앙니지만 연산자(Operator)로 분류된다. 다중분기 + 내장함수
SELECT CASE 10
	WHEN 1 THEN '일'
    WHEN 3 THEN '삼'
    WHEN 5 THEN '오'
    ELSE '모름'
END AS 'CASE TEST';

-- 문자열 함수 (활용도 갑!)

-- 1-1. ASCII(아스키코드), CHAR(숫자)
SELECT ASCII('A'), CHAR(65);

-- MySQL은 기본 UTF-8 코드를 사용하기 때문에 영문자는 3byte, 한글은 9byte 할당한다.
SELECT BIT_LENGTH('abc'), CHAR_LENGTH('abc'), LENGTH('abc');
SELECT BIT_LENGTH('일이삼'), CHAR_LENGTH('일이삼'), LENGTH('일이삼');

-- concat(문자열1,문자열2...)

-- concat_ws(구분자,문자열1,문자열2...) -> 구분자와 함께 문자열을 이어준다.
SELECT CONCAT_WS('/','2024','해커톤 우승자','래리 킴');

SELECT 
ELT(2,'ONE','TWO','THREE'), 
FIELD('둘','ONE','TWO','둘'), 
FIND_IN_SET('둘','ONE,둘,THREE'), 
INSTR('하나둘셋','둘'), 
LOCATE('둘','하나둘셋');

-- FORMAT(숫자, 소수점 자릿수) : 숫자를 소수점 아래 자릿수까지 표현, 1000단위로 콤마(,)로 표시
SELECT FORMAT(123456.123456,4);

SELECT BIN(31), HEX(31), OCT(31);

SELECT INSERT('abcdefghijk',3,4,'####');

SELECT LEFT('abcdefghi', 3), RIGHT('abcdefghi', 3);

-- upper(문자열), lower(문자열)
SELECT UPPER('abc'), LOWER('DEF');

-- LPAD(문자열, 채울문자열), RPAD(문자열, 채울문자열)
SELECT LPAD('SSG', 5, '&'), RPAD('SSG', 5, '&');

-- TRIM() : 양쪽 공백 제거
SELECT 
TRIM('   신세계 자바 프로그래밍   '),
LTRIM('   신세계 자바 프로그래밍   '),
RTRIM('   신세계 자바 프로그래밍   ');

-- SUBSTRING(문자열, 시작 위치, 길이) 
-- SUBSTRING(문자열 from 시작위치 for 길이)
SELECT SUBSTRING('자바프로그래밍',3,2),
SUBSTRING('자바프로그래밍' from 3 for 2),
SUBSTRING('자바프로그래밍',3),
SUBSTRING('자바프로그래밍' from 3);

-- 1. ADDDATE(날짜, 차이), SUBDATE(날짜, 차이)
SELECT 
ADDDATE('2025-01-01', INTERVAL 31 DAY),
SUBDATE('2025-01-01', INTERVAL 12 MONTH);

SELECT 
ADDTIME('2025-01-01 23:59:59', '1:1:1'),
SUBTIME('2025-01-01 23:59:59', '1:1:1');

-- CURDATE() : 현재 연-월-일 반환
-- CURTIME() : 현재 시:분:초 반환
-- NOW(), SYSDATE(),LOCALTIME(), LOCALSTAMP() : 현재 연-월-일 시:분:초 반환
SELECT
CURDATE(),
CURTIME(),
NOW(),
SYSDATE();

-- YEAR(날짜), MONTH(날짜), HOUR(시간), MINUTE(시간), SECOND(시간), MICROSECOND(시간)
SELECT
YEAR(CURDATE()),
MONTH(CURDATE()),
DAY(CURDATE()),
HOUR(CURTIME()),
MINUTE(CURTIME()),
SECOND(CURTIME());