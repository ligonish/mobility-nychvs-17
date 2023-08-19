capture log close
clear all
prog drop _all
set more off
version 17.0
set linesize 80

use "hvs_17_occ.dta", clear

* Add weights using -svyset- function

svyset [pweight = fw]

* INITIAL EXPLORATION: 2017 NYC Housing & Vacancy Survey

* Codebook: https://www2.census.gov/programs-surveys/nychvs/technical-documentation/record-layouts/2017/occupied-units-17.pdf 

* Sub-Boro Maps & Codes: https://www.census.gov/geographies/reference-maps/2017/demo/nychvs/sub-bourough-maps.html

* Glossary: https://www2.census.gov/programs-surveys/nychvs/about/glossary/gloss17.pdf

******** OH FUCK HOLD THE PHONE, just do pp 33 on in this census.gov tech handbook on replicate weights & NYCHVS: https://www2.census.gov/programs-surveys/nychvs/technical-documentation/variances/2017-NYCHVS-Guide-to-Estimating-Variances.pdf

describe

/*********************************************************************
 
 DATA CLEANING:
 
	1. ID variables
	2. Drop unneeded 
	3. Explore 
	
**********************************************************************/

/* 1. VARIABLES OF INTEREST ----------------------------------------

SPATIAL
boro				1=Bronx
					2=BK
					3=Manhattan
					4=Queens
					5=Staten Island
cd				sub-borough area
																	
HOUSEHOLDER DEMOGRAPHIC										
hhr2			Sex of householder
hhr3t			Race of householder
hhr5			Hispanic origin
uf61			Race of householder (multiple allowed)
uf60			Recoded race (by "_ Alone")
uf69			Race and ethnicity of householder
uf108			Receipt of public asst. or welfare pmts
rec39			Household below poverty

MIGRATION
uf79			Most recent place lived
uf66			Year householder moved into unit (recode)
sc54			First occupants of unit
uf67			Reason for moving
sc560			Moved to US as immigrant
uf53			Year moved to US as immigrant
uf54			Year moved to NYC

DWELLING CHARACTERISTICS
sc115           Tenure(1)
sc116           Tenure(2)
uf17            Contract rent
sc181           Length of lease
sc114			Coop/condo status
sc117			Lived in unit at time of coop/condo conversion
sc118			Coop/condo conversion through non-eviction plan
sc120			Occupancy status before acquisition
sc121			Condo/coop before acquisition
uf6 			Value
sc196			Respondent rating of structures in neighborhood
sc168			"Affordable"
sc169			"Too expensive given its condition"
sc183			"Too expensive given its location"
uf23			Year built recode
rec21			Condition of unit recode

HOUSING ASSISTANCE/REGULATION STATUS
sc541           Federal section 8		1=Y
										2=N
										3=Don't know
										8=Not reported
										9=N/A*
										*(rentfree or owner occ)
uf107          	Other rental subsidy
uf17a           Out of pocket rent
uf_csr			Control status recode

INCOME & HOUSING COSTS
uf42			hh income	-000001 to -999999=Income loss (in $)
							9999997=$9,999,997 or more
							999999=No income
uf26			Monthly gross rent							
uf30			rent burden (gross rent:hhinc)
il30per			30% HUD limits
il50per			50% HUD limits
il80per			80% HUD limits

WEIGHTS
seqno
fw
chufw

** Data note: flags not included for now. Come back & figure out best practices for handling these at scale.
*/

* 2. TRIM EXTRANEOUS VARIABLES ------------------------------------

keep 	///
	boro 	///
	cd		///										
	hhr2 	///
	hhr3t 	///
	hhr5 	///
	uf61 	///
	uf60 	///
	uf69 	///
	uf108 	///
	rec39 	///
	uf79 	///
	uf66 	///
	sc54 	///
	uf67 	///
	sc560 	///
	uf53 	///
	uf54 	///
	sc115 	///
	sc116 	///
	sc181 	///
	sc114 	///
	sc117 	///
	sc118 	///
	sc120 	///
	sc121 	///
	uf6 	///
	sc196 	///
	sc168 	///
	sc169 	///
	sc183 	///
	uf23 	///
	rec21 	///
	sc541 	///
	uf107 	///
	uf_csr 	///
	uf42 	///
	uf26 	///					
	uf30 	///
	il30per	///
	il50per	///
	il80per	///
	seqno	///
	fw		///
	chufw

