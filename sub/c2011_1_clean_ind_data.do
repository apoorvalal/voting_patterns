loc path "${raw_2011}"
ls "`path'"
loc hh_id "DIST VDCMUN WARD EA HNO HHNO"
loc ind_id "`hh_id' IDCODE"
use "`path'/Individual01.dta", clear
// Caste
bys `hh_id': egen hh_caste = mode(Q06)
la values hh_caste Q06
// Religion
bys `hh_id': egen hh_rel = mode(Q09)
la values hh_rel Q09
// Lang
bys `hh_id': egen hh_lang = mode(Q10_2)
la values hh_lang Q10_2
// Education Level
bys `hh_id': egen hh_lit = mode(Q13)
la values hh_lang Q13

drop ID2 

save "${tmp}/ind_lev_merged", replace

