USE vk;
DROP TABLE IF EXISTS bookmarks;
CREATE TABLE bookmarks (
	id SERIAL,
    users_id BIGINT UNSIGNED NOT NULL,
    name VARCHAR(45),
    type_id BIGINT UNSIGNED NOT NULL,
    tags_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW()
    );
    
DROP TABLE IF EXISTS bookmarks_type;
CREATE TABLE bookmarks_type (
	id SERIAL,
    name VARCHAR(45)
    );
    
DROP TABLE IF EXISTS personal_tags;
CREATE TABLE personal_tags (
	id SERIAL,
    name VARCHAR(45)
    );
    
ALTER TABLE bookmarks
ADD CONSTRAINT bookmarks_fk 
FOREIGN KEY (users_id) REFERENCES users(id);

ALTER TABLE bookmarks
ADD CONSTRAINT bookmarks_fk_1 
FOREIGN KEY (type_id) REFERENCES bookmarks_type(id);

ALTER TABLE bookmarks
ADD CONSTRAINT bookmarks_fk_2 
FOREIGN KEY (tags_id) REFERENCES personal_tags(id);