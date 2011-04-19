set serveroutput on;
declare
   cursor subs is select * from subasta;
begin
   for reg in subs loop
      dbms_output.put_line(reg.id||';'||reg.titulo||';'||reg.categoria||';'||reg.estado||';'||reg.foto||';'||reg.observaciones||';'||reg.precio_salida||';'||reg.fechafin||';'||reg.ofertante);
   end loop;
end;
/