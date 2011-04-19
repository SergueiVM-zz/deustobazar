declare
  cursor c1 is select hospital_cod, sum(num_cama) as num_camas from 
  sala group by hospital_cod;
  i hospital%rowtype;
  
begin
  for reg in c1 loop
  select * into i from hospital where hospital_cod = reg.hospital_cod;
  if i.num_cama <> reg.num_camas then
    update hospital set num_cama = reg.num_camas where hospital_cod = reg.hospital_cod;
  end if;
  end loop;
end;
/