/*

-- Реализовать работу джоинов (INNER, LEFT, RIGHT, FULL) для таблиц A и B и вывести полученные результаты. 

Структура таблицы A:      Структура таблицы B: 
     |A|                          |B|
      a                            b
      7                            1
      1                            3
      2                            5
      3                            7
      4                            7
      1                           NULL
     NULL                         NULL
*/

-- SQL-запрос
SELECT * FROM A JOIN B ON A.a = B.b;

/*

-- Результат запроса
      a    b
      7    7
      7    7
      1    1
      3    3
      1    1
      
*/      
      
-- SQL-запрос
SELECT * FROM A LEFT JOIN B ON A.a = B.b;

/*

-- Результат запроса
      a    b
      7    7
      7    7
      1    1
      2    NULL
      3    3
      4    NULL
      1    1
      NULL NULL
      
 */     
      
-- SQL-запрос
SELECT * FROM A RIGHT JOIN B ON A.a = B.b;

/*

-- Результат запроса
      a    b
      1    1
      1    1
      3    3
      NULL 5
      7    7
      7    7
      NULL NULL
      NULL NULL
      
*/      
      
-- SQL-запрос
SELECT * FROM A FULL JOIN B ON A.a = B.b;

/*

-- Результат запроса
      a    b
      7    7
      7    7
      1    1
      2    NULL
      3    3
      4    NULL
      NULL 5
      NULL NULL
      NULL NULL
      
*/      
      
/*

-- Написать запрос, который выводит количество пятёрок и фамилии тех учеников, которые имеют более трёх двоек.

Входящие данные:
name    | mark |    subj    |
Иванов        5  Математика
Иванов        4  Физика
Петров        5  Математика
Смирнов       5  Математика
Петров        2  Физика
Иванов        2  Математика
Смирнов       5  Математика
............................

*/

SELECT COUNT(mark),
       name
FROM TABLE
WHERE mark = 5
  AND name IN
    (SELECT name
     FROM TABLE
     WHERE mark = 2
     GROUP BY name
     HAVING COUNT(mark) > 3)
GROUP BY name;
