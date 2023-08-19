capture log close
clear all
prog drop _all
set more off
version 17.0
set linesize 80

*******************************************************************
* SETUP & CLEANING: COMBINED OCC/VAC UNIT 2017 NYCHVS DATA
*							srl 10/27/21
* Occupied Unit Codebook: https://www2.census.gov/programs-surveys/nychvs/technical-documentation/record-layouts/2017/occupied-units-17.pdf 
*
* Vacant Unit Codebook: https://www2.census.gov/programs-surveys/nychvs/technical-documentation/record-layouts/2017/vacant-units-17.pdf
*
* Sub-Boro Maps & Codes: https://www.census.gov/geographies/reference-maps/2017/demo/nychvs/sub-bourough-maps.html
*
* Glossary: https://www2.census.gov/programs-surveys/nychvs/about/glossary/gloss17.pdf
*
* Technical Manual w/ Detailed Guide to Final & Replicate Weights: https://www2.census.gov/programs-surveys/nychvs/technical-documentation/variances/2017-NYCHVS-Guide-to-Estimating-Variances.pdf
*
*******************************************************************


cd "/Users/Sarah/Desktop/HLU Mobility Stata/NYCHVS"
 
* LOAD OCCUPIED-ONLY 2017 DATASET -------------------------------

use "data_raw/hvs_17_occ.dta", clear

* CONVERT FINAL/REPLICATE WEIGHTS W/ IMPLIED DECIMAL PLACES ------

	// (via 2017 NYCHVS Guide TO Estimating Variances: "Since the final weights & replicate weights have five implied decimal places, users need to convert them ... divide weights by 100,000" [34].)

replace fw = fw/100000

foreach x of var fw1 - fw80 { 
	replace `x' = `x' / 100000
}				

* ADD PUMAs TO OCC-ONLY FILE -------------------------------------

sort boro cd
merge boro cd using "data_build/sb_to_puma.dta"

* EXPORT OCC-ONLY .CSV FOR R ANALYSIS ---------------------------
	// Note weights intentionally not set
export delimited "hsv_occ_17", replace

* SET STATA SURVEY DESIGN PARAMETERS --------------------------		
	// (see 2017 NYCHVS Guide to Est. Variances, p 34.)		
	// (re: estimates &st errors: "NYCHVS uses SDR, so users should use -vce(sdr)- option" [34].)

svyset[pweight = fw], vce(sdr) sdrweight(fw1-fw80) fay(.5)mse

* SAVE SVYSET DATA --------------------------------------------		

save "data_build/hvs_occ_17.dta", replace

*******************************************************************

* SWITCH TO COMBINED OCCUPIED/VACANT UNIT 2017 DATASET ------------

clear

use "data_raw/hvs_occvac_17.dta", clear

* CONVERT FINAL/REPLICATE WEIGHTS W/ IMPLIED DECIMAL PLACES ------

	// (via 2017 NYCHVS Guide TO Estimating Variances: "Since the final weights & replicate weights have five implied decimal places, users need to convert them ... divide weights by 100,000" [34].)

replace fw = fw/100000

foreach x of var fw1 - fw80 {
	replace `x' = `x' / 100000
}		

/* ADD PUMAs COMBINED OCC-VAC FILE --------------------------------
sort boro cd
merge boro cd using "data_build/sb_to_puma.dta"
	// this doesn't weight the PUMAs
*/

