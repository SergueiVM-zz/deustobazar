select s.id as id, titulo, fechafin, precio_salida, ciudad, foto 
from subasta s, usuario u 
where u.id = s.ofertante 
and ((titulo like '%Titulo714%' or observaciones like '%Titulo714%') and fechafin >= to_date('29-3-2001','dd-mm-yyyy')
and categoria in (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32) );
	
/
