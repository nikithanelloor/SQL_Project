-- Q1 Create a database named employee, then import data_science_team.csv, proj_table.csv and emp_record_table.csv into the employee database fromthe given resources.

create database employee;
use employee;
select * from data_science_team;
select * from emp_record_table;
select * from proj_table;

-- Q2 Create an ER diagram for the given employee database.
-- database -- reverse engineer--ER Diagram

-- Q3 Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and details of their department.

select emp_id,first_name,last_name,gender,dept 
       from emp_record_table 
       order by dept;

-- Q4 Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER,DEPARTMENT, and EMP_RATING if the EMP_RATING is:● less than two ● greater than four ● between two and four

 select emp_id,first_name,last_name,gender,dept,emp_rating,
 case 
 when emp_rating <=2 then 'low'
 when emp_rating <4 then 'avg'
 else 'high'
 end rating_status
 from emp_record_table ;
 
 -- Q5 Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department from the employee table and then give the resultant column alias as NAME.
 
 SELECT CONCAT(FIRST_NAME,' ',LAST_NAME) AS EMP_NAME 
       FROM EMP_RECORD_TABLE 
       WHERE DEPT='FINANCE';
 
 -- Q6 Write a query to list only those employees who have someone reporting to them. Also, show the number of reporters (including the President).
 
 SELECT  M.FIRST_NAME,COUNT(*) NO_REPORTERS 
        FROM EMP_RECORD_TABLE E JOIN EMP_RECORD_TABLE M 
		ON E.MANAGER_ID=M.EMP_ID 
		GROUP BY M.FIRST_NAME;

-- 7 Write a query to list down all the employees from the healthcare and finance departments using union. Take data from the employee record table.

SELECT * FROM EMP_RECORD_TABLE WHERE DEPT='HEALTHCARE'
UNION
SELECT * FROM EMP_RECORD_TABLE WHERE DEPT='FINANCE';

-- 8 Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept. Also include the respective employee rating along with the max emp rating for the department.

SELECT EMP_ID,FIRST_NAME,LAST_NAME,ROLE,DEPT,EMP_RATING,
       MAX(EMP_RATING) OVER(PARTITION BY DEPT) MAXRATING 
       FROM EMP_RECORD_TABLE;

-- Q9 Write a query to calculate the minimum and the maximum salary of the employees in each role. Take data from the employee record table.

SELECT ROLE,MIN(SALARY) MIN_SALARY,MAX(SALARY) MAX_SALARY 
       FROM emp_RECORD_TABLE GROUP BY ROLE;

-- Q10 Write a query to assign ranks to each employee based on their experience. Take data from the employee record table.

SELECT EMP_ID,FIRST_NAME,LAST_NAME,EXP,
        RANK() OVER(ORDER BY EXP DESC) RANKING 
        FROM EMP_RECORD_TABLE;

-- Q11 Write a query to create a view that displays employees in various countries whose salary is more than six thousand. Take data from the employee record table.

CREATE VIEW VIEW_EMP_SALARY_ABOVE6K AS
       SELECT EMP_ID,FIRST_NAME,LAST_NAME,SALARY,COUNTRY 
       FROM EMP_RECORD_TABLE 
       WHERE SALARY>6000 ORDER BY COUNTRY;

SELECT  * FROM VIEW_EMP_SALARY_ABOVE6K;

-- Q12 Write a nested query to find employees with experience of more than ten years. Take data from the employee record table.
SELECT * FROM EMP_RECORD_TABLE 
         WHERE EMP_ID IN(SELECT EMP_ID FROM EMP_RECORD_TABLE WHERE EXP>10);

-- Q13 Write a query to create a stored procedure to retrieve the details of the employees whose experience is more than three years. Take data from the employee record table.

SELECT * FROM EMP_RECORD_TABLE WHERE EXP>3;

USE `employee`;
DROP procedure IF EXISTS `EMPEXPABOVE3YR`;

DELIMITER $$
USE `employee`$$
CREATE PROCEDURE `EMPEXPABOVE3YR` ()
BEGIN
SELECT * FROM EMP_RECORD_TABLE WHERE EXP>3;
END$$

DELIMITER ;

CALL EMPEXPABOVE3YR;

-- Q 14 Write a query using stored functions in the project table to check whether the job profile assigned to each employee in the data science team matches the organization’s set standard.

SELECT * FROM DATA_SCIENCE_TEAM;

USE `employee`;
DROP function IF EXISTS `Check_JobProfiles`;

DELIMITER $$
USE `employee`$$
CREATE FUNCTION Check_JobProfiles (eid char(4)) 
RETURNS varchar(100) 
    DETERMINISTIC
BEGIN
	declare ex int;
    declare r varchar(80);
    declare vrole varchar(100);
    declare flag varchar(10);
    select exp, ROLE into ex, VROLE from data_science_team where emp_ID = eid;
  
		if ex > 12 and ex < 16 then
			if VROLE = 'MANAGER' then
				set flag = 'Yes';
			else
				set flag = 'No';
			end if;
			# set r = 'MANAGER';
		elseif ex > 10 and ex <= 12 then 
			if VROLE = 'LEAD DATA SCIENTIST' then
				set flag = 'Yes';
			else
				set flag = 'No';
			end if;
			#set r = 'LEAD DATA SCIENTIST';
		elseif ex > 5 and ex <=10 then 
			if VROLE = 'SENIOR DATA SCIENTIST' then
				set flag = 'Yes';
			else
				set flag = 'No';
			end if;
            #set r='SENIOR DATA SCIENTIST';
		elseif ex > 2 and ex <=5 then
			if VROLE = 'ASSOCIATE DATA SCIENTIST' then
				set flag = 'Yes';
			else
				set flag = 'No';
			end if;
			#set r = 'ASSOCIATE DATA SCIENTIST';
		elseif ex <= 2 then
			if VROLE = 'JUNIOR DATA SCIENTIST' then
				set flag = 'Yes';
			else
				set flag = 'No';
			end if;
            #set r = 'JUNIOR DATA SCIENTIST';
		end if;
	RETURN flag;
    END;$$

DELIMITER ;

SELECT *,Check_JobProfiles(Emp_ID) as Standard FROM data_science_team;

-- Q15 Create an index to improve the cost and performance of the query to find the employee whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan.

SELECT * FROM EMP_RECORD_TABLE WHERE FIRST_NAME='ERIC';

CREATE INDEX INDX_FIRSTNAME ON EMP_RECORD_TABLE(FIRST_NAME);
SELECT * FROM EMP_RECORD_TABLE WHERE FIRST_NAME='ERIC';

-- Q16 Write a query to calculate the bonus for all the employees, based on their ratings and salaries (Use the formula: 5% of salary * employee rating).

SELECT EMP_ID,FIRST_NAME,LAST_NAME,SALARY,EMP_RATING,
	   SALARY*0.5*EMP_RATING AS BONUS 
       FROM EMP_RECORD_TABLE;

-- 17 Write a query to calculate the average salary distribution based on the continent and country. Take data from the employee record table.

SELECT COUNTRY,CONTINENT,AVG(SALARY) AVERAGE_SALARY 
	   FROM EMP_RECORD_TABLE 
       GROUP BY CONTINENT,COUNTRY WITH ROLLUP;
