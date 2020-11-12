-- 2020.11.09
-- Select 기본

-- scott 계정으로 로그인
-- scott 계정이 소유한 테이블 객체를 확인 : Tab -> 사용자가 가지는 테이블의 정보를 저장하는 데이터 딕셔너리
select * from tab;

-- 테이블의 구조 확인 : DESC
-- 테이블의 데이터를 검색하기 전 구조를 확인할 때
DESC emp;
desc dept;

-- 데이터 조회 명령 : Select --> 행단위로 처리
-- SELECT 컬럼명, ... FROM 테이블 이름(조회의 대상) --> 기본 문법
-- *중요* SELECT의 결과 --> Table이다 !!!!!!!!!!!!
-- SQL은 대소문자 구별하지 않음
select 
    *       -- 컬럼 이름들을 기술해준다. 기술하는 순서에 따라 결과도 순서에 맞게 출력된다.
From emp    -- 조회하고자하는 테이블 이름을 기술해준다.
;           -- SQL의 종료

-- 부서 테이블의 모든 데이터를 조회
SELECT *
FROM dept;

-- 부서 테이블에서 --> FORM
-- 부서의 이름과 위치를 출력 --> SELECT
select dname, loc
from dept;

select loc, dname, deptno
from dept;

-- 모든 사원의 정보를 출력하자
SELECT *
FROM emp;

-- 사원의 이름, 사번, 직급(직무)를 포함하는 리스트 출력
SELECT
    ename, empno, job
FROM emp;

-- select 절의 칼럼의 사칙연산 가능
-- 임시 테이블 daul : 컬럼은 x를 가지는 테이블
select 100+200, 200-100, 100*10, 100/10
FROM dual;

select ename, sal, sal*12
from emp;

select * from emp;

-- 연봉을 sal*12+comm 으로 계산하자
select ename, sal, sal*12, comm, sal*12+comm
from emp;

-- null(빈칸) : 값은 존재하는데 정해지지 않은 값
-- 연산이 불가 : 사칙연산, 비교연산, 논리연산 ...

-- nvl 함수 : null 값을 치환해주는 함수
-- nvl(컬럼, 대체값) : 컬럼의 값이 null일 때 대체값으로 치환, 이 때 대체값은 컬럼이 타입에 맞는 데이터여야한다.
-- 연봉을 sal*12+comm 으로 계산하자.
-- as 이름 : 별칭 --> as 생략 가능 / 한글로 할 때는 as "한글이름" (한글은 잘 사용하지 않음)
select ename, sal, sal*12 sall, nvl(comm,0) as comm, sal*12+nvl(comm,0) as "12개월 연봉"
from emp;

-- 데이터베이스의 sql ^내부^의 문자열 처리는 작은 따옴표('')
-- 문자열의 조합
select ename || ' 의 직무는 ' || job || '입니다.'
from emp;

-- select distinct : 데이터의 중복되는 값은 제외하고 출력
select DISTINCT deptno
from emp;


