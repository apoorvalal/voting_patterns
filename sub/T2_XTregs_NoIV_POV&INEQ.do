

**Results in table2.out and table3.out (drop first column)
**OLS-FE (table2.out), NB-FE (table3.out)

clear all
set more 1
set more off
set mem 500m
*log using Output6.log, replace

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

macro define v1 poverty HHEDU WORKH HHFARMER NEPALI rural 
macro define instr agriland_operate female_land female_biglvstk  


***********************************************
*			XTREG
***********************************************

**LOG Dep var
gen lMtotkill=ln(1+Mtotkill)
xtreg lMtotkill gini pol10 $v1 vdcpop lvdcpop, fe  
      outreg2 using table2.out, nolabel title("Baseline: Log-Linear, UNInstrumented") /*
       	*/ addnote("", "Run at $S_TIME, $S_DATE", Using data from $S_FN) /*
     	      */ addstat(k, e(df_b), WithinR2, e(r2), fracUi, e(rho)) adec(2,3) bracket rdec(4) replace 

foreach e in gini pol10 {

xtreg lMtotkill  `e' poverty, fe 
 	outreg2 using table2.out, nolabel addstat(k, e(df_b), WithinR2, e(r2), fracUi, e(rho)) adec(2,3) bracket append
xtreg lMtotkill  `e' poverty lvdcpop, fe 
 	outreg2 using table2.out, nolabel addstat(k, e(df_b), WithinR2, e(r2), fracUi, e(rho)) adec(2,3) bracket append
xtreg lMtotkill  `e' $v1 lvdcpop, fe 
 	outreg2 using table2.out, nolabel addstat(k, e(df_b), WithinR2, e(r2), fracUi, e(rho)) adec(2,3) bracket append

}

***********************************************
*			NBREG
***********************************************
xi: nbreg Mtotkill gini pol10 $v1 vdcpop lvdcpop i.DISTID
      outreg2 using table3.out, nolabel title("Baseline: Linear, Uninstrumented") /*
       	*/ addnote("", "Run at $S_TIME, $S_DATE", Using data from $S_FN) /*
     	      */ addstat(k, e(k), WaldChi2, e(chi2), Waldp, e(p), PseoduR2, e(r2_p), Alpha, e(alpha)) adec(2,3) bracket rdec(4) replace 

foreach e in gini pol10 {

xi: nbreg Mtotkill `e' poverty i.DISTID
 	outreg2 using table3.out, nolabel addstat(k, e(k), WaldChi2, e(chi2), Waldp, e(p), PseoduR2, e(r2_p), Alpha, e(alpha)) adec(2,3) bracket append
xi: nbreg Mtotkill `e' poverty lvdcpop i.DISTID
 	outreg2 using table3.out, nolabel addstat(k, e(k), WaldChi2, e(chi2), Waldp, e(p), PseoduR2, e(r2_p), Alpha, e(alpha)) adec(2,3) bracket append
xi: nbreg Mtotkill `e' $v1 lvdcpop i.DISTID
 	outreg2 using table3.out, nolabel addstat(k, e(k), WaldChi2, e(chi2), Waldp, e(p), PseoduR2, e(r2_p), Alpha, e(alpha)) adec(2,3) bracket append
}


log close
