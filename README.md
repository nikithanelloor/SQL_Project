#  ScienceQtech Employee Performance Mapping (SQL)

A database-driven HR analytics project enabling ScienceQtech to assess employee performance, salary structures, project alignment, and training needs ahead of annual appraisals.

---

##  Project Overview  
ScienceQtech is a data science startup involved in fraud detection, healthcare analytics, self-driving cars, and drug discovery. As their Junior DBA, you're tasked with extracting actionable insights from employee and project data to aid HR's appraisal and training decisions.

---

##  Objectives  
- Compute **maximum and minimum salaries** per role to ensure pay equity  
- Analyze **performance ratings** to identify top and low performers  
- Determine **bonus costs** using: `bonus = salary × performance_rating × 5%`  
- Validate **job-role alignment** using experience-based standards (Junior to Manager tiers)  
- Improve database performance using indexing and query optimization  
- Provide specialized reports for the **Data Science team**  

---

##  Dataset Description

1. **emp_record_table**  
   - EMP_ID, NAME, GENDER, ROLE, DEPT, EXP, COUNTRY, CONTINENT, SALARY, EMP_RATING, MANAGER_ID, PROJ_ID

2. **proj_table**  
   - PROJECT_ID, PROJ_NAME, DOMAIN, START_DATE, CLOSURE_DATE, DEV_QTR, STATUS

3. **data_science_team**  
   - Subset of `emp_record_table` focusing on Data Science employees

---

##  Methodology & Tasks Performed

1. **Database Schema & ER Diagram**  
   - Created `employee` database  
   - Imported CSVs into tables  
   - Designed ER diagram with keys and relationships  
2. **Core Queries & Reporting**  
   - Fetched employee details, segmented by rating tiers (<2, 2–4, >4)  
   - Concatenated names for Finance employees  
   - Identified managers and report counts  
   - Queried healthcare/finance teams using UNION  
   - Computed max/min salaries, and ranked employees by experience  
   - Created views and nested queries for high-salary and experienced staff  
3. **Procedural SQL & Functions**  
   - Developed stored procedures (e.g., experience > 3 years)  
   - Created stored function to check job-role standards (Junior → Manager based on EXP)  
4. **Performance Optimization**  
   - Added indexes (e.g. on FIRST_NAME) and compared execution plans  
5. **Cost & Distribution Analysis**  
   - Calculated bonus per employee based on salary and rating  
   - Reported average salary by country and continent  
6. **Data Science Team Focus**  
   - Calculated average metrics (salary, rating, experience) for Data Science staff
     
##  Key Insights

- Some **roles exceed expected salary ranges**, highlighting compensation review needs  
- Several employees with **low ratings and high salaries** may benefit from training  
- Calculated **bonus costs by department**—helpful for HR budget planning  
- **Data Science team overview** revealed average tenure, salary, and performance metrics for targeted coaching

---

##  Recommendations

1. **Adjust compensation tiers** based on max/min salary outputs  
2. **Launch targeted training** for employees with low ratings and high salaries  
3. **Standardize job-role alignment** using the stored function for consistency  
