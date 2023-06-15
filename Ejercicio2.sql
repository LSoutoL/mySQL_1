SELECT nombre FROM producto;

SELECT nombre, precio FROM producto;

SELECT * FROM producto;

SELECT nombre, ROUND(precio) FROM producto;

SELECT codigo_fabricante FROM producto;

SELECT codigo_fabricante FROM producto GROUP BY codigo_fabricante;

SELECT nombre FROM fabricante ORDER BY nombre;

SELECT nombre FROM producto ORDER BY nombre ASC, precio DESC;

SELECT * FROM producto WHERE codigo<=5;

SELECT * FROM producto ORDER BY precio LIMIT 1;

SELECT * FROM producto ORDER BY precio DESC LIMIT 1;

SELECT * FROM producto WHERE precio<=120;

SELECT * FROM producto WHERE precio BETWEEN 60 AND 200;

SELECT * FROM producto WHERE codigo_fabricante IN (1,3,5);

SELECT nombre FROM producto WHERE nombre LIKE '%portatil%';

SELECT p. codigo, p.nombre, p.precio, f.nombre FROM producto p, fabricante f WHERE p.codigo_fabricante=f.codigo;

SELECT p.nombre, p.precio, f.nombre FROM producto p, fabricante f WHERE p.codigo_fabricante=f.codigo ORDER BY f.nombre;

SELECT p.nombre, p.precio, f.nombre FROM producto p, fabricante f WHERE p.codigo_fabricante=f.codigo ORDER BY p.precio LIMIT 1;

SELECT p.nombre, p.precio, f.nombre FROM producto p, fabricante f WHERE p.codigo_fabricante=f.codigo AND f.nombre = 'Lenovo';

SELECT * FROM producto p, fabricante f WHERE p.codigo_fabricante=f.codigo AND f.codigo IN (1,3);

SELECT p.nombre, p.precio, f.nombre FROM producto p, fabricante f WHERE p.codigo_fabricante=f.codigo AND p. precio>=180 ORDER BY p.precio DESC, p.nombre ASC;

SELECT * FROM fabricante LEFT JOIN producto ON fabricante.codigo=producto.codigo_fabricante;

SELECT * FROM fabricante WHERE NOT EXISTS (SELECT * FROM producto WHERE fabricante.codigo=producto.codigo_fabricante);

SELECT * FROM producto WHERE codigo_fabricante=(SELECT codigo FROM fabricante WHERE nombre='Lenovo');

SELECT * FROM producto WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante=(SELECT codigo FROM fabricante WHERE nombre='Lenovo'));

SELECT nombre FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre='Lenovo') ORDER BY precio DESC LIMIT 1;

SELECT * FROM producto WHERE precio > (SELECT AVG (precio) from producto WHERE codigo_fabricante=1) AND codigo_fabricante=1;

SELECT nombre FROM fabricante WHERE codigo IN (SELECT codigo_fabricante FROM producto);

SELECT nombre FROM fabricante WHERE codigo NOT IN (SELECT codigo_fabricante FROM producto);

SELECT nombre FROM fabricante WHERE codigo IN (SELECT codigo_fabricante FROM producto GROUP BY(codigo_fabricante) HAVING count(codigo_fabricante)>=(SELECT COUNT(codigo_fabricante) FROM producto WHERE codigo_fabricante=2)) AND codigo NOT IN (2);