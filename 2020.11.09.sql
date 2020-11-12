-- 2020.11.09
-- Select �⺻

-- scott �������� �α���
-- scott ������ ������ ���̺� ��ü�� Ȯ�� : Tab -> ����ڰ� ������ ���̺��� ������ �����ϴ� ������ ��ųʸ�
select * from tab;

-- ���̺��� ���� Ȯ�� : DESC
-- ���̺��� �����͸� �˻��ϱ� �� ������ Ȯ���� ��
DESC emp;
desc dept;

-- ������ ��ȸ ��� : Select --> ������� ó��
-- SELECT �÷���, ... FROM ���̺� �̸�(��ȸ�� ���) --> �⺻ ����
-- *�߿�* SELECT�� ��� --> Table�̴� !!!!!!!!!!!!
-- SQL�� ��ҹ��� �������� ����
select 
    *       -- �÷� �̸����� ������ش�. ����ϴ� ������ ���� ����� ������ �°� ��µȴ�.
From emp    -- ��ȸ�ϰ����ϴ� ���̺� �̸��� ������ش�.
;           -- SQL�� ����

-- �μ� ���̺��� ��� �����͸� ��ȸ
SELECT *
FROM dept;

-- �μ� ���̺��� --> FORM
-- �μ��� �̸��� ��ġ�� ��� --> SELECT
select dname, loc
from dept;

select loc, dname, deptno
from dept;

-- ��� ����� ������ �������
SELECT *
FROM emp;

-- ����� �̸�, ���, ����(����)�� �����ϴ� ����Ʈ ���
SELECT
    ename, empno, job
FROM emp;

-- select ���� Į���� ��Ģ���� ����
-- �ӽ� ���̺� daul : �÷��� x�� ������ ���̺�
select 100+200, 200-100, 100*10, 100/10
FROM dual;

select ename, sal, sal*12
from emp;

select * from emp;

-- ������ sal*12+comm ���� �������
select ename, sal, sal*12, comm, sal*12+comm
from emp;

-- null(��ĭ) : ���� �����ϴµ� �������� ���� ��
-- ������ �Ұ� : ��Ģ����, �񱳿���, ������ ...

-- nvl �Լ� : null ���� ġȯ���ִ� �Լ�
-- nvl(�÷�, ��ü��) : �÷��� ���� null�� �� ��ü������ ġȯ, �� �� ��ü���� �÷��� Ÿ�Կ� �´� �����Ϳ����Ѵ�.
-- ������ sal*12+comm ���� �������.
-- as �̸� : ��Ī --> as ���� ���� / �ѱ۷� �� ���� as "�ѱ��̸�" (�ѱ��� �� ������� ����)
select ename, sal, sal*12 sall, nvl(comm,0) as comm, sal*12+nvl(comm,0) as "12���� ����"
from emp;

-- �����ͺ��̽��� sql ^����^�� ���ڿ� ó���� ���� ����ǥ('')
-- ���ڿ��� ����
select ename || ' �� ������ ' || job || '�Դϴ�.'
from emp;

-- select distinct : �������� �ߺ��Ǵ� ���� �����ϰ� ���
select DISTINCT deptno
from emp;


