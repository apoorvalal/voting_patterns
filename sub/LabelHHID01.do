clear 
cd "/Users/Apoorva/Downloads/Data/Nepal Census 2001/Files Downloaded from Cornell/"
use "smplhi01.dta"
br
label variable batchid "Batch ID"
label variable hhld "Household ID"
label variable q01_htyp "House type"
label define htyp 1 "Permanent" 2 "Semi-Permanent" 3 "Temporary" 4 "Others"
label values q01_htyp htyp
codebook  q01_htyp

label variable q02_otyp "House Ownership type"
label define otyp 1 "Own" 2 "Rented" 3 "Institutional" 4 "Rent-Free"
label values q02_otyp otyp
codebook q02_otyp

recode q03_agld (2 = 0) (1 = 1), gen (aglanddummy)
recode  q05_lvst (2 = 0) (1 = 1), gen (livestockdummy)
recode q07_hfem (2 = 0) (1 = 1), gen (FHouseOwnDummy)
recode q07_lfem (2 = 0) (1 = 1), gen (FLandOwnDummy)

label variable q07_area "Land Area"

recode q08_lvfe (2 = 0) (1 = 1), gen (FLivestockOwnDummy)

label variable q08_bhfe "Total Big Head Livestock"
label variable q08_shfe "Total Small Head Livestock"

recode q09_heco (2 = 0) (1 = 1), gen (SNAgEcAcDummy)
label variable SNAgEcAcDummy "Small non-agricultural economic activity"

label variable q10_mact "Main activity of household"
label define mact 1 "Small Industry" 2 "Business/Trade" 3 "Transport" 4 "Service" 5 "Others"
label values q10_mact mact
codebook q10_mact

recode q11_abst (2 = 0) (1 = 1), gen (AbsenteeDummy)

gen str UniqueHHLDIdentifier = string(batchid) + "-" + string(hhld)

merge 1:1 UniqueHHLDIdentifier using "smplhi02.dta", update

save "HouseholdDataMaster2001.dta", replace

clear
use "HouseholdDataMaster2001.dta"

*merge m:1 batchid using "batchid.dta", update

*gen str VDC = ltrim(vname)


label variable q1_wsorc "Main source of drinking water"
label define wsorc 1 "Tap" 2 "Well" 3 "Tube Well" 4 "Spout" 5 "River/Stream" 6 "Others" 9 "NR"
label values  q1_wsorc wsorc
codebook q1_wsorc

label variable q2_cookf "Main source of fuel used for cooking"
label define cookf 1 "Wood" 2 "Kerosene" 3 "LPG" 4 "Biogas" 5 "Cow Dung" 6 "Others" 9 "NR"
label values q2_cookf cookf
codebook q2_cookf

label variable q3_lighf "Main source of fuel used for lighting"
label define lightf 1 "Electricity" 2 "Kerosene" 3 "Biogas" 4 "Others" 9 "NR"
label values  q3_lighf lightf
codebook q3_lighf

label variable q4_toilf "Type of toilet facility"
label define toilf 1 "Modern" 2 "Ordinary" 3 "None" 9 "NR"
label values q4_toilf toilf
codebook q4_toilf

label variable q5a_hhfa "Radio"
recode q5a_hhfa (. = 0) (1 = 1), gen (RadioDummy)
label variable q5b_hhfa "TV"
recode q5b_hhfa (. = 0) (2 = 1), gen (TVDummy)
label variable q6_death "Death in last 12 months"
recode q6_death (2 = 0) (1 = 1), gen (DeathInHHDummy)




/*

use "/Users/Apoorva/Downloads/Data/Nepal Census 2001/Files Downloaded from Cornell/smplmi01.dta"
bysort  UniqueHHLDIdentifier: egen NumMigrants = count(hhld)
codebook NumMigrants
save "/Users/Apoorva/Downloads/Data/Nepal Census 2001/Files Downloaded from Cornell/smplmi01.dta", replace
collapse (mean) NumMigrants, by (UniqueHHLDIdentifier)
save "MigTally.dta"
*/

merge 1:1 UniqueHHLDIdentifier using "MigTally.dta", update

save "HouseholdDataMaster2001.dta", replace

replace NumMigrants = 0 if NumMigrants == .

/* 



 q03_agld
 q05_lvst
 q06_tlvs
 q06_tpol
 q07_hfem
 q07_lfem
 q07_area
 q08_lvfe
 q08_bhfe
 q08_shfe
 q09_heco
 q10_mact
 q11_abst
