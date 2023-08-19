capture log close
clear all
prog drop _all
set more off
version 17.0
set linesize 80

use "hvs_17_vac.dta", clear

* Add weights using -svyset- function

svyset [pweight = fw]

* INITIAL EXPLORATION: 2017 NYC Housing & Vacancy Survey

* Codebook: https://www2.census.gov/programs-surveys/nychvs/technical-documentation/record-layouts/2017/occupied-units-17.pdf 

* Sub-Boro Maps & Codes: https://www.census.gov/geographies/reference-maps/2017/demo/nychvs/sub-bourough-maps.html

* Glossary: https://www2.census.gov/programs-surveys/nychvs/about/glossary/gloss17.pdf

describe

/*********************************************************************
 
 DATA CLEANING:
 
	1. ID variables
	2. Drop unneeded 
	3. Explore 
	
**********************************************************************/


* RECODE/RELABEL FOR LEGIBILITY ------------------------------
	
* Rent stabilization/control/asst status
	
	//See https://www1.nyc.gov/assets/hpd/downloads/pdfs/services/rent-regulation-memo-1.pdf Table 1 & footnote for possible clarification.

gen rent_st = 0
	label variable rent_st "Rent stabilization status"
	replace rent_st = 1 if uf_csr == 3 | uf_csr == 7
	replace rent_st = 2 if uf_csr == 5
	replace rent_st = 3 if uf_csr == 30 | uf_csr == 31
	replace rent_st = 4 if uf_csr == 21 | uf_csr == 95
	replace rent_st = 5 if uf_csr == 86
	replace rent_st = 6 if uf_csr == 85
	replace rent_st = 7 if uf_csr == 80
	replace rent_st = 8 if uf_csr == 4
label define asstLabel /// 
1 "Vacant, FS, private/unregulated" ///
2 "Public housing" ///
3 "Stabilized, pre or post 1947" ///
4 "HUD/Other regulated or in rem" ///
5 "Mitchell-Lama coop" ///
6 "Mitchell-Lama rental or Article 4" ///
7 "Other rental" ///
8 "Not available vacant"
label values rent_st asstLabel
tab uf_csr
tab rent_st

* Boroughs
label define boroLabel /// 
1 "Bronx" ///
2 "Brooklyn" ///
3 "Manhattan" ///
4 "Queens" ///
5 "Staten Island"
label values boro boroLabel

save "cleaner_vac_nychvs17", replace

/* TO DO: 
 
