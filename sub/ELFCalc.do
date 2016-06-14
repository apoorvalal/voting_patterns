use "/Users/Apoorva/Downloads/Data/Nepal Census 2011/HHMaster2011.dta", clear

decode  HHCaste, gen (stHHCaste)
egen tag = tag(DistCons stHHCaste)
bysort DistCons: egen NumEthCons = total(tag)

save "/Users/Apoorva/Downloads/Data/Nepal Census 2001/Files Downloaded from Cornell/HouseholdDataMaster2001.dta", replace

contract DistCons stHHCaste, zero freq(count) nomiss
save "HHCasteTally.dta", replace

use "/Users/Apoorva/Downloads/Data/Nepal Census 2001/Files Downloaded from Cornell/HouseholdDataMaster2001.dta"

merge m:1 DistCons stHHCaste using "HHCasteTally.dta", update
drop if _merge !=3

bysort DistCons: egen HHTot = total(count * tag)
* calculate ELF Index


gen EthPctInCons = count/HHTot
gen EthSq = (EthPctInCons)^2

bysort DistCons: egen SumELF = total(EthSq * tag)
gen ELF = 1-SumELF
summarize ELF

gen Qtransform = (((0.5-EthPctInCons)/0.5)^2) * EthPctInCons
bysort DistCons: egen ConsQTransform = total(Qtransform * tag)
rename ConsQTransform ERPol



gen BCNDummy = (stHHCaste == "Brahman - Hill" | stHHCaste == "Brahman - Terai" | stHHCaste == "Chhetri" | stHHCaste == "Newar")   
gen BCNPct = (count*tag*BCNDummy) / HHTot

bysort DistCons: egen ConsBCN = total(BCNPct)

gen AgDummy = (HHOcc == "Skilled agri.,forestry & fishery workers")


gen AgDummy = (HHOccupation == "Agriculture")
