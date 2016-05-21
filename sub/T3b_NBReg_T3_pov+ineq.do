

**Table 3 -- IVNB (FE)   and Table 4 -- IVNB (FE) 
**Results in table2.out (drop 1st column)

clear all
set more 1
set more off
set mem 500m

use smalldataset_rainfall2, clear

*tis vcode
*xtset DISTID // for STATA10
xtset DISTID vcode

********************************************************************************************
**prepare data for runs 
********************************************************************************************
rename c96fgt0 poverty
rename c96gini gini

g lvdcpop = ln(vdcpop)
replace vdcpop = vdcpop/1000

macro define v1 HHEDU WORKH HHFARMER NEPALI rural lvdcpop 


******************************************************************************************************************
**								Instrumented 
******************************************************************************************************************

**DUMMY regs
xtreg gini agriland_operate female_land female_biglvstk $v1, fe robust
  outreg2 using tableFstage.out, nolabel title("First Stage") addstat(FstageF, r(F)) adec(2,3) bracket rdec(4) replace 
xi: nbreg Mtotkill gini pol10 pol15 poverty $v1 i.DISTID, robust
      outreg2 using table2.out, nolabel title("Baseline: Linear, Instrumented") /*
       	*/ addnote("", "Run at $S_TIME, $S_DATE", Using data from $S_FN) /*
     	      */ addstat(k, e(k), WaldChi2, e(chi2), Waldp, e(p), PseoduR2, e(r2_p), Alpha, e(alpha)) adec(2,3) bracket rdec(4) replace 


************************
*First-stage loop

**Instruments
macro define instr agriland_operate female_land female_biglvstk 

foreach e in gini pol10 HI1 HI2 HI3 HI10 {

 xtreg `e' $instr poverty $v1, fe robust
   predict p`e'
   test (agriland_operate = 0) (female_land = 0) (female_biglvstk = 0) 
   outreg2 using tableFstage.out, nolabel title("First Stage") addstat(FstageF, r(F)) adec(2,3) bracket rdec(4) append 
 }
***********************
**Second stage Loop

foreach v in pgini ppol10 pHI1 pHI2 pHI3 pHI10 {
 xi: nbreg Mtotkill `v' poverty $v1 i.DISTID, robust
  	outreg2 using table2.out, nolabel addstat(k, e(k), WaldChi2, e(chi2), Waldp, e(p), PseoduR2, e(r2_p), Alpha, e(alpha)) adec(2,3) bracket append
 }



log close

