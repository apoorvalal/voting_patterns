clear
use "/Users/al6/Desktop/Nepal Census Data/Nepal Census 2001/Files Downloaded from Cornell/HouseholdDataMaster2001.dta"

merge m:1 District using "/Users/al6/Desktop/Nepal Census Data/ConsCount.dta", update

gen Constituency = floor(NumberofConstituencies*runiform() + 1)
gen DistCons = District + "-" + string(Constituency)



/*

 generate ui = floor((b-a+1)*runiform() + a)
