-- 2020.11.10
-- 함수

-- 단일행, 집합 함수

-- 단일행 함수 : 숫자, 문자, 날짜, 변환함수

 desc dual;

-- 숫자 함수
select ABS(-15.5) from dual;    -- 절댓값
select FLOOR(15.7) from dual;   -- 소수점 절사
select ROUND(15.693) from dual; -- 반올림
select ROUND(15.693,1) from dual; -- 소수점 둘째자리에서 반올림
select LOG(10,100) from dual;   -- 로그(지수 구하기)
select POWER(3,2) from dual;    --제곱 구하기 / (x,y) -> x의 y승

-- 문자 함수
select concat('나는', ' 손흥민 입니다.') from dual; -- 문자열 두개를 붙인다.
select concat('저의 이름은 ',ename) from emp where job='MANAGER';
select LOWER('MR. SCOTT MCMILLAN') "Lowercase" from dual; -- 대문자를 소문자로 변경
select lower(ename) from emp;
select LPAD('Page 1',15,'*.') FROM DUAL; -- 특정 패턴 만들기 / 전체가 15자리이고 왼쪽으로 *이 채워진다.
select RPAD('00112-3',14,'*') FROM DUAL; -- 특정 패턴 만들기 / 전체가 15자리이고 오른쪽으로 *이 채워진다.
select SUBSTR('ABCDEFG',3,4) FROM DUAL; -- 지정된 문자열 자르기 / 3번째 자리(C)부터 4개(CDEF)
select RPAD(substr('001212-3001247',1,8),14,'*') FROM DUAL; -- 특정 패턴 만들기 / 8번째 숫자까지만 보여주고 그 뒤는 *로 채워진다 / 숫자 자리에 컬럼을 넣어도 됨
select ltrim('===from===', '=') from dual; -- 왼쪽에 있는 문자가 일치하면 지운다.
select rtrim('===from===', '=') from dual; -- 오른쪽에 있는 문자가 일치하면 지운다.
select trim('=' from '===from===' ) as "from" from dual; -- 일치하는 문자를 지운다
select REPLACE('J ACK and JUE','J','BL') from dual; -- 문자 치환하기 (x, y, z) / x에 있는 y를 z로 바꿔라
select REPLACE('000000-0000000', '-', '') from dual; -- 문자 치환하기 (x, y, z) / x에 있는 y를 z로 바꿔라

-- 날짜 함수
select sysdate from dual; -- 현재 날짜 출력
select sysdate+14 from dual; -- 현재 날짜 + x일 출력
select sysdate-14 from dual; -- 현재 날짜 - x일 출력
select add_months(sysdate, 2) from dual; -- 현재 날짜 ±x월 출력
select last_day(sysdate) from dual; -- 현재 월의 마지막 날짜 출력

-- 변환 함수
-- TO_CHAR
-- 날짜 -> 문자
select sysdate, to_char(sysdate, 'YYYY.MM.DD DAY AM HH24:MI:SS') from dual; -- 날짜를 특정 형태로 바꿔 출력
select to_char(sysdate, 'YYYY.MM.DD. HH24:MI') from dual;
-- 숫자 -> 문자
select to_char(10000.123, '000,000.00') from dual; -- 해당 자리까지 출력 / 출력 범위 넘어갈경우 #으로 출력됨 / 출력 범위보다 작을경우 부족한 자릿수만큼 앞에 0을 붙인다.
select to_char(10000, 'L999,999.99') from dual; -- 해당 지역의 통화 출력 / 출력 범위보다 작을 경우 그대로 출력함
select sal,to_char(sal*1100,'L99,999,999.99') from emp;
select ename, job, sal, to_char(sal*1100*12+nvl(comm,0)*1100,'L99,999,999.99') as "연봉" from emp order by sal desc; -- 누가 가장 급여를 많이 받는지
-- 문자 -> 날짜
SELECT to_date ('2009/09/05','YYYY/MM/DD') from dual;
SELECT to_date ('2020.11.01','YYYY.MM.DD') from dual;
select trunc(sysdate - to_date('20-01-01', 'YY-MM-DD')) from dual; -- 오늘이 2020년에서 며칠이 지났는지 확인
select trunc(sysdate - to_date('1998-10-26', 'YYYY-MM-DD')) from dual; -- 내가 며칠 살았는지 확인
-- 문자 -> 숫자
select to_number('100.00', '999.99')/to_number('10.00', '999.99') from dual;

