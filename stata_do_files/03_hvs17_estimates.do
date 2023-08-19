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

* cd "/Users/Sarah/Desktop/HLU Mobility Stata/NYCHVS"

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
	
*************************************************************************	
*																		*
* 	CLEAN & GENERATE VARIABLES/VALUE LABELS 							*
*																		*
*************************************************************************

gen renters = (sc116 == 2 | sc116 == 3)	// renter hh subset	
replace sc185 = .a if sc185 == 8

gen duration = 2017 - yrmoved			// tenure duration
		label variable duration "Number of years' tenure in unit" // 0= under 1 yr
			// 1,869 of 15,135 missing in raw data

gen races = 0							// simpler race encoding
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

/* Binary indicator for hh incomes <= HUD 30, 50, 80% limit @ size // this is still buggy (did they subset renters?)
	
gen hh_30AMI = 0
	replace hh_30AMI = 1 if hhinc <= il30per & occ == 1
	label variable hh_30AMI "Household income <= 30% HUD inc. limits for hh size"
	
gen hh_50AMI = 0
	replace hh_50AMI = 1 if hhinc <= il50per & occ == 1
	label variable hh_50AMI "Household income <= 50% HUD inc. limits for hh size"
	
gen hh_80AMI = 0
	replace hh_80AMI = 1 if hhinc <= il80per & occ == 1
	label variable hh_80AMI "Household income <= 80% HUD inc. limits for hh size"
	
* Buckets for hhinc<AMI%s

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

* Rent burden

gen burden_30 = 0 if sc116 == 2 & occ == 1
	replace burden_30 = 1 if rentbrd >= 30 & sc116 == 2 & occ == 1
	label variable burden_30 "Gross rent >= 30% hh income"
	
gen burden_50 = 0 if occ == 1 & sc116 == 2
	replace burden_50 = 1 if rentbrd >= 50 & occ == 1 & renters == 1 & sc116 != 3
	label variable burden_50 "Gross rent >= 50% hh income"

	
 svy: prop burden_30, percent	// yup, still off -- trace encoding
*/
 
* Integer weight equivalents for -catplot- 

gen int_fw = int(fw)
	label variable int_fw "Final weight as integer: for Stata visualizations"

* Below fed poverty level flag

gen b_pov = 0 if occ == 1
	replace b_pov = 1 if rec39 == 1 & occ == 1
	label variable b_pov "Household below poverty level"

svy: total occ if b_pov == 1
	svy: total occ if b_pov == 1
	
* Evicted/Harrassed ------------------------------------------------------

* As indicator variable
gen evhar = 0 if occ == 1
replace evhar = 1 if whymoved == 18 & occ == 1

* Reported moving due to ev/harr: NYC
svy: total evhar	//NYC total: est.1326 hh moved due to eviction/harassment
svy: mean evhar		//NYC percent: .04% """""""

* Boro destination after being evicted/harrassed
 svy: total evhar, over(boro)	// total hh reporting move due to evhar
 svy: mean evhar, over(boro)	// % hh reproting move due to evhar
 
 * PUMA destination after being evicted/harassed
svy: total evhar, over(puma)	
svy: prop puma if evhar == 1	// SEs crazy high due to low observations - were people reluctant to name this as a reason? 

* Origin: where were hh originally evicted/harrassed out
svy: tab lived_bef if evhar == 1
svy: prop races if evhar ==1, over(lived_bef)

* Duration: how long have hhers lived in current unit if evicted from last one
svy: mean duration if whymoved == 18	// 1.62: mean dur if prev. evicted


* "Needed Greater Affordability" movers destinations -------------------------------

gen needaff = 0 if occ == 1
replace needaff = 1 if whymoved == 16 & occ == 1

* Reported moving due to need for affordability: NYC
svy: total needaff
svy: mean needaff

* Boro moved to when affordability cited (SUBSET BELOW POV?)
svy: total needaff, over(boro)	// total hh reporting move due to evhar
svy: mean needaff, over(boro)

* PUMA moved to when affordability cited
svy: total needaff, over(puma)
svy: prop puma if needaff == 1

* Origin: where were hh originally evicted/harrassed out
svy: tab lived_bef if needaff == 1

* Duration: how long have hhers lived in current unit if evicted from last one
svy: mean duration if needaff == 1	// 1.8 yrs mean dur if needaff -- but not esp. useful since this question only applied to moves within past 5 yrs

