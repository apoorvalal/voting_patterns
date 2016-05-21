clear
use "/Users/Apoorva/Downloads/Data/LSMS 2010-11/LSMS 2010-11.dta"
gen UniqueHHID = string(xhpsu) + "-" + string(xhnum)
sort UniqueHHID
drop if xhpsu == .
save "LSMS20102011AL.dta"


* for Section 17B
gen UniqueHHID = string(xhpsu) + "-" + string(xhnum)
sort UniqueHHID
gen remitDummy = 1
collapse (sum) remitDummy (mean)v17_20a v17_20b, by (UniqueHHID)
save "Section17B Collapsed.dta"

*merge

clear
use "/Users/Apoorva/Downloads/Data/LSMS 2010-11/LSMS20102011AL.dta"

merge m:1 UniqueHHID using "/Users/Apoorva/Downloads/Data/LSMS 2010-11/Household Data/Section17B Collapsed.dta", update
replace remitDummy = 0 if _merge == 1
rename remitDummy NumberOfMembersAbroad
gen remitDummy = (NumberOfMembersAbroad > 0)
save "/Users/Apoorva/Downloads/Data/LSMS 2010-11/LSMS20102011AL.dta", replace

*Merge with sample
clear
use "/Users/Apoorva/Downloads/Data/LSMS 2010-11/BigLSMS20102011AL.dta"
/*
drop _merge
merge m:1 UniqueHHID using "/Users/Apoorva/Downloads/Data/LSMS 2010-11/Household Data/Sample.dta", update 
drop _merge

merge m:1 xstra v00_dist v00_vdc 
*/

rename xstra SampleStrata
rename v00_dist District
rename v00_vdc VDCMuncip 

clear
use "/Users/Apoorva/Downloads/Data/LSMS 2010-11/BigLSMS20102011AL.dta"

merge m:m SampleStrata District VDCMuncip using "/Users/Apoorva/Downloads/Data/LSMS 2010-11/Rural Community/Section  1 Population characteristics and infrastructure.dta", update

/*

    Result                           # of obs.
    -----------------------------------------
    not matched                         9,294
        from master                     9,230  (_merge==1)
        from using                         64  (_merge==2)

    matched                            19,490
        not updated                    19,490  (_merge==3)
        missing updated                     0  (_merge==4)
        nonmissing conflict                 0  (_merge==5)
    -----------------------------------------

	
