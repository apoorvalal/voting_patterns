loc path "${input}/Nepal Census 2011/pums/assets/datafiles/"
ls "`path'"

* extract labels from batchid file 

use "`path'/batchid.dta", clear
cap mkdir "${code}/sub/labels/"
la dir
loc labels "`r(names)'"
foreach l in `labels' {
	la save `l' using "${code}/sub/labels/batchid_`l'_labels", replace	
}
	
clear