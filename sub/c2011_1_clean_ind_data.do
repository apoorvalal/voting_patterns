loc path "${raw_2011}"
ls "`path'"
loc hh_id "DIST VDCMUN WARD EA HNO HHNO"
loc ind_id "`hh_id' IDCODE"
use "`path'/Individual01.dta", clear
// Caste
bys `hh_id': egen hh_caste = mode(Q06), maxmode
la values hh_caste Q06
// Religion
bys `hh_id': egen hh_rel = mode(Q09), maxmode
la values hh_rel Q09
// Lang
bys `hh_id': egen hh_lang = mode(Q10_2), maxmode
la values hh_lang Q10_2
// Education Level
bys `hh_id': egen hh_lit = mode(Q13), maxmode
la values hh_lang Q13
// gender balance
recode Q04 (1 = 0) (2 = 1) // female dummy
cap la drop Q04
la def Q04 0 Male 1 Female
la values Q04 Q04
bys `hh_id': egen hh_gender = mean(Q04)

drop ID2  HHCaste HHMTong LiterateDummy HHLiteracy HHRel stHHCaste stHHMTong stHHRel

bys `hh_id': keep if _n == _N

keep `hh_id' hh_*
compress
save "${tmp}/hh_level_caste", replace
