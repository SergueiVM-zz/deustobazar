set serveroutput on;
declare
  dia varchar2(4);
  fecha date;
begin
  select sysdate into fecha from dual;
  dbms_output.put_line(to_char(fecha,'dy'));
  dbms_output.put_line(to_char(fecha+1,'dy'));
  dbms_output.put_line(to_char(fecha+2,'dy'));
  dbms_output.put_line(to_char(fecha+3,'dy'));
  dbms_output.put_line(to_char(fecha+4,'dy'));
  dbms_output.put_line(to_char(fecha+5,'dy'));
  dbms_output.put_line(to_char(fecha+6,'dy'));

end;
/