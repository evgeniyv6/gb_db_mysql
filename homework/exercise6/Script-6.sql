
select CONCAT(first_name, ' ', last_name) AS fullname from users where id = (
select from_user_id from (
select from_user_id, sum(1) msg_count from messages m where to_user_id =77 and 
	from_user_id in (SELECT friend_id from friendships f where user_id = 77)
	GROUP BY from_user_id order by msg_count desc
) as t limit 1 )
;


select sum(t.like_count) from (
select target_id, sum(1) like_count from likes where target_type_id= 
	(select id from target_types where name='users')
	GROUP by target_id
) as t where t.target_id in (select * from (select user_id from profiles order by birthday desc limit 10) as t2);



select gender, sum(1) like_count from profiles where user_id in 
(select user_id from likes l) group by gender order by like_count desc limit 1;


select t.user_id, sum(1) activity from (
(select user_id, sum(1) files_count from media m group by user_id order by files_count)
union all
(select user_id, sum(1) likes_count from likes l group by user_id order by likes_count)
union all
(select from_user_id, sum(1) msg_count from messages group by from_user_id order by msg_count)) as t 
GROUP by t.user_id order by activity limit 10;