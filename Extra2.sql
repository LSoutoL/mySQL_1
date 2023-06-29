/*1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.*/
SELECT codigo_oficina, ciudad FROM oficina;

/*2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.*/
SELECT ciudad, telefono FROM oficina WHERE pais='España';

/*3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un
código de jefe igual a 7.*/
SELECT nombre, apellido1, apellido2, email FROM empleado WHERE codigo_jefe=7;

/*4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.*/
SELECT puesto, nombre, apellido1, apellido2, email FROM empleado WHERE codigo_empleado=1;

/*5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean
representantes de ventas.*/
SELECT nombre, apellido1, apellido2, puesto FROM empleado WHERE NOT puesto='representante ventas';

/*6. Devuelve un listado con el nombre de los todos los clientes españoles.*/
SELECT nombre_cliente FROM cliente WHERE pais='Spain';

/*7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.*/
SELECT estado FROM pedido GROUP BY estado;

/*8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago
en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan
repetidos. Resuelva la consulta:
o Utilizando la función YEAR de MySQL.
o Utilizando la función DATE_FORMAT de MySQL.
o Sin utilizar ninguna de las funciones anteriores.*/
SELECT codigo_cliente FROM pago WHERE YEAR(fecha_pago)=2008 GROUP BY codigo_cliente;
SELECT DISTINCT codigo_cliente FROM pago WHERE DATE_FORMAT(fecha_pago, '%Y')=2008; 
SELECT DISTINCT codigo_cliente FROM pago WHERE fecha_pago='%2008';

/*9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de
entrega de los pedidos que no han sido entregados a tiempo.*/
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE fecha_entrega>fecha_esperada;

/*10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de
entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha
esperada.
o Utilizando la función ADDDATE de MySQL.
o Utilizando la función DATEDIFF de MySQL.*/
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE fecha_entrega=ADDDATE(fecha_esperada, INTERVAL -2 DAY);
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE DATEDIFF(fecha_entrega, fecha_esperada)=-2;

/*11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.*/
SELECT * FROM pedido WHERE estado='rechazado' AND fecha_pedido LIKE '%2009%';

/*12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de
cualquier año.*/
SELECT * FROM pedido WHERE MONTH(fecha_entrega)=1; 

/*13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal.
Ordene el resultado de mayor a menor.*/
SELECT * FROM pago WHERE YEAR(fecha_pago)=2008 AND forma_pago LIKE '%Paypal%' ORDER BY total DESC;

/*14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en
cuenta que no deben aparecer formas de pago repetidas.*/
SELECT DISTINCT forma_pago FROM pago;

/*15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que
tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de
venta, mostrando en primer lugar los de mayor precio.*/
SELECT * FROM producto WHERE gama='Ornamentales' AND cantidad_en_stock>100 ORDER BY precio_venta DESC;

/*16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo
representante de ventas tenga el código de empleado 11 o 30.*/
SELECT * FROM cliente WHERE ciudad LIKE '%madrid%' AND codigo_empleado_rep_ventas IN (11,30);

/* INNER JOIN
1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante
de ventas.*/
SELECT c.nombre_cliente, e.nombre, e.apellido1, e.apellido2 FROM cliente c INNER JOIN empleado e ON e.codigo_empleado=c.codigo_empleado_rep_ventas;

/*2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus
representantes de ventas.*/
SELECT DISTINCT c.nombre_cliente, e.nombre as Representante_ventas FROM cliente c INNER JOIN empleado e ON e.codigo_empleado=c.codigo_empleado_rep_ventas INNER JOIN pago p ON p.codigo_cliente=c.codigo_cliente;

/*3. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de
sus representantes de ventas.*/
SELECT DISTINCT c.nombre_cliente, e.nombre as Representante_ventas FROM cliente c INNER JOIN empleado e ON e.codigo_empleado=c.codigo_empleado_rep_ventas WHERE NOT EXISTS (SELECT * FROM pago p WHERE p.codigo_cliente=c.codigo_cliente);

/*4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes
junto con la ciudad de la oficina a la que pertenece el representante.*/
SELECT DISTINCT c.nombre_cliente, e.nombre as Representante_ventas, o.ciudad FROM cliente c, empleado e, pago p, oficina o WHERE e.codigo_empleado=c.codigo_empleado_rep_ventas AND p.codigo_cliente=c.codigo_cliente AND e.codigo_oficina=o.codigo_oficina;

/*5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus
representantes junto con la ciudad de la oficina a la que pertenece el representante.*/
SELECT DISTINCT c.nombre_cliente, e.nombre as Representante_ventas, o.ciudad FROM cliente c INNER JOIN empleado e ON e.codigo_empleado=c.codigo_empleado_rep_ventas INNER JOIN oficina o ON e.codigo_oficina=o.codigo_oficina WHERE NOT EXISTS (SELECT * FROM pago p WHERE p.codigo_cliente=c.codigo_cliente);

