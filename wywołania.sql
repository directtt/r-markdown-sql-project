-- Zad 1
SELECT AVG(arr_delay_new) AS [avg_delay]
FROM [dbad_flights].[dbo].[Flight_delays];

-- Zad 2
SELECT MAX(arr_delay_new) AS [max_delay]
FROM [dbad_flights].[dbo].[Flight_delays];

-- Zad 3
SELECT carrier, origin_city_name, dest_city_name, fl_date, arr_delay_new
FROM [dbad_flights].[dbo].[Flight_delays]
WHERE arr_delay_new = (SELECT MAX(arr_delay_new) AS [max_delay]
                       FROM [dbad_flights].[dbo].[Flight_delays])

-- Zad 4
SELECT AVG(arr_delay_new) AS [avg_delay], W.weekday_name
FROM [dbad_flights].[dbo].[Flight_delays] D
INNER JOIN [dbad_flights].[dbo].[Weekdays] W
        ON D.day_of_week = W.weekday_id
GROUP BY W.weekday_name
ORDER BY avg_delay DESC;

-- Zad 5

SELECT AVG(D.arr_delay_new) as [avg_delay], A.airline_name
FROM [dbad_flights].[dbo].[Flight_delays] D   
INNER JOIN [dbad_flights].[dbo].[Airlines] A
        ON A.airline_id = D.airline_id
GROUP BY A.airline_name

SELECT *
FROM (SELECT AVG(D.arr_delay_new) as [avg_delay], A.airline_name
        FROM [dbad_flights].[dbo].[Flight_delays] D   
        INNER JOIN [dbad_flights].[dbo].[Airlines] A
                ON A.airline_id = D.airline_id
        GROUP BY A.airline_name) AS T
WHERE T.airline_name IN (SELECT A.airline_name
                         FROM   [dbad_flights].[dbo].[Airlines] A
                         WHERE  A.airline_name = T.airline_name
                                AND A.airline_id IN (SELECT D.airline_id
                                                     FROM   [dbad_flights].[dbo].[Flight_delays] D 
                                                     WHERE  D.origin = 'SFO' AND A.airline_id = D.airline_id))
ORDER BY T.avg_delay DESC;

-- zad 6
SELECT AVG(D.arr_delay_new)
FROM   [dbad_flights].[dbo].[Flight_delays] D
GROUP BY airline_id
HAVING AVG(D.arr_delay_new) >= 10;

SELECT *
FROM   (SELECT AVG(D.arr_delay_new) as [avg_delay]
        FROM   [dbad_flights].[dbo].[Flight_delays] D
        GROUP BY airline_id
        HAVING AVG(D.arr_delay_new) >= 10) AS TEMP

SELECT *
FROM   (SELECT AVG(D.arr_delay_new) as [avg_delay]
        FROM   [dbad_flights].[dbo].[Flight_delays] D
        GROUP BY airline_id) AS TEMP

SELECT  CAST(COUNT(TEMP.avg_delay1) AS DECIMAL) / CAST(COUNT(TEMP1.avg_delay2) AS DECIMAL) AS [late_propotion]
FROM   (SELECT AVG(D.arr_delay_new) as [avg_delay1]
        FROM   [dbad_flights].[dbo].[Flight_delays] D
        GROUP BY airline_id
        HAVING AVG(D.arr_delay_new) >= 10) AS TEMP
RIGHT OUTER JOIN (SELECT AVG(D.arr_delay_new) as [avg_delay2]
                  FROM   [dbad_flights].[dbo].[Flight_delays] D
                  GROUP BY airline_id) TEMP1
              ON  TEMP.avg_delay1 = TEMP1.avg_delay2;

-- zad 7
SELECT (AVG(arr_delay_new * dep_delay_new) - (AVG(arr_delay_new) * AVG(dep_delay_new)))
        / (STDEVP(arr_delay_new) * STDEVP(dep_delay_new)) AS 'Pearsons r'
FROM   [dbad_flights].[dbo].[Flight_delays]