* Race breakdown of where ppl moved to they needed more affordability
svy: prop races if needaff ==1, over(boro)

* And where moved from if they needed affordability
svy: prop races if needaff ==1, over(lived_bef)
svy:
*/

* Moved Within Same Boro ------------------------------------------------------

gen boro_from = lived_bef if lived_bef >=3 & lived_bef <= 7
	replace boro_from = 1 if boro_from == 3 //even up with current boro codes
	replace boro_from = 2 if boro_from == 4
	replace boro_from = 3 if boro_from == 5
	replace boro_from = 4 if boro_from == 6
	replace boro_from = 5 if boro_from == 7

gen tf_same = 0
	replace tf_same = 1 if boro_from == boro
	label variable tf_same "Moved within borough"
	
*************************************************************************	
*																		*
* 	ANALYSIS 															*
*																		*
*************************************************************************

* Sec8 From/To Move Patterns ----------------------------------------------

* Within same borough
	
svy, subpop(sec8): mean tf_same	// 70.7% of Section 8 hh moved from same boro
svy, subpop(sec8): mean tf_same, over(races) coeflegend	// Wh 81.3%
														// Bl 67.6%
														// Hp/Ltnx 69%
														// Asian 65%
														// Other 76.7%

svy, subpop(sec8): regress tf_same i.races			// wowwwww.
	svy: regress tf_same i.races					// contrast with all hh, and
	svy, subpop(renters): regress tf_same i.races	// 
	

* Sec8 Moved From:
prop lived_bef if sec8 ==1	// Note ppl were almost as likely to have moved from Russia as from Manhattan if they're paying w/ a voucher -- Russia et al == origin for 1.09% of voucherholders. And more likely to have moved from tristate than from MH.
	* BX: 33.68%
	* BK: 29.46%
	* MH: 1.61%
	* QU: 8.51%
	* SI: 2.53%
		// outreg2 using tables/from_to_sec8.xls, replace ctitle (sec8From) nose
	
* Sec8 Live Now:
svy: prop boro if sec8 ==1	
	* BX: 41.99%
	* BK: 29.84%
	* MH: 16.69%
	* QU: 8.25%
	* SI: 3.23%
	* NY/NJ/CT: 1.83%
		// outreg2 using tables/from_to_sec8.xls, append ctitle (sec8To) nose	
	
* By Race - Sec8 Moved From:
svy, subpop(if sec8 ==1): prop lived_bef, over(races)
		// outreg2 using tables/from_to_sec8.xls, append ctitle (sec8FromByRaces) nose	
	
* By Race: sec8 Live Now:
svy, subpop(if sec8 ==1): prop boro, over(races)
		// outreg2 using tables/from_to_sec8.xls, append ctitle (sec8ToByRaces) nose	

* Sec8 live now, By PUMA:
		// svy: tab puma if sec8 == 1, percent

* Sec8 duration
		// svy: mean duration if sec8 == 1	// 13.84 years


* Same boro or?