/*6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.*/
SELECT o.linea_direccion1, o.linea_direccion2 FROM oficina o INNER JOIN cliente c, empleado e WHERE e.codigo_empleado=c.codigo_empleado_rep_ventas AND e.codigo_oficina=o.codigo_oficina AND c.ciudad LIKE 'Fuenlabrada';

/*7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad
de la oficina a la que pertenece el representante.*/
SELECT c.nombre_cliente, e.nombre as Representante_ventas, o.ciudad FROM cliente c, empleado e, oficina o WHERE e.codigo_empleado=c.codigo_empleado_rep_ventas AND e.codigo_oficina=o.codigo_oficina;

/*8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.*/
SELECT e.nombre as Nombre_empleado, e.apellido1 as Apellido_empleado, o.nombre as Nombre_jefe, o.apellido1 as Apellido_jefe FROM empleado e INNER JOIN (SELECT * FROM empleado) as o ON e.codigo_jefe=o.codigo_empleado;

/*9. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.*/
SELECT DISTINCT c.nombre_cliente FROM cliente c INNER JOIN pedido p ON p.codigo_cliente=c.codigo_cliente WHERE fecha_entrega>fecha_esperada;

/*10. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.*/
SELECT DISTINCT p.gama FROM producto p INNER JOIN detalle_pedido d ON p.codigo_producto=d.codigo_producto INNER JOIN pedido pe ON pe.codigo_pedido=d.codigo_pedido INNER JOIN cliente c ON c.codigo_cliente=pe.codigo_cliente;

/*Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, JOIN.
1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.*/
SELECT * FROM cliente c LEFT JOIN pago p ON c.codigo_cliente=p.codigo_cliente WHERE NOT EXISTS (SELECT * FROM pago p WHERE c.codigo_cliente=p.codigo_cliente);

/*2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún
pedido.*/
SELECT * FROM cliente c LEFT JOIN pedido p ON c.codigo_cliente=p.codigo_cliente WHERE NOT EXISTS (SELECT * FROM pedido p WHERE c.codigo_cliente=p.codigo_cliente);

/*3. Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que
no han realizado ningún pedido.*/
SELECT * FROM cliente c LEFT JOIN pedido p ON c.codigo_cliente=p.codigo_cliente LEFT JOIN pago pa ON pa.codigo_cliente=c.codigo_cliente WHERE NOT EXISTS (SELECT * FROM pedido p, pago pa WHERE c.codigo_cliente=p.codigo_cliente AND c.codigo_cliente=pa.codigo_cliente);

/*4. Devuelve un listado que muestre solamente los empleados que no tienen una oficina
asociada.*/
SELECT * FROM empleado e LEFT JOIN oficina o ON  e.codigo_oficina=o.codigo_oficina WHERE NOT EXISTS (SELECT * FROM oficina o WHERE e.codigo_oficina=o.codigo_oficina);

/*5. Devuelve un listado que muestre solamente los empleados que no tienen un cliente
asociado.*/
SELECT DISTINCT * FROM empleado e LEFT JOIN cliente c ON c.codigo_empleado_rep_ventas=e.codigo_empleado WHERE NOT EXISTS (SELECT * FROM cliente c WHERE c.codigo_empleado_rep_ventas=e.codigo_empleado);

/*6. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los
que no tienen un cliente asociado.*/
SELECT * FROM empleado e LEFT JOIN cliente c ON c.codigo_empleado_rep_ventas=e.codigo_empleado LEFT JOIN oficina o ON e.codigo_oficina=o.codigo_oficina WHERE NOT EXISTS (SELECT * FROM cliente c, oficina o WHERE c.codigo_empleado_rep_ventas=e.codigo_empleado AND e.codigo_oficina=o.codigo_oficina);

/*7. Devuelve un listado de los productos que nunca han aparecido en un pedido.*/
SELECT DISTINCT * FROM producto p LEFT JOIN detalle_pedido d ON p.codigo_producto=d.codigo_producto WHERE NOT EXISTS (SELECT * FROM detalle_pedido d WHERE p.codigo_producto=d.codigo_producto); 

/*8. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los
representantes de ventas de algún cliente que haya realizado la compra de algún producto
de la gama Frutales.*/
SELECT DISTINCT * FROM oficina o LEFT JOIN empleado e ON e.codigo_oficina=o.codigo_oficina LEFT JOIN cliente c ON e.codigo_empleado=c.codigo_empleado_rep_ventas LEFT JOIN pedido pe ON pe.codigo_cliente=c.codigo_cliente LEFT JOIN detalle_pedido d ON d.codigo_pedido=pe.codigo_pedido LEFT JOIN producto pr ON pr.codigo_producto=d.codigo_producto WHERE pr.gama LIKE '%Frutales%';

/*9. Devuelve un listado con los clientes que han realizado algún pedido, pero no han realizado
ningún pago.*/
SELECT DISTINCT * FROM cliente c INNER JOIN pedido p ON p.codigo_cliente=c.codigo_cliente LEFT JOIN pago pa ON pa.codigo_cliente=c.codigo_cliente WHERE NOT EXISTS (SELECT * FROM pago pa WHERE pa.codigo_cliente=c.codigo_cliente);

