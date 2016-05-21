/*GENERATE INDIVIDUAL ID for each observation in each dataset for
cross-dataset merging */
#delimit 
clear 
set more off 
cd "/Users/Apoorva/Downloads/Data/LSMS 1995-96/Household Data/Individual Level/"

*Household Roster
use "Z00 Household Roster.dta"
gen str8 INDID = string(WWWHH) + "-" + string(IDCode)
label variable INDID "Individual ID (WWWHH)-(IDCODE)"
isid INDID
*Tag duplicate observations
save "Z00 Household Roster.dta", replace

*Z01A Parents of HH Members
clear
use "Z01A Parents of HH Members.dta"
gen str8 INDID = string(WWWHH) + "-" + string(IDCode)
label variable INDID "Individual ID (WWWHH)-(IDCODE)"
isid INDID
*Tag duplicate observations
duplicates tag INDID, gen (dup)
save "Z01A Parents of HH Members.dta", replace 

*Z07A Literacy
clear
use "Z07A Literacy.dta"
gen str8 INDID = string(WWWHH) + "-" + string(IDCode)
label variable INDID "Individual ID (WWWHH)-(IDCODE)"
isid INDID
*Tag duplicate observations
duplicates tag INDID, gen (dup)
save "Z07A Literacy.dta", replace 

*Z07B Past Enrollment
clear
use "Z07B Past Enrollment.dta"
gen str8 INDID = string(WWWHH) + "-" + string(IDCode)
label variable INDID "Individual ID (WWWHH)-(IDCODE)"
isid INDID
*Tag duplicate observations
duplicates tag INDID, gen (dup)
save "Z07B Past Enrollment.dta", replace 

*Z07C1 Current Enrollment
clear
use "Z07C1 Current Enrollment.dta"
gen str8 INDID = string(WWWHH) + "-" + string(IDCode)
label variable INDID "Individual ID (WWWHH)-(IDCODE)"
isid INDID
*Tag duplicate observations
duplicates tag INDID, gen (dup)
save "Z07C1 Current Enrollment.dta", replace 

*Z07C2 Current Enrollment
clear
use "Z07C2 Current Enrollment.dta"
gen str8 INDID = string(WWWHH) + "-" + string(IDCode)
label variable INDID "Individual ID (WWWHH)-(IDCODE)"
isid INDID
*Tag duplicate observations
duplicates tag INDID, gen (dup)
save "Z07C2 Current Enrollment.dta", replace 

*Z08A Chronic Illness
clear
use "Z08A Chronic Illness.dta"
gen str8 INDID = string(WWWHH) + "-" + string(IDCode)
label variable INDID "Individual ID (WWWHH)-(IDCODE)"
isid INDID
*Tag duplicate observations
duplicates tag INDID, gen (dup)
save "Z08A Chronic Illness.dta", replace 

*Z08B1 Injuries & Illnesses
clear
use "Z08B1 Injuries & Illnesses.dta"
gen str8 INDID = string(WWWHH) + "-" + string(IDCode)
label variable INDID "Individual ID (WWWHH)-(IDCODE)"
isid INDID
*Tag duplicate observations
duplicates tag INDID, gen (dup)
save "Z08B1 Injuries & Illnesses.dta", replace 

*Z08B2 Injuries & Illnesses
clear
use "Z08B2 Injuries & Illnesses.dta"
gen str8 INDID = string(WWWHH) + "-" + string(IDCode)
label variable INDID "Individual ID (WWWHH)-(IDCODE)"
isid INDID
*Tag duplicate observations
duplicates tag INDID, gen (dup)
save "Z08B2 Injuries & Illnesses.dta", replace 

*Z08C Immunizations
clear
use "Z08C Immunizations.dta"
gen str8 INDID = string(WWWHH) + "-" + string(IDCode)
label variable INDID "Individual ID (WWWHH)-(IDCODE)"
isid INDID
*Tag duplicate observations
duplicates tag INDID, gen (dup)
save "Z08C Immunizations.dta", replace 

*Z09 Anthropometrics
clear
use "Z09 Anthropometrics.dta"
gen str8 INDID = string(WWWHH) + "-" + string(IDCode)
label variable INDID "Individual ID (WWWHH)-(IDCODE)"
isid INDID
*Tag duplicate observations
duplicates tag INDID, gen (dup)
save "Z09 Anthropometrics.dta", replace 

*Z10A1 Maternity History
clear
use "Z10A1 Maternity History.dta"
gen str8 INDID = string(WWWHH) + "-" + string(IDCode)
label variable INDID "Individual ID (WWWHH)-(IDCODE)"
isid INDID
*Tag duplicate observations
duplicates tag INDID, gen (dup)
save "Z10A1 Maternity History.dta", replace 

/* Z10A2 Maternity History
clear
use "Z10A2 Maternity History.dta"
gen str8 INDID = string(WWWHH) + "-" + string(IDCode)
label variable INDID "Individual ID (WWWHH)-(IDCODE)"
isid INDID
*Tag duplicate observations
duplicates tag INDID, gen (dup)
save "Z10A2 Maternity History.dta", replace 
*/ 

*Z10B Pre and Post-natal care
clear
use "Z10B Pre and Post-natal care.dta"
gen str8 INDID = string(WWWHH) + "-" + string(IDCode)
label variable INDID "Individual ID (WWWHH)-(IDCODE)"
isid INDID
*Tag duplicate observations
duplicates tag INDID, gen (dup)
save "Z10B Pre and Post-natal care.dta", replace 

*Z10C Family Planning
clear
use "Z10C Family Planning.dta"
gen str8 INDID = string(WWWHH) + "-" + string(IDCode)
label variable INDID "Individual ID (WWWHH)-(IDCODE)"
isid INDID
*Tag duplicate observations
duplicates tag INDID, gen (dup)
save "Z10C Family Planning.dta", replace 

*Z12A1A Landholding
clear
use "Z12A1A Landholding.dta"
gen str8 INDID = string(WWWHH) + "-" + string(IDCode)
label variable INDID "Individual ID (WWWHH)-(IDCODE)"
isid INDID
*Tag duplicate observations
duplicates tag INDID, gen (dup)
save "Z12A1A Landholding.dta", replace 


*Z15B2 Remittances Received
clear
use "Z15B2 Remittances Received.dta"
gen str8 INDID = string(WWWHH) + "-" + string(IDCodeRes2)
label variable INDID "Individual ID (WWWHH)-(IDCODE)"
*Tag duplicate observations
duplicates tag INDID, gen (dup)
save "Z15B2 Remittances Received.dta", replace 

clear
use "Z17 Adequacy of Consumption.dta"
gen str8 INDID = string(WWWHH) + "-" + string(IDCode)
label variable INDID "Individual ID (WWWHH)-(IDCODE)"
isid INDID
*Tag duplicate observations
duplicates tag INDID, gen (dup)
save "Z17 Adequacy of Consumption.dta", replace 
