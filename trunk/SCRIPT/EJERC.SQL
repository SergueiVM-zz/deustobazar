set serveroutput on;
create or replace trigger tigre
before insert or update on emp for each row
begin
  execute tablas;
  if (:new.emp_no < 8000) then
   dbms_output.put_line('El codigo de empleado es incorrecto');
   raise_application_error(-20988,'Codigo incorrecto');
  end if;
end;
/