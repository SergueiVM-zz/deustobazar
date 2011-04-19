declare
  cursor cats is select * from categoria;
  clave number;
  num_subastas number;
  hijos number;
begin
  select max(id), count(id) into clave, num_subastas from subasta;
  if (clave = null or num_subastas = 0) then 
    clave := 0;
  end if;
  clave := clave + 1;
  for reg in cats loop
    hijos := 0;
    select count(id) into hijos from categoria where cat_padre = reg.id;
    --dbms_output.put_line('Hijos: '||hijos);
    if hijos = 0 then
      --dbms_output.put_line('Subasta: '||clave);
      insert into subasta values (clave,'Titulo'||clave,reg.id,1,null,'Observaciones o bien la descripcion del producto',clave * 1000,sysdate + 15,1);
      clave := clave + 1;
    end if;
  end loop;
end;
/
  
  	

  