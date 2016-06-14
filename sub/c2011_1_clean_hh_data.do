loc path "${raw_2011}"

*******************************************************
*** Saved Labels, now labelling HH and IND level files
*******************************************************
loc varlist_household "DIST VDCMUN WARD EA HNO HHNO H01 H021 H022 H023 H024 H025 H03 H04 H05 H06 H07A H07B H07C H07D H07E H07F H07G H07H H07I H07J H07K H07L H08 H09 H10B H10K H10D H10R H10A H10P H11 H11NO H13 H13NO"
loc varlist_batchid	"DIST DNAME VDCMUN VNAME DDVVV DEV_REG ECO_BELT ECO_DEV URB_RUR"

use "`path'/household.dta", clear
cap la drop DIST
do "${code}/sub/labels/batchid_DIST_labels"
la val DIST DIST
compress

foreach v of varlist _all{
	format %10.0g `v' 
}
qui la dir
loc labels "`r(names)'"
foreach l in `labels' {
	la save `l' using "${code}/sub/labels/hh_`l'_labels", replace	
}

merge m:1 DIST VDCMUN using "`path'/batchid", nogen 

save "${tmp}/hh_w_geo_ids", replace
