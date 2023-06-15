SELECT * FROM empleados;

SELECT * FROM departamentos;

SELECT nombre_depto FROM departamentos;

SELECT nombre, sal_emp FROM empleados;

SELECT * FROM empleados WHERE cargo_emp='Secretaria';

SELECT comision_emp FROM empleados;

SELECT * FROM empleados WHERE cargo_emp= 'Vendedor' ORDER BY nombre;

SELECT nombre, cargo_emp FROM empleados ORDER BY sal_emp;

SELECT nombre_jefe_depto FROM departamentos WHERE ciudad='CIUDAD REAL';

SELECT nombre AS 'Nombre', cargo_emp AS 'Cargo' FROM empleados;

SELECT sal_emp, comision_emp FROM empleados WHERE id_depto=2000 ORDER BY comision_emp;

SELECT nombre, (sal_emp + comision_emp + 500) FROM empleados WHERE id_depto=3000 ORDER BY nombre;

SELECT * FROM empleados WHERE nombre LIKE 'J%';

SELECT sal_emp, comision_emp, (sal_emp+comision_emp), nombre FROM empleados WHERE comision_emp=0;

SELECT * FROM empleados WHERE comision_emp>sal_emp;

SELECT * FROM empleados WHERE comision_emp <= (sal_emp*0.3);

SELECT * FROM empleados WHERE NOT nombre LIKE "%ma%";

SELECT nombre_jefe_depto FROM departamentos WHERE nombre_depto= 'VENTAS' OR nombre_depto='INVESTIGACIÓN' OR nombre_depto='MANTENIMIENTO';

SELECT nombre_jefe_depto FROM departamentos WHERE NOT nombre_depto IN ('VENTAS', 'INVESTIGACIÓN', 'MANTENIMIENTO');

SELECT max(sal_emp) from empleados;

SELECT max(nombre) FROM empleados;

SELECT max(sal_emp), min(sal_emp), (max(sal_emp) - min(sal_emp)) FROM empleados;

SELECT avg(sal_emp) FROM empleados GROUP BY (id_depto);

SELECT COUNT(id_depto), id_depto FROM empleados GROUP BY id_depto HAVING COUNT(id_depto)>3;

SELECT d.nombre_depto FROM empleados e, departamentos d GROUP BY d.nombre_depto HAVING COUNT(e.id_depto=d.id_depto)=0;

SELECT * FROM departamentos WHERE NOT EXISTS (SELECT * FROM empleados WHERE empleados.id_depto=departamentos.id_depto);

SELECT nombre, nombre_depto, nombre_jefe_depto FROM empleados JOIN departamentos ON empleados.id_depto=departamentos.id_depto;

SELECT * FROM empleados WHERE sal_emp>= (SELECT AVG(sal_emp) FROM empleados) ORDER BY id_depto;