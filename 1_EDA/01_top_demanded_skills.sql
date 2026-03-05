/*
problem Statement 
**Question: What are the most in-demand skills for data Scientist?**

- Identify the top 10 in-demand skills for data Scientist
- Focus on jobs in the US and that are not remote work 
- **Why?**
    - Retrieves the top 10 skills with the highest demand in the US that are not remote work, 
    providing insights into the most valuable skills for data scientist seeking inperson or hybrid work 

*/

SELECT 
    sd.skills,
    COUNT(sjd.job_id) AS demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim  AS sjd 
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd 
    ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Scientist' 
    AND jpf.job_work_from_home = False
    AND jpf.job_location = 'United States'
GROUP BY
    sd.skills
ORDER BY
    demand_count DESC
LIMIT 10;
 

/*
┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ python     │         4187 │
│ sql        │         2952 │
│ r          │         2472 │
│ tableau    │         1316 │
│ sas        │         1194 │
│ aws        │         1007 │
│ spark      │          892 │
│ azure      │          703 │
│ java       │          680 │
│ tensorflow │          633 │
├────────────┴──────────────┤
│ 10 rows         2 columns │

└───────────────────────────┘