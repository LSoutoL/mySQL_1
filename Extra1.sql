/*1. Mostrar el nombre de todos los jugadores ordenados alfabéticamente.*/
SELECT Nombre FROM jugadores ORDER BY Nombre;

/*2. Mostrar el nombre de los jugadores que sean pivots (‘C’) y que pesen más de 200 libras,
ordenados por nombre alfabéticamente.*/
SELECT Nombre FROM jugadores WHERE Posicion = 'C' AND Peso>200 ORDER BY Nombre;

/*3. Mostrar el nombre de todos los equipos ordenados alfabéticamente.*/
SELECT Nombre FROM equipos ORDER BY Nombre;

/*4. Mostrar el nombre de los equipos del este (East).*/
SELECT Nombre FROM equipos WHERE Conferencia='East';

/*5. Mostrar los equipos donde su ciudad empieza con la letra ‘c’, ordenados por nombre.*/
SELECT Nombre FROM equipos WHERE Ciudad LIKE 'C%' ORDER BY Nombre;

/*6. Mostrar todos los jugadores y su equipo ordenados por nombre del equipo.*/
SELECT * FROM equipos INNER JOIN jugadores WHERE equipos.Nombre=jugadores.Nombre_equipo ORDER BY equipos.Nombre;

/*7. Mostrar todos los jugadores del equipo “Raptors” ordenados por nombre.*/
SELECT * FROM jugadores WHERE Nombre_equipo = 'Raptors' ORDER BY Nombre;

/*8. Mostrar los puntos por partido del jugador ‘Pau Gasol’.*/
SELECT e.Puntos_por_partido FROM estadisticas e, jugadores j WHERE e.jugador=j.codigo AND j.Nombre = 'Pau Gasol';

/*9. Mostrar los puntos por partido del jugador ‘Pau Gasol’ en la temporada ’04/05′.*/
SELECT e.Puntos_por_partido FROM estadisticas e, jugadores j WHERE e.jugador=j.codigo AND j.Nombre = 'Pau Gasol' AND e.temporada='04/05';

/*10. Mostrar el número de puntos de cada jugador en toda su carrera.*/
SELECT j.Nombre, SUM(e.Puntos_por_partido) as Puntos FROM estadisticas e, jugadores j WHERE e.jugador=j.codigo GROUP BY e.jugador;

/*11. Mostrar el número de jugadores de cada equipo.*/
SELECT e.Nombre, COUNT(j.Nombre_equipo) as Jugadores FROM equipos e, jugadores j WHERE e.Nombre=j.Nombre_equipo GROUP BY e.Nombre;

/*12. Mostrar el jugador que más puntos ha realizado en toda su carrera.*/
SELECT j.Nombre, SUM(e.Puntos_por_partido) FROM estadisticas e, jugadores j WHERE e.jugador=j.codigo GROUP BY e.jugador ORDER BY SUM(e.Puntos_por_partido) DESC LIMIT 1;

/*13. Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA.*/
SELECT e.Nombre, e.Conferencia, e.Division FROM equipos e, jugadores j  ORDER BY Altura DESC LIMIT 1;

/*14. Mostrar la media de puntos en partidos de los equipos de la división Pacific.*/
SELECT AVG(Puntos_por_partido) FROM estadisticas e, jugadores j, equipos eq WHERE e.jugador=j.codigo AND eq.Nombre=j.Nombre_Equipo AND eq.Division = 'Pacific' GROUP BY j.Nombre_equipo;

/*15. Mostrar el partido o partidos (equipo_local, equipo_visitante y diferencia) con mayor
diferencia de puntos.*/
SELECT codigo, equipo_local, equipo_visitante, ABS(puntos_local - puntos_visitante) FROM partidos WHERE ABS(puntos_local - puntos_visitante)=(SELECT MAX(ABS(puntos_local - puntos_visitante)) FROM partidos);

/*16. Mostrar la media de puntos en partidos de los equipos de la división Pacific.*/
SELECT AVG(Puntos_por_partido) FROM estadisticas e, jugadores j, equipos eq WHERE e.jugador=j.codigo AND eq.Nombre=j.Nombre_Equipo AND eq.Division = 'Pacific' GROUP BY j.Nombre_equipo;

/*17. Mostrar los puntos de cada equipo en los partidos, tanto de local como de visitante.*/
SELECT e.Nombre, SUM(puntos_local), SUM(puntos_visitante) FROM partidos p, equipos e WHERE e.Nombre=p.equipo_local OR e.Nombre=p.equipo_visitante group by e.Nombre;

/*18. Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante,
equipo_ganador), en caso de empate sera null.*/

select codigo, equipo_local, equipo_visitante,
case 
when puntos_local>puntos_visitante then equipo_local 
when puntos_visitante>puntos_local then equipo_visitante 
else null end as Ganador
from partidos;

/*SELECT codigo, equipo_local from partidos WHERE puntos_local>puntos_visitante;
SELECT codigo, equipo_visitante from partidos WHERE puntos_visitante>puntos_local group by codigo;*/