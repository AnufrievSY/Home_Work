--- Задание 1.
-- Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, 
-- который больше всех общался с выбранным пользователем (написал ему сообщений).

SELECT 
    r.firstname AS `r_firstname`,
    r.lastname AS `r_lastname`,
    r.email AS `r_email`,
    r.phone AS `r_phone`,
    s.firstname AS `s_firstname`,
    s.lastname AS `s_lastname`,
    s.email AS `s_email`,
    s.phone AS `s_phone`
FROM
    users AS r
        JOIN
    users AS s
WHERE
    r.id = 1
        AND s.id = (SELECT 
            COUNT(from_user_id) AS id_user_with_max_of_messages
        FROM
            messages
        WHERE
            to_user_id = 1
        GROUP BY from_user_id
        ORDER BY COUNT(from_user_id) DESC
        LIMIT 1);

--- Задание 2.
-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.

SELECT 
    COUNT(*)
FROM
    likes
        JOIN
    profiles
WHERE
    likes.user_id = profiles.user_id
        AND TIMESTAMPDIFF(YEAR,
        profiles.created_at,
        NOW()) < 10;


--- Задание 3.
-- Определить кто больше поставил лайков (всего): мужчины или женщины.
SELECT 
    gender, COUNT(gender)
FROM
    likes
        JOIN
    profiles
WHERE
    likes.user_id = profiles.user_id
GROUP BY gender;

