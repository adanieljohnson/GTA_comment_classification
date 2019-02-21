
Session 7 (of 8) is this coming Monday (2/25). We're going to begin our meeting with 3 minutes for each person to briefly update everyone else on:

    The progress you've made since Session 6, and
    The next research/programming problem you're hoping to address.

Ideally, each of us will have an update posted to our websites before Monday, and our updates will be an opportunity to help focus the group's attention on the items of greatest interest to you. 

Following the updates, Jerid and Mike are going to walk us through one or more statistical approaches in R, with an eye to your various projects. We'll finish with some time spent updating our websites & projects.

With two remaining sessions, we might also begin to discuss our final project efforts (i.e. research proposal or pilot study project, and strategies for sharing out efforts). Our final session is March 18th, and final projects need to be turned in before the end of the term. 

I'm looking forward to seeing everyone on Monday.




####Confidentiality Problem
My initial dataset contains confidential information that needs to be de-identified. How do I convert the data so it can be displayed on a public site?

Most direct solution is to write bridge scripts. The versions that actually read my data in private repo. The public versions of these scripts would have 1+ empty placeholder spaces in the key commands that read in the data. Script documentation would explain how others can modify the bridge script file paths.

I assume that without correct system paths, outside users would not be able to access them. I can provide the de-identified data publicly, without exposing the confidential data. 

Any gaps or problems with this approach?

####\  

####Primary Data Keys For Structuring the Dataset?
These are values that are present already in the dataset.

*record.id*: Column is a semester ID and 5-digit number, like sp18.00001. This particular record.id indicates the data line is from Spring 2018 CSV file, and is line 00001 of the data table. This should be the unique primary key value for each record. Once assigned, it should not change.

*report.id*: Format is R\_nnn(...). The string is assigned to each entry made in Qualtrics. This particular string is assigned when a report is collected by our system. It is anonymous, and serves as a unique id for each REPORT document that we collect.

*student*: The email address of the SUBMITTING STUDENT. Unique to each student, and assigned by WFU. The email address connects multiple reports to a SINGLE STUDENT AUTHOR. It is NOT confidential though, so needs to be switched out. 

*ta*: The name of the TA assigning scores. Unique to instructor, and connects multiple reports scored by SINGLE TA. Again it is NOT confidential, so also needs to be switched out.

Strategy we decided is to create ing lists of non-repeating IDs with S\_nnn(...) = Student name, T\_nnn(...) = TA name. Then assign the names via a "mutate" and join by row_number function
* Using a global names generator to build 25K list of randomly generated non-repeating first_last names. In practice, random names are easier to scan for visually.   

####\  


####Miscellaneous To Do
* Need to review map, cast and bind commands again. Not sticking in my head.
* Try visualizing the 2-D array of the TA comments as a mosaic plot.

####\  


Target goal is to be able to assign TA comments to our pre-defined Subject and Structure sub-categories with >90% accuracy.

Basic Workflow



#Background
## Overview
I am interested in understanding how students develop technical writing skills in biology, and how we might improve that process by applying data science methods. 

My current NSF-sponsored project explores how scripted instruction, automated support, and holistic feedback can accelerate students' development as technical writers. Some of the specific questions we are asking:

*  What do instructors spend most of their effort on? Does this align with known best practices?
*  Is there a correlation between the structure and focus of instructors' comments, and how rapidly students' writing improves over time?

To answer these questions we must extract instructor comments from student writing, categorize those comments according to their subject and structure, then correlate the types of comments with student performance. 

My project for the R Faculty Learning Community was partly predictive in that I built a text classification workflow that automates the process of categorizing instructors' comments on student technical writing. My project also was (and continues to be) partly exploratory, in that I am asking: what additional information can be mined from TA comments, and how can those data inform our approaches to teaching technical writing? 




0. Index page
	Text of main page quickly outlines:
		Background, rationale
		Prior Work
		Project Goals
		Site Map

1. Background
	Text of main page focuses on:
		Student learning issues
		Goals and challenges
		Text Classification generally

	Branch and Supporting Pages focus on:
		Specific Text Classification information
		Classifier strategies


2. Initial Data Exploration
	Text of main page focuses on:
		Data Structure
		Initial Exploration of structure
		Features uncovered

	Branch and Supporting Pages focus on:
		Reference tables pages
		


3. Change Draft to Classifier
	Text of main page focuses on:
		Classifier method
		Structuring the data
		Iterative refinements
		Final model

	Branch and Supporting Pages focus on:
		
		


4. Change Project to Results/Findings
	Text of main page focuses on:
		Summary of initial exploration
		Show final NB table, comparison to original
		

	Branch and Supporting Pages focus on:
		
		


5. Add Next Steps
	Text of main page focuses on:
		Plans to improve method
		

	Branch and Supporting Pages focus on:
		
		

background	Background
pre_work	Data Exploration
draft		Classifier
project		Findings
nextsteps	Next Steps

# References

####\



Developing the code book.