/*10. Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el
nombre de su jefe asociado.*/
SELECT DISTINCT * FROM empleado e JOIN (SELECT * FROM empleado) AS em ON e.codigo_jefe=em.codigo_empleado LEFT JOIN cliente c ON c.codigo_empleado_rep_ventas=e.codigo_empleado WHERE NOT EXISTS (SELECT * FROM cliente cl WHERE cl.codigo_empleado_rep_ventas=e.codigo_empleado);

/*Consultas resumen
1. ¿Cuántos empleados hay en la compañía?*/
SELECT COUNT(codigo_empleado) FROM empleado;

/*2. ¿Cuántos clientes tiene cada país?*/
SELECT COUNT(codigo_cliente), pais FROM cliente GROUP BY pais;

/*3. ¿Cuál fue el pago medio en 2009?*/
SELECT AVG(total) FROM pago WHERE YEAR(fecha_pago)=2009;

/*4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el
número de pedidos.*/
SELECT COUNT(codigo_pedido), estado FROM pedido GROUP BY estado ORDER BY COUNT(codigo_pedido) DESC;

/*5. Calcula el precio de venta del producto más caro y más barato en una misma consulta.*/
SELECT MAX(precio_venta), MIN(precio_venta) FROM producto;

/*6. Calcula el número de clientes que tiene la empresa.*/
SELECT COUNT(codigo_cliente) FROM cliente;

/*7. ¿Cuántos clientes tiene la ciudad de Madrid?*/
SELECT COUNT(codigo_cliente) FROM cliente WHERE ciudad LIKE 'Madrid' GROUP BY ciudad;

/*8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?*/
SELECT COUNT(codigo_cliente), ciudad FROM cliente WHERE ciudad LIKE 'M%' GROUP BY ciudad;

/*9. Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende
cada uno.*/
SELECT e.nombre, e.apellido1, e.apellido2, COUNT(c.codigo_cliente) FROM cliente c INNER JOIN empleado e ON c.codigo_empleado_rep_ventas=e.codigo_empleado GROUP BY c.codigo_empleado_rep_ventas;

/*10. Calcula el número de clientes que no tiene asignado representante de ventas.*/
SELECT COUNT(codigo_cliente) FROM cliente c LEFT JOIN empleado e ON c.codigo_empleado_rep_ventas=e.codigo_empleado WHERE NOT EXISTS (SELECT * FROM empleado e WHERE c.codigo_empleado_rep_ventas=e.codigo_empleado); 

/*11. Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado
deberá mostrar el nombre y los apellidos de cada cliente.*/
SELECT c.nombre_cliente, c.nombre_contacto, c.apellido_contacto, MIN(p.fecha_pago) AS Primer_pago, MAX(p.fecha_pago) AS Ultimo_pago FROM cliente c INNER JOIN pago p ON c.codigo_cliente=p.codigo_cliente GROUP BY p.codigo_cliente;

/*12. Calcula el número de productos diferentes que hay en cada uno de los pedidos.*/
SELECT codigo_pedido, COUNT(DISTINCT codigo_producto) AS Tipos_producto FROM detalle_pedido GROUP BY codigo_pedido;

/*13. Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de
los pedidos.*/
SELECT codigo_pedido, SUM(cantidad) AS Cantidad_productos FROM detalle_pedido GROUP BY codigo_pedido;

/*14. Devuelve un listado de los 20 productos más vendidos y el número total de unidades que
se han vendido de cada uno. El listado deberá estar ordenado por el número total de
unidades vendidas.*/
SELECT p.nombre, SUM(d.cantidad) FROM producto p JOIN detalle_pedido d ON p.codigo_producto=d.codigo_producto GROUP BY d.codigo_producto ORDER BY SUM(d.cantidad) DESC LIMIT 20;

/*15. La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el
IVA y el total facturado. La base imponible se calcula sumando el coste del producto por el
número de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base
imponible, y el total la suma de los dos campos anteriores.*/
SELECT base_imponible, IVA, (base_imponible+IVA) AS Total_Facturacion FROM (SELECT base_imponible, (base_imponible*0.21) AS IVA FROM (SELECT p.precio_proveedor*cantidad as base_imponible FROM detalle_pedido d, producto p WHERE d.codigo_producto=p.codigo_producto) AS Tabla1) AS Tabla2;

/*16. La misma información que en la pregunta anterior, pero agrupada por código de producto.*/
SELECT codigo_producto, base_imponible, IVA, (base_imponible+IVA) AS Total_Facturacion FROM (SELECT base_imponible, (base_imponible*0.21) AS IVA, codigo_producto FROM (SELECT p.precio_proveedor*cantidad as base_imponible, d.codigo_producto AS codigo_producto FROM detalle_pedido d, producto p WHERE d.codigo_producto=p.codigo_producto) AS Tabla1) AS Tabla2;

/*17. La misma información que en la pregunta anterior, pero agrupada por código de producto
filtrada por los códigos que empiecen por OR.*/


/*18. Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se
mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21%
IVA)*/