* CREATE PUMA INDICATORS	
gen puma = 0
	replace puma = 3710 if boro == 1 & cd == 1
	replace puma = 3705 if boro == 1 & cd == 2
	replace puma = 3708 if boro == 1 & cd == 3
	replace puma = 3707 if boro == 1 & cd == 4
	replace puma = 3706 if boro == 1 & cd == 5
	replace puma = 3701 if boro == 1 & cd == 6
	replace puma = 3709 if boro == 1 & cd == 7
	replace puma = 3703 if boro == 1 & cd == 8 
	replace puma = 3704 if boro == 1 & cd == 9
	replace puma = 3702 if boro == 1 & cd == 10
	replace puma = 4001 if boro == 2 & cd == 1
	replace puma = 4004 if boro == 2 & cd == 2
	replace puma = 4003 if boro == 2 & cd == 3
	replace puma = 4002 if boro == 2 & cd == 4
	replace puma = 4008 if boro == 2 & cd == 5
	replace puma = 4005 if boro == 2 & cd == 6
	replace puma = 4012 if boro == 2 & cd == 7
	replace puma = 4006 if boro == 2 & cd == 8
	replace puma = 4011 if boro == 2 & cd == 9
	replace puma = 4013 if boro == 2 & cd == 10
	replace puma = 4017 if boro == 2 & cd == 11
	replace puma = 4014 if boro == 2 & cd == 12
	replace puma = 4018 if boro == 2 & cd == 13
	replace puma = 4015 if boro == 2 & cd == 14
	replace puma = 4016 if boro == 2 & cd == 15
	replace puma = 4007 if boro == 2 & cd == 16
	replace puma = 4010 if boro == 2 & cd == 17
	replace puma = 4009 if boro == 2 & cd == 18
	replace puma = 3810 if boro == 3 & cd == 1
	replace puma = 3809 if boro == 3 & cd == 2
	replace puma = 3807 if boro == 3 & cd == 3
	replace puma = 3808 if boro == 3 & cd == 4
	replace puma = 3806 if boro == 3 & cd == 5
	replace puma = 3805 if boro == 3 & cd == 6
	replace puma = 3802 if boro == 3 & cd == 7
	replace puma = 3803 if boro == 3 & cd == 8
	replace puma = 3804 if boro == 3 & cd == 9
	replace puma = 3801 if boro == 3 & cd == 10
	replace puma = 4101 if boro == 4 & cd == 1
	replace puma = 4109 if boro == 4 & cd == 2
	replace puma = 4102 if boro == 4 & cd == 3
	replace puma = 4107 if boro == 4 & cd == 4
	replace puma = 4110 if boro == 4 & cd == 5
	replace puma = 4108 if boro == 4 & cd == 6
	replace puma = 4103 if boro == 4 & cd == 7
	replace puma = 4106 if boro == 4 & cd == 8
	replace puma = 4111 if boro == 4 & cd == 9
	replace puma = 4113 if boro == 4 & cd == 10
	replace puma = 4104 if boro == 4 & cd == 11
	replace puma = 4112 if boro == 4 & cd == 12
	replace puma = 4105 if boro == 4 & cd == 13
	replace puma = 4114 if boro == 4 & cd == 14
	replace puma = 3903 if boro == 5 & cd == 1
	replace puma = 3902 if boro == 5 & cd == 2
	replace puma = 3901 if boro == 5 & cd == 3

label define puma_label ///
3710	"Bronx: Mott Haven/Hunts Point"		///
3705	"Bronx: Morrisania/East Tremont"		///
3708	"Bronx: Highbridge/S. Concourse"		///
3707	"Bronx: University Heights/Fordham"		///
3706	"Bronx: Kingsbridge Heights/Mosholu"		///
3701	"Bronx: Riverdale/Kingsbridge"		///
3709	"Bronx: Soundview/Parkchester"		///
3703	"Bronx: Throgs Neck/Co-op City"		///
3704	"Bronx: Pelham Parkway"		///
3702	"Bronx: Williamsbridge/Baychester"		///
4001	"Brooklyn: Williamsburg/Greenpoint"		///
4004	"Brooklyn: Brooklyn Heights/Fort Greene"		///
4003	"Brooklyn: Bedford Stuyvesant"		///
4002	"Brooklyn: Bushwick"		///
4008	"Brooklyn: East New York/Starrett City"		///
4005	"Brooklyn: Park Slope/Carroll Gardens"		///
4012	"Brooklyn: Sunset Park"		///
4006	"Brooklyn: North Crown Heights/Prospect Heights"		///
4011	"Brooklyn: South Crown Heights"		///
4013	"Brooklyn: Bay Ridge"		///
4017	"Brooklyn: Bensonhurst"		///
4014	"Brooklyn: Borough Park"		///
4018	"Brooklyn: Coney Island"		///
4015	"Brooklyn: Flatbush"		///
4016	"Brooklyn: Sheepshead Bay/Gravesend"		///
4007	"Brooklyn: Brownsville/Ocean Hill"		///
4010	"Brooklyn: East Flatbush"		///
4009	"Brooklyn: Flatlands/Canarsie"		///
3810	"Manhattan: Greenwich Village/Financial District"		///
3809	"Manhattan: Lower East Side/Chinatown"		///
3807	"Manhattan: Chelsea/Clinton/Midtown"		///
3808	"Manhattan: Stuyvesant Town/Turtle Bay"		///
3806	"Manhattan: Upper West Side"		///
3805	"Manhattan: Upper East Side"		///
3802	"Manhattan: Morningside Heights/Hamilton Heights"		///
3803	"Manhattan: Central Harlem"		///
3804	"Manhattan: East Harlem"		///
3801	"Manhattan: Washington Heights/Inwood"		///
4101	"Queens: Astoria"		///
4109	"Queens: Sunnyside/Woodside"		///
4102	"Queens: Jackson Heights"		///
4107	"Queens: Elmhurst/Corona"		///
4110	"Queens: Middle Village/Ridgewood"		///
4108	"Queens: Forest Hills/Rego Park"		///
4103	"Queens: Flushing/Whitestone"		///
4106	"Queens: Hillcrest/Fresh Meadows"		///
4111	"Queens: Kew Gardens/Woodhaven"		///
4113	"Queens: Howard Beach/S. Ozone Park"		///
4104	"Queens: Bayside/Little Neck"		///
4112	"Queens: Jamaica"		///
4105	"Queens: Bellerose/Rosedale"		///
4114	"Queens: Rockaways"		///
3903	"Staten Island: North Shore"		///
3902	"Staten Island: Mid-Island"		///
3901	"Staten Island: South Shore"		