svy, subpop(sec8 if lived_bef == 3): total occ, over(races tf_same)
 
 
/*
/* WHYMOVED BY RACE/POVERTY/OTHER STATUS

svy: tab whymoved, percent				// Citywide baseline
	outreg2 using tables/move_reasons.xls, replace ti(Why New Yorkers Moved, 2017)  ctitle (NYC) nose

svy: tab whymoved if own ==1, percent	// NYC Owners
	outreg2 using tables/move_reasons.xls, append ctitle (NYC Owners) nose
	
svy: tab whymoved if renters ==1, percent	// NYC Renters
	outreg2 using tables/move_reasons.xls, append ctitle (NYC Renters) nose
	
svy: tab whymoved if boro ==1 & renters ==1, percent	// Bronx
	outreg2 using tables/move_reasons.xls, append ctitle (Bronx) nose
	
svy: tab whymoved if boro ==2 & renters ==1, percent	// Brooklyn
	outreg2 using tables/move_reasons.xls, append ctitle (Brooklyn) nose		
svy: tab whymoved if boro ==3 & renters ==1, percent	// MH
	outreg2 using tables/move_reasons.xls, append ctitle (Manhattan) nose	
	
svy: tab whymoved if boro ==4 & renters ==1, percent	// QU
	outreg2 using tables/move_reasons.xls, append ctitle (Queens) nose
	
svy: tab whymoved if boro ==5 & renters ==1, percent	// SI
	outreg2 using tables/move_reasons.xls, append ctitle (Staten Island) nose	
		
svy: tab whymoved if wh ==1 & renters ==1, percent	// White
	outreg2 using tables/move_reasons.xls, append ctitle (White) nose
	
svy: tab whymoved if bl ==1 & renters ==1, percent	// Black
	outreg2 using tables/move_reasons.xls, append ctitle (Black) nose
	
svy: tab whymoved if hplx ==1 & renters ==1, percent	// Hispanic/Latinx
	outreg2 using tables/move_reasons.xls, append ctitle (Hispanic/Latinx) nose
	
svy: tab whymoved if sec8 ==1 & renters ==1, percent	// Section 8
	outreg2 using tables/move_reasons.xls, append ctitle (Section 8) nose
	
svy: tab whymoved if b_pov ==1 & renters ==1, percent	// Below Poverty
	outreg2 using tables/move_reasons.xls, append ctitle (Below Poverty) nose	
*/
/* DURATION BY RACE/POVERTY/OTHER STATUS

svy: mean duration			// Citywide baseline
	outreg2 using tables/DURATION.xls, replace ti(Years In Current Home)  ctitle (NYC) nose

svy: mean duration if own ==1	// NYC Owners
	outreg2 using tables/DURATION.xls, append ctitle (Owners) nose
	
svy: mean duration if renters ==1	// NYC Renters
	outreg2 using tables/DURATION.xls, append ctitle (Renters) nose
	
svy: mean duration if boro ==1 & renters ==1	// Bronx
	outreg2 using tables/DURATION.xls, append ctitle (Bronx) nose
	
svy: mean duration if boro ==2 & renters ==1	// Brooklyn
	outreg2 using tables/DURATION.xls, append ctitle (Brooklyn) nose
	
svy: mean duration if boro ==3 & renters ==1	// MH
	outreg2 using tables/DURATION.xls, append ctitle (Manhattan) nose	
	
svy: mean duration if boro ==4 & renters ==1	// QU
	outreg2 using tables/DURATION.xls, append ctitle (Queens) nose
	
svy: mean duration if boro ==5 & renters ==1	// SI
	outreg2 using tables/DURATION.xls, append ctitle (Staten Island) nose	
		
svy: mean duration if wh ==1 & renters ==1	// White
	outreg2 using tables/DURATION.xls, append ctitle (White) nose
	
svy: mean duration if bl ==1 & renters ==1	// Black
	outreg2 using tables/DURATION.xls, append ctitle (Black) nose
	
svy: mean duration if hplx ==1 & renters ==1	// Hispanic/Latinx
	outreg2 using tables/DURATION.xls, append ctitle (Hispanic/Latinx) nose
	
svy: mean duration if sec8 ==1 & renters ==1	// Section 8
	outreg2 using tables/DURATION.xls, append ctitle (Section 8) nose
	
svy: mean duration if b_pov ==1 & renters ==1	// Below Poverty
	outreg2 using tables/DURATION.xls, append ctitle (Below Poverty) nose
*/
/* Basic estimated hh totals for different subpops (for tables)


gen bx_renters = 0 if occ == 1
	replace bx_renters = 1 if boro ==1 & renters == 1

gen bk_renters = 0 if occ == 1
	replace bk_renters = 1 if boro ==2 & renters == 1
	
gen mh_renters = 0 if occ == 1
	replace mh_renters = 1 if boro ==3 & renters == 1
	
gen q_renters = 0 if occ == 1
	replace q_renters = 1 if boro ==4 & renters == 1
	
gen si_renters = 0 if occ == 1
	replace si_renters = 1 if boro ==5 & renters == 1
	
gen bpov_renters = 0 if occ == 1
	replace bpov_renters = 1 if b_pov == 1 & renters == 1
	
gen wh_renters = 0 if occ == 1
	replace wh_renters = 1 if wh == 1 & renters == 1
	
gen bl_renters = 0 if occ == 1
	replace bl_renters = 1 if bl == 1 & renters == 1	
	
gen hp_renters = 0 if occ == 1
	replace hp_renters = 1 if hplx == 1 & renters == 1
	
gen asn_renters = 0 if occ == 1
	replace asn_renters = 1 if races == 4 & renters == 1

svy, subpop(occ): mean bx_renters
svy, subpop(occ): mean bk_renters
svy, subpop(occ): mean mh_renters
svy, subpop(occ): mean q_renters
svy, subpop(occ): mean si_renters

svy, subpop(occ): mean sec8
svy, subpop(occ): mean bpov_renters

svy, subpop(occ): mean wh_renters
svy, subpop(occ): mean bl_renters
svy, subpop(occ): mean hp_renters
svy, subpop(occ): mean asn_renters

* Where are the below-poverty-line folks concentrated in relatiion to whole city?

 
svy, subpop(b_pov): prop puma, percent

svy, subpop(evhar): prop puma, percent

* Puma-level race %s

svy: mean wh, over(puma)
	outreg2 using tables/puma_sec8.xls, append ctitle (% White) label nose 
svy: mean bl, over(puma)
		outreg2 using tables/puma_sec8.xls, append ctitle (% Black) label nose 

svy: mean hplx, over(puma)
		outreg2 using tables/puma_sec8.xls, append ctitle (% Hispanic/Latinx) label nose 

* Mean number of heating breakdowns

replace sc186 = 0 if sc186 == 9
replace sc186 = 1 if sc186 == 2
replace sc186 = 2 if sc186 == 3
replace sc186 = 3 if sc186 == 4
replace sc186 = 4 if sc186 == 5		// note 4 is "4 or more"
replace sc186 = .a if sc186 == 8
	// if I had time I'd fix this bc taking a mean of a mean is going to yield useless SE's and off numbers
*/
gen heat_brk = 0 if occ == 1
replace heat_brk = 1 if sc185 == 0 & occ == 1
	
