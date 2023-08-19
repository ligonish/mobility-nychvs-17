capture log close
clear all
prog drop _all
set more off
version 17.0
set linesize 80

capture log close
clear all
prog drop _all
set more off
version 17.0
set linesize 80

******************************************************************
* GENERATE ESTIMATES: 2017 NYC Housing & Vacancy Survey

* Occupied Unit Codebook: https://www2.census.gov/programs-surveys/nychvs/technical-documentation/record-layouts/2017/occupied-units-17.pdf 
*
* Vacant Unit Codebook: https://www2.census.gov/programs-surveys/nychvs/technical-documentation/record-layouts/2017/vacant-units-17.pdf
******************************************************************

use "data_build/smaller_cleaner_hvs_occvac_17.dta", clear
	
* Variables to generate:
	* how_long	simpler estimated tenure duration
	* owners & renters
	
* Within citywide, boro, & sb, gen owner & renter baseline mean:
	* race
	* poverty
	* income
	* moved_from (measured in pre-cooked dummies)
	* duration
	* why_moved
	* invol 		== 	1 if why_moved = involuntary
	* bldg/unit/neighborhood quality indicators
	* PUMA
	
* Still gotta fix some variables/value labels --------------------

gen renters = (sc116 == 2 | sc116 == 3)
replace sc185 = .a if sc185 == 8

gen duration = 2017 - yrmoved
		label variable duration "Number of years' tenure in unit" // 0= under 1 yr
			// 1,869 of 15,135 missing in raw data

gen races = 0
	replace races = 1 if race == 1
	replace races = 2 if race == 2
	replace races = 3 if race == 3 | race == 4
	replace races = 4 if race == 5
	replace races = 5 if race == 6 | race == 7
	replace races = . if races == 0

label define racesLabel ///
1 "White" ///
2 "Black" ///
3 "Hispanic/Latinx" ///
4 "Asian" ///
5 "Other"
label values races racesLabel

label define whymoveLabel ///
1 "Change in employment status" ///
2 "Looking for work" ///
3 "Commuting reasons" ///
4 "To attend school" ///
5 "Other financial/employement reason" ///
6 "Needed larger house or apartment" ///
7 "Widowed, separated/divorced, or family decreased" ///
8 "Newly married" ///
9 "Moved to be closer to relatives" ///
10 "Wanted to establish separate household" ///
11 "Other family reason" ///
12 "Wanted this neighborhood/better neighborhood" ///
13 "Other neighborhood reason" ///
14 "Wanted to own residence" ///
15 "Wanted to rent residence" ///
16 "Wanted greater housing affordability" ///
17 "Wanted better quality housing" ///
18 "Evicted, displaced, or harassment by landlord (self reported)" ///
19 "Other housing reason" ///
20 "Any other reason"
label values whymoved whymoveLabel

replace whymove = .a if whymove == 99
replace whymove = .b if whymove == 98

* Races as Binary Indicators
gen wh = 0
	replace wh = 1 if races == 1
	label variable wh "White"
	
gen bl = 0
	replace bl = 1 if races == 2
	label variable bl "Black"
	
gen hplx = 0
	replace hplx = 1 if races == 3
	label variable hplx "Hispanic/Latinx"
	
gen asn = 0
replace asn = 1 if races == 4
	label variable asn "Asian"
	
gen r_oth = 0
	replace r_oth = 1 if races == 5
	label variable r_oth "Other"

drop race

* Recode AMI benchmarks' "not calculated - 9+ persons in hh" value from numeric to missing
	replace il30per = .a if il30per == 99999
	replace il50per = .a if il50per == 99999
	replace il80per = .a if il80per == 99999

* Binary indicator for hh incomes <= HUD 30, 50, 80% limit @ size
	
gen hh_30AMI = 0
	replace hh_30AMI = 1 if hhinc <= il30per & occ == 1
	label variable hh_30AMI "Household income <= 30% HUD inc. limits for hh size"
	
gen hh_50AMI = 0
	replace hh_50AMI = 1 if hhinc <= il50per & occ == 1
	label variable hh_50AMI "Household income <= 50% HUD inc. limits for hh size"
	
gen hh_80AMI = 0
	replace hh_80AMI = 1 if hhinc <= il80per & occ == 1
	label variable hh_80AMI "Household income <= 80% HUD inc. limits for hh size"
	
* Categorical range for hhinc<AMI%s

gen hh_AMI = .
replace hh_AMI = 1 if hh_30AMI == 1 
replace hh_AMI = 2 if hh_50AMI == 1 & hh_30AMI == 0
replace hh_AMI = 3 if hh_80AMI == 1 & hh_30AMI == 0 & hh_50AMI == 0
		label variable hh_AMI "Household at or below HUD income limits for hh size"
	
label define amiLabel ///
1 "At or below 30% HUD income limit" ///
2 "At 31-50% HUD income limit" ///
3 "At 51-80% income limit"
label values hh_AMI amiLabel

tab hh_AMI, m

* GRAPHING ---------------------------------------------------------

