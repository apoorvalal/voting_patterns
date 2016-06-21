loc hh_id "DIST VDCMUN WARD EA HNO HHNO"
use "${tmp}/hh_w_geo_ids", clear
merge 1:1 `hh_id' using "${tmp}/hh_level_caste", nogen
cap drop householdcount
// bysort DistCons: egen HHcount = count(VDCMUN)
egen Amenitiesindex = rownonmiss(H07A H07B H07C H07D H07E H07F H07G H07H H07I H07J H07K H07L)
g HouseholdQualIndex = (H022 == 2) + (H021 == 2) + (H021 == 4 | H021 == 3 | H022 == 4)
replace HouseholdQualIndex =  HouseholdQualIndex + H024
label define HHQ 510 "Very High" 3 "High" 4 "High" 2 "Medium" 1 "Low"
label values HouseholdQualIndex HHQ
g WaterQualIndex = (H03 < 2) + (H03 < 3)
g EnergyQualIndex = (H04 == 3 | H04 == 6 | H04 == 5) + (H05 == 1) + 0.5*(H05 == 4) +  0.5*(H05 == 2 |H04 == 2)
g SanitationQualIndex = (H06<3) + (H06<4)
g GenderEquityPropertyIndex = (H08 == 1 | H 09 == 1)
save "${output}/c_2011_full", replace

