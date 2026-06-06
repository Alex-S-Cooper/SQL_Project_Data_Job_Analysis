WITH top_paying_jobs AS (
    SELECT  
        job_id
    ,   job_title
    ,   salary_year_avg
    ,   cd.name AS company_name
    FROM job_postings_fact jpf
    LEFT JOIN company_dim cd ON cd.company_id = jpf.company_id
    WHERE jpf.job_title_short = 'Data Analyst'
        AND jpf.salary_year_avg IS NOT NULL
        AND jpf.job_work_from_home = TRUE
    ORDER BY jpf.salary_year_avg DESC
    LIMIT 10
)

SELECT top_paying_jobs.*
,      skills
FROM top_paying_jobs
INNER JOIN skills_job_dim sjd ON top_paying_jobs.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id

/* The tutor uses ChatGPT to then get a count of the skills. 
   I though I would write an additional query to return the top 10 most common skills:
*/

WITH top_paying_jobs AS (
    SELECT  
        job_id
    ,   job_title
    ,   salary_year_avg
    ,   cd.name AS company_name
    FROM job_postings_fact jpf
    LEFT JOIN company_dim cd ON cd.company_id = jpf.company_id
    WHERE jpf.job_title_short = 'Data Analyst'
        AND jpf.salary_year_avg IS NOT NULL
        AND jpf.job_work_from_home = TRUE
    ORDER BY jpf.salary_year_avg DESC
    LIMIT 10
)

SELECT skills, COUNT(*) AS skill_count
FROM top_paying_jobs
INNER JOIN skills_job_dim sjd ON top_paying_jobs.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
GROUP BY skills
ORDER BY skill_count DESC
LIMIT 10