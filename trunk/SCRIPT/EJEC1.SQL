declare
  mini number(7);
begin
  select min(salario) into mini from emp;
  update emp set salario=salario+mini where dept_no=30;
end;
/