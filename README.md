
# Job Scanner ---an app for job seekers

# Web app concepts:


The original design that we would want to finish is a job recommendation system based on the keywords on the user’s resume. The employee could also lookup certain keywords in the user’s resume to find a potential good candidate. That design turned into a more sophisticated system that can take in a user’s resume instead of keywords searching, based on the instruction we accepted in this class. 

Better that our original idea, Job scanner can be one-of-a-kind job matching web app that benefit busy scholar and college graduate: it will take your resume in pdf or doc form, and output the recommended job lists on major job hunting website like Glassdoor that actually fits you the best. 

As for the employee panel, Job scanner will match the job description in pdf or doc form and match all the candidate in data files, also based on the similarity of the resume, it could lower the cost for HR to screen unmatched candidates.

For the rest of the panel, Job scanner will locate the user’s resume and analysis the weakness in it , including giving suggestion of missing keywords suggestion based on the job description of certain industry that user would like to work in. 

#### Front-end style and element design: Kevin
#### Test conduct and streamlit panel design: Ruchit
#### Data purify and processing : Chris
#### Test static page + employer panel back-end: Zihan
#### Data prediction + application panel back-end: Chi
#### Table insertion and visualization: Ziwei
#### Application model deployment and linking panel code: Kyle


# Test major procedure and result
(for pre-lease only)
Video record of test demo: https://youtu.be/Dr1AF8cRAeQ
Panels/new feature in final demo (please click the website to test it, these will be stable for a long time since the app instances is free): 
https://jobscanner.shinyapps.io/Scholar1/
https://jobscanner.shinyapps.io/emp2/


First install Ananconda, then:
### 1. download the release and replace it with the Chromed Driver in the pre-release .zip files, every single one of it.
Website: https://sites.google.com/a/chromium.org/chromedriver/ 
Choose one selenium webdriver that fit your system, this step is important because you will need it to scrape the data from Glassdoor:

![alt text](https://github.com/Capstone-Projects-2020-Fall/jobscanner/blob/master/test%20picture/Picture1.png)

### 2.In Anaconda, please set the environment first to bring all the drivers working:

![alt text](https://github.com/Capstone-Projects-2020-Fall/jobscanner/blob/master/test%20picture/Picture2.png)

### 3.choose R (r) and python (3.0+, must be python 3) version, give the new enviroment a name and hit create.
When it is done, open the Home on the left:

![alt text](https://github.com/Capstone-Projects-2020-Fall/jobscanner/blob/master/test%20picture/Picture3.png)

### 4.Then install the Rstudio, Jupyter notebook and Spyder under the environment you create just then (in this case mine is "demo")
Before we begin scrapping, we need to add python dependents into the environment like this:
Go back to anaconda, see the pic below, search "selenium" (also “numpy” and “pandas” and install it, then reopen the spyder and refresh)

![alt text](https://github.com/Capstone-Projects-2020-Fall/jobscanner/blob/master/test%20picture/Picture4.png)
![alt text](https://github.com/Capstone-Projects-2020-Fall/jobscanner/blob/master/test%20picture/Picture5.png)

### 5.Test result screenshots (front-end that shows the final product)

![alt text](https://github.com/Capstone-Projects-2020-Fall/jobscanner/blob/master/test%20picture/Picture6.png)
![alt text](https://github.com/Capstone-Projects-2020-Fall/jobscanner/blob/master/test%20picture/Picture7.png)
![alt text](https://github.com/Capstone-Projects-2020-Fall/jobscanner/blob/master/test%20picture/Picture8.png)
![alt text](https://github.com/Capstone-Projects-2020-Fall/jobscanner/blob/master/test%20picture/Picture9.png)
![alt text](https://github.com/Capstone-Projects-2020-Fall/jobscanner/blob/master/test%20picture/Picture10.png)
# known Bugs
(pre-lease version)

1. The application have dependency issue that currently works fine at local but cannot publish to the instances.
![alt text](https://github.com/Capstone-Projects-2020-Fall/jobscanner/blob/master/test%20picture/Picture11.png)
2. Back-end matching code works fine with local dataset that scrapped from Glassdoor.com, but have crashing/glitch issue from time to time when using the same updated dataset from Amazon RDS.

# Test Bugs and Issues
### Front- end may not compatible with different computer due to the environment settings, even though all the dependencies are installed correctlyby the 14 pages test instruction document in master repository. 
This is the feedback from our test group, currently we are working on solving the problem for good.
![alt text](https://github.com/Capstone-Projects-2020-Fall/jobscanner/blob/master/test%20picture/pic12.png)
![alt text](https://github.com/Capstone-Projects-2020-Fall/jobscanner/blob/master/test%20picture/pic13.png)

# Feature tested:

(Only for baby version pre-lease)

Front-end(written in R):

1. User can upload their resume successfully once the front-end pages pop up.
2. User can get preminary match scores by finding the similarity between their resume and job description
2. User can alternate the numbers of job lists they want to show in the main screen(e.g. Someone will only want to show 10 matched job opening, then it will only show 10 by choosing the scroll down list "10" on the left hand side.
3. User can update the job lists by searching with specific keywords appears in the job lists by type in the word in "seaching" on the rupper right.


Back-end(written in Python)

1. User can use selenium to web scrapping Glassdoor.com to get the job lists that they want to do the match later.
2. User can alternate the job lists they want to scrap by changing the job name parameter and job number paramenter in the data collection back-end code.
3. User can bypass the Glassdoor popout window and scrap the information without interrupting till finally the expected numbers of job lists finished collecting.

# Test Manual:
Please see the test manual in communication email/test manual in shared test drive folder/master repo

