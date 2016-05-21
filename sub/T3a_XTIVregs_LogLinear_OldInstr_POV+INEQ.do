

**Table 3 -- IV Log-Linear (FE)
**Results in table21.out (drop 1st column)

**OLS FE, IV

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


**Exog Regressors
macro define v1 HHEDU WORKH HHFARMER NEPALI rural lvdcpop

**Instruments1  (Village Level)
macro define instr1 agriland_operate female_land female_biglvstk  


**LOG Dep var
gen lMtotkill=ln(1+Mtotkill)

***********************************************
*		IVREG 
***********************************************
**Dummy reg
ivreg2 lMtotkill  (gini = $instr1)  $v1, first robust
      outreg2 using table21.out, nolabel title("Baseline: Log-Linear, Instrumented") /*
       	*/ addnote("", "Run at $S_TIME, $S_DATE", Using data from $S_FN) /*
     	      */ addstat(k, e(df_b), ModelF, e(F), numdf, e(Fdf1), dendf, e(Fdf2), KPWeakId, e(widstat), Underid, e(idstat), HansenJOverid,  e(j), hansenJpr,  e(jp)) adec(2,3) bracket rdec(4) replace 

**IV regression loop
foreach e in gini pol10 {
 xtivreg2 lMtotkill  poverty $v1 (`e' = $instr1), fe robust first
 	outreg2 using table21.out, nolabel addstat(k, e(df_b), ModelF, e(F), numdf, e(Fdf1), dendf, e(Fdf2), KPWeakId, e(widstat), Underid, e(idstat), HansenJOverid,  e(j), hansenJpr,  e(jp)) adec(2,3) bracket append
}



log close

