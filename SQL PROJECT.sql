
--QUESTIONS
 
1./*What is the genger breakdown of employees in the company?*/
select gender, count(*) as count
from hr
where age >= 18 and termdate = '0000-00-00'
group by gender;

2./*What is the race/ethnicity breakown of emlpoyees in the company?*/
select race, count(*) as count
from hr
where age >= 18 and termdate = '0000-00-00'
group by race
order by count(*) desc;

3./*What is the age disrubution in the company?*/
select 
   min(age) as youngest,
   max(age) as oldest
from hr
where age >= 18 and termdate = '0000-00-00';

SELECT 
    CASE 
     WHEN age>= 18 and age<=24 then'18-24'
     WHEN age>= 25 and age<=34 then'25-34'
     WHEN age>= 35 and age<=44 then'35-44'
     WHEN age>= 45 and age<=54 then'45-54'
     WHEN age>= 55 and age<=64 then'55-64'
     else '65+'
	END AS age_group,
    count(*) as count
FROM hr
where age >= 18 and termdate = '0000-00-00'
group by age_group
order by age_group;

SELECT 
    CASE 
     WHEN age>= 18 and age<=24 then'18-24'
     WHEN age>= 25 and age<=34 then'25-34'
     WHEN age>= 35 and age<=44 then'35-44'
     WHEN age>= 45 and age<=54 then'45-54'
     WHEN age>= 55 and age<=64 then'55-64'
     else '65+'
	END AS age_group, gender,
    count(*) as count
FROM hr
where age >= 18 and termdate = '0000-00-00'
group by age_group, gender
order by age_group,gender;

 4./*How many employees work at headquater versus remote location?*/
select location, count(*) AS count
from hr
where age >=18 and termdate = '0000-00-00'
group by location;

5/*What is the average length of employmnet for employee who have been terminated?*/
SELECT 
    round(avg(datediff(termdate,hire_date))/360,0) as avg_length_employment
from hr
where termdate <= curdate() and termdate <> '0000-00-00'and age >=18;

6./*How does the gender distribution vary across departments and job titles?*/
select department, gender, count(*) as count
from hr
where age >= 18 and termdate = '0000-00-00'
group by department,gender
order by department;

7./*What is the distribution of job title across the company?*/
select jobtitle, count(*) as count
from hr
where age >= 18 and termdate = '0000-00-00'
group by jobtitle
order by jobtitle desc;

8./*Which department have the highest turnover rate?*/
select department,
   total_count,
   terminated_count,
   terminated_count/total_count as termination_rate
from(
  select department,
  count(*) as total_count,
  sum(case when termdate <> '0000-00-00' and termdate <= curdate() then 1 else 0 end) as termination_rate
  from hr
  where age>=18
  group by department
  ) as subquery
order by termination_rate desc;