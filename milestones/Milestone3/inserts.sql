   -- Script name: inserts.sql
   -- Author:      Rai'd Muhammad
   -- Purpose:     insert sample data to test the integrity of this database system
   
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- the database used to insert the data into.
    Use SecondOne675; 
-- -----------------------------------------------------
-- SAMPLE INSERTS ON EXISTING TABLES
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Table `users`
-- -----------------------------------------------------
DELETE FROM `Users`;
INSERT INTO `Users` (user_id, first_name, last_name) 
VALUES 
(1, 'James', 'Brown'), 
(2, 'Bo', 'Jackson'), 
(3, 'Helsinki', 'guartem');

-- -----------------------------------------------------
-- Table `account`
-- -----------------------------------------------------
DELETE FROM `Account`;
INSERT INTO `Account` (account_id, username, password, user_id) 
VALUES 
(1, 'johnny5', 'brtnu685', 1), 
(2, 'swamisami', 'cqE2FFE435', 2), 
(3, 'carrotstick2', '45IKUM', 3);

-- -----------------------------------------------------
-- Table `multimedia`
-- -----------------------------------------------------
DELETE FROM multimedia;
INSERT INTO multimedia (multimedia_id, type, lifetime)
VALUES
(1, 'image', 365), 
(2, 'digital image', 250), 
(3, 'video', 300);
-- -- -----------------------------------------------------
-- Table `music`
-- -----------------------------------------------------
DELETE FROM `music`;
INSERT INTO `music` (music_id, title, type, description, multimedia_id)
VALUES 
  (1, 'DESPACITO', 'mp3', 'song about movement', 1),
  (2, 'Take me away','mp4','Video about partying all night', 3),
  (3,'electric shock','wav','image about electricity' ,2);
-- -----------------------------------------------------
-- Table `searches`
-- -----------------------------------------------------
DELETE FROM `Searches`;
INSERT INTO `Searches` (searches_id, searches_count, type)
VALUES 
  (3, 25, 'image'),
  (4, 3, 'video'),
  (5,8, 'music');
-- -----------------------------------------------------
-- Table `tag`
-- -----------------------------------------------------
DELETE FROM `Tag`;
INSERT INTO `Tag` (tag_id, tag_count, type, searches_id)
VALUES 
  (1, 6, 'image', 3),
  (2, 4, 'video', 4),
  (3, 10 , 'music', 5);
-- -----------------------------------------------------
-- Table `upgraded account`
-- -----------------------------------------------------
DELETE FROM `Upgraded_Account`; 
Insert INTO `Upgraded_Account` (upgraded_account_id, account_id)
VALUES 
(1,1),
(2,2),
(3,3);
-- -----------------------------------------------------
-- Table `upvote`
-- -----------------------------------------------------
DELETE FROM `Upvote`; 
Insert INTO `Upvote` (upvote_id, upvote_count, upvote_type, user_id)

VALUES
(1,12,'GOOD', 1),
(2,5,'GOOD', 1),
(3,11,'GOOD', 1),
(2,3,'AWESOME', 2),
(3, 6, 'BAD', 3); 
-- -----------------------------------------------------
-- Table `video`
-- -----------------------------------------------------
DELETE FROM `Video`; 
Insert INTO `Video` (video_id, title, description, type, multimedia_id)

VALUES
(1,'Party party','GOOD','wav', 1),
(2,3,'Wake the Sun up','mov', 2),
(3, 6, 'Down goes the floor','mp4', 3); 
-- -----------------------------------------------------
-- Table `product`
-- -----------------------------------------------------
DELETE FROM `Product`;
INSERT INTO `Product` (product_id,creation_date, name)
VALUES
(1,'2020-10-07', 'appliance'),
(6,'2021-11-04', 'electronic'),
(8,'2022-06-18','sonar');

-- -----------------------------------------------------
-- Table `devices`
-- -----------------------------------------------------
DELETE FROM `devices`;
INSERT INTO `devices` (devices_id, type , lifetime)
VALUES
(1,'smartphone', 365),
(2,'computer', 715),
(3,'smartwatch',80);



