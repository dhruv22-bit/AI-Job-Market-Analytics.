CREATE DATABASE AI_job_project ;

USE AI_job_project;

SELECT * FROM ai_job_market;

# Top Paying Roles
SELECT JobTitle 
,Round(AVG(Salary)) as Avg_Salary
FROM ai_job_market as a
GROUP BY JobTitle
ORDER BY Avg_Salary DESC;

# Salary By Experience Level
SELECT Round(AVG(Salary)) AS Avg_Salary,
Experience
FROM  ai_job_market as a
GROUP BY Experience
ORDER BY Avg_Salary DESC;

# Top Hiring Companies
SELECT Company,
COUNT(*) AS Total_jobs
FROM  ai_job_market as a
GROUP BY Company
ORDER BY Total_jobs DESC;

# Hiring Demand by Location
SELECT 
Location,
COUNT(*) AS Hiring_demand
FROM  ai_job_market as a
GROUP BY Location
ORDER BY Hiring_demand DESC;

# Remote vs Hybrid vs On-site
SELECT RemoteStatus,
COUNT(*) AS Total_jobs
FROM  ai_job_market as a
GROUP BY RemoteStatus
ORDER BY Total_jobs DESC;

#Rank Companies by Number of Openings
SELECT 
Company,
COUNT(*) as Total_hirings,
rank() OVER (ORDER BY COUNT(*) DESC) as Hiring_Rank
FROM ai_job_market as a
GROUP BY Company;

#Highest Paying Job in Each Location
SELECT
Location,
MAX(Salary) AS Highest_Salary
FROM ai_job_market
GROUP BY Location;

#Salary Percent Contribution by Role
SELECT
    JobTitle,
    SUM(Salary) AS Total_Salary,
    ROUND(
        SUM(Salary)*100.0 /
        (SELECT SUM(Salary) FROM ai_job_market),2
    ) AS Percentage
FROM ai_job_market
GROUP BY JobTitle;

#Company Hiring Share
SELECT
    Company,
    COUNT(*) AS Total_jobs,
    ROUND(
        COUNT(*)*100.0 /
        (SELECT COUNT(*) FROM ai_job_market),2
    ) AS Hiring_Share
FROM ai_job_market
GROUP BY Company
ORDER BY Total_jobs DESC;

#Experience Level Ranking by Salary
SELECT
    Experience,
    AVG(Salary) AS Avg_Salary,
    DENSE_RANK() OVER(
        ORDER BY AVG(Salary) DESC
    ) AS Salary_Rank
FROM ai_job_market
GROUP BY Experience;

# View of high paying jobs
CREATE VIEW High_Paying_job AS
SELECT *
FROM ai_job_market
WHERE Salary > 2000000;

SELECT * FROM High_Paying_job;
