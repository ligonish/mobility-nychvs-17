capture log close
clear all
prog drop _all
set more off
version 17.0
set linesize 80

use "cleaner_nychvs17", clear

***********************************************************************
* INITIAL EXPLORATION: 2017 NYC Housing & Vacancy Survey

* Codebook: https://www2.census.gov/programs-surveys/nychvs/technical-documentation/record-layouts/2017/occupied-units-17.pdf 

* Use of the Public Use Replicate Weight File:
* https://www2.census.gov/programs-surveys/nychvs/technical-documentation/variances/2017-NYCHVS-Guide-to-Estimating-Variances.pdf

* Sub-Boro Maps & Codes: https://www.census.gov/geographies/reference-maps/2017/demo/nychvs/sub-bourough-maps.html

* Glossary: https://www2.census.gov/programs-surveys/nychvs/about/glossary/gloss17.pdf

* 2017 Code Methodology Updates: https://www.census.gov/programs-surveys/nychvs/technical-documentation/rent-regulation-status.html

* Replicate weights and -svy- commands:
* https://usa.ipums.org/usa/repwt.shtml
* https//www.iser.essex.ac.uk/files/teaching/ec969/docs/Week2Lecture1_Worksheet.pdf

* "Where We Live NYC" for 2017 data crosschecks: https://www1.nyc.gov/assets/hpd/downloads/pdfs/wwl-plan.pdf

* also for data crosschecks: https://www.nber.org/system/files/working_papers/w25906/w25906.pdf

* UGH I CAN'T TAKE YOU STATA: http://asdfree.com/new-york-city-housing-and-vacancy-survey-nychvs.html
***********************************************************************

* Justin wants:

	* concentration of stabilized units by borough & neighhborhood
	* correlations of stabilized units w/ poverty concentration, by borough
	* "how many ppl leave stabilized units each year, where they tend to go"
	
	
* EXPLORE ---------------------------------------------------------

svy: mean yrmoved
	//Citywide mean: 2003
	
svy: mean yrmoved if own == 1
	//Citywide ownermean: 1998
	
svy: mean yrmoved if own == 9
	//Citywide rentermean: 2006

svy: mean yrmoved, subpop (if race == 2)	


svy: mean yrmoved, subpop (if race == 2 & own == 9) 
	//Black renter mean: 2004
	
svy: mean yrmoved, subpop (if race == 1 & own == 9)
	//White rentermean: 2006
	
svy: mean yrmoved, subpop (if race == 3 | race ==4 & own == 9)
	//Hisp rentermean: 2004

svy: mean yrmoved, subpop (if race == 3 | race ==4 & own == 9)
	//Sec8 rentermean: 2003

svy: mean yrmoved, over(race)

svy: mean yrmoved, over(boro)

svy: mean yrmoved, over(age)

svy: mean yrmoved, over(sc541)

svy: mean yrmoved, over(uf_csr)

svy: mean yrmoved if sc541 == 1, over(race) 
	// holy shit, is this accurate?

svy: mean yrmoved, over(uf_csr)	

svy: mean yrmoved if uf_csr == 80, over(boro)

svy: mean rentbrd if rentbrd >0 & rentbrd < 9999	// 44% citywide

svy: mean rentbrd if rentbrd >0 & rentbrd < 9999, over(boro) // Manhattan lowest @ 41%, Bronx highest @ 51%

svy: mean rentbrd if rentbrd >0 & rentbrd < 9999, over(race)







	
/*pwcorr race boro hhinc sec8 age sex yrmoved whymoved, star(.05)

bysort boro: tab yrmoved
bysort boro: tab whymoved	
bysort race: tab yrmoved
bysort race: tab whymoved
bysort age:  sum yrmoved
bysort sec8: sum yrmoved

 hist yrmoved if sec8==1
	
 hist yrmoved 
 
reg yrmoved i.race
reg yrmoved age
reg yrmoved sex // sex of householder, crucially, here. Fem HHers lived in their apts 2 yrs longer than men, on average. (@1% level)

tab whymoved if age<30