svy: mean heat_brk, over(puma)

* % with vermin

gen vermin = 0 if occ == 1
replace vermin = 1 if 
	
	
	/*
####### OK SO THE BIGGEST CONCENTRATION OF VOUCHERHOLDERS, *AND* THE BIGGEST CONCENTRATION OF EVICTIONS, ARE IN THE SAME LITTLE PILE IN THE BRONX. 

GEN SAME-BOROUGH MOVED-FROM INDICATOR (WHERE 1 == MOVED WITHIN-BORO)
 
/* Rent burden BUGGY VERSION

gen burden_30 = 0 if occ == 1 & renters == 1 & sc116 != 3
	replace burden_30 = 1 if rentbrd >= 30 & occ == 1 & renters == 1 & sc116 != 3
	label variable burden_30 "Gross rent >= 30% hh income"
	
gen burden_50 = 0 if occ == 1 & renters == 1 & sc116 != 3
	replace burden_50 = 1 if rentbrd >= 50 & occ == 1 & renters == 1 & sc116 != 3
	label variable burden_50 "Gross rent >= 50% hh income"

tab burden_30
tab burden_50	
 svy: prop burden_50, percent	// this is off from HPD's report for some reason

* Duration, as categorical

gen dur_cat = . if occ == 1
	replace dur_cat = 1 if duration <= 1 & occ == 1
	replace dur_cat = 2 if duration == 2 | duration == 3 & occ == 1
	replace dur_cat = 3 if duration == 4 | duration == 5 & occ == 1
	replace dur_cat = 4 if duration > 5 & duration <= 10 & occ == 1
	replace dur_cat = 5 if duration > 10 & duration <= 15 & occ == 1
	replace dur_cat = 6 if duration > 15 & duration <= 20 & occ == 1
	replace dur_cat = 7 if duration > 20 & duration <= 25 & occ == 1
	replace dur_cat = 8 if duration > 25 & duration < . & occ == 1
	
label define durCats ///
1 "1 year or less" ///
2 "2 - 3 years" ///
3 "4 - 5 years" ///
4 "6 - 10 years" ///
5 "11 - 15 years" ///
6 "16 - 20 years" ///
7 "21-25 years" ///
8 "More than 25 years"
label values dur_cat durCats

	// graph these over race

 svy: total occ, over(dur_cat)	

* Rent Stabilized units, as binary indicator

gen stabilized = 0
replace stabilized = 1 if rent_st == 3 
	label variable stabilized "Rent-stabilized (pre- & post-1947)"


/* INCOME & POVERTY ---------------------------------------------------------

svy: mean hhinc					// $99,814.65
svy: mean hhinc, over(boro)	
svy: mean hhinc, over(races)

svy: prop hh_30AMI, percent		// 17.93% citywide
svy: prop hh_50AMI, percent		// 30.21% citywide
svy: prop hh_80AMI, percent		// 44.63% citywide

svy: prop hh_30AMI, over(races) percent		
svy: prop hh_50AMI, over(races) percent		
svy: prop hh_80AMI, over(races) percent		
*/

