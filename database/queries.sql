-- Барлық тапсырмаларды алу
-- Орындалған тапсырмаларды алу
-- Аты бойынша сұрыптау
-- JOIN сұраныстары: 4. Әр тапсырманы оның пайдаланушысымен бірге (INNER JOIN) 
-- 5. Әр тапсырманы оның тегтерімен бірге (JOIN арқылы) 
--6. Пайдаланушыларды олардың тапсырмаларымен (LEFT JOIN — тапсырмасы жоқ пайдаланушы да көрінсін)
-- GROUP BY: 7. Әр пайдаланушының тапсырма саны 8. Әр тегке қанша тапсырма тиесілі
-- Подзапрос: 9. Ең көп тапсырмасы бар пайдаланушы 10. Орындалмаған тапсырмасы бар пайдаланушылар
-- Агрегаттық функциялар: 11. Барлық тапсырма саны (COUNT) 12. Орындалған тапсырма саны
-- Фильтрлер: 13. Белгілі бір пайдаланушының орындалмаған тапсырмалары 
--14. «Study» тегі бар тапсырмалар
-- 15. Соңғы қосылған 3 тапсырма (ORDER BY + LIMIT)

select * from tasks;     -- 1 
select * from tasks where completed = true;  -- 2
select * from tasks order by title asc;      -- 3
select name, title from tasks inner join app_users on tasks.user_id = app_users.id;    -- 4
select title, name from tasks      -- 5
inner join task_tags on tasks.id = task_tags.task_id    
inner join tags on task_tags.tag_id = tags.id;     
select name, title from app_users left join tasks on app_users.id = tasks.user_id;    -- 6
select name, count(title) from tasks inner join app_users on tasks.user_id = app_users.id group by name;    -- 7
select tags.name, count(tasks.id) as tag_tasks                                -- 8
from tags
inner join task_tags on tags.id = task_tags.tag_id
inner join tasks on task_tags.task_id = tasks.id
group by tags.name;
select name from app_users                               -- 9
where id = (
    select user_id from tasks 
    group by user_id 
    order by count(*) desc 
    limit 1
);
select name from app_users where id in (
    select user_id from tasks where completed = false  --10
);

select count(title) as total_tasks from tasks;      -- 11
select count(title) as total_completed_tasks from tasks where completed = true;     -- 12
select name, title, completed from app_users inner join tasks on app_users.id = tasks.user_id where completed = false;   -- 13
select tasks.title, tags.name 
from tasks
inner join task_tags on tasks.id = task_tags.task_id
inner join tags on task_tags.tag_id = tags.id
where tags.name = 'Study';
   -- 14
select * from tasks order by id desc limit 3;    -- 15