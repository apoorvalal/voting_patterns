clear
capture log close
cd "/Users/Apoorva/Downloads/Data/LSMS 1995-96/Household Data/Household Level/"
use "Z01B Dwelling Info.dta"
log using "/Users/Apoorva/Downloads/Data/LSMS 1995-96/Household Data/Household Level/mergingHHLData.log", replace
merge 1:1 WWWHH using "Z02C1 Facilities.dta", keep(match master using) nogenerate update
merge 1:1 WWWHH using "Z02C2 Facilities.dta", keep(match master using) nogenerate  update
merge 1:1 WWWHH using "Z05A Food Expense and Home Production (Collapsed).dta", keep(match master using) nogenerate  update
merge 1:1 WWWHH using "Z05B Home Production.dta", keep(match master using) nogenerate  update
merge 1:1 WWWHH using "Z06A Frequent Non-food Expense (Collapsed).dta", keep(match master using) nogenerate  update
merge 1:1 WWWHH using "Z06B Infrequent Non-food Expense (Collapsed).dta", keep(match master using) nogenerate  update
merge 1:1 WWWHH using "Z06C Inventory of Durable Goods (Collapsed).dta", keep(match master using) nogenerate  update
merge 1:1 WWWHH using "Z12A1C Landholding (Collapsed).dta", keep(match master using) nogenerate  update
merge 1:1 WWWHH using "Z12A2A Landholding.dta", keep(match master using) nogenerate  update
merge 1:1 WWWHH using "Z12A3 Landholding.dta", keep(match master using) nogenerate  update
merge 1:1 WWWHH using "Z12B2 Production and Distribution (Collapsed).dta", keep(match master using) nogenerate  update
merge 1:1 WWWHH using "Z12B2 Production and Distribution.dta", keep(match master using) nogenerate  update
merge 1:1 WWWHH using "Z12C1A Seeds and Young Plants.dta", keep(match master using) nogenerate  update
merge 1:1 WWWHH using "Z12C2A Fertilizers and Insecticides.dta", keep(match master using) nogenerate  update
merge 1:1 WWWHH using "Z12C2C.dta", keep(match master using) nogenerate  update
merge 1:1 WWWHH using "Z12C3A Expenditures on hiring labor.dta", keep(match master using) nogenerate  update
merge 1:1 WWWHH using "Z12C3C.dta", keep(match master using) nogenerate  update
merge 1:1 WWWHH using "Z12E1A Livestock.dta", keep(match master using) nogenerate  update
merge 1:1 WWWHH using "Z12E1B.dta", keep(match master using) nogenerate  update
merge 1:1 WWWHH using "Z12E2 Earnings from livestock (Collapsed).dta", keep(match master using) nogenerate  update
merge 1:1 WWWHH using "Z12E2 Earnings from livestock.dta", keep(match master using) nogenerate  update
merge 1:1 WWWHH using "Z12F Farming Assets (Collapsed).dta", keep(match master using) nogenerate  update
merge 1:1 WWWHH using "Z12G Agricultural Extension.dta", keep(match master using) nogenerate  update
merge 1:1 WWWHH using "Z13A1 General Characteristics.dta", keep(match master using) nogenerate  update
merge 1:1 WWWHH using "Z13B Income from Enterprises (Collapsed).dta", keep(match master using) nogenerate  update
merge 1:1 WWWHH using "Z14A1 Borrowing.dta", keep(match master using) nogenerate  update
merge 1:1 WWWHH using "Z14B1 Lending.dta", keep(match master using) nogenerate  update
merge 1:1 WWWHH using "Z14C Other Assets.dta", keep(match master using) nogenerate  update
merge 1:1 WWWHH using "Z16 Other Assets and Income (Collapsed).dta", keep(match master using) nogenerate  update
cd "/Users/Apoorva/Downloads/Data/LSMS 1995-96/Household Data/Individual Level/"
merge 1:1 WWWHH using "Z15B1 Remittances Received.dta", keep (match master using) nogenerate update force
merge 1:1 WWWHH using  "Z15B2 RemittancesReceived(Collapsed).dta", keep (match master using) nogenerate update force
save "mergedHHLDLevel96.dta", replace

/*
*Sum all remittance received numbers
cd "/Users/Apoorva/Downloads/Data/LSMS 1995-96/Household Data/Individual Level/"
use "Z15B2 RemittancesReceived(Collapsed).dta"
bysort WWWHH: egen TotRemit = total(AmtRec+AmtRecKd)

save "Z15B2 Remittances Received.dta", replace

collapse (mean) TotRemit RegDon NumOfEmigrants (max) DistDon, by (WWWHH)
save "Z15B2 RemittancesReceived(Collapsed).dta", replace