/* Simpler Outreg? (HAHAHAHAHAHAHAHA)

*Total hh below pov, by puma
	svy: total b_pov, over(puma)
	outreg2 using tables/puma_pov.xls, replace ti(Estimated Mean Tenure Duration in Years, NYC 2017)  ctitle (Total HH Below Poverty)  nose 

* Percent hh below pov, by puma
	svy: mean b_pov, over(puma)
	outreg2 using tables/puma_pov.xls, append ctitle (% HH Below Poverty)  nose 
	
* Total hh sec8, by puma
	svy: total sec8, over(puma)
	outreg2 using tables/puma_pov.xls, append ctitle (Total HH Sec8)  nose 
 
* Percent hh sec8, by puma
	svy: mean sec8, over(puma)
	outreg2 using tables/puma_pov.xls, append ctitle (% HH Sec8)  nose 
 
* Total hh rent stabilized, by puma
	svy: total stabilized if occ ==1, over(puma)
	outreg2 using tables/puma_pov.xls, append ctitle (Total Stabilized)  nose 

* Percent hh rent stabilized, by puma
	svy: mean stabilized if occ ==1, over(puma)
	outreg2 using tables/puma_pov.xls, append ctitle (% Stabilized)  nose 

* Share of NYC Sec 8 units, by puma
	svy, subpop(sec8): prop puma, percent
	outreg2 using tables/puma_sec8.xls, replace ctitle (Share of NYC Sec8) label nose 

* Boro movements by race (for alluvial)

svy, subpop(sec8 if lived_bef == 3): total occ, over(races boro)
outreg2 using tables/race_boro_s8.xls, replace ctitle(fromBX) nose dec(0)	

svy, subpop(sec8 if lived_bef == 4): total occ, over(races boro)
outreg2 using tables/race_boro_s8.xls, append ctitle(fromBK) nose dec(0)

svy, subpop(sec8 if lived_bef == 5): total occ, over(races boro)
outreg2 using tables/race_boro_s8.xls, append ctitle(fromMH) nose dec(0)

svy, subpop(sec8 if lived_bef == 6): total occ, over(races boro)
outreg2 using tables/race_boro_s8.xls, append ctitle(fromQU) nose dec(0)

svy, subpop(sec8 if lived_bef == 7): total occ, over(races boro)
outreg2 using tables/race_boro_s8.xls, append ctitle(fromSI) nose dec(0)

/* CITYWIDE TABLE -------------------------------------------------------

	// ADD ESTIMATED COUNTS USING -SVY TOTAL-
	
svy: mean duration		// NYC: 13.84 yrs, se .12
	outreg2 using tables/citywide.doc, replace ti(Estimated Mean Tenure Duration in Years, NYC 2017)  ctitle (All) label nose 

svy, subpop(renters): mean duration	// NYC renters: 11.22 yrs, se .15 yr
	outreg2 using tables/citywide.doc, append ctitle (Renters) label nose

svy: mean duration if own == 1 & occ == 1 // NYC owners: 19.31 yrs, se .22
	outreg2 using tables/citywide.doc, append ctitle (Owner-Occupied) label nose
	
svy: mean duration if sec8 == 1 // NYC Sec8: 13.84 yrs, se .39
	outreg2 using tables/citywide.doc, append ctitle (Section 8) label nose

 svy: total occ, over(dur_cat)
	
/* OTHER CITY DATA ----------------------------------------------------

* Move origin
svy: prop lived_bef, percent
	outreg2 using tables/boro_movedfrom.doc, replace ctitle (NYC) 

svy: prop lived_bef if boro ==1, percent
	outreg2 using tables/boro_movedfrom, excel append ctitle (Bronx) 

svy: prop lived_bef if boro ==2, percent
	outreg2 using tables/boro_movedfrom, excel append ctitle (Brooklyn) 

svy: prop lived_bef if boro ==3, percent
	outreg2 using tables/boro_movedfrom, excel append ctitle (Manhattan) 

svy: prop lived_bef if boro ==4, percent
	outreg2 using tables/boro_movedfrom, excel append ctitle (Bronx) 

svy: prop lived_bef if boro ==5, percent 
	outreg2 using tables/boro_movedfrom, excel append ctitle (Staten Island) 
*/

