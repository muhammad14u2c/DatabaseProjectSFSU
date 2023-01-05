-- tests.sql script for Business Requirements 
-- Rai'd S Muhammad 
SET SQL_SAFE_UPDATES = 0; 

DROP TRIGGER IF EXISTS UPDATE_POST;
DROP TRIGGER IF EXISTS UPDATE_ADS;
DROP PROCEDURE IF EXISTS VIDEO_MULTIMEDIA;
-- Get list of all users who have created a post for at least 3 different blogs.  
SELECT (post_id) AS pid, ( blog_id) AS bid
FROM Users usr
RIGHT JOIN `Post`  ON user_id = usr.user_id RIGHT JOIN `Blog` ON blog_id = usr.user_id
WHERE blog_id >=3;  
-- OUTPUT (1,3,2,3,3,3)



-- Get the list of all limited account users who have commented on at least 2 posts 
SELECT (limited_account_id) AS limitedCount FROM Users usr
JOIN `Comment` comment ON comment.comment_id = usr.user_id
JOIN (SELECT (post_id) AS pid, post_id FROM Post GROUP BY post_id) pst ON
pst.post_id = comment.comment_id AND pst.pid >= 2
JOIN Account acc ON acc.user_id = usr.user_id
JOIN `limited Account` limAcc ON limAcc.account_id = acc.account_id;  
-- OUTPUT: (2,3)

-- Get the list of all prime account users who have made at least 3 blogs 
SELECT COUNT(prime_account_id) AS pai FROM Users usr
JOIN `Blog` blg ON blg.blog_id = usr.user_id
JOIN (SELECT COUNT(blog_id) AS bCount, blog_id FROM Blog GROUP BY blog_id) b ON
 b.blog_id = blg.blog_id AND b.bCount >= 3
JOIN Account acc ON acc.user_id = usr.user_id
JOIN `Prime Account` pAcc ON pAcc.account_id = acc.account_id;

-- Output: 0

-- Find users with subscription_duration more than 30 days that have not made a post  
SELECT COUNT(DISTINCT prime_account_id) AS Users
FROM `Prime Account` users JOIN Post post ON post.post_id = Users.prime_account_id
WHERE users.subscription_duration < 30 AND post_id = 0;

-- -- Output: 0
-- Inner queries --------

-- Get users with the most upvotes and have an upgraded account

-- Get companies with the most posts and have a limited account 

-- "BEFORE INSERT" and "AFTER INSERT"

-- Update post count in blogs (trigger implementation) 

DELIMITER $$
CREATE TRIGGER UPDATE_POST BEFORE INSERT ON Blog
FOR EACH ROW
    BEGIN
        DECLARE new_post_count INT;
        SET new_post_count = (SELECT COUNT(*) from Blog WHERE Blog = Blog);
        UPDATE Post SET new_post_count = new_post_count WHERE blog_id = Blog;
	END$$
    -- Meesage: 0 row(s) affected

-- Update advertisement count in blogs (trigger implementation) 

DELIMITER $$
CREATE TRIGGER UPDATE_ADS AFTER INSERT ON Blog
FOR EACH ROW
    BEGIN
        DECLARE new_ad_count INT;
        SET new_ad_count = (SELECT COUNT(*) from Blog WHERE Blog = Blog);
        UPDATE Post SET new_ad_count = new_ad_count WHERE blog_id = Blog;
	END$$
    -- Meesage: 0 row(s) affected

-- Stored procedures

-- implement procedure to get the titles of all video multimedia 

DELIMITER $$
CREATE PROCEDURE VIDEO_MULTIMEDIA (In Video VARCHAR(45))
	BEGIN
		SELECT Video.title As "title",
        CONCAT (Multimediaa.type, " ", Multimedia.lifetime) AS "File" FROM Multimedia
        JOIN Video ON Video.video_id = Multimedia.multimedia_id; 
        
        END $$
        -- Meesage: 0 row(s) affected
	DELIMITER ;

-- implement procedures to get the comments from all posts 

-- Stored functions INC

-- Create a function that returns the number of posts containing advertisements
 
-- Create a function that returns the number of blogs that have been commented on 

-- Updates that include "JOINS" in the same query  DONE

-- Update a user’s account to prime account 

Update Users usr INNER JOIN `Prime Account` pA
ON usr.user_id = pA.prime_account_id
SET user_id = prime_account_id, usr.first_name = "Joe";

-- -- Message: 3 row(s) affected Rows matched: 3  Changed: 3  Warnings: 0


--  Update automatically the tag for a category when new blogs are created
Update `Tag` tag RIGHT JOIN `Category` cat
ON  cat.category_id = tag.tag_id 
SET tag.tag_id = cat.category_id, tag.tag_count = tag.tag_count + 1; 
-- Message: 3 row(s) affected Rows matched: 3  Changed: 3  Warnings: 0


-- Delete data (ON CASCADE) from at least two tables DONE 

-- A user no longer wishes to use our database, delete account and user 

DELETE `Account` FROM `Account` INNER JOIN Users ON Account.account_id = Users.user_id; 
-- Message: 3 row(s) affected

-- A video no longer exists in our system, delete existence in video table and multimedia table 

DELETE Multimedia FROM Multimedia INNER JOIN Video ON Multimedia.multimedia_id = Video.video_id; 
-- Message: 3 row(s) affected