-- -- -----------------------------------------------------
-- -- Table `Runs On`
-- -- -----------------------------------------------------
DELETE FROM `Runs_On`;
INSERT INTO `Runs_On` (runs_on_id, products_id, devices_id)
VALUES
(1,1, 1),
(2,6, 2),
(3,8,3);


-- -- -----------------------------------------------------
-- -- Table `admin`
-- -- -----------------------------------------------------
DELETE FROM `admin`;
INSERT INTO `admin` (admin_id, `rank`, name, advertisement_id)
VALUES
(1,1, 'James Shuttlesworth', 1),
(2,3, 'Leroy jenkins', 5),
(3,5,'Minister Admin', 2);



-- -- -----------------------------------------------------
-- -- Table `articles`
-- -- -----------------------------------------------------
DELETE FROM `articles`;
INSERT INTO `articles` (article_id, title, body)
VALUES
(1,'Breaking news ', 'news about what happened today'),
(2,'Morgan Freeman lives to be 150', 'fountain of youth works wonders' ),
(3,'Kanye West deleted from all sites', 'no one wants to associate with ye');

-- -----------------------------------------------------
-- Table `Monitors`
-- -----------------------------------------------------
DELETE FROM `Monitors`;
INSERT INTO `Monitors` (monitors_id, admin_id, account_id, multimedia_id, advertisement_id, article_id)
VALUES
(1,1,1,1,1,5),
(2,2,2,2,2, 2),
(3,3,3,3,3,7);

-- -- -----------------------------------------------------
-- -- Table `advertisments`
-- -- -----------------------------------------------------

DELETE FROM `advertisements`;
INSERT INTO `advertisements` (advertisement_id, title, body)
VALUES
(1,'Bleach works wonders', 'advertisment from bleach company about bleach'),
(2,'Computers for sale ', 'many computers are going up for sale this fall' ),
(3,'laptop discounts', 'many discounts available near you for laptops'),
(5,'laptop ', 'many laptops'); 


-- -- -----------------------------------------------------
-- -- Table `blog`
-- -- -----------------------------------------------------
DELETE FROM `blog`;
INSERT INTO `blog` (blog_id, date_created, title, user_id, blogAmount)
VALUES
(1,'2020-10-04', 'Big BLog', 1, 4),
(2,'2020-10-05', 'Big BLogger Day', 1 , 3),
(3,'2020-10-06', 'Big Day Blog today', 1, 12),
(1,'2020-10-04', 'Lame Blog', 2, 2),
(2,'2020-10-05', 'Another Lame One', 2, 10),
(3,'2020-10-06', 'TooCoolForSchool', 2, 40),
(1,'2020-10-04', 'Blogging Life', 3, 32),
(2,'2020-10-05', 'Personal Blog', 3, 1),
(4,'2020-10-06', 'Nothing to Blog Today', 4, 13); 



-- -- -----------------------------------------------------
-- -- Table `category`
-- -- -----------------------------------------------------
DELETE FROM `category`;
INSERT INTO `category` (category_id, category_count, `type`)
VALUES
(1,7, 'Luxury'),
(2,8, 'Products' ),
(3,4, 'Media');


-- -- -----------------------------------------------------
-- -- Table `Report`
-- -- -----------------------------------------------------
DELETE FROM `Report`;
INSERT INTO `Report` (report_id, title,body, date_created)
VALUES
(1,'Blog Report: Products', 'Blog report about products','2021-10-06'),
(2,'Blog Report: stats', 'Stats on blog report ' ,'2022-1-04'),
(3,'Blog Report: Ads', 'Report on ads views','2022-08-08');

-- -----------------------------------------------------
-- Table `Contains`
-- -----------------------------------------------------
DELETE FROM `Contains`;
INSERT INTO `Contains` (contains_id, blog_id,tag_id, searches_id, category_id, report_id, account_id)
VALUES
(1,1,1,1,1,1,1),
(2,2,2,2,2,2,2),
(3,3,3,3,3,3,3);



-- -- -----------------------------------------------------
-- -- Table `comment`
-- -- -----------------------------------------------------
DELETE FROM `comment`;
INSERT INTO `comment` (comment_id, date_created, body, user_id)
VALUES
(1,'2019-03-04', 'This is a great photo', 1),
(2,'2019-10-10', 'Thanks for Posting ', 2),
(3,'2021-08-17', 'Ill share this later', 3);

