# jobscanner

Waiting for the final check and personal repo merge, will notify test team once the web is up




# Web app concepts:


The original design that we would want to finish is a job recommendation system based on the keywords on the user’s resume. The employee could also lookup certain keywords in the user’s resume to find a potential good candidate. That design turned into a more sophisticated system that can take in a user’s resume instead of keywords searching, based on the instruction we accepted in this class. 

Better that our original idea, Job scanner can be one-of-a-kind job matching web app that benefit busy scholar and college graduate: it will take your resume in pdf or doc form, and output the recommended job lists on major job hunting website like Glassdoor that actually fits you the best. 

As for the employee panel, Job scanner will match the job description in pdf or doc form and match all the candidate in data files, also based on the similarity of the resume, it could lower the cost for HR to screen unmatched candidates.

For the rest of the panel, Job scanner will locate the user’s resume and analysis the weakness in it , including giving suggestion of missing keywords suggestion based on the job description of certain industry that user would like to work in. 

# known Bugs
(pre-lease version)

1. The application have dependency issue that currently works fine at local but cannot publish to the instances.
2. Back-end matching code works fine with local dataset that scrapped from Glassdoor.com, but have crashing/glitch issue from time to time when using the same updated dataset from Amazon RDS.

# Test Bugs and Issues
1. Front- end may not compatible with different computer due to the environment settings, even though all the dependencies are installed correctly by the 14 pages test instruction document in master repository. This is the feedback from our test group, currently we are working on solving the problem for good.
![alt text](https://github.com/Capstone-Projects-2020-Fall/jobscanner/blob/master/test%20picture/pic12.png)

![alt text](https://github.com/Capstone-Projects-2020-Fall/jobscanner/blob/master/test%20picture/pic13.png)

