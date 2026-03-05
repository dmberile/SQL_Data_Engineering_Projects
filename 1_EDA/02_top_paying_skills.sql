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
RESULTS 
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

TAKEAWAYS:
    - Java offers the highest median salary ($144,500) but lower demand (54),
      suggesting it's a high-value differentiator rather than a core requirement
    - Python is the strongest overall skill — top in both demand (307) AND
      strong salary ($131,000), making it the clearest priority for skill-building
    - SAP and Oracle appear frequently but have notably lower salary ceilings
      ($75,000) — likely tied to legacy/enterprise support roles rather than
      modern DS positions
    - Cloud (AWS) and big data (Spark) skills punch above their frequency in
      salary, signaling growing strategic value
    - Tableau's gap: high demand (126) but lower median ($95,273) suggests it
      is often a supporting skill rather than a primary hiring driver

 TABLES USED:
    - job_postings_fact  (aliased: jpf)
    - skills_job_dim     (aliased: sjd)
    - skills_dim         (aliased: sd)
*/