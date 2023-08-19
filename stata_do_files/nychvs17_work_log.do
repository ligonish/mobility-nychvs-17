***********************************************************
*
* Work Log: 2017 NYC Housing & Vacancy Survey
* Housing & Land Use Seminar Project, F'21
*
***********************************************************


Workflow ---------------------------------------------------

- .csv as Stata file
- add replicate weights
- generate simpler Q&A tables using -svy- conditionals
	- export coefficients/summary data (outreg2 works I think)
- load Q&A tables into R
- gen visuals using R

- Workflow Questions:
		* weighted estimates playing well w/ specific R packages?
			* (should be ok if estimates already in import)


Q & A Tables to Build ---------------------------------------

Justin's:
	- concentrations of stabilized units, by borough & neighhborhood
	- correlations of stabilized units w/ poverty concentration, by borough
	- "how many ppl leave stabilized units each year, where they tend to go"
		* NB I'm a little baffled by sustained focus on rent stabilization in this context. Clarify.

Eliza's:
	- NYCHVS not useful source set for construction costs
	
Mine:
	
	* Divergence from NYC-wide renter mean:
	
	- Voucherholding households'
		- spatial concentration
		- duration of tenure
		- proximity of last neighborhood moved from
			- dummy out if necessary (ref Lance Freeman metric?): 
				- in boro, from within sb
				- in boro, from adjacent sb
				- in boro, non-adjacent sb
				- NYC
				- [tristate? check codebook for viability]	
				- beyond
		- gen mean estimates for ny_all, ny_own, ny_rent subsets 
		- subtract each sb's S8 estimate & graph variance
		
	- Also look @ voucherholding hh stats in comparison to non-voucherholding hh estimates @ similar demographic & income levels.
	



Visualizations -----------------------------------------------

- map sub-boroughs to PUMAs in 
	- presets within R -tidycensus- &/or R -tmap-
		- see paparkerstat.com/post/plotting-pumas-in-r/
		- or zevross.com/blog/2018/10/02/creating-beautiful-demographic-maps-in-r-with-the-tidycensus-and-tmap-packages/






Notes/Bugs ---------------------------------------------------

- RN I have only householder-generated unit estimates. Worth energy extending to pp estimates?

Random Crap

/* just because I don't want to retype all this:	
svy: mean duration if renters == 1, over(races) 	
	outreg2 using tables/citywide, excel replace ctitle (mean white renter dur)


svy: mean duration if renters == 1 & races == 2, over(races) 
	outreg2 using tables/citywide, excel append ctitle (mean dur Black renters)	

svy: mean duration if renters == 1 & races == 3, over(races) 
	outreg2 using tables/citywide, excel append ctitle (mean dur HspLtnx renters)	
													
svy: mean duration if renters == 1 & races == 4, over(races) 
	outreg2 using tables/citywide, excel append ctitle (mean dur Asian renters)	
													
svy: mean duration if renters == 1 & races == 5, over(races) 
	outreg2 using tables/citywide, excel append ctitle (mean dur otherrace renters)	

svy: mean duration if sec8 == 1 & races == 1, over(races) 	
	outreg2 using tables/citywide, excel append ctitle (mean dur white sec8)		
													
svy: mean duration if sec8 == 1 & races == 2, over(races) 
	outreg2 using tables/citywide, excel append ctitle (mean dur Black sec8)	

svy: mean duration if sec8 == 1 & races == 3, over(races) 
	outreg2 using tables/citywide, excel append ctitle (mean dur HspLtnx sec8)	
													
svy: mean duration if sec8 == 1 & races == 4, over(races) 
	outreg2 using tables/citywide, excel append ctitle (mean dur Asian sec8)	
													
svy: mean duration if sec8 == 1 & races == 5, over(races) 
	outreg2 using tables/citywide, excel append ctitle (mean dur otherrace sec8)	
*/
