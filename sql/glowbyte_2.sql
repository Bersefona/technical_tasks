/* 

  Создать простую базу данных аптеки (см. medicines_erd.png).

  drugs
  id — код лекарства
  name — название
  producer — производитель
  
  availability
  eff_date_from — день изменения количества лекарства на складе
  eff_date_to — день, когда количество лекарства на складе не менялось в последний раз
  id — код лекарства
  amount — количество
  
  price 
  id — код лекарства
  eff_date_from — день изменения количества лекарства
  eff_date_to — день, когда количество лекарства не менялось в последний раз
  price — цена лекарства
  
  transact
  tr_date — дата покупки лекарства
  id — код лекарства
  sum — сумма покупки
  amount — количество купленного лекарства
  client — имя покупателя

*/


/* На какую сумму было продано арбидола за январь 2020? */

SELECT SUM(t.sum)
FROM transact t
JOIN drugs d ON t.id = d.id
WHERE d.name = 'Арбидол'
  AND strftime('%Y-%m', t.tr_date) = '2020-01'
  

/*

  Вывести названия товаров, сумму продаж по этим товарам из TRANSACT, 
  у которых количествово товаров из таблицы AVAILABILITY на 31.01.2020 было больше десяти, 
  а цена по этим товарам в таблице PRICE в течение 2020 года была не менее 100 рублей.
  
*/

SELECT drugs.name,
       SUM(transact.sum) AS Сумма
FROM transact
JOIN drugs ON transact.id = drugs.id
JOIN availability ON transact.id = availability.id
JOIN price ON transact.id = price.id
WHERE (availability.amount > 1
       AND (strftime('%Y-%m-%d', availability.eff_date_from) >= '2020-12-31'
            AND strftime('%Y-%m-%d', availability.eff_date_to) <= '2020-12-31')
       AND (price.price > 100
            AND strftime('%Y', availability.eff_date_from) = '2020'
            AND strftime('%Y', availability.eff_date_to) = '2020'))
