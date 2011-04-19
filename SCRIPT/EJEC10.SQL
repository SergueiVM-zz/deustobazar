set serveroutput on;
create or replace trigger t3
after insert or update of dept_no on dept for each row
begin
  if (:new.dept_no not in (10,20,30,40,50,60)) then
    dbms_output.put_line('Numero de departamento erroneo');
    raise_application_error(-20999,'Numero de departamento erroneo');
  end if;
end;
/