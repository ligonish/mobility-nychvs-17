capture log close
clear all
prog drop _all
set more off
version 17.0
set linesize 80

* UCLA IDRE Stata 17 Survey Data Analysis Tutorial --------------
* stats.idre.ucla.edu/stata/seminars/survey-data-analysis-in-stata-17/
* 10/29/21

* Load smaller dataset ------------------------------------------

use "data_build/smaller_cleaner_hvs_occvac_17.dta", clear

/* Get -svy- summary ---------------------------------------------

svydescribe

* Descriptive stats ---------------------------------------------

svy: mean yrmoved		// mean, se
estat sd				// mean, sd. don't need for project?
estat sd, var			// variance

svy: tab rent_st, missing count cellwidth(15) format (%15.2g)
						// includes missing & fixes e notation
						
svy: tab rent_st boro, col	
						// col proportions to within-boro totals
						
svy: proportion sec8	

* Subpopulation analysis ----------------------------------------

*	On why we can't just drop unneeded observations from survey sets in Stata estimations: "If the data set is subset (meaning that observations not to be included in the subpopulation are deleted from the data set), the standard errors of the estimates cannot be calculated correctly. When the subpopulation option is used, only the cases defined by the subpopulation are used in the calculation of the estimate, but all cases are used in the calculation of the standard errors."

*	As above, from Stata -svy- manual: "Use of if or in restrictions will not produce correct variance estimates for subpopulations in many cases.  To compute estimates forsubpopulations, use the subpop() option.  The full specification for subpop() is:
*			subpop([varname] [if])

* NOTE: "The -over- option is available ONLY for svy: mean, svy: proportion, svy: ratio and svy: total."

svy, subpop(if rent_st != 1): mean yrmoved	// if statement
* svy, over(rent_st): mean yrmoved			// same w/ over statemen
	// NB this was presented in the UCLA data but doesn't work here -- maybe bc categorical but not binary? retry w/ sec8 variable

svy: mean yrmoved, over(sec8)
	// OK this works; their syntax was just off
	
svy, subpop(sec8): mean yrmoved, over(boro cd) 	
	estat size		// weighted & unwtd no. observations per level

* Using Stata 17's new -lincom- command for subpop mean comparisons

svy: mean yrmoved, over(own)	// R 2006, O 1998
svy: mean yrmoved, over(own) coeflegend	// display coeff. legend
// see https://www.stata.com/manuals13/semsemreportingoptions.pdf
			// 1 =  _b[c.yrmoved@1bn.own]
			// 2 =	_b[c.yrmoved@9.own]

* What's the difference betw. owners & renters mean yrmoved?

lincom _b[c.yrmoved@9.own] - _b[c.yrmoved@1bn.own]
	// coeff: 8.085534   se: .2837289
	display 2005.779 - 1997.694 // check against earlier output
								// == 8.085	

* Same but over more categories: let's try boro

svy: total sec8		//  145499.1, se 6656.127
estimates table, b(%15.2f) se(%13.2f)								
matlist e(b), format(%15.2f)

svy, subpop(sec8): mean yrmoved, over(boro cd) 
estimates table, b(%15.2f) se(%13.2f)								
* matlist e(b), format(%15.2f) // thanks I hate it
*/
* Simple Graphing ----------------------------------------------
	// come back to this
	
* Something about integers
	// "the histogram command will only accept a frequency weight, which, by definition, can have only integer values. A suggestion by Heeringa, West and Berglund (2010, pages 121-122) is to simply use the integer part of the sampling weight."
	
gen int_fw = int(fw)
histogram yrmoved [fw = int_fw], bin(20)

* Wow not sure if I'm subsetting correctly but this is a whole mood
twoway (scatter hhinc yrmoved if own==9 [pw = fw]) 
	// this works, kinda (see note re: probably wrong subsetting for accurate estimates & fix later)
	// 
twoway (scatter hhinc yrmoved if own==9 & race == 1 [pw = fw], ///
	mcolor(purple%50) msymbol(Oh) graphregion(color(white))) ///
	(scatter hhinc yrmoved if own==9 & race != 1 [pw = fw], ///
	mcolor(gold%50) msymbol(Oh)graphregion(color(white)) ///
	legend(label (1 "White New Yorkers (n = ?)") label (2 "Non-White New Yorkers (n = ?)")) ///
	title("{bf:Income, Race, and Tenure Duration}", size (med)) ///
	subtitle("Source: NYCHVS 2017"))

graph hbar yrmoved [pw = fw], over(race)	
	
twoway (kdensity yrmoved if race == 1 [fw = int_fw]) (kdensity yrmoved if race!= 1 [fw = int_fw])
	// via https://www.statalist.org/forums/forum/general-stata-discussion/general/1466040-graphs-with-svy
	
	
/* 
twoway (scatter bpsystol bpdiast [pw = finalwgt]) ///
title("Systolic Blood Pressure" "v. Diastolic Blood Pressure")
f
Code for my MR'21 categorical scatterplot
twoway (scatter t_pcrent t_povrty if t_majblk, ///
	mcolor(purple%50) msymbol(Oh) graphregion(color(white))) ///
	(scatter t_pcrent t_povrty if t_majwhte, ///
	mcolor(gold%50) msymbol(Oh)graphregion(color(white)) ///
	legend(label (1 "Majority-Black (n = 2,085)") label (2 "Majority-White (n = 4,746)")) ///
	title("{bf:Impact of Poverty on Rental Tenure: by Tract Segregation}", size (med)) ///
	subtitle("Source: NNCS Sample of 9,593 Census Tracts in Large U.S. Cities c. 2000"))
*/	
	
	
	
	
/* Percentiles --------------------------------------------------
	// see https://www.stata.com/support/faqs/statistics/percentiles-for-survey-data/
	// or just download -epctile- Stata package, though a quick Google suggests people experience compatibility errors enough that I might not want to mess with it
	
summarize yrmoved [aweight=fw], detail	// median 2008, median 2003.164 (which matches earlier output)

bysort sec8: sum yrmoved [aweight=fw], detail	// sec8 median 2006, mean 2003.161 (matches earlier output)

bysort own: sum yrmoved [aweight=fw], detail	// owner/renter med
	// renter median: 2011, mean: 2005.779
	// owner median: 2001, mean: 1997.694
	
* Trying to generate a stable difference from median variable
summarize yrmoved [aweight=fw], detail
	scalar nyc_yrmoved_median = r(p50) 
	dis nyc_yrmoved_median

gen med_diff_move = yrmoved - nyc_yrmoved_median 
	// (1,869 missing values generated)
	
	