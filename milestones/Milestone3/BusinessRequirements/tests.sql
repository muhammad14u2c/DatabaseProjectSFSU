-- SET SQL_SAFE_UPDATES = 0;  MAY NEED TO UN COMMENT THIS LINE NOT 100%
-- COMMAND 1 
SELECT u.first_name AS FirstName, u.last_name AS LastName, u.user_id AS UserId, 
        COUNT(b.user_id) 
        AS userBlogPosts 
        FROM Users u
        INNER JOIN blog b ON u.user_id = b.user_id
        GROUP BY u.user_id 
        HAVING COUNT(b.user_id)>=2;
-- -- COMMAND 2
SELECT u.first_name AS firstName, u.last_name AS lastName, u.user_id AS UserId, AVG(b.blogAmount) AS TotalBlogAmount 
FROM Users u
INNER JOIN blog b ON u.user_id = b.blog_id
GROUP BY u.user_id;


-- -- COMMAND 3
SELECT DISTINCT ad.name AS adminName, ad.rank AS adminRank, ad.admin_id AS adminId, ad.advertisement_id AS adId
  FROM admin ad
  JOIN ( SELECT advertisement_id 
           FROM advertisements
          LIMIT 5
       ) adv
    ON adv.advertisement_id; 


-- COMMAND 4 FIND OUT WHEN ACCOUNT BEGAN SUBSCRIPTION
DROP FUNCTION IF EXISTS subrscription_length;
DELIMITER //

CREATE FUNCTION subrscription_length(sub int) RETURNS int DETERMINISTIC
BEGIN
 DECLARE sub2 int;
  Select current_date()into sub2;
  RETURN year(sub2)-(sub);
END 

//

DELIMITER ;

-- Command 5

Select prime_account_id AS primeAccountId, subrscription_length(subscription_duration) as 'subscribedSince' from Prime_Account;

DROP FUNCTION IF EXISTS categoryCount;
DELIMITER //
CREATE FUNCTION categoryCount(cat int) RETURNS int DETERMINISTIC
BEGIN
 DECLARE count int;
  Select cat into count;
  RETURN count;
END 

//

DELIMITER ;

Select category_id AS 'categoryId', type AS 'type', categoryCount(category_count) AS 'categoryCount'
FROM category
WHERE category_count > 4;


-- COMMAND 6 
DROP PROCEDURE IF EXISTS findRoles;
DELIMITER $$ 
CREATE PROCEDURE findRoles()
BEGIN
  SELECT a.account_id AS accountIdWithRoles, rol.theme AS theme, rol.conditon AS conditions
  FROM Account a 
  INNER JOIN Roles rol
  ON rol.account_id = a.account_id;
END$$
DELIMITER ; 

call findRoles;


-- COMMAND 7

DROP PROCEDURE IF EXISTS findDevices;
DELIMITER $$ 
CREATE PROCEDURE findDevices()
BEGIN
  SELECT rOn.devices_id AS deviceId, dev.type AS 'type', dev.lifetime AS lifetime
  FROM Runs_On rOn 
  INNER JOIN devices dev
  ON dev.devices_id = rOn.runs_on_id
  HAVING dev.lifetime > 85;
END$$
DELIMITER ; 

-- COMMAND 8 
SELECT article_id AS previousArticleId, monitors_id AS monitorsId FROM Monitors ;
 
UPDATE Monitors mon 
INNER JOIN articles art
SET mon.article_id = 8 
WHERE art.article_id = 3;

SELECT article_id AS newArticleId, monitors_id AS monitorsId FROM Monitors ; 


-- COMMAND 9 

SELECT upv.upvote_id AS upvoteID,  MAX(upv.upvote_count) AS UpVoteCount 
        FROM Upvote upv
        INNER JOIN Users u ON upv.upvote_id = u.user_id
        WHERE upv.upvote_count > 5 && upv.upvote_type="GOOD"
        GROUP BY  u.user_id
        HAVING MAX(upv.upvote_count)
        ORDER BY UpVoteCount DESC; 


-- COMMAND 10
Select multimedia_id AS multimediaID, `type` AS multimediaType FROM multimedia mul
WHERE multimedia_id IN
(SELECT multimedia_id FROM Monitors WHERE multimedia_id > 1); 


-- COMMAND 11 

SELECT lim.limited_account_period AS limitedAcoountPeriod, lim.account_id AS accountID
FROM Limited_Account lim
INNER JOIN Users u ON lim.limited_account_id = u.user_id
GROUP BY lim.account_id, lim.limited_account_id
HAVING MIN(lim.limited_account_period) < 45; 

-- Delete data (ON CASCADE) from at least two tables DONE 

-- A user no longer wishes to use our database, delete account and user 
DELETE `Account` FROM `Account` INNER JOIN Users ON Account.account_id = Users.user_id; 
-- Message: 3 row(s) affected

-- A video no longer exists in our system, delete existence in video table and multimedia table 

DELETE multimedia FROM multimedia INNER JOIN Video ON multimedia.multimedia_id = Video.video_id;

Update Users usr INNER JOIN `Prime_Account` pA
ON usr.user_id = pA.prime_account_id
SET user_id = prime_account_id, usr.first_name = "Joe";

-- -- Message: 3 row(s) affected Rows matched: 3  Changed: 3  Warnings: 0


--  Update automatically the tag for a category when new blogs are created
Update `Tag` tag RIGHT JOIN `category` cat
ON  cat.category_id = tag.tag_id 
SET tag.tag_id = cat.category_id, tag.tag_count = tag.tag_count + 1; 
-- Message: 3 row(s) affected Rows matched: 3  Changed: 3  Warnings: 0


SELECT COUNT(DISTINCT prime_account_id) AS cp
FROM `Prime_Account` pa JOIN post p ON p.post_id = pa.prime_account_id
WHERE pa.subscription_duration < 30 AND post_id = 0;

SELECT (post_id) AS pid, ( blog_id) AS bid
FROM Users usr
RIGHT JOIN `post`  ON user_id = usr.user_id RIGHT JOIN `blog` ON blog_id = usr.user_id
WHERE blog_id >=3;  