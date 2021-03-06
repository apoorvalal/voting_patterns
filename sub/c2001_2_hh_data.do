loc path "${raw_2001}"

// vars in memory
 // batchid hhld idcode q3_sex q4_age q5_caste q6_reltn q7_relgn q8_mtong q8_slang q9_citzn q10_dibl q2_sex q3_age q4_bplce q4a_dist q4b_vdcm q4c_ctry q5_durtn q6_rstay q7_li5ya q7a_dist q7b_vdcm q7c_ctry q8_edutn q9a_elvl q9b_fstd q10_catt q11_msta q12_fage q13_stog q13_dtog q13_ssep q13_dsep q13_sded q13_dded q13_stot q13_dtot q14_livb q14_1sex q14_1yer q14_1mth q14_2sex q14_2yer q14_2mth q15_work q16_wrkm q16_ewkm q16_swkm q16_nwkm q17_occ1 q18_ind1 q19_esta q20_resn q21_liar

use "${temp}/merged_ind_lev_c2001", clear

loc hh_id "batchid hhld"
bys `hh_id': egen hh_caste = mode(q5_caste), maxmode
tempvar t
bys `hh_id': g `t' = (q5_caste[_n] != q5_caste[_n-1]) * (_n != 1)
bys `hh_id': egen hh_multi_caste = max(`t')
bys `hh_id': egen hh_rel = mode(q7_relgn), maxmode
bys `hh_id': egen hh_lang = mode(q8_mtong), maxmode
bys `hh_id': egen hh_lit = mode(q8_edutn), maxmode
recode q3_sex (1 = 0) (2 = 1) // female dummy
bys `hh_id': egen hh_gender = mean(q3_sex)

la var hh_caste "HH caste"
la var hh_multi_caste "Multi-caste household - flag"
la var hh_rel  "HH Religion"
la var hh_lang "HH language"
la var hh_lit "HH literacy"
la var hh_gender "HH gender-balance "

cap la drop Q04
la def q3_sex 0 Male 1 Female
la val q3_sex q3_sex

la val hh_caste  ethnnp_lbl
la val hh_rel relig_lbl
la val hh_lang mtngnp_lbl
la val hh_lit q8_edutn
la val hh_gender q3_sex

loc level `hh_id' 
bys `level': keep if _n == _N 

merge m:1 batchid hhld using "`path'/smplhi01.dta", nogen keep(1 3)
merge m:1 batchid hhld using "`path'/smplhi02.dta", nogen keep(1 3)
merge m:1 batchid using "`path'/batchid.dta", nogen keep(1 3)
drop ${vars_to_label}  idcode q3_sex q4_age q5_caste q6_reltn q7_relgn q8_mtong q8_slang q9_citzn q10_dibl  aglanddummy livestockdummy FHouseOwnDummy FLandOwnDummy FLivestockOwnDummy SNAgEcAcDummy AbsenteeDummy UniqueHHLDIdentifier

la var batchid "Batch ID"
la var hhld "Household ID"
la var q01_htyp "1. Type of housing unit occupied by the household"
la var q02_otyp "2. Tenure of housing unit"
la var q07_area "Land Area"
la var q08_bhfe "Total Big Head Livestock"
la var q08_shfe "Total Small Head Livestock"
la var q10_mact "Main activity of household"
la var q1_wsorc "Main source of drinking water"
la var q2_cookf "Main source of fuel used for cooking"
la var q3_lighf "Main source of fuel used for lighting"
la var q4_toilf "Type of toilet facility"
la var q5a_hhfa "Radio"
la var q5b_hhfa "TV"
la var q6_death "Death in last 12 months"

recode q03_agld (2 = 0) (1 = 1), g (Aglanddummy)
recode q05_lvst (2 = 0) (1 = 1), g (Livestockdummy)
recode q07_hfem (2 = 0) (1 = 1), g (FHouseOwnDummy)
recode q07_lfem (2 = 0) (1 = 1), g (FLandOwnDummy)
recode q08_lvfe (2 = 0) (1 = 1), g (FLivestockOwnDummy)
recode q09_heco (2 = 0) (1 = 1), g (SNAgEcAcDummy)
recode q11_abst (2 = 0) (1 = 1), g (AbsenteeDummy)
recode q5a_hhfa (. = 0) (1 = 1), g (RadioDummy)
recode q5b_hhfa (. = 0) (2 = 1), g (TVDummy)
recode q6_death (2 = 0) (1 = 1), g (DeathInHHDummy)


cap la def wsorc 1 "Tap" 2 "Well" 3 "Tube Well" 4 "Spout" 5 "River/Stream" 6 "Others" 9 "NR"
cap la def cookf 1 "Wood" 2 "Kerosene" 3 "LPG" 4 "Biogas" 5 "Cow Dung" 6 "Others" 9 "NR"
cap la def lightf 1 "Electricity" 2 "Kerosene" 3 "Biogas" 4 "Others" 9 "NR"
cap la def toilf 1 "Modern" 2 "Ordinary" 3 "None" 9 "NR"
cap la def mact 1 "Small Industry" 2 "Business/Trade" 3 "Transport" 4 "Service" 5 "Others"
cap la def htyp 1 "Permanent" 2 "Semi-Permanent" 3 "Temporary" 4 "Others"
cap la def otyp 1 "Own" 2 "Rented" 3 "Institutional" 4 "Rent-Free"
cap la val q01_htyp htyp
cap la val q02_otyp otyp
cap la val  q1_wsorc wsorc
cap la val q2_cookf cookf
cap la val  q3_lighf lightf
cap la val q4_toilf toilf
cap la val q10_mact mact

drop _*


la var q03_agld "I have no idea what these vars are"
la var q05_lvst "I have no idea what these vars are"
la var q06_tlvs "I have no idea what these vars are"
la var q06_tpol "I have no idea what these vars are"
la var q07_hfem "I have no idea what these vars are"
la var q07_lfem "I have no idea what these vars are"
la var q08_lvfe "I have no idea what these vars are"
la var q09_heco "I have no idea what these vars are"
la var q11_abst "I have no idea what these vars are"


save "${temp}/c_2001_hh_master", replace

