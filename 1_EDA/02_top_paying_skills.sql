/*
 **Question: What are the highest-paying skills for data Scientist?** 

- Calculate the median salary for each skill required in data scientist positions
- Focus on jobs in the united states with specified salaries ( doesent matter if remote or not )
- Include skill frequency to identify both salary and demand
- Why?
    - Helps identify which skills command the highest compensation while also showing how common those skills are, providing a more complete picture for skill development priorities.
    - The median is used instead of the average to reduce the impact of outlier salaries.
*/
SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(sd.skills) AS skill_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Scientist'
    AND jpf.salary_year_avg IS NOT NULL
    AND jpf.job_location =  'United States' 
GROUP BY
    skills
 HAVING
    COUNT(sd.skills) >= 50
ORDER BY
    -- median_salary DESC ,
    COUNT(sd.skills) DESC
LIMIT 10;

/*

─────────┬───────────────┬─────────────┐
│ skills  │ median_salary │ skill_count │
│ varchar │    double     │    int64    │
├─────────┼───────────────┼─────────────┤
│ python  │      131000.0 │         307 │
│ sql     │      118000.0 │         263 │
│ r       │      125327.0 │         180 │
│ tableau │       95273.0 │         126 │
│ sas     │      122500.0 │          74 │
│ aws     │      125000.0 │          71 │
│ spark   │      127550.0 │          65 │
│ sap     │       75000.0 │          59 │
│ oracle  │       75000.0 │          57 │
│ java    │      144500.0 │          54 │
├─────────┴───────────────┴─────────────┤
│ 10 rows                     3 columns │
└───────────────────────────────────────┘
*/