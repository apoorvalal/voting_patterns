loc path "${raw_2001}"
loc  hhid "batchid hhld"
loc batchid_vars " batchid belt region district vcode ward urbnrurl Village District"
use "`path'/smplpi01.dta", clear
cap drop  uniqueHHID HHCaste HHMtong HHSize HHMultiEth
merge 1:1 batchid hhld idcode using "`path'/smplpi02.dta", nogen keep(1 3)
cap drop litdummy uniqueHHID HHLit HHOccMin HHOccupation

// PI 02 labels 

la var q2_sex "2. Sex"
la var q3_age "3. Age"
la var q4_bplce "4. Place of birth"
la var q4a_dist "4. Place of birth dist"
la var q4b_vdcm "4. Place of birth vdc"
la var q4c_ctry "4. Place of birth ctry"
la var q5_durtn "5. Duration of stay at the present place"
la var q6_rstay "6. Reason for staying in this district"
la var q7_li5ya "7. Residence five years ago"
la var q7a_dist "7. Residence five years ago dist"
la var q7b_vdcm "7. Residence five years ago vdc"
la var q7c_ctry "7. Residence five years ago ctry"
la var q8_edutn "8. Whether able to read and write"
la var q9a_elvl "9. Level of education"
la var q9b_fstd "9. Level of education"
la var q10_catt "10. Whether currently attending any school"
la var q11_msta "11. Marital status"
la var q12_fage "12. Age at first marriage"
la var q13_stog "13. No. of children ever born - sons"
la var q13_dtog "13. No. of children ever born - daughters"
la var q13_ssep "13. No. of children ever born - sons separated"
la var q13_dsep "13. No. of children ever born - daughters separated"
la var q13_sded "13. No. of children ever born - sons dead"
la var q13_dded "13. No. of children ever born - daughters dead"
la var q13_stot "13. No. of children ever born - sons total"
la var q13_dtot "13. No. of children ever born - daughters total"
la var q14_livb "14. Any live births during last 12 months"
la var q14_1sex "14. Any live births during last 12 months - sex"
la var q14_1yer "14. Any live births during last 12 months - year"
la var q14_1mth "14. Any live births during last 12 months - month"
la var q14_2sex "14. Any live births during last 12 months - sex"
la var q14_2yer "14. Any live births during last 12 months - year"
la var q14_2mth "14. Any live births during last 12 months - month"
la var q15_work "15. Work usually done during the last 12 months"
la var q16_wrkm "16. No. of months worked during the last 12 months"
la var q16_ewkm "16. No. of months worked during the last 12 months - extended eco"
la var q16_swkm "16. No. of months worked during the last 12 months - work seeking"
la var q16_nwkm "16. No. of months worked during the last 12 months - no work"
la var q17_occ1 "17. Occupation (type of usual work)"
la var q18_ind1 "18. Industry (place of usual work)"
la var q19_esta "19. Employment Status" 
la var q20_resn "20. Reasons for usually not working" 
la var q21_liar "21. Living arrangements of children below 16 years"

la def q2_sex 1 "male" 2 "female"
la def q4_bplce 1 "same district" 2 "other district" 3 "foreign country"
la def q4b_vdcm 1 "vdc" 2 "municipality" 
la def q6_rstay 1 "business/trade" 2 "agriculture" 3 "service" 4 "study" 5 "marriage" 6 "others"
la def q7_li5ya 1 "same district" 2 "other district" 3 "foreign country"
la def q7b_vdcm 1 "vdc" 2 "municipality" 
la def q8_edutn 1 "read only" 2 "read and write" 3 "can't read and write" 9 "not reported"
loc classes ""
forv i = 1/10 {
	loc classes `"`classes' `i' "Class `i'""'
}
la def q9a_elvl 0 "read and write" `classes' 11 "SLC Equivalent" 12 "intermediate" 13 "bachelor's degree" 15 "masters degree" 15 "phd" 16 "CMA" 17 "CTEVT" 18 "non-formal" 19 "Others" 

la def q9b_fstd 1 "humanities" 2 "commerce mgmt" 3 "law" 4 "education" 5 "science" 6 "medicine" 7 "engineering" 8 "ag.livestock science" 9 "forestry" 10 "sanskrit" 99 "not reported"
la def q10_catt 1 "yes" 2 "no"
la def q11_msta 1 "never married" 2 "married (single spouse)" 3 "married (multiple spouse)" 4 "re-married" 5 "widow/widower" 6 "divorced" 7 "separated" 9 "not reported"
la def q14_livb 1 "yes" 2 "no"
la def q17_occ1 1 "legal" 2 "professional" 3 "associate professional" 4 "clerk" 5 "service workers" 6 "skilled/semi-skilled agro/fishery" 7 "craft and related trades" 8 "machine operations" 9 "elementary operations" 
la def q18_ind1 1 "agriculture" 2 "fishing" 3 "mining and quarrying" 4 "manufacturing" 5 "electricity/gas" 6 "construction" 7 "wholesale/retail trade" 8 "hotels and restaurants" 9 "transport/storage and comm" 10 "financial intermediation" 
la def q19_esta 1 "employer" 2 "employee" 3 "self-employed" 4 "unpaid family worker"
la def q20_resn 1 "student" 2 "household chores" 3 "aged" 4 "pension/income recipient" 5 "physically and mentally handicapped" 6 "sickness" 7 "others"
la def q21_liar 1 "Biological parents" 2 "biological mother" 3 "biological father" 


gl vars_to_label " q2_sex q3_age q4_bplce q4a_dist q4b_vdcm q4c_ctry q5_durtn q6_rstay q7_li5ya q7a_dist q7b_vdcm q7c_ctry q8_edutn q9a_elvl q9b_fstd q10_catt q11_msta q12_fage q13_stog q13_dtog q13_ssep q13_dsep q13_sded q13_dded q13_stot q13_dtot q14_livb q14_1sex q14_1yer q14_1mth q14_2sex q14_2yer q14_2mth q15_work q16_wrkm q16_ewkm q16_swkm q16_nwkm q17_occ1 q18_ind1 q19_esta q20_resn q21_liar"

foreach v in $vars_to_label {
	cap la val `v' `v'
}

qui compress
save "${temp}/merged_ind_lev_c2001", replace

