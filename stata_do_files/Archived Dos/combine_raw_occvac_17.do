capture log close
clear all
prog drop _all
set more off
version 17.0
set linesize 80

use "data_raw/hvs_17_occ.dta", clear

* Generate combined occupied & vacant unit dataset

append using "data_raw/hvs_17_vac.dta" 

save "data_raw/hvs_occvac_17", replace

