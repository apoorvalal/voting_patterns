clear
use "/Users/Apoorva/Downloads/Data/Nepal Census 2001/Files Downloaded from Cornell/HouseholdDataMaster2001.dta"

gen HouseholdQualIndex = (q07_area >0.2) + (q01_htyp == 1) 
gen Amenitiesindex = RadioDummy + TVDummy + (q3_lighf == 1)
gen WaterQualIndex = (q1_wsorc < 2) + (q1_wsorc < 3)
gen EnergyQualIndex = (q2_cookf == 3) +(q3_lighf == 1) + 0.5*(q3_lighf == 2)
gen SanitationQualIndex = (q4_toilf<2) + (q4_toilf<3)
gen GenderEquityPropertyIndex = (FHouseOwnDummy == 1) + (FLandOwnDummy == 1) + 0.25*(FLivestockOwnDummy == 1)
bysort DistCons: egen HHcount = count(hhld)


*gen MigDummy = (q11_abst == 1)

gen UrbanDummy = (urbnrurl == 1)


collapse (mean) Amenitiesindex HouseholdQualIndex WaterQualIndex EnergyQualIndex ///
	HHcount SanitationQualIndex GenderEquityPropertyIndex MigDummy ///
	HHTot ConstotPop ELF BCNDummy  UrbanDummy ///
	BCNPct ERPol AgDummy, by (DistCons) 

cd "/Users/Apoorva/Downloads/Data/Nepal Census 2001/Files Downloaded from Cornell/"
	
     foreach x of varlist Amenitiesindex HouseholdQualIndex WaterQualIndex EnergyQualIndex HHcount ///
	 SanitationQualIndex GenderEquityPropertyIndex MigDummy HHTot ConstotPop ELF BCNDummy ///
	BCNPct ERPol AgDummy  UrbanDummy {
	 gen `x'2001 = `x'
	 drop `x'
	 }



save "ConsLevelCensus2001.dta", replace

use "ConsLevelCensus2001.dta", clear
