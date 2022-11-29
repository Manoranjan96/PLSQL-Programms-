--Q1> WRITE A PROCEDURE THAT WILL TAKE ID AS DEPTNO AND GIVE ALL EMPLOYEES DETAILS WHO ARE WORKING IN THAT DEPARTMENT AS REF_CURSOR ?
  --THE REQUIREMENT IS TO GET ALL THE DETAILS OF THE EMPLOYEES WHO ARE WORKING THE SAME DEPRATMENT AND TO PRINT THAT IN THE REQUIRED FORMAT.
--Here I am creating a procedure that will take id as input parameter and sys_refcursor for out parameter .

CREATE  OR REPLACE PROCEDURE PROC_GET(
                                       ID IN EMP.DEPTNO%TYPE
                                      ,DETAILS OUT SYS_REFCURSOR
                                     )
 IS 
  BEGIN 
    OPEN DETAILS FOR 
    SELECT * FROM EMP
    WHERE DEPTNO= ID ;
    
  END;
  
--Heere I am calling the procedure in a plsql block to get the requried output from emp table . 
DECLARE 
DETAILS   SYS_REFCURSOR; --This REF CURSOR will give the output from the PROC_GET procedure. 
EMP_DET EMP%ROWTYPE;	  --This will store the details for the further process because I am getting the output on emp schema. 
VID NUMBER := '&ID';	 --This will ask the user to give the department number at runtime, basically for dynamic purpose.
BEGIN 
     PROC_GET(VID,DETAILS);
     LOOP
     FETCH DETAILS INTO EMP_DET;
     EXIT WHEN DETAILS%NOTFOUND;  --This will end the process if there is no data more in the cursor to fetch.
     
     DBMS_OUTPUT.PUT_LINE(EMP_DET.ENAME||'  '||EMP_DET.DEPTNO||'  '||EMP_DET.JOB||'  '||EMP_DET.SAL||'  '||EMP_DET.HIREDATE);
     END LOOP;
END;

--Thank You for reading this code.