-- zad 8
SELECT TEMP.difference AS [delay_increase], TEMP.airline_name
FROM  (SELECT T1.airline_name, MAX(T2.delay - T1.delay1) AS [difference]
       FROM  (SELECT AVG(D.arr_delay_new) as [delay1], A1.airline_name
              FROM   [dbad_flights].[dbo].[Flight_delays] D
              INNER JOIN [dbad_flights].[dbo].[Airlines] A1
                      ON  D.airline_id = A1.airline_id AND D.day_of_month >= 1
                      AND D.day_of_month <= 23
              GROUP BY A1.airline_name) T1
       INNER JOIN (SELECT AVG(D.arr_delay_new) as [delay], A.airline_name
                   FROM   [dbad_flights].[dbo].[Flight_delays] D
                   INNER JOIN [dbad_flights].[dbo].[Airlines] A
                           ON  D.airline_id = A.airline_id AND D.day_of_month >= 24
                           AND D.day_of_month <= 31
                   GROUP BY A.airline_name) T2
               ON  T1.airline_name = T2.airline_name
       GROUP BY T1.airline_name) AS TEMP
WHERE TEMP.difference =
     (SELECT MAX(TEMP.DIFFERENCE)
      FROM  (SELECT T1.airline_name, MAX(T2.delay - T1.delay1) AS [difference]
             FROM  (SELECT AVG(D.arr_delay_new) as [delay1], A1.airline_name
                    FROM   [dbad_flights].[dbo].[Flight_delays] D
                    INNER JOIN [dbad_flights].[dbo].[Airlines] A1
                            ON  D.airline_id = A1.airline_id AND D.day_of_month >= 1
                            AND D.day_of_month <= 23
                    GROUP BY A1.airline_name) T1
             INNER JOIN (SELECT AVG(D.arr_delay_new) as [delay], A.airline_name
                         FROM   [dbad_flights].[dbo].[Flight_delays] D
                         INNER JOIN [dbad_flights].[dbo].[Airlines] A
                                 ON  D.airline_id = A.airline_id AND D.day_of_month >= 24
                                 AND D.day_of_month <= 31
                         GROUP BY A.airline_name) T2
                      ON  T1.airline_name = T2.airline_name
             GROUP BY T1.airline_name) AS TEMP)


WITH CTE_Delay_Increase
AS
(
    SELECT T1.airline_name, MAX(T2.delay - T1.delay1) AS [difference]
       FROM  (SELECT AVG(D.arr_delay_new) as [delay1], A1.airline_name
              FROM   [dbad_flights].[dbo].[Flight_delays] D
              INNER JOIN [dbad_flights].[dbo].[Airlines] A1
                      ON  D.airline_id = A1.airline_id AND D.day_of_month >= 1
                      AND D.day_of_month <= 23
              GROUP BY A1.airline_name) T1
       INNER JOIN (SELECT AVG(D.arr_delay_new) as [delay], A.airline_name
                   FROM   [dbad_flights].[dbo].[Flight_delays] D
                   INNER JOIN [dbad_flights].[dbo].[Airlines] A
                           ON  D.airline_id = A.airline_id AND D.day_of_month >= 24
                           AND D.day_of_month <= 31
                   GROUP BY A.airline_name) T2
               ON  T1.airline_name = T2.airline_name
       GROUP BY T1.airline_name
)
SELECT C.difference AS [delay_increase], C.airline_name
FROM   CTE_Delay_Increase C
WHERE  C.difference = (SELECT MAX(C.difference)
                       FROM CTE_Delay_Increase C);

-- Zad 9
SELECT DISTINCT A1.airline_name
FROM    [dbad_flights].[dbo].[Flight_delays] D
INNER JOIN [dbad_flights].[dbo].[Airlines] A1
        ON D.airline_id = A1.airline_id AND D.origin = 'SFO' AND D.dest = 'PDX'
INNER JOIN [dbad_flights].[dbo].[Flight_delays] D1
        ON D1.airline_id = A1.airline_id AND D1.origin = 'SFO' AND D1.dest = 'EUG'

-- Zad 10
SELECT  D.origin, D.dest, AVG(D.arr_delay_new) AS [avg_delay]
INTO    TESTUJE
FROM    [dbad_flights].[dbo].[Flight_delays] D
WHERE   D.origin IN ('MDW', 'ORD') AND D.dest IN ('SFO', 'SJC', 'OAK') AND D.crs_dep_time >= 1400 
GROUP   BY D.origin, D.dest
ORDER BY avg_delay DESC;

SELECT  AVG(D.arr_delay_new) AS [avg_delay], D.origin, D.dest
FROM    [dbad_flights].[dbo].[Flight_delays] D
WHERE   D.origin IN ('MDW', 'ORD') AND D.dest IN ('SFO', 'SJC', 'OAK') AND D.crs_dep_time >= 1400 
GROUP   BY D.origin, D.dest
ORDER BY AVG(D.arr_delay_new) DESC;