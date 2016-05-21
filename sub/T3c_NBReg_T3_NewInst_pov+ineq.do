

**Table 3 and Table 4: Rainfall instrument (District Level IVNB)
**Results in table3New.out (drop 1st column)

**NOTE: 1st stage OLS, 2nd stage straight NBreg w/o RE 


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

**Rainfall as instrument
**var and precision
egen sd1 = rsd(rainfall80p rainfall85p rainfall90p rainfall95)
replace sd1=sd1/1000
g isd1=1/sd1
g var1 = sd1^2
g ivar1 = 1/sd1^2

**Exog Regressors
macro define v1 HHEDU WORKH HHFARMER NEPALI rural lvdcpop

**Instruments
macro define instr var1 ivar1	


******************************************************************************************************************
**								Instrumented 
******************************************************************************************************************
**DUMMY regs
 xtreg gini var1 ivar1 poverty $v1, re robust
  outreg2 using tableFstageOLS.out, nolabel title("First Stage") addstat(FstageF, r(F)) adec(2,3) bracket rdec(4) replace 

 nbreg Mtotkill gini pol10 poverty $v1 /*i.DISTID */, robust
  outreg2 using table3New.out, nolabel title("Baseline: Linear, Instrumented") /*
       	*/ addnote("", "Run at $S_TIME, $S_DATE", Using data from $S_FN) /*
     	      */ addstat(k, e(k), WaldChi2, e(chi2), Waldp, e(p), PseoduR2, e(r2_p), Alpha, e(alpha)) adec(2,3) bracket rdec(4) replace 

**First stage loop
foreach e in gini pol10 HI1 HI2 HI3 HI10 {

 reg `e' $instr poverty $v1, robust
   predict p`e'
   test (var1 = 0) (ivar1 = 0)
   outreg2 using tableFstageOLS.out, nolabel addstat(FstageF, r(F)) adec(2,3) bracket append 
}  

***********************
**Second stage Loop
foreach v in pgini ppol10 pHI1 pHI2 pHI3 pHI10 {
 nbreg Mtotkill `v' poverty $v1 , robust 
      outreg2 using table3New.out, nolabel addstat(k, e(k), WaldChi2, e(chi2), Waldp, e(p), PseoduR2, e(r2_p), Alpha, e(alpha)) adec(2,3) bracket append
      estat ic
  }



log close

