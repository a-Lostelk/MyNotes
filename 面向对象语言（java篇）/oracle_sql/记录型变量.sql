DECLARE
  v_emp emp%ROWTYPE;
BEGIN
  select * into v_emp from emp where empno = 7934;
  DBMS_OUTPUT.put_line('������'|| v_emp.ename||'нˮ��'||v_emp.sal);
END;