* Create integer weight legible to Stata (see https://stats.idre.ucla.edu/stata/seminars/applied-svy-stata13/)

gen int_fw = int(fw)
	label variable int_fw "Final weight as integer: for Stata visualizations"

* HBar: NYC duration/race
	
graph hbar duration [fw = int_fw], over(races, gap(*1.5) sort(1) descending) ///
	graphregion(color(white)) ///
	bargap(20)	///
	bar(1, color(ebblue))	///
	bar(2, color(gold))		///
	intensity(*.8)	///
	ytitle("Years Lived in Current Unit") ///
	blabel(bar, format(%3.1f)) ///
	title("{bf:Mean NYC Householder Tenure Duration in 2017}", span)	///
	subtitle(`"2017 New York City Housing and Vacancy Survey"', size(small) span)	///
	name(RaceDurNYC)

* HBar: NYC duration within HCV households, over race	
graph hbar duration if sec8 ==1 [fw = int_fw], over(races, gap(*1.5) sort(1) descending) ///
	graphregion(color(white)) ///
	bargap(10)	///
	bar(1, color(ebblue))	///
	bar(2, color(gold))		///
	intensity(*.8)	///
	ytitle("Years Lived in Current Unit") ///
	blabel(bar, format(%3.1f)) ///
	title("{bf:Mean NYC Section 8 Tenure Duration in 2017}", span)	///
	subtitle(`"2017 New York City Housing and Vacancy Survey"', size(small) span)	///
	name(Sec8RaceDurNYC)

* Catplot?	
	
	
*so we're trying to show differences in this:
	svy, subpop(wh): prop whymoved, percent
	svy: prop lived_bef, percent

catplot whymoved if wh == 1 & sec8 == 1 [fw = int_fw], ///
	percent ///
	bar(1, color(ebblue))	///
	blabel(bar, format(%3.1f)) ///
	intensity(*.8)	///
	graphregion(color(white)) ///
	title("{bf:Why White Section 8 Householders Say They Moved to Their Current Unit}", span)	///
	name(whymovedS8Wh)
	
catplot whymoved if bl == 1 & sec8 == 1 [fw = int_fw], ///
	percent ///
	bar(1, color(ebblue))	///
	blabel(bar, format(%3.1f)) ///
	intensity(*.8)	///
	graphregion(color(white)) ///
	title("{bf:Why Black Section 8 Householders Say They Moved to Their Current Unit}", span)	///
	name(whymovedS8Bl)
	
catplot whymoved if hplx == 1 & sec8 == 1 [fw = int_fw], ///
	percent ///
	bar(1, color(ebblue))	///
	blabel(bar, format(%3.1f)) ///
	intensity(*.8)	///
	graphregion(color(white)) ///
	title("{bf:Why Hispanic/Latinx Section 8 Householders Say They Moved to Their Current Unit}", span)	///
	name(whymovedS8Hsplx)
	
catplot whymoved if wh == 1 & renters == 1 [fw = int_fw], ///
	percent ///
	bar(1, color(ebblue))	///
	intensity(*.8)	///
	graphregion(color(white)) ///
	title("{bf:Move Reason: White Renters}", span)	///
	ytitle("% of white renters", size(small))		///
	name(whymovedWh)

catplot whymoved if bl == 1 & renters == 1 [fw = int_fw], ///
	percent ///
	bar(1, color(ebblue))	///
	intensity(*.8)	///
	graphregion(color(white)) ///
	title("{bf:Move Reason: Black Renters}", span)	///
	ytitle("% of Black renters", size(small))				///
	name(whymovedBl)
	
catplot whymoved if hplx == 1 & renters == 1 [fw = int_fw], ///
	percent	///
	bar(1, color(ebblue))	///
	intensity(*.8)	///
	graphregion(color(white)) ///
	title("{bf:Move Reason: Hispanic/Latinx Renters}", span)	///
	ytitle("% of Hispanic/Latinx renters", size(small))				///
	name(whymovedHpLx)
	
catplot whymoved if sec8 == 1 & renters == 1 [fw = int_fw], ///
	percent ///
	bar(1, color(ebblue))	///
	intensity(*.8)	///
	graphregion(color(white)) ///
	title("{bf:Move Reason: Section 8 Renters}", span)	///
	legend(off)							///
	ytitle("% of Section 8 renters", size(small))				///
	name(whymovedSec8)
	
* Combine

graph combine whymovedWh whymovedBl whymovedHpLx
	
	// add -	var1opts(sort(1) descending) /// - to arrange in desc. freq.

/*Where do voucherholders move into?
catplot boro races if sec8 ==1 [fw = int_fw], percent(races) ///
	blabel(barformat(%2.1f)) ///
	graphregion(color(white)) ///
	title("{bf:Where Do Section 8 Householders Move To?}", span)	///
	name(Sec8From)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   

catplot lived_bef races if sec8 ==1 & lived_bef >=3 & lived_bef <= 7 [fw = int_fw], percent(races) ///
	blabel(barformat(%2.1f)) ///
	graphregion(color(white)) ///
	title("{bf:Where do Section 8 Householders Move From?}", span)	///
	name(Sec8To)


	
* Scatterplots
	// go recall why they're all these massively overplotted blobs?!
	
twoway (scatter duration rentbrd [fw = int_fw])

* Lollipop
	// via Statalist: 
		* sysuse auto, clear
		* encode make, g(obs) // just turns -make- string into numeric, who'da thunk
		* twoway dropline mpg obs, horizontal ylab(#72, value)
		
	// ok this is pretty promising:
*/	
graph dot duration if renters == 1 [fw = int_fw], over(puma, sort(1)descending label (labsize(tiny))) ///
title("{bf:NYC Renters' Average Years in Current Unit (2017)}", span) ///
graphregion(color(white)) 
*xtitle("mean renter tenure duration (years)")

