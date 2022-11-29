--Writing a procedure with Dynamic sql to get the emplyee details from emp with same deptno and job category ?
--Creating a procedure that will take deptno and job type as input and print the details of employees from emp Table.

   CREATE OR REPLACE PROCEDURE EMP_DET (
                                  P_ID  EMP.DEPTNO%TYPE
                                  ,P_JOB  EMP.JOB%TYPE
                                  ) AUTHID CURRENT_USER
       IS
       V_SELECT1 VARCHAR2(30):='SELECT COUNT(*) FROM EMP ';
	V_SELECT VARCHAR2(30):='SELECT * FROM EMP ';
       V_WHERE VARCHAR2(100);
       VCNT1 NUMBER;
       VCNT SYS_REFCURSOR;
       EMP1 EMP%ROWTYPE;
      BEGIN
              IF P_ID IS NULL AND P_JOB IS NULL THEN
               V_WHERE := 'WHERE 1=1';
              ELSIF P_ID IS NULL AND P_JOB IS NOT NULL THEN
               V_WHERE :='WHERE JOB= '''||P_JOB||'''';
              ELSIF P_ID IS NOT NULL AND P_JOB IS NOT NULL THEN
               V_WHERE := 'WHERE DEPTNO='||P_ID ||' AND JOB='''||P_JOB||'''';
              ELSIF P_ID IS NOT NULL AND P_JOB IS NULL THEN
               V_WHERE := 'WHERE DEPTNO='||P_ID ;
              END IF ;
	     EXECUTE IMMEDIATE V_SELECT1||V_WHERE INTO VCNT1;
	     DBMS_OUTPUT.PUT_LINE('EMPNO  NAME  JOB  MGR  HIREDATE  SAL  DEPTNO  COMM');
	     DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
             OPEN VCNT
             FOR V_SELECT||' '||V_WHERE;
              LOOP
              FETCH VCNT INTO EMP1;
              EXIT WHEN VCNT%NOTFOUND;
              DBMS_OUTPUT.PUT_LINE(EMP1.EMPNO||' '||EMP1.ENAME||' '||EMP1.JOB||' '||EMP1.MGR||' '||EMP1.HIREDATE||' '||EMP1.SAL||' '||EMP1.DEPTNO||'   '||EMP1.COMM);
              END LOOP;
              CLOSE VCNT;
		DBMS_OUTPUT.PUT_LINE(VCNT1||' NO OF ROWS ARE THERE');
     END;
/

	