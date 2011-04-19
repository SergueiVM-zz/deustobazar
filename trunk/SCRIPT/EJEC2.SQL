declare
  cursor c1 is select * from plantilla;
begin
  for reg in c1 loop
    if reg.turno = 'M' then
       update plantilla set turno='T' where empleado_no = reg.empleado_no;
    elsif reg.turno = 'T' then
       update plantilla set turno='N' where empleado_no = reg.empleado_no;
    else 
       update plantilla set turno='M' where empleado_no = reg.empleado_no;
    end if;
  end loop;
end;
/