-- -- -----------------------------------------------------
-- -- Table `company`
-- -- -----------------------------------------------------
DELETE FROM `company`;
INSERT INTO `company` (company_id,  company_name, account_id)
VALUES
(1,'McDs Industries', 1),
(2,'BKDeluxe', 2),
(3,'SFEnterprises', 3);

-- -- -----------------------------------------------------
-- -- Table `digital_image`
-- -- -----------------------------------------------------
DELETE FROM `digital_image`;
INSERT INTO `digital_image` (digital_image_id, `title`,  `description`, `type`,  multimedia_id)
VALUES
(1,'Silk image from silk collector', 'digital image about silk', '.vector', 1),
(2,'Roadways to travel in the summer', 'digital image about summer travel', '.raster', 2),
(2,'Cartoon drawing of barney and pooh', 'cartoon drawing', '.vector', 3),
(3,'image about electronics from 1980', '1980 Hard Drive', '.raster', 4);

-- -- -----------------------------------------------------
-- -- Table `Limited Account`
-- -- -----------------------------------------------------
DELETE FROM `Limited_Account`;
INSERT INTO `Limited_Account` (limited_account_id,  limited_account_period, subscription_duration, account_id)
VALUES
(1,20, 10, 1),
(2,30,20, 2),
(3,40, 30, 3),
(4,60, 40, 4);

-- -- -----------------------------------------------------
-- -- Table `photo`
-- -- -----------------------------------------------------
DELETE FROM `photo`;
INSERT INTO `photo` (photo_id,  `description`,`title`, `type`,  multimedia_id)
VALUES
(1,'Silk image from spiders', 'Silk Road', '.jpeg', 1),
(2,'Roadways to travel', 'Travel Location', '.pdf', 2),
(3,'Cartoon drawing of barney', 'Drawing ', '.png', 3),
(4,'image about electronics', 'Self Computer', '.jpg', 4);

-- -- -----------------------------------------------------
-- -- Table `post`
-- -- -----------------------------------------------------
DELETE FROM `post`;
INSERT INTO `post` (post_id, `title`, `body`, category_id)
VALUES
(1,'I like this media', 'songs a user enjoys',1),
(2,'Great selections', 'videos to walk to include...', 2),
(2,'Review of laptops', 'most of these laptops are in great shape',3),
(3,'Places to hike', 'I like to travel to Yosemite...',4);

-- -- -----------------------------------------------------
-- -- Table `Prime Account`
-- -- -----------------------------------------------------
DELETE FROM `Prime_Account`;
INSERT INTO `Prime_Account` (prime_account_id, prime_account_period, subscription_duration, account_id)
VALUES
(1,180, 3,1),
(2,60, 1, 2),
(3,30, 5,3);


-- -- -----------------------------------------------------
-- -- Table `privileges`
-- -- -----------------------------------------------------
DELETE FROM `privileges`;
INSERT INTO `privileges` (privileges_id, `rank`, `description`, user_id)
VALUES
(1,1, 'DBAdmin',1),
(2,2, 'NoAccess', 2),
(3,4, 'Write',4);

-- -- -----------------------------------------------------
-- -- Table `Registered User`
-- -- -----------------------------------------------------
DELETE FROM `Registered_User`;
INSERT INTO `Registered_User` (registered_user_id, `name`, `user_id`)
VALUES
(1,'Leroy Shuttlesworth', 3),
(2,'Riley Newton', 2 ),
(3,'Huey Roosevelt', 1);


-- -- -----------------------------------------------------
-- -- Table `Roles`
-- -- -----------------------------------------------------
DELETE FROM `Roles`;
INSERT INTO `Roles` (roles_id, `conditon`, theme,account_id)
VALUES
(1,'dbOwner', 'green', 4),
(2,'dbReader', 'yellow',1 ),
(3,'dbManager', 'blue',3);

-- -- -----------------------------------------------------
-- -- Table `Unregistered User`
-- -- -----------------------------------------------------
DELETE FROM `Unregistered_User`;
INSERT INTO `Unregistered_User` (unregistered_user_id, user_id)
VALUES
(1,1),
(2,2 ),
(3,5);












































































