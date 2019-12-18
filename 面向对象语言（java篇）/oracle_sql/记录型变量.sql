DECLARE
  v_emp emp%ROWTYPE;
BEGIN
  select * into v_emp from emp where empno = 7934;
  DBMS_OUTPUT.put_line('ÐÕÃû£º'|| v_emp.ename||'Ð½Ë®£º'||v_emp.sal);
END;