* 3. RECODE/RELABEL FOR LEGIBILITY ------------------------------

rename	hhr2	sex
rename	uf66	yrmoved
rename	hhr3t	age
rename	uf67	whymoved		
rename 	sc115	own
rename	uf69	race
rename	uf42	hhinc

* Generate simpler indicator variables

*Section 8
gen sec8 = sc541 == 1
label variable sec8 "Federal Section 8"

* Hispanic/Latinx
gen hlx = 0
	replace hlx = 1 if hhr5 != 1
	label variable hlx "Puerto Rican/Dominican/Cuban/SC Am/Mexican/Other Hispanic Householder"
	tab hlx
	sum hlx hhr5, d 
	drop hhr5
	
* Most Recent Place HHer Lived for >= 6 Months
rename uf79	lived_bef
label define befLabel /// 
1 "Always lived in this unit" ///
2 "Other unit in same bldg" ///
3 "Bronx" ///
4 "Brooklyn" ///
5 "Manhattan" ///
6 "Queens" ///
7 "Staten Island" ///
08 "NY/NJ/CT" ///
09 "Other state or PR" ///
10 "DR" ///
11 "non-DR/PR Caribbean" ///
12 "Mexico/CentrAm/SouthAm/Canada" ///
13 "Russia/FSU/Europe" ///
14 "All other countries" ///
98 "Not reported"
label values lived_bef befLabel

* First Occupants
gen first_occ = 0
	replace first_occ = 1 if sc54 == 1
	label variable first_occ "First occupants of unit"
	drop sc54
	
* Householder-reported rent stabilization/control/asst status
* See https://www1.nyc.gov/assets/hpd/downloads/pdfs/services/rent-regulation-memo-1.pdf Table 1 & footnote for possible clarification.

gen hher_rent_st = 0
	label variable hher_rent_st "Householder rent stabilization status"
	replace hher_rent_st = 1 if uf_csr == 1 | uf_csr == 2 | uf_csr == 12|uf_csr == 86
	replace hher_rent_st = 2 if uf_csr == 5
	replace hher_rent_st = 3 if uf_csr == 30 | uf_csr == 31
	replace hher_rent_st = 4 if uf_csr == 90
	replace hher_rent_st = 5 if uf_csr == 21 | uf_csr == 95
	replace hher_rent_st = 6 if uf_csr == 85
	replace hher_rent_st = 7 if uf_csr == 80
label define asstLabel /// 
1 "Owner-occupied (incl M-L coops)" ///
2 "Public housing" ///
3 "Stabilized, pre or post 1947" ///
4 "Rent controlled" ///
5 "HUD/Other regulated or in rem" ///
6 "Mitchell-Lama rental or Article 4" ///
7 "Private, unregulated"
label values hher_rent_st asstLabel

* Boroughs
label define boroLabel /// 
1 "Bronx" ///
2 "Brooklyn" ///
3 "Manhattan" ///
4 "Queens" ///
5 "Staten Island"
label values boro boroLabel

* Race
label define raceLabel ///
1 "White" ///
2 "Black" ///
3 "Puerto Rican" ///
4 "Other Spanish/Hispanic" ///
5 "Asian" ///
6 "NH PI AIAN" ///
7 "Two or more races, not-Hispanic"
label values race raceLabel

* Rent Burden
rename	uf30	rentbrd
replace rentbrd = .a if rentbrd == 0000
replace rentbrd = .b if rentbrd == 9999
tab rentbrd

save "cleaner_nychvs17", replace

/* TO DO: 
	* recode race variable for a simpler Latinx measure
	* recode missing values in rentbrd
	* 
	* recode missing values in other vars of interest (this one's maddening; the 999 v 99999 v 9999999s are inconsistently applied)
 
