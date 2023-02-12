-- i. Заполнить все таблицы БД vk данными (по 10-20 записей в каждой таблице) 
-- файл Lesson_4_crud_samples

-- ii. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке.
SELECT DISTINCT firstname
FROM vk.users
ORDER BY firstname
;

-- iii. Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = true).
-- При необходимости предварительно добавить такое поле в таблицу profiles со значением по умолчанию = false (или 0).

ALTER TABLE vk.profiles 
ADD is_active BIT 
DEFAULT false NULL
;

UPDATE vk.profiles
SET is_active = 1
WHERE YEAR(now()) - YEAR(birthday) < 18
;

-- iv. Написать скрипт, удаляющий сообщения «из будущего» (дата позже сегодняшней)

UPDATE messages
SET created_at='2222-01-01 22:22:22'
WHERE from_user_id = 1
;

DELETE FROM messages
WHERE created_at > now()
;