-- decode 함수 : switch문과 비슷하다.
-- 사원이름, 부서번호, 부서 이름을 출력
select ename, deptno, decode(deptno, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALES', 40, 'OPERATIONS') 
as "부서" from emp order by deptno; -- deptno가 n이면 해당 부서이름 출력

-- 직급에 따라 급여 인상
-- 'ANALYST' -> 5% 
-- 'SALESMAN' -> 10%
--'MANAGER' -> 15%
-- 'CLERK' -> 20%

select ename, sal, decode(job, 'ANALYST', sal*1.05, 'SALESMAN', sal*1.1, 'MANAGER', sal*1.15, 'CLERK', sal*1.20) 
as upsal from emp order by sal;

select emp.ename as name, deptno as dno, 
case when deptno = 10 then 'ACCOUNTING' when deptno = 20 then 'RESEARCH' 
when deptno = 30 then 'SALES' when deptno = 40 then 'OPERAION' end 
as dname from emp order by dname;

-- 그룹함수 : 하나의 행의 컬럼이 대상이 아닌 행의 그룹의 컬럼들을 묶어 그룹화하고 연산 --> 단일함수와 같이 쓸 수 없음
--         : SUM, AVG, COUNT, MAX, MIN

select to_char(sum(sal)*1100, 'L999,999,999') as "월급 총액",
round(avg(sal)) as "월급 평균",
count(*) as "전체 사원(명)", count(comm) as "커미션 받는 사원(명)",
max(sal)*1100 as "가장 높은 월급(원)",
min(sal)*1100 as "가장 낮은 월급(원)"
from emp;

select sum(comm), avg(comm), count(nvl(comm,0)), max(comm), min(comm) from emp; -- null은 빼고 연산한다.

-- 전체 행 구하기
select count(sal) as "MANAGER의 수(명)", avg(sal) as "매니저의 평균 월급", max(sal), min(sal) from emp where job = 'MANAGER';

-- 직무의 개수 구하기
select count(distinct job) as "직무의 개수(개)" from emp order by job;

-- 특정 컬럼 기준으로 그룹핑 : group by 컬럼 이름
-- 각 부서의 소속 인원 구하기
select deptno, count(*) as "부서 소속 인원(명)"
from emp
group by deptno
order by count(*) desc;

-- 각 부서별 총 급여 구하기
select deptno, sum(sal) as "부서 별 총 급여(원)"
from emp
group by deptno
order by deptno;

-- 부서별 급여 평균 구하기
select deptno, round(avg(sal)) as "부서 별 급여 평균(원)"
from emp
group by deptno
order by deptno;

-- 부서별 급여 최고 금액과 최저 금액 출력
select deptno, max(sal) as "급여 최고 금액(원)", min(sal) as "급여 최저 금액(원)", max(sal)-min(sal) as "급여 차이(원)"
from emp
group by deptno
order by deptno;

-- 부서별로 그룹지은 후(GROUP BY)
-- 그룹 지어진 부서별 평균 급여
-- 평균 급여가 2000 이상인 (HAVING)
-- 부서 번호와 부서별 평균 급여를 출력
select deptno, round(avg(sal))
from emp
group by deptno
having avg(sal) >= 2000
order by deptno;

-- 부서별 급여의 최대값과 최소값을 구하되
-- 최대 급여가 2900 이상인 부서만 출력
select deptno, max(sal), min(sal)
from emp
group by deptno
having max(sal)>=2900
order by deptno;

-- 직무별 지표 : 사원의 수, 급여의 총 합, 평균 급여, 최대 급여, 최소 급여
select job as "직업",
count(*) || '명' as "사원의 수", 
to_char(sum(sal)*1100, 'L999,999,999') as "급여의 총 합", 
to_char(avg(sal)*1100, 'L999,999,999.99') as "평균 급여",
to_char(max(sal)*1100, 'L999,999,999') as "최대 급여", 
to_char(min(sal)*1100, 'L999,999,999') as "최소 급여"
from emp
where job != 'PRESIDENT'
group by job
order by job;







