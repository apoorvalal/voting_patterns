clear
cd "/Users/Apoorva/Downloads/Data/Nepal Census 2011/"
use "Household.dta"

cap drop householdcount
// bysort DistCons: egen HHcount = count(VDCMUN)

egen Amenitiesindex = rownonmiss(H07A H07B H07C H07D H07E H07F H07G H07H H07I H07J H07K H07L)

gen HouseholdQualIndex = (H022 == 2) + (H021 == 2) + (H021 == 4 | H021 == 3 | H022 == 4)
replace HouseholdQualIndex =  HouseholdQualIndex + H024

label define HHQ 510 "Very High" 3 "High" 4 "High" 2 "Medium" 1 "Low"
label values HouseholdQualIndex HHQ

g WaterQualIndex = (H03 < 2) + (H03 < 3)

g EnergyQualIndex = (H04 == 3 | H04 == 6 | H04 == 5) + (H05 == 1) + 0.5*(H05 == 4) +  0.5*(H05 == 2 |H04 == 2)

g SanitationQualIndex = (H06<3) + (H06<4)
g GenderEquityPropertyIndex = (H08 == 1 | H 09 == 1)


use "/Users/Apoorva/Downloads/Data/Nepal Census 2011/HHMaster2011.dta", clear

gen UrbanDummy = (URB_RUR == 1)


gen Qtransform = (((0.5-EthPctInCons)/0.5)^2) * EthPctInCons
bysort DistCons: egen ConsQTransform = total(Qtransform * tag)

	
collapse (mean) Amenitiesindex HouseholdQualIndex WaterQualIndex EnergyQualIndex ///
	HHcount SanitationQualIndex GenderEquityPropertyIndex MigDummy ///
	HHTot ELF BCNDummy ERPol  UrbanDummy AgDummy, by (DistCons) 
	
save "/Users/Apoorva/Downloads/Data/Nepal Census 2011/ConsLevelCensus2011.dta", replace

*egen totHHcount = total(HHcount)
*gen HHWeight = HHcount /  totHHcount


clear
cd "/Users/Apoorva/Downloads/Data/Nepal Census 2011/"
use  "ConsLevelCensus2011.dta"

foreach x of varlist Amenitiesindex HouseholdQualIndex WaterQualIndex ///
EnergyQualIndex HHcount SanitationQualIndex GenderEquityPropertyIndex MigDummy ///
HHTot ELF BCNDummy ERPol AgDummy UrbanDummy {
	gen `x'2011 = `x'
	drop `x'
}


save  "ConsLevelCensus2011.dta", replace
use  "ConsLevelCensus2011.dta",clear
replace DistCons = subinstr(DistCons, "kavrepalanchok", "kavre", .)


merge 1:1 DistCons using "/Users/Apoorva/Downloads/Data/Nepal Census 2001/Files Downloaded from Cornell/ConsLevelCensus2001.dta", update

gen DiffMig =MigDummy2011 - MigDummy2001


save "PanelCensus.dta", replace



replace District = "chitwan" if District == "chitawan"
replace District = "dhanusha" if District == "dhanusa"
replace District = "kapilvastu" if District == "kapilbastu"
replace District = "kavrepalanchowk" if District == "kavrepalanchok"
replace District = "ramechap" if District == "ramechhap"
replace District = "sindhupalchowk" if District == "sindhupalchok"
replace District = "udaypur" if District == "udayapur"

save "PanelCensus.dta", replace

clear
use "PanelCensus.dta"

merge 1:1 District using "PanelResults.dta", update







