


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

**Generate interactions
g giniedu = gini*HHEDU
g pol10edu = pol10*HHEDU

g ginipoverty = gini*poverty
g pol10poverty = pol10*poverty

g ginipop = gini*vdcpop
g pol10pop = pol10*vdcpop

macro define v1 lvdcpop HHEDU WORKH HHFARMER NEPALI rural 


******************************************************************************************************************
**								Instrumented 
******************************************************************************************************************
**DUMMY regs
xtreg gini agriland_operate female_land female_biglvstk $v1, fe robust
  outreg2 using tableFstage.out, nolabel title("First Stage") addstat(FstageF, r(F)) adec(2,3) bracket rdec(4) replace 
xi: nbreg Mtotkill gini pol10 poverty $v1 i.DISTID, robust
      outreg2 using table2.out, nolabel title("Baseline: Linear, Instrumented") /*
       	*/ addnote("", "Run at $S_TIME, $S_DATE", Using data from $S_FN) /*
     	      */ addstat(k, e(k), WaldChi2, e(chi2), Waldp, e(p), PseoduR2, e(r2_p), Alpha, e(alpha)) adec(2,3) bracket rdec(4) replace 


************************
*First-stage loop

**Instruments
macro define instr agriland_operate female_land female_biglvstk 

foreach e in gini pol10 {

xtreg `e' $instr poverty $v1, fe robust
  predict p`e'
  test (agriland_operate = 0) (female_land = 0) (female_biglvstk = 0) 
  outreg2 using tableFstage.out, nolabel title("First Stage") addstat(FstageF, r(F)) adec(2,3) bracket rdec(4) append 

}

g pginipoverty = pgini*poverty
g ppol10poverty = ppol10*poverty

g pginiHHEDU = pgini*HHEDU
g ppol10HHEDU = ppol10*HHEDU

g pginiWORKH = pgini*WORKH
g ppol10WORKH = ppol10*WORKH

g pginiHHFARMER = pgini*HHFARMER
g ppol10HHFARMER = ppol10*HHFARMER

g income=exp(lincome)/1000
g pginiincome = pgini*income
g ppol10income = ppol10*income


***********************
**Second stage Loop
foreach v in pgini ppol10 {

 foreach z in poverty HHEDU WORKH HHFARMER income {

xi: nbreg Mtotkill `v' `v'`z' poverty $v1 i.DISTID, robust
 	outreg2 using table2.out, nolabel addstat(k, e(k), WaldChi2, e(chi2), Waldp, e(p), PseoduR2, e(r2_p), Alpha, e(alpha)) adec(2,3) bracket append

  }

}

log close


