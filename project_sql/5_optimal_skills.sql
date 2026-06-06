WITH skills_demand AS (
    SELECT sd.skill_id, sd.skills, COUNT(sjd.job_id) AS skill_demand
    FROM job_postings_fact jpf
    INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
    WHERE jpf.job_title_short = 'Data Analyst' AND
        jpf.job_work_from_home = TRUE AND
        jpf.salary_year_avg IS NOT NULL
    GROUP BY sd.skill_id
) 
, average_salary AS (
    SELECT sd.skill_id, sd.skills, ROUND(AVG(jpf.salary_year_avg), 0) AS average_salary
    FROM job_postings_fact jpf
    INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
    WHERE jpf.job_title_short = 'Data Analyst' AND
        jpf.job_work_from_home = TRUE AND
        jpf.salary_year_avg IS NOT NULL
    GROUP BY sd.skill_id
)

SELECT skills_demand.skill_id
,      skills_demand.skills
,      skill_demand
,      average_salary
FROM skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
ORDER BY skill_demand DESC, average_salary DESC
LIMIT 25