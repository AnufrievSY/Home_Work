USE vk;
-- Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, 
-- который больше всех общался с выбранным пользователем (написал ему сообщений).
  
SELECT
	from_user_id as id,
    COUNT(*) AS total
FROM
	messages where to_user_id = (SELECT to_user_id FROM messages GROUP BY to_user_id ORDER BY COUNT(to_user_id) DESC LIMIT 1)
GROUP BY
	from_user_id
ORDER BY
	total DESC;

SELECT
	*
FROM
	users
WHERE
	id = 7 OR
    id = 3;

-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.
-- Пользователей младше 10 в моей таблице нет так что я не стал создавать новую, а отобрал несовершенолетних

SELECT 
	user_id AS id, 
	count(*) AS total 
FROM 
	likes 
WHERE 
	user_id IN (
		SELECT 
			user_id 
		FROM 
			profiles 
		WHERE 
			age < 18)
GROUP BY 
	user_id 
ORDER BY 
	total DESC;

-- Определить кто больше поставил лайков (всего): мужчины или женщины

SELECT count(*) AS female FROM likes WHERE user_id IN(
		SELECT user_id FROM	profiles WHERE gender = 'f');
SELECT count(*) AS male FROM likes WHERE user_id IN(
		SELECT user_id FROM	profiles WHERE gender = 'm');