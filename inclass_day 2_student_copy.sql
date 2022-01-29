-- --------------------------------------------------------
# Datasets Used: cricket_1.csv, cricket_2.csv
-- cricket_1 is the table for cricket test match 1.
-- cricket_2 is the table for cricket test match 2.
-- --------------------------------------------------------
create database day2;
use day2;

# Q1. Find all the players who were present in the test match 1 as well as in the test match 2.
 select * FROM cricket_1
 UNION
 SELECT * FROM cricket_2;
 
# Q2. Write a query to extract the player details player_id, runs and player_name from the table “cricket_1” who
#  scored runs more than 50
SELECT Player_Id,Player_Name FROM cricket_1 WHERE RUNS>50;

# Q3. Write a query to extract all the columns from cricket_1 where player_name starts with ‘y’ and ends with ‘v’.
SELECT * FROM  CRICKET_1 
WHERE Player_Name LIKE 'y%v';

# Q4. Write a query to extract all the columns from cricket_1 where player_name does not end with ‘t’.
 SELECT * FROM  CRICKET_1 
WHERE Player_Name NOT LIKE '%T';
-- --------------------------------------------------------
# Dataset Used: cric_combined.csv 
-- --------------------------------------------------------

# Q5. Write a MySQL query to add a column PC_Ratio to the table that contains the divsion ratio 
# of popularity to charisma .(Hint :- Popularity divide by Charisma)
ALTER TABLE cric_combined ADD COLUMN PC_Ratio FLOAT;
UPDATE cric_combined SET PC_RATIO=(POPULARITY/CHARISMA);
desc cric_combined;

# Q6. Write a MySQL query to find the top 5 players having the highest popularity to charisma ratio.
select * from cric_combined order by  PC_RATIO DESC LIMIT 5;

# Q7. Write a MySQL query to find the player_ID and the name of the player that contains the character “D” in it.
select * from cric_combined where Player_Name like'%d%';

# Q8. Extract Player_Id  and PC_Ratio where the PC_Ratio is between 0.12 and 0.25.
select * from cric_combined WHERE PC_Ratio between 0.12 and 0.25;

-- --------------------------------------------------------
# Dataset Used: new_cricket.csv
-- --------------------------------------------------------
# Q9. Extract the Player_Id and Player_name of the players where the charisma value is null.
select * from new_cricket WHERE CHARISMA IS NULL;
 
# Q10. Write a MySQL query to display all the NULL values  in the column Charisma imputed with 0.
select *  from new_cricket where IFNULL(CHARISMA,0);
 
# Q11. Separate all Player_Id into single numeric ids (example PL1 to be converted as 1, PL2 as 2 , ... PL12 as 12 ).
select * from new_cricket;
select Player_Id,substr(Player_Id,3) as new_id 
 from new_cricket;
 select replace(Player_Id,'PL','') from new_cricket;
 
# Q12. Write a MySQL query to extract Player_Id , Player_Name and charisma where the charisma is greater than 25.
select * from new_cricket where Charisma>25;

-- --------------------------------------------------------
# Dataset Used: churn1.csv 
-- --------------------------------------------------------

# Q13. Write a query to display the rounding of lowest integer value of monthlyservicecharges and rounding of higher integer value of totalamount 
# for those paymentmethod is through Electronic check mode.

select  floor(MonthlyServiceCharges) and ceil(TotalAmount) from churn_details where PaymentMethod='Electronic check';


# Q14. Rename the table churn1 to “Churn_Details”.

rename table churn1 to Churn_Details;
select * from churn_details;

# Q15. Write a query to create a display a column new_Amount that contains the sum of TotalAmount and MonthlyServiceCharges.
alter table Churn_Details 
add column new_Amount float;
update Churn_Details set new_Amount=(TotalAmount+MonthlyServiceCharges);

# Q16. Rename column new_Amount to Amount.
alter table Churn_Details change new_Amount amount float;

# Q17. Drop the column “Amount” from the table “Churn_Details”.
alter table Churn_Details
drop amount;

alter table churn_Details
drop  amount;

# Q18. Write a query to extract the customerID, InternetConnection and gender 
# from the table “Churn_Details ” where the value of the column “InternetConnection” has ‘i’ 
# at the second position.
select *  from churn_details where InternetConnection like '_i%';

# Q19. Find the records where the tenure is 6x, where x is any number.
select * from churn_details where tenure like '6_';

# Q20. Write a query to display the player names in capital letter and arrange in alphabatical order along with the charisma, display 0 for whom the charisma value is NULL.
select upper(Player_Name),ifnull(charisma,0) from cricket_2 order by player_name;
/*
select
from
where condition
groupby condition
having condition
orderby column
limit
*/