/* Move reason
svy: prop whymoved if renters == 1, percent
	outreg2 using tables/boro_whymoved.doc, replace ti(Householders' Stated Reason for Moving to Current Unit, NYC 2017)  ctitle (Citywide) label nose dec(2)

svy: prop whymoved if renters == 1 & boro ==1, percent
	outreg2 using tables/boro_whymoved.doc, append ctitle (Bronx) label nose dec(2)

svy: prop whymoved if renters == 1 & boro ==2, percent
	outreg2 using tables/boro_whymoved.doc, append ctitle (Brooklyn) label nose dec(2)

svy: prop whymoved if renters == 1 & boro ==3, percent
	outreg2 using tables/boro_whymoved.doc, append ctitle (Manhattan) label nose dec(2)

svy: prop whymoved if renters == 1 & boro ==4, percent
	outreg2 using tables/boro_whymoved.doc, append ctitle (Bronx) label nose dec(2)

svy: prop whymoved if renters == 1 & boro ==5, percent 
	outreg2 using tables/boro_whymoved.doc, append ctitle (Staten Island) label nose dec(2)

* Mean duration, by race, for sec8 hhs

svy: mean duration, over(races) 	
	outreg2 using tables/citywide_races, excel replace ctitle (NYC) label nose dec(2) 

svy, subpop(renters): mean duration, over(races)
	outreg2 using tables/citywide_races, excel append ctitle (renters) label nose dec(2) 

svy: mean duration if own == 1 & occ == 1, over(races)
	outreg2 using tables/citywide_races, excel append ctitle (owner_occ) label nose dec(2)
	
svy: mean duration if sec8 == 1, over(races) 
	outreg2 using tables/citywide_races, excel append ctitle (sec8) label nose dec(2)
	
* Mean duration, by rent control status

svy: mean duration, over(rent_st) 
	outreg2 using tables/duration_rent_st.doc, replace ctitle (NYC) label nose dec(2)
	
svy, subpop(if sec8 == 1): tab puma, percent
	outreg2 using tables/sec8_allocation_by_PUMA.doc, replace label nose dec(2)
	
* Rent stabilization status: unit counts & percents

svy: total occ if occ==1, over(rent_st)
svy: total occ if occ==1, over(boro rent_st)
svy: total occ if occ==1, over(puma rent_st)
	outreg2 using tables/sec8_allocation_by_PUMA.doc, replace label nose dec(2)

*/
* PUMA TABLE -----------------------------------------------------------	

svy: mean duration, over(puma) 						// by PUMA
	outreg2 using tables/by_puma, excel replace ctitle (NYC) label nose dec(2) 
	
svy: mean duration if renters == 1, over(puma) 		// by PUMA (renters)
	outreg2 using tables/by_puma, excel append ctitle (renters) label nose dec(2)
	
svy: mean duration if own == 1 & occ == 1, over(puma) // by PUMA (owner-occ)
	outreg2 using tables/by_puma, excel append ctitle (owner_occ) label nose dec(2)

svy: mean duration if sec8 == 1, over(puma) 		// by PUMA (sec 8)
	outreg2 using tables/by_puma, excel append ctitle (sec8) label nose dec(2)	
	
svy: mean duration if renters == 1 & races == 1, over(puma) 	
	outreg2 using tables/by_puma, excel append ctitle (white_renters) label nose dec(2)		
													// by PUMA (white renters)
													
svy: mean duration if renters == 1 & races == 2, over(puma) 
	outreg2 using tables/by_puma, excel append ctitle (black_renters) label nose dec(2)	
													// by PUMA (Black renters)

svy: mean duration if renters == 1 & races == 3, over(puma) 
	outreg2 using tables/by_puma, excel append ctitle (hlx_renters)	label nose dec(2)
													// by PUMA (Hsp/Ltnx renters)
													
svy: mean duration if renters == 1 & races == 4, over(puma) 
	outreg2 using tables/by_puma, excel append ctitle (asian_renters) label nose dec(2)	
													// by PUMA (Asian renters)
													
svy: mean duration if renters == 1 & races == 5, over(puma) 
	outreg2 using tables/by_puma, excel append ctitle (otherrace_renters) label nose dec(2)	
													// by PUMA (otherrace renters)

svy: mean duration if sec8 == 1 & races == 1, over(puma) 	
	outreg2 using tables/by_puma, excel append ctitle (white_sec8)	label nose dec(2)	
													// by PUMA (white sec8)
													
