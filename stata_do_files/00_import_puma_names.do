capture log close
clear all
prog drop _all
set more off
version 17.0
set linesize 80

* Convert PUMA Excel to .dta
import excel using data_raw/sb_to_puma.xlsx, firstrow clear

* Sort
sort boro cd

* Save as .dta
save "data_build/sb_to_puma.dta", replace
