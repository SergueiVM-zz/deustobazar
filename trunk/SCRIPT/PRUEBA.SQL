set serveroutput on;
create or replace procedure tablas is
  fila tabs.table_name%type;
  cursor c1 is select table_name from tabs;
begin
  open c1;
  loop
    fetch c1 into fila;
    exit when c1%NOTFOUND;
    dbms_output.put_line(fila);
  end loop;
end;
/