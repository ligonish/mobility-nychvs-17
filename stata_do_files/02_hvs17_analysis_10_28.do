capture log close
clear all
prog drop _all
set more off
version 17.0
set linesize 80

******************************************************************
* INITIAL ANALYSIS: 2017 NYC Housing & Vacancy Survey

* Occupied Unit Codebook: https://www2.census.gov/programs-surveys/nychvs/technical-documentation/record-layouts/2017/occupied-units-17.pdf 
*
* Vacant Unit Codebook: https://www2.census.gov/programs-surveys/nychvs/technical-documentation/record-layouts/2017/vacant-units-17.pdf
* 
* Sub-Boro Maps & Codes: https://www.census.gov/geographies/reference-maps/2017/demo/nychvs/sub-bourough-maps.html

* Glossary: https://www2.census.gov/programs-surveys/nychvs/about/glossary/gloss17.pdf

* 2017 Code Methodology Updates: https://www.census.gov/programs-surveys/nychvs/technical-documentation/rent-regulation-status.html

* Replicate weights and -svy- commands:
* https://usa.ipums.org/usa/repwt.shtml
* https//www.iser.essex.ac.uk/files/teaching/ec969/docs/Week2Lecture1_Worksheet.pdf
*
* UCLA crash course on updated Stata 17 -svy- commands: https://stats.idre.ucla.edu/stata/seminars/survey-data-analysis-in-stata-17/
* "Where We Live NYC" for 2017 data crosschecks: https://www1.nyc.gov/assets/hpd/downloads/pdfs/wwl-plan.pdf

* also for data crosschecks: https://www.nber.org/system/files/working_papers/w25906/w25906.pdf
	* or https://www1.nyc.gov/assets/hpd/downloads/pdfs/services/rent-regulation-memo-1.pdf
	
* R analysis examples: http://asdfree.com/new-york-city-housing-and-vacancy-survey-nychvs.html
*******************************************************************

* Justin wants:

	* concentration of stabilized units by borough & neighhborhood
	* correlations of stabilized units w/ poverty concentration, by borough
	* "how many ppl leave stabilized units each year, where they tend to go"

cd "/Users/Sarah/Desktop/HLU Mobility Stata/NYCHVS"
 
* LOAD CLEANED DATA -----------------------------------------------	

use "data_build/cleaner_hvs_occvac_17.dta", clear

* TRIM FOR SPEED --------------------------------------------------

* Drop detailed bldg condition vars for now
drop uf1_1 uf1_3 uf1_4 uf1_5 uf1_6 uf1_7 uf1_8 uf1_9 uf1_10 uf1_11 uf1_12 uf1_13 uf1_14 uf1_15 uf1_16 uf1_35 uf1_17 uf1_19 uf1_20 uf1_21 uf1_22 sc24 sc36 sc37 sc38

* Drop other unused

drop	uf2a_1		// no. persons from temporary residence
drop 	sc111 sc112 sc113	// birthplaces
drop	uf5 sc125	// down payment
drop	sc127 uf68 uf7a sc141 sc144 sc149 sc173 sc171 uf77 uf78 uf81 uf82 uf83 sc157 sc158 sc159 uf12 sc161 uf13 uf14 sc164 uf15 sc166 uf16
	// vector of other bldg/unit mortgage & (dis)repair features
drop	uf17		// contract rent (using gross)
drop	sc197 sc187 sc189 sc193	// vector of extra heat/rodent variables (kept basic ones)
drop	sc575 uf72 sc574 sc198 sc647 sc648 sc649 sc650 sc651 sc131 sc132 sc136 sc137 sc138	// vector of medical & poverty indicators
drop	uf74 uf76 uf71 rec1 uf46 uf105 rec54 rec53 tot_per cppr uf28 uf27 uf34 uf34a uf35 uf35a uf36 uf36a uf37 uf37a uf38 uf38a uf39 uf39a uf40 uf40a // detailed income & bldg class subcategories
drop	uf29	// contract rent/income ration (using gross)
drop	hflag13 hflag1 hflag6 hflag3 hflag14 hflag16 hflag7 hflag9 hflag10 hflag91 hflag11 hflag12 hflag4 uf52h_a uf52h_b uf52h_c uf52h_d uf52h_e uf52h_f uf52h_g // unused variable flags
drop	sc30 sc518 sc520 sc522 sc553 sc555 sc529 sc530 sc533 uf32 hflag15 hflag17 hflag8 hflag5 //vacant unit unused & flag vars

// 15,135 obs & 157 variables remaining

save "data_build/smaller_cleaner_hvs_occvac_17.dta", replace

* GEN SIMPLE ID VARIABLES FOR SUBSETTING --------------------------

* gen id = _n 
gen u = 1


/* VIA NYCHVS 2017 DATA MANUAL: SAMPLE SVY SUBSET ANALYSIS ---------
		// SL: confirmed my output matches manual's, 10/27/21.

* Totals
svy, subpop(occ): total occ		// 3,109,955 occ u, se 8627


* NYCHVS code for est. variance of a difference
		// SL: confirmed my output matches manual's, 10/27/21.

* Bronx:
 gen rent_bronx = ((uf_csr == 30 | uf_csr == 31) & (boro == 1))
* Manhattan:
 gen rent_man = ((uf_csr == 30 | uf_csr == 31) & boro == 3)

* Creating difference between these:
 gen stable_diff = rent_man - rent_bronx

* Create proper subdomain:
	gen rent_boro = (((uf_csr == 30 | uf_csr == 31) & boro == 3) | ((uf_csr == 30 | uf_csr == 31) & (boro == 1))) 

* Now estimating differences between these:
 svy, subpop(rent_boro): total stable_diff // 15,497; se 10,420 

* NYCHVS Data Team code for est. mean variance
		// SL: confirmed my output matches manual's, 10/27/21.

* Need proper subdomain var: Renters only - note STATA automatically removes missing values from analysis
 gen renters = (sc116 == 2 | sc116 == 3)
 gen gross_rent = uf26
 replace gross_rent = . if uf26 == 99999
 
 * Now estimating mean:
svy, subpop(renters): mean gross_rent	// $1,693.54, se $10.58

* NYCHVS Data Team code for est. variance of regression parameter
		// SL: confirmed my output matches manual's, 10/27/21.

* Linear regression model:
svy, subpop(renters): reg gross_rent yrmoved	// nb varname change
	// every additional year closer to the present bumps rent by $28.79, cp, 1% conf. se == $0.81
		
/******************************************************************

* DATA CONFIRMATION CHECK:

svy: total occ if occ==1, over(rent_st)
	// values for universe and subpopulations match Table 1 of HPD memo here: https://www1.nyc.gov/assets/hpd/downloads/pdfs/services/rent-regulation-memo-1.pdf



* EXPLORE ---------------------------------------------------------

* Mobility: citwide & by own/rent

svy: mean yrmoved		
	// Citywide, all tenures: 2003, se .12

svy, subpop(renters): mean yrmoved	
	// Citywide, renters: 2006, se .15 yr

svy: mean yrmoved if own == 1 & occ == 1
	// Citwide, owners: 1998, se .22
	
* Section 8 Household Concentrations

svy: total sec8, over(boro)
	// Bronx: 61,090
	// BK: 43,415
	// Manhattan: 24,285
	// Queens: 12,004
	// SI: 4,704
	
svy: total sec8, over(boro cd)		// use this: voucher unit count estimates for all sub-boroughs.

svy, subpop(sec8): tab boro cd
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
			// for context: entirety of Queens holds just 8.25%


svy, subpop(renters): tab sec8 boro, row column percent
	// Bronx: 3%
	// BK: 2%
	// Nope fix this 

svy, subpop(if sec8 == 1): tab boro, percent	
	// Of all estimated voucherholder households:
	// Bronx: 42%
	// BK: 30%
	// Manhattan: 17%
	// Queens: 8%
	// Staten Island: 3%

svy, subpop(if sec8 == 1): tab boro, count format(%11.0fc)
	// Bronx: 61,090
	// Brooklyn: 42,415
	// Manhattan: 24,285
	// Queens: 12,004
	// SI: 4,704
	// Total: 145,499

svy, subpop(renters): tab sec8 boro, row column percent

svy, subpop(sec8): tab boro cd, percent // interesting

svy, subpop(if boro == 5): tab sec8 cd, col percent
	
* Stabilized Unit Concentrations

svy: total occ if occ==1, over(rent_st boro)

svy: mean yrmoved if rent_st == 3, over(boro)
	// Bronx: 2005
	// BK: 2--5
	// Manhattan: 2002
	// Queens: 2005
	// SI: 2009

* Tenure duration in Staten Island stabilized units, by sub-boro:

svy: mean yrmoved if rent_st == 3 & boro == 5, over(cd)
	// stabilized u in SI 1: 2010 (se 1.43)
	// stabilized u in SI 2: 2014 (se 0.21)
	// stabilized u in SI 3: 2005 (se 1.10)
	
**** USE THIS: tenure duration by boro & sub-boro:
svy: mean yrmoved if rent_st == 3, over(boro cd)

*** AND THIS: total estimated stabilized units by boro & sub-borough
svy: total occ if rent_st == 3, over(boro cd)
	
svy: count if rent_st == 3 & boro == 5, over(cd)

svy: tab rent_st if boro == 5, over(cd)

svy: tabulate rent_st, count format (%11.3g)	

svy: tabulate rent_st, percent		
		
svy, subpop(if boro == 5): tab rent_st cd, count format(%11.0fc)
			// sort of promising but also sort of illegible??

svy: tabulate rent_st boro, row column percent	
// recall this weird Stata setup. output is stacked as:
			* row %
			* column %

* OK try these for SI specifically: 
svy, subpop(if boro == 5 & cd < 4): tab rent_st cd, row column percent


* Good also:
svy: mean yrmoved, over(boro cd)
*/
* Replicating Fig 5.88 the NYC report linked at top, just to check:

gen id = _n 
gen u = 1
	
	
	
/* 


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
