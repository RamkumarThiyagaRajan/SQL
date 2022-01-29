CREATE SCHEMA IF NOT EXISTS Video_Games;
USE Video_Games;
SELECT * FROM Video_Games_Sales;

# 1. Display the names of the Games, platform and total sales in North America for respective platforms.

select name, platform, sum(NA_sales)over(partition by platform) from video_games_sales;

# 2. Display the name of the game, platform , Genre and total sales in North America for corresponding Genre as Genre_Sales,total sales for the given platform as Platformm_Sales and also display the global sales as total sales .
# Also arrange the results in descending order according to the Total Sales.

select name, platform, sum(Na_sales)over(partition by platform) as Platform_sales, genre, sum(na_sales)over(partition by genre) as Genre_sales, 
global_sales as total_sales from video_games_sales order by total_sales desc;

# 3. Use nonaggregate window functions to produce the row number for each row 
# within its partition (Platform) ordered by release year.

select *, row_number()over(partition by platform order by year_of_release desc) from video_games_sales; 

# 4. Use aggregate window functions to produce the average global sales of each row within its partition (Year of release). Also arrange the result in the descending order by year of release.
   
select name, platform, year_of_release, global_sales, avg(global_sales)over(partition by year_of_release rows between unbounded preceding and current row) as 'Running avg (Year wise)' from video_games_sales order by year_of_release;

# 5. Display the name of the top 5 Games with highest Critic Score For Each Publisher. 
select * from
(select name, publisher, critic_score, row_number()over(partition by publisher order by critic_score desc) as critic_rank from video_games_sales) t
where critic_rank < 5;

------------------------------------------------------------------------------------
# Dataset Used: website_stats.csv and web.csv
------------------------------------------------------------------------------------
select * from website_stats;
select * from web;

# 6. Write a query that displays the opening date two rows forward i.e. the 1st row should display the 3rd website launch date

select id, name, budget, launch_date,lead(l1)over() as '2_forward_date' from
(select *, lead(launch_date)over() as l1 from web) t;

# 7. Write a query that displays the statistics for website_id = 1 i.e. for each row, show the day, the income and the income on the first day.

select website_id, day, income, first_value(income)over(order by day asc) as "first_day_income" from website_stats;

-----------------------------------------------------------------
# Dataset Used: play_store.csv 
-----------------------------------------------------------------
# 8. For each game, show its name, genre and date of release. In the next three columns, show RANK(), DENSE_RANK() and ROW_NUMBER() sorted by the date of release.
select * from play_store;

select name, genre, released, rank()over(order by str_to_date(released, '%d-%m-%Y') desc) as release_rank, dense_rank()over(order by str_to_date(released, '%d-%m-%Y') desc) as release_dense_rank,
row_number()over(order by str_to_date(released, '%d-%m-%Y') desc) as 'release_row_no' from play_store;
