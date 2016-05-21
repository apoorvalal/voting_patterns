clear
*General PSU Data
set more off

cd "/Users/Apoorva/Downloads/Data/LSMS 2010-11/Rural Community/"

*Ethnic Composition
use "Section 1A Ethnicity Composition.dta"
describe
bysort PSU: egen ethcount = count (NumHH)
label variable ethcount "Number of Ethnicities recorded"
codebook ethcount
codebook PercHH
save "Section 1A Ethnicity Composition.dta", replace
collapse (mean) ethcount (sum) NumHH, by (PSU)
if ethcount == 0 replace ethcount =.
save "EthCompCollapsed.dta", replace

*Language composition
use "Section 1A Language Composition.dta"
bysort PSU: egen langcount = count (HHNum)
label variable langcount "Number of Languages recorded"
save "Section 1A Language Composition.dta", replace
collapse (mean) langcount (sum) HHNum, by (PSU)
*if ethcount == 0 replace ethcount =.
save "LangCompCollapsed.dta", replace

*Religious Composition
use "Section 1A Religious Composition.dta"
bysort PSU: egen relcount = count (NumHH)
codebook relcount
label variable relcount "Number of religions recorded"
save "Section 1A Religious Composition.dta", replace
collapse (mean) relcount (sum) NumHH, by (PSU)
save "RelCompCollapsed.dta", replace

*School Access
use "Section 2A Education.dta"
bysort PSU: egen numsklacc = count (SklNum)
label variable numsklacc "Number of Schools accessible from PSU"
save "Section 2A Education.dta", replace
collapse (mean) numsklacc, by (PSU)
save "SklAccess.dta", replace

/*Health Access
use "Section 2B Health Facilities.dta"
describe
summarize
bysort PSU: egen numhealthacc = count(r02b_seq)
label variable numhealthacc "Number of Health Facilities accessible from PSU"
codebook numhealthacc

*/

use "Section 7 Markets & Prices (HH Level).dta"
describe
summarize

