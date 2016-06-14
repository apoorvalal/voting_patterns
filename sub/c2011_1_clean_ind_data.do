loc path "${raw_2011}"
ls "`path'"
loc merge_id "DIST VDCMUN WARD EA HNO HHNO"
loc ind_id "`merge_id' IDCODE"
use "`path'/Individual01.dta", clear



