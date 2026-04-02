create database social_media_database;
use social_media_database;
create table users(
user_id INT  primary key ,
username VARCHAR(50) ,
email VARCHAR(50)    ,
join_date DATE
);
create table posts(
post_id INT primary key ,
user_id INT ,
content TEXT ,
post_date DATETIME
);
create table likes(
like_id INT primary key ,
user_id INT ,
post_id INT ,
like_date DATETIME
);
create table comments(
comment_id INT primary key ,
post_id INT ,
user_id INT ,
comment_text TEXT ,
comment_date DATETIME
);
create table friendships(
friendship_id INT primary key ,
user_id1  INT ,
user_id2 INT ,
since_date DATE
);
#Task 1:
#Retrieve all posts along with the username of the author.
#Find all comments on each post along with the commenter’s username.
select p.post_id , u.username, p.content , p.post_date   from posts as p left join users as u on
p.user_id = u.user_id;
select c.comment_id ,u.username , c.comment_text , c.comment_date , p.post_id ,p.content from comments as c left join
 posts p on c.user_id = p.user_id left join users as u on
 c.user_id = u.user_id;
#Task 2:
#Find the top 3 users with the most posts.
#Retrieve posts that have more likes than the average number of likes per post.
#Find users who have never posted anything but have liked posts.
select u.user_id , u.username , count(p.post_id) as total_posts from users as u left join posts as p on
u.user_id = p.user_id group by u.user_id,u.username order by total_posts desc limit 3 ;
SELECT 
    p.post_id, 
    p.content, 
    p.post_date, 
    COUNT(l.like_id) AS total_likes
FROM posts AS p
LEFT JOIN likes AS l 
    ON p.post_id = l.post_id 
GROUP BY 
    p.post_id, p.content, p.post_date 
HAVING COUNT(l.like_id) > (
    SELECT AVG(like_count) 
    FROM (
        SELECT COUNT(like_id) AS like_count 
        FROM likes 
        GROUP BY post_id
    ) AS avg_table
);
#Find users who have never posted anything but have liked posts.
select u.username , u.user_id from users as u left join posts as p on 
u.user_id = p.user_id left join likes as l on
u.user_id = l.user_id
where p.post_id is null; 
#Get a list of all friends of a specific user (say user_id = 3).
select f.friendship_id , f.user_id1 , f.user_id2 , f.since_date , u.username from friendships as f left join users as u
on f.user_id1 = u.user_id or f.user_id2 = u.user_id where f.user_id1 = 3 or f.user_id2 = 3;
#Retrieve posts that were liked by friends of a given user (nested join scenario).
SELECT 
    p.post_id,
    p.content,
    p.post_date
FROM posts p
JOIN likes l 
    ON p.post_id = l.post_id
JOIN (
    SELECT 
        CASE 
            WHEN user_id1 = 3 THEN user_id2
            ELSE user_id1
        END AS friend_id
    FROM friendships
    WHERE user_id1 = 3 OR user_id2 = 3
) AS f
ON l.user_id = f.friend_id;
DELIMITER $$
CREATE PROCEDURE GetUserActivity(IN userId INT)
BEGIN

    SELECT 
        (SELECT COUNT(*) 
         FROM posts 
         WHERE user_id = userId) AS total_posts,

        (SELECT COUNT(*) 
         FROM likes 
         WHERE user_id = userId) AS total_likes_given,

        (SELECT COUNT(*) 
         FROM likes l
         JOIN posts p 
            ON l.post_id = p.post_id
         WHERE p.user_id = userId) AS total_likes_received,

        (SELECT COUNT(*) 
         FROM comments 
         WHERE user_id = userId) AS total_comments;

END $$

DELIMITER ;
CALL GetUserActivity(3);
#Find the most influential user (the user whose posts have the highest total likes + comments).
SELECT 
    u.user_id,
    u.username,
    COUNT(DISTINCT l.like_id) + COUNT(DISTINCT c.comment_id) AS influencers_score
FROM users u
JOIN posts p 
    ON u.user_id = p.user_id
LEFT JOIN likes l 
    ON p.post_id = l.post_id
LEFT JOIN comments c 
    ON p.post_id = c.post_id
GROUP BY u.user_id, u.username
ORDER BY influencers_score DESC
LIMIT 1;