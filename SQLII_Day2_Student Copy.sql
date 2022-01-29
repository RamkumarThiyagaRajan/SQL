create database inclass2;
use inclass2;

-- --------------------------------------------------------------
# Dataset Used: wine.csv
-- --------------------------------------------------------------

SELECT * FROM wine;

# Q1. Rank the winery according to the quality of the wine (points).-- Should use dense rank

SELECT winery,points,DENSE_RANK() OVER( ORDER BY points DESC ) WINE_RANK
FROM wine;

# Q2. Give a dense rank to the wine varities on the basis of the price.

SELECT winery,price,DENSE_RANK() OVER( ORDER BY price DESC ) WINE_PRICE
FROM wine;

# Q3. Use aggregate window functions to find the average of points for each row within its partition (country). 
-- -- Also arrange the result in the descending order by country.

select country,AVG(POINTS) OVER(partition by COUNTRY) AVG_POINTS
FROM wine
group by country
order by country DESC;

-----------------------------------------------------------------
# Dataset Used: students.csv
-- --------------------------------------------------------------

# Q4. Rank the students on the basis of their marks subjectwise.
SELECT *,dense_rank() OVER(partition by subject order by marks DESC) STD_RANK
FROM students;

# Q5. Provide the new roll numbers to the students on the basis of their names alphabetically.
SELECT row_number() over(order by NAME )'S.NO',name from students;


# Q6. Use the aggregate window functions to display the sum of marks in each row within its partition (Subject).
SELECT student_id,name,subject,SUM(marks) OVER(partition by subject) SUM_MARKS,MARKS
FROM students;

# Q7. Display the records from the students table where partition should be done 
-- on subjects and use sum as a window function on marks, 
-- -- arrange the rows in unbounded preceding manner.
/*select subject,marks,sum(marks) over(partition by subject  rows between unbounded 
preceding and current row) TOTAL
from students;*/#RUNNING TOTAL FOR CURRENT PARTITION

select subject,marks,sum(marks) over(partition by subject order by marks rows between unbounded 
preceding and current row) TOTAL
from students;


# Q8. Find the dense rank of the students on the basis of their marks subjectwise. Store the result in a new table 'Students_Ranked'
CREATE TABLE STUDENTS_RANKED
AS
SELECT student_id,name,subject,dense_rank() OVER(PARTITION BY subject ORDER BY marks DESC) RNK
FROM students;
-----------------------------------------------------------------
# Dataset Used: website_stats.csv and web.csv
-----------------------------------------------------------------
# Q9. Show day, number of users and the number of users the next day (for all days when the website was used)
SELECT website_id,DAY,no_users,LEAD(no_users) OVER(partition by website_id order by day) LEAD_USERS FROM website_stats;


# Q10. Display the difference in ad_clicks between the current day and the next day for the website 'Olympus'
#ad_clicks-LEAD(ad_clicks)
select day, ad_clicks, lead(ad_clicks) over (order by day) LEAD_VAL, ad_clicks-lead(ad_clicks) over(order by day) as diff
from website_stats
where website_id=1;



# Q11. Write a query that displays the statistics for website_id = 3 such that for each row, show the day, the number of users and the smallest number of users ever.
SELECT day,no_users,min(no_users) OVER() MIN_USER #over(partition by website_id order by day)
FROM website_stats
WHERE website_id = 3;

SELECT day,no_users,first_value(no_users) OVER(order by no_users ASC) MIN_USER #over(partition by website_id order by day)
FROM website_stats
WHERE website_id = 3;

# Q12. Write a query that displays name of the website and it's launch date. The query should also display the date of recently launched website in the third column.
SELECT name,launch_date, max(launch_date) over() RECENTLY_LAUNCH
FROM web;


-----------------------------------------------------------------
# Dataset Used: play_store.csv and sale.csv
-----------------------------------------------------------------
SELECT *,NTILE(10) OVER() AS GRUP_NO
FROM employees;
# Q13. Write a query thats orders games in the play store into three buckets as per editor ratings received  
SELECT *,ntile(3) OVER(ORDER BY editor_rating DESC)
FROM play_store;

# Q14. Write a query that displays the name of the game, the price, the sale date and the 4th column should display 
# the sales consecutive number i.e. ranking of game as per the sale took place, so that the latest game sold gets number 1. Order the result by editor's rating of the game
select ps.name, price, date,editor_rating, row_number() over (order by date desc) as RNK
from sale s 
join play_store ps
on s.id=ps.id
order by editor_rating;

# Q15. Write a query to display games which were both recently released and recently updated. For each game, show name, 
#date of release and last update date, as well as their rank
#Hint: use ROW_NUMBER(), sort by release date and then by update date, both in the descending order
select id, name, released, updated, row_number() over(order by released desc, updated desc)
from play_store;

-----------------------------------------------------------------
# Dataset Used: movies.csv, customers.csv, ratings.csv, rent.csv
-----------------------------------------------------------------
# Q16. Write a query that displays basic movie informations as well as the previous rating provided by customer for that same movie 
# make sure that the list is sorted by the id of the reviews.

select distinct m.id, m.title, m.release_year,m.genre, m.editor_rating ,lag(r.rating) over(order by m.id) LAG_VAL
from movies m
join ratings r
on m.id = r.movie_id;

# Q17. For each movie, show the following information: title, genre, average user rating for that movie 
# and its rank in the respective genre based on that average rating in descending order (so that the best movies will be shown first).
select title,genre,rating,dense_rank() over(order by rating)
from
(select title,genre,r.rating,avg(r.rating) as avg_rating
from movies m
join ratings r
on m.id=r.id
group by title)a;

# Q18. For each rental date, show the rental_date, the sum of payment amounts (column name payment_amounts) from rent 
#on that day, the sum of payment_amounts on the previous day and the difference between these two values.
select rental_date,payment_amount,lag(payment_amount) over(partition by rental_date),payment_amount-lag(payment_amount) over(partition by rental_date)
from
(select rental_date,sum(payment_amount) payment_amount
from rent
group by rental_date)a;



