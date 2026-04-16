# -Apache-Superset

## Описание проекта
Цель проекта — визуализировать ключевые показатели авиакомпании (выручка, структура флота, ценообразование) на основе демо-базы данных «Авиаперевозки». Проект демонстрирует навыки построения сквозной аналитики: от написания SQL-запросов до создания интерактивных дашбордов.

<img width="1280" height="651" alt="image" src="https://github.com/user-attachments/assets/3f9094d3-988b-48f6-81dd-98f8844bcf17" />

## Стек технологий
* **СУБД:** PostgreSQL (DBeaver)
* **BI-платформа:** Apache Superset
* **Язык:** SQL

## Разбор ключевых графиков и SQL-запросов
1. Динамика выручки по классам обслуживания
Позволяет отследить ежедневную выручку в разрезе Economy, Comfort и Business классов для анализа сезонности и спроса.
<img width="1280" height="776" alt="image" src="https://github.com/user-attachments/assets/fc62ef51-5d65-4233-bce5-e27e4c2c34d3" />

```sql
select 
    fare_conditions, 
    DATE(actual_arrival) as date, 
    sum(amount) as day_sum
from ticket_flights 
join flights using(flight_id)
where status = 'Arrived'
group by fare_conditions, DATE(actual_arrival);
```

2. Распределение посадочных мест по моделям самолетов
Анализ конфигурации бортов: помогает понять вместимость флота и соотношение классов на разных моделях ВС.
<img width="1270" height="771" alt="image" src="https://github.com/user-attachments/assets/3659dfd2-462d-4001-b507-d22a53697efa" />

```sql
select 
    model['ru'], 
    fare_conditions, 
    COUNT(*)
from seats 
join aircrafts_data using(aircraft_code)
group by 1, 2;
```
3. Средняя стоимость билета в зависимости от модели самолета
Позволяет оценить ценовую политику компании для различных типов воздушных судов.
<img width="1280" height="568" alt="image" src="https://github.com/user-attachments/assets/39ef896f-c97b-4e27-8160-0a182f9cd284" />
```sql
SELECT 
    model['ru'] AS model,
    AVG(amount) AS avg_price
FROM ticket_flights
JOIN flights USING(flight_id)
JOIN aircrafts_data USING(aircraft_code)
GROUP BY 1
ORDER BY avg_price DESC;
```

4. Детальный расчет средней цены (округленный)
Используется для точных отчетов и сверки финансовых показателей.
<img width="1280" height="553" alt="image" src="https://github.com/user-attachments/assets/e568a885-637b-4b2f-a158-22274c735090" />
```sql
select 
    model['ru'] as model, 
    ROUND(AVG(amount), 2) as avg_price
from ticket_flights 
join flights using(flight_id)
join aircrafts_data using(aircraft_code)
group by 1;
```