svy: mean duration if sec8 == 1 & races == 2, over(puma) 
	outreg2 using tables/by_puma, excel append ctitle (blacksec8) label nose dec(2)
													// by PUMA (Black sec8)

svy: mean duration if sec8 == 1 & races == 3, over(puma) 
	outreg2 using tables/by_puma, excel append ctitle (hlx_sec8) label nose dec(2)
													// by PUMA (Hsp/Ltnx sec8)
													
svy: mean duration if sec8 == 1 & races == 4, over(puma) 
	outreg2 using tables/by_puma, excel append ctitle (asian_sec8) label nose dec(2)	
													// by PUMA (Asian sec8)
													
svy: mean duration if sec8 == 1 & races == 5, over(puma) 
	outreg2 using tables/by_puma, excel append ctitle (otherrace_sec8) label nose dec(2)	
													// by PUMA (other race sec8)

* PUMA shares of NYC's total Sec8 units
svy: total occ if sec8 == 1, over(puma)
		outreg2 using tables/by_puma, excel append ctitle (Total Sec8 units) label nose noaster dec(0)
svy, subpop(sec8): prop puma, percent
	outreg2 using tables/by_puma, excel append ctitle (% share of NYC Sec8 units) label nose dec(4)
	
* PUMA shares of NYC's total stabilized units
svy: total occ if rent_st == 3, over(puma)
		outreg2 using tables/by_puma, excel append ctitle (Total Stabilized Units) label nose noaster dec(0)
svy: prop puma if rent_st == 3, percent
	outreg2 using tables/by_puma, excel append ctitle (% share of NYC stabilized units) label nose dec(4)


	
	
* BORO TABLE -----------------------------------------------------------

svy: mean duration, over(boro) 							// dur by boro		
	outreg2 using tables/by_boro, excel replace ctitle (mean dur) label nose dec(2)
	
svy: mean duration if renters == 1, over(boro) 		
	outreg2 using tables/by_boro, excel append ctitle (mean dur renters) label nose dec(2)
	
svy: mean duration if own == 1 & occ == 1, over(boro) // dur by boro (owner-occ)
	outreg2 using tables/by_boro, excel append ctitle (mean dur owner-occ) label nose dec(2)

svy: mean duration if sec8 == 1, over(boro) 		// by boro (sec 8)
	outreg2 using tables/by_boro, excel append ctitle (mean Sec8 dur) label nose dec(2)	
	
svy: mean duration if renters == 1 & races == 1, over(boro) 	
	outreg2 using tables/by_boro, excel append ctitle (mean dur white renters)	label nose dec(2)	
													// by boro (white renters)
													
svy: mean duration if renters == 1 & races == 2, over(boro) 
	outreg2 using tables/by_boro, excel append ctitle (mean dur Black renters)	label nose dec(2)
													// by boro (Black renters)

svy: mean duration if renters == 1 & races == 3, over(boro) 
	outreg2 using tables/by_boro, excel append ctitle (mean dur HspLtnx renters)	label nose dec(2)
													// by boro (Hsp/Ltnx renters)
													
svy: mean duration if renters == 1 & races == 4, over(boro) 
	outreg2 using tables/by_boro, excel append ctitle (mean dur Asian renters)	label nose dec(2)
													// by boro (Asian renters)
													
svy: mean duration if renters == 1 & races == 5, over(boro) 
	outreg2 using tables/by_boro, excel append ctitle (mean dur otherrace renters)	label nose dec(2)
													// by boro (otherrace renters)

svy: mean duration if sec8 == 1 & races == 1, over(boro) 	
	outreg2 using tables/by_boro, excel append ctitle (mean dur white sec8)	label nose dec(2)	
													// by boro (white sec8)
													
svy: mean duration if sec8 == 1 & races == 2, over(boro) 
	outreg2 using tables/by_boro, excel append ctitle (mean dur Black sec8)	label nose dec(2)
													// by boro (Black sec8)

svy: mean duration if sec8 == 1 & races == 3, over(boro) 
	outreg2 using tables/by_boro, excel append ctitle (mean dur HspLtnx sec8)	label nose dec(2)
													// by boro (Hsp/Ltnx sec8)
													
svy: mean duration if sec8 == 1 & races == 4, over(boro) 
	outreg2 using tables/by_boro, excel append ctitle (mean dur Asian sec8)	label nose dec(2)
													// by boro (Asian sec8)
													
