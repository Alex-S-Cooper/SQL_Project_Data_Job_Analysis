SELECT  
    job_id
,   job_title
,   job_location
,   job_schedule_type
,   salary_year_avg
,   job_posted_date
,   cd.name AS company_name
FROM job_postings_fact jpf
LEFT JOIN company_dim cd ON cd.company_id = jpf.company_id
WHERE jpf.job_title_short = 'Data Analyst'
    AND jpf.salary_year_avg IS NOT NULL
    AND jpf.job_work_from_home = TRUE
ORDER BY jpf.salary_year_avg DESC
LIMIT 10