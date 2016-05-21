/*clear
cd "/Users/Apoorva/Downloads/Data/LSMS 2010-11/Household Data"
use "1 Household Roster.dta"
merge m:1 xhpsu xhnum xstra using "Sample.dta", update nogenerate
*/
clear
cd "/Users/Apoorva/Downloads/Data/LSMS 2010-11/Household Data"
use "Sample.dta"
gen str hhid = string(xhpsu) + "-" + string(xhnum)

bysort hhid: egen remitdummy = min(v17_11)
label define remit 1 "yes" 2 "no"
label values remitdummy remit
label variable remitdummy "Remittances received"
//region sorting
gen regionIndex = 0
replace regionIndex = 1 if (xstra == 218) //kathmandu
replace regionIndex = 2 if (xstra == 219 | xstra == 310 ) //Other Urban
replace regionIndex = 3 if (xstra == 223 | xstra == 224  | xstra == 225 ) // rural western mtn, hills
replace regionIndex = 4 if (xstra == 221 | xstra == 222  | xstra == 100 ) // rural eastern mtn, hills
replace regionIndex = 5 if (xstra == 323 | xstra == 324  | xstra == 325 ) // rural western terai
replace regionIndex = 6 if (xstra == 321 | xstra == 322) // rural eastern terai

label define region 1 "Kathmandu" 2 "Other Urban" 3 "Rural Western Mountains & Hills" 4 "Rural Eastern Mountains and hills" ///
	5 "Rural Western Terai" 6 "Rural Eastern Terai"

label values regionIndex region

// by region
gen rem = 1 if remitdummy == 1
bysort regionIndex: egen remitTally = total(rem)
bysort regionIndex: egen regionTally = count(regionIndex)
gen remReceiptPct = (remitTally/regionTally)*100
tab regionIndex remReceiptPct

//by land ownership

codebook v13_02
bysort v13_02:  egen LandRemitTally = total(rem)
bysort v13_02:  egen LandStatusTally = count(v13_02) 
gen LandRemReceiptPct = (LandRemitTally/LandStatusTally)*100