svy: mean duration if sec8 == 1 & races == 5, over(boro) 
	outreg2 using tables/by_boro, excel append ctitle (mean dur otherrace sec8)	label nose dec(2)
													// by boro (other race sec8)

svy: mean duration if rent_st == 3, over (boro)
	outreg2 using tables/by_boro_rentst_dur.doc, replace label nose 
	
* Boro % shares of NYC's Sec8 units
												
svy, subpop(sec8): prop boro, percent
	outreg2 using tables/by_boro, excel append ctitle (% share of NYC Sec8 units) label nose dec(4)													
	
	* BY NYC, BORO, & PUMA:
		* where moved from if sec8
		* where moved from if renter
		* where moved from, by race
		
	* BY NYC, BORO, & PUMA:
		* where moved from if sec8
		* where moved from if renter
		* where moved from, by race
	
/* Subset: Section 8 ------------------------------------------------

* HCV unit count estimates: by boro 
svy: total sec8, over(boro)
	// Bronx: 61,090
	// BK: 43,415
	// Manhattan: 24,285
	// Queens: 12,004
	// SI: 4,704

* HCV unit count estimates: by sub-boro 
svy: total sec8, over(boro cd)
svy: total sec8, over(puma)

* Share of total HCV units: by boro
svy, subpop(if sec8 == 1): tab boro, percent	
	// Of all estimated voucherholder households:
	// Bronx: 42%
	// BK: 30%
	// Manhattan: 17%
	// Queens: 8%
	// Staten Island: 3%
	
* Share of total HCV units: by sub-boro
svy, subpop(sec8): tab boro cd
svy, subpop(sec8): tab puma, nolab
	// JFC. Look at the concentration of all voucherholders in just 2 boroughs of the Bronx (7.98% are in 1, 7.40% are in 2.) Make a list in descending order and map the city that way. From eyeballing:
		* 7.98%: Bronx 1
		* 7.40%: Bronx 2
		* 6.00%: Bronx 3
		* 5.91%: Bronx 4
		* 5.15%: Bronx 5
		* 4.48%: BK 13
		* 4.14%: Manhattan 10
		* 3.67%: BK 16
		* 3.62%: Bronx 10
		* 3.54%: Manhattan 9
		* 3.05%: SI 1
			// for context: entirety of Queens holds just 8.25% of estimated HCVs

* Subset: Rent Stabilized ------------------------------------------

/* SCRATCHPAD ---------------------------------------------------------				

svy: mean yrmoved		// NYC: 2003, se .12
svy: mean duration		// NYC: 13.84 yrs, se .12
	
svy, subpop(renters): mean yrmoved	// NYC renters: 2006, se .15 yr
svy, subpop(renters): mean duration	// NYC renters: 11.22 yrs, se .15 yr

svy: mean yrmoved if own == 1 & occ == 1 // NYC owners: 1998, se .22
svy: mean duration if own == 1 & occ == 1 // NYC owners: 19.31 yrs, se .22

Newman: "Freeman and Braconi (2004, 2002b)
examined renter households and defined as
displaced those who chose any of three
reasons: wanted a less expensive residence
or had difficulty paying rent; moved because
of landlord harassment; or, were displaced
by private action (such as condo conversions,
landlords taking over units for their own living
space, etc.)." ("The Right to Stay Put, Revisited" 29)
	// "Evicted, displaced, or harassed by landlorde" is whymoved == 18
*/
	


* Export Table of all other necessary variables (??)

/* Re: maintenance variance question:

gen heat_brk = 0
	replace heat_brk = 1 if sc185 == 0
	
svy: mean heat_brk if rent_st == 2, over(boro cd)
svy: mean heat_brk if rent_st == 2, over(race)
outreg2 using heat_brk_test.doc, replace	// YASSSSSS it worked
outreg2 using heat_brk_xcl, excel replace	// also good though SEs stored as strings?

matrix list e(b)	// shows results as a matrix
putexcel set "tables/heat_brk1", sheet ("by race") modify
putexcel A1 = heat_brk B1 = race 

* What I Was Playing W/ for That Alluvial Chart, Fri 11/19:

* Subset Out the 4 PUMA codes holding over 27% of all 2017 Section 8 HH
 gen top4 = 0
 replace top4 = 1 if puma == 3710 | puma == 3705 | puma == 3708 | puma == 3707

* Who's Moving to Them?

svy, subpop(sec8): total occ, over(races top4)
