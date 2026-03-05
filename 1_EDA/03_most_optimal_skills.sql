/*
Question: What are the most optimal skills for data scientists—balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on Data Science positions in the United State with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately instead of letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical and valuable to learn for data engineering careers.
*/

SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 1) AS median_salary,
    COUNT(jpf.*) AS demand_count,
    ROUND(LN(COUNT(jpf.*)), 1) AS ln_demand_count,
    ROUND((LN(COUNT(jpf.*)) * MEDIAN(jpf.salary_year_avg))/100_000, 2) AS optimal_score
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Scientist'
    AND jpf.salary_year_avg IS NOT NULL
    AND jpf.job_location =  'United States' 
GROUP BY
    sd.skills
HAVING 
    COUNT(sjd.job_id) >= 50
ORDER BY
    optimal_score DESC
LIMIT 20;


/*
─────────┬───────────────┬──────────────┬─────────────────┬───────────────┐
│ skills  │ median_salary │ demand_count │ ln_demand_count │ optimal_score │
│ varchar │    double     │    int64     │     double      │    double     │
├─────────┼───────────────┼──────────────┼─────────────────┼───────────────┤
│ python  │      131000.0 │          307 │             5.7 │           7.5 │
│ sql     │      118000.0 │          263 │             5.6 │          6.58 │
│ r       │      125327.3 │          180 │             5.2 │          6.51 │
│ java    │      144500.0 │           54 │             4.0 │          5.76 │
│ aws     │      125000.0 │           71 │             4.3 │          5.33 │
│ spark   │      127550.0 │           65 │             4.2 │          5.32 │
│ sas     │      122500.0 │           74 │             4.3 │          5.27 │
│ azure   │      130000.0 │           50 │             3.9 │          5.09 │
│ excel   │      121815.5 │           52 │             4.0 │          4.81 │
│ tableau │       95272.5 │          126 │             4.8 │          4.61 │
│ sap     │       75000.0 │           59 │             4.1 │          3.06 │
│ oracle  │       75000.0 │           57 │             4.0 │          3.03 │
├─────────┴───────────────┴──────────────┴─────────────────┴───────────────┤
│ 12 rows                                                        5 columns │
└──────────────────────────────────────────────────────────────────────────
*/