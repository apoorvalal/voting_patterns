loc path "${raw_2001}"

loc batchid_vars " batchid belt region district vcode ward urbnrurl Village District"
loc census_vars "cntry year sample serial dwnum pern mign mortn belt region zone district urbnrurl housetyp ownershp aglandop livestck nlivestk npoultry fhouse fland farea flivestk fbiglive fsmlive hhecon hhactiv abroad watsrc fuelcook lighting toilet radio tv death pernum wtper np01a_pernum idcode sex age caste relate religion mtongue lang2 citizen disable samedist bplzone bpldist bplvdc bplcntry durres rstay same5yr zone5yr dist5yr vdc5yr cntry5yr lit edlevel field school marst agemarr malehh femhh maleaway femaway maledead femdead mchborn fchborn births sexbth1 ylstbth1 mlstbth1 sexbth2 ylstbth2 activity mthsecon mthsexec mthsseek mthsnec occ ind classwkr wkreason living16"

use "`path'/smplpi01.dta", clear


exit 111

ds np01a*

foreach v in `r(varlist)' {
	loc nv `=substr("`v'",7,.)'
	di "`nv'"
	cap ren `v' `nv'
}





 // isid cntry year sample serial dwnum pernum RETURNS TRUE