label values puma puma_label
d puma
tab puma
tab puma, nolab

* EXPORT OCC-VAC .CSV FOR R ANALYSIS ---------------------------
	// Note weights intentionally not set
export delimited "hsv_occvac_17", replace
		
* SET SURVEY DESIGN PARAMETERS --------------------------------		
	// (see 2017 NYCHVS Guide to Est. Variances, p 34.)		
	// (re: estimates &st errors: "NYCHVS uses SDR, so users should use -vce(sdr)- option" [34].)

svyset[pweight = fw], vce(sdr) sdrweight(fw1-fw80) fay(.5)mse

* SAVE SVYSET DATA --------------------------------------------		
	// ?? R EXP/IMP/ANALYSIS ??

save "data_build/hvs_occvac_17.dta", replace	

*******************************************************************


	
	
*****************************************************************/

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

* 3. RECODE/RELABEL FOR LEGIBILITY ------------------------------

rename	hhr2	sex
rename	uf66	yrmoved
rename	hhr3t	age
rename	uf67	whymoved		
rename 	sc115	own
rename	uf69	race

* Generate simpler indicator variables --------------------------

* Occupied
gen occ = (recid == 1)
	label variable occ "occupied unit indicator"

* Section 8
gen sec8 = sc541 == 1 & occ == 1
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
	
* Rent stabilization/control/asst status
	// see https://www1.nyc.gov/assets/hpd/downloads/pdfs/services/rent-regulation-memo-1.pdf Table 1 & footnote for possible clarification.

gen rent_st = 0
	label variable rent_st "Rent stabilization status"
	replace rent_st = 1 if uf_csr == 1 | uf_csr == 2 | uf_csr == 12 | uf_csr == 86
	replace rent_st = 2 if uf_csr == 5
	replace rent_st = 3 if uf_csr == 30 | uf_csr == 31
	replace rent_st = 4 if uf_csr == 90
	replace rent_st = 5 if uf_csr == 21 | uf_csr == 95
	replace rent_st = 6 if uf_csr == 85
	replace rent_st = 7 if uf_csr == 80
	replace rent_st = 8 if uf_csr == 3 | uf_csr == 7
	replace rent_st = 9 if uf_csr == 4

label define asstLabel /// 
	1 "Owner-occupied (incl M-L coops)" ///
	2 "Public housing" ///
	3 "Stabilized, pre or post 1947" ///
	4 "Rent controlled" ///
	5 "HUD/other regulated, or in rem" ///
	6 "Mitchell-Lama rental or Article 4" ///
	7 "Private, unregulated rental" ///
	8 "Vacant, FS, private/unregulated" ///
	9 "Unit unavailable/vacant"

label values rent_st asstLabel

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

* Rent Burden: Legibility for 1 Implied Decimal Place
rename	uf30	rentbrd						// legibility
replace rentbrd = .a if rentbrd == 0000		// "Not computed"
replace rentbrd = .b if rentbrd == 9999		// "N/A"
replace rentbrd = rentbrd/10				// 
tab rentbrd

* Household Income

rename	uf42	hhinc
replace hhinc = .a if hhinc == 9999999
sum hhinc, d
tab hhinc if hhinc <0						// 37 obs w/ neg inc

save "data_build/cleaner_hvs_occvac_17.dta", replace

/* TO DO: 
	* recode race variable for a simpler Latinx measure
	* recode missing values in other vars of interest (this one's maddening; the 999 v 99999 v 9999999s are inconsistently applied)
 
