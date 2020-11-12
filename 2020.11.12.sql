-- 2020.11.12

-- DDL
-- 테이블 생성 : creat tasble table_name
--             (column_name domain [constrait],
--             (column_name domain [constrait],
--             (column_name domain [constrait],
--             (column_name domain [constrait]
--              ... )

create table test_tbl(
    no number(4), user_name varchar2(10), user_id varchar2(16),
    user_password varchar2(12), reg_date TIMESTAMP default sysdate -- TIMESTAMP : date의 확장판
);

desc test_tbl;

create table EMP01(
    empno number(4),
    ename varchar2(10),
    sal number(7,2) -- 총 7자리 숫자, 소수점 둘째자리까지 표현
    );

desc emp01;

-- create table ~ as ~ : 테이블 복사, 제약 조건은 복사되지 않음.
-- 1. creat table 명령어 다음에 컬럼을 일일이 정의하는 대신
-- AS 절을 추가하여 EMP 테이블과 동일한 내용과 구조를 갖는 EMP02 테이블을 생성
create table EMP02 as select * from emp;

desc emp02;
select * from emp02;

-- 2. 서브 쿼리문의 select 절에 * 대신 원하는 컬럼명을 명시하면
-- 기존 테이블에서 일부의 컬럼만 복사할 수 있습니다.
-- 사원번호, 사원명, 급여만 복사하여 테이블 생성
create table emp03
as
select empno, ename, sal from emp;

desc emp03;
select * from emp03;

-- 3. 서브 쿼리문의 select 문을 구성할 때 
-- where 절을 추가하여 원하는 조건을 제시하면
-- 기존 테이블에서 일부의 행만 복사
create table emp04
as
select * from emp where deptno = 10;

select * from emp04;

-- 4. where 조건 절에 항상 거짓이 되는 조건을 지정하게 되면
-- 테이블에서 얻어질 수 있는 로우가 없게 되므로 
create table emp05
as
select * from emp where deptno=40;

select * from emp05;

select * from tab;

-- 테이블의 삭제 : 저장공간을 삭제 --> 저장되어 있는 데이터도 모두 삭제 --> 복구 불가능!
-- drop table table_name
drop table test_tbl;

-- TRUNCATE : 테이블의 모든 행(튜플)을 바로 삭제, 물리적인 적용도 바로 진행(커밋이 따로 없다)
create table emp06
as
select * from emp;

select * from emp06;
TRUNCATE table emp06; --> 행 다 삭제됨

-- rename 현재 테이블 이름 to 변경할 테이블 이름
rename emp06 to new_emp;
select * from tab;

rename new_emp to hot_emp;
select * from hot_emp;

-- 테이블 구조의 변경
-- alter table table_name (add(컬럼의 추가) | modift(컬럼의 수정) | drop(컬럼의 삭제))

-- 기존 테이블에 속성을 추가
-- emp01 job 컬럼을 추가 job varchar2(10)
desc emp01;
alter table emp01 
add (job varchar(10));

alter table emp01 
add (deptno number(2));

-- 기존 테이블의 컬럼 변경 : 새롭게 정의된 컬럼으로 교체하는것
alter table emp01
MODIFY (deptno number(10));

-- 기존 테이블의 컬럼 삭제 : 데이터도 모두 삭제
alter table emp01
drop (deptno);

-- 제약 조건 정의
insert into dept values(10, 'test', 'seoul');

desc emp01;
insert into emp01 values(null, null, 1000, 'tester');
select * from emp01;

-- emp01 테이블 삭제
drop table emp01;
-- emp01 테이블 생성 : empno, ename에 null 값이 들어가지 않도록 제약
create table emp01(
    empno number(4) not null,
    ename varchar2(10) not null,
    job varchar(9),
    deptno number(2)
);

insert into emp01 values (null, null, 'tester', 10);
insert into emp01 values (1, 'test1', 'tester', 10);
select * from emp01 where empno =1; --> 중복값 발생

-- 데이터의 중복 금지 : unique
drop table emp02;
create table emp02(
    empno number(4) unique,
    ename varchar2(10) not null
    );
desc emp02;
insert into emp02 values(1, 'test1');
insert into emp02 values(1, 'test2'); --> empno 값 중복이므로 오류 발생

select * from emp02;

-- empno not null, unique 제약을 동시에 적용
drop table emp03;
create table emp03(
    empno number(4) not null unique, --> 두개의 제약조건 적용
    ename varchar2(10) not null
);

insert into emp03 values(null, 'test1'); -- not null 위배
insert into emp03 values(1, null);       -- not null 위배
insert into emp03 values(1, 'test1');
insert into emp03 values(1, 'test2');    -- unique 위배
insert into emp03 values(2, 'test2');

select * from emp03;

-- 기본키 제약 : 기본키 설정 -> not unll + unique
drop table emp04;
create table emp04(
    empno number(4) primary key,
    ename varchar2(10) not null
);

insert into emp04 values(null, 'test'); --> primary key 이므로 null값 넣을 수 없음
insert into emp04 values(1, 'test');

-- 외래키 제약 : 참조하는 테이블과 컬럼 정의
drop table emp05;
create table emp05(
    empno number(4) primary key,
    ename varchar2(10) not null,
    deptno number(2) REFERENCES dept(deptno)
);

insert into emp05 values(1, 'test', 10);
insert into emp05 values(1, 'test', 50); --> dept 테이블에 deptno=50이 없으므로 참조 불가능 = 오류
insert into emp05 values(2, 'test', null);
select * from emp05;

-- check : 특정 범위 제한
create table emp06(
    empno number(4) primary key,
    ename varchar(10) not NULL,
    sal number(7,2) CHECK(sal>=800)
);

insert into emp06 values(1, 'test', 1000);
insert into emp06 values(2, 'test', 799); --> sal check 제약 조건 위배

-- default : insert 시에 데이터가 입력되지 않을 때 자동으로 등록되는 데이터의 정의
drop table emp07;
create table emp07(
    empno number(4) primary key,
    ename varchar(10) not null,
    sal number(7,2) check(sal>=500),
    comm number(7,2) default 0,
    hiredate date default sysdate
);

insert into emp07 (empno, ename, sal) values(1, 'test', 3000);
select * from emp07;

-- 제약 조건에 이름 부여
drop table emp08;
create table emp08(
    empno number(4) CONSTRAINT emp08_empno_PK primary key,
    ename varchar(10) CONSTRAINT emp08_enam_NN not null,
    sal number(7,2) CONSTRAINT emp08_sal_CK check(sal>=500),
    comm number(7,2) default 0,
    hiredate date default sysdate
);

insert into emp08 (empno, ename, sal) values(null, 'test', 3000);
select * from emp08;

-- 테이블 레벨에서 제약조건 정의 / not null, default는 컬럼 레벨에서 정의해야함
create table emp09(
    empno number(4),
    ename varchar2(10) not null,
    job varchar2(9),
    deptno number(10),  -- 컬럼 러벨 정의 끝
    CONSTRAINT emp09_empno_PK primary key(empno),
    CONSTRAINT emp09_job_UK unique(job),
    CONSTRAINT emp09_deptno_FK foreign key(deptno) REFERENCES dept(deptno) -- 테이블 레벨 정의 끝
);

insert into emp09 values (null, null, 'job1', 50);
insert into emp09 values (1, 'tester', 'job1', 40);
insert into emp09 values (2, 'tester', 'job2', 40);

select * from emp09;

--========================================================

-- DML : 데이터의 삽입, 수정, 삭제
-- DML의 대상은 행이다. -> 행단위 입력, 행단위 수정, 행단위 삭제

-- 데이터 삽입
-- insert into table_name (데이터를 저장할 컬럼들) values(저장할 데이어들)
create table dept01
as
select * from dept where 1=2;

insert into dept01(deptno, dname, loc) values (10, '마케팅', '서울');

SELECT
    *
FROM dept01;

desc dept01;
insert into dept01 values(20, '디자인', '부산');

SELECT
    *
FROM dept01;
















