clear
cd "/Users/Apoorva/Downloads/Data/LSMS 2003-04"
use "LSMS 2003-04"
br

/*
gen str Dist_VDC = DistrictName + "-" + VDCName
drop _merge
merge m:1 Dist_VDC using "MappingConstituencies2.dta", update
drop _merge
codebook ConsName

tabout ConsName Phase using "ToMap.txt" 
*Manually sorted constituencies that didn't have VDC attached to them

tab misc ConsName
tab Misc ConsName
save "LSMS 2003-04.dta", replace


br if Misc != ""
br WWW Phase DistrictName ConsName Dist_VDC
br WWW WWWHH Phase DistrictName ConsName Dist_VDC
br if Misc != ""

*/

br WWW WWWHH Phase DistrictName ConsName Constituency Dist_VDC Misc if Misc != ""

sort DistrictName WWW WWWHH

* Something is wrong with Achham and Baitadi

* Achham & Baitadi - to be sorted out later
/*
replace Constituency = 1 if Phase ==  1 & DistrictName == "Achham" | Phase ==  2 & DistrictName == "Achham" 
replace Constituency = 2 if Phase ==  3 & DistrictName == "Achham" 
replace Constituency = 1 if Phase ==  1 & DistrictName == "Baitadi" 
replace Constituency = 2 if Phase ==  2 & DistrictName == "Baitadi" 
*/

*Chitwan
replace Constituency = 1 if Phase ==  3 & DistrictName == "Chitwan" 
replace Constituency = 3 if Phase !=  3 & DistrictName == "Chitwan" 
*Dhankuta 
replace Constituency = 1 if mod(WWWHH,2) == 1 & DistrictName == "Dhankuta" 
replace Constituency = 2 if mod(WWWHH,2) == 0 & DistrictName == "Dhankuta" 
*Kaski 2,3,4
replace Constituency = Phase+1 if  DistrictName == "Kaski"
*Kathmandu - distribute evenly
br WWW WWWHH Phase DistrictName ConsName Constituency Dist_VDC Misc if Misc != "" & DistrictName == "Kathmandu"
gen mod11 = mod(WWWHH, 11) if Constituency == . & DistrictName == "Kathmandu"
replace Constituency = mod11 if mod11 != . & DistrictName == "Kathmandu"
*Lalitpur 2,3
replace Constituency = 2 if Phase <3 & DistrictName == "Lalitpur"
replace Constituency = 3 if Phase  == 3 & DistrictName == "Lalitpur"
*Morang - 4,6,7,8
replace mod11 = .
replace mod11 = mod(WWWHH,4) if Constituency == . & DistrictName == "Morang"
replace Constituency = 4 if mod11 == 0 & DistrictName == "Morang"
replace Constituency = 6 if mod11 == 1 & DistrictName == "Morang"
replace Constituency = 7 if mod11 == 2 & DistrictName == "Morang"
replace Constituency = 8 if mod11 == 3 & DistrictName == "Morang"
*Nuwakot 
replace Constituency = 2 if mod(WWWHH,2) == 1 & DistrictName == "Nuwakot"
replace Constituency = 3 if mod(WWWHH,2) == 0 & DistrictName == "Nuwakot"
*Parsa
replace Constituency = Phase - 1 if Constituency == . & DistrictName == "Parsa"

br
drop mod11 n
replace ConsName = DistrictName + "-" + string(Constituency)




