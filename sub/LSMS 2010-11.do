/***********************************************************************
OVERVIEW OF PROGRAM
YoBRainfall.do -- This annotated Stata ".do" file estimates 
the effects of local birth year rainfall on people's long run socioeconomic outcomes.

Author: Tejesh Pradhan
************************************************************************/

/************************************************************************* 
(1) OPTIONAL: DEFINE A DELIMITER
*************************************************************************/
#delimit ;

/************************************************************ 
(2) CLEAR PREVIOUSLY OPENED DATA SETS
*************************************************************/
clear ;
clear matrix ;

/********************************************************* 
(3) ADJUST MEMORY ALLOCATED TO STATA
**********************************************************/
set memory 8000M ;

/******************************************************** 
(4) ADJUST MATRIX SIZE
*********************************************************/
set matsize 1000 ;

/*********************************************************** 
(5) OPTIONAL: CONTROL SCROLLING OF RESULTS
************************************************************/
set more off ;

/***********************************************************
(6) CLOSE ANY ALREADY OPEN LOG FILES
************************************************************/
capture log close ;

/***********************************************************
(7) DEFINE THE CURRENT DIRECTORY
*************************************************************/ 
cd "C:\Users\williams user\Desktop\Thesis Data\LSMS Data\LSMS 2010-11" ;

/***********************************************************
(8) RECORD RESULTS TO AN EXTERNAL LOG FILE
************************************************************/
log using LSMS2010to11.log, replace ;

/***************************************************************************
(11) OPEN NLSS DATA
****************************************************************************/
use "C:\Users\williams user\Desktop\Thesis Data\LSMS Data\LSMS 2010-11\LSMS 2010-11.dta"; 

/****************************
CREATE OUTCOME VARIABLES
*****************************/
egen NumInd = max(IDCode), by (xhpsu xhnum);

egen TotalAsset = rowtotal(PlotVal LivVal DwelSaleVal NonFmEntVal OthAsstVal DurVal FmAsst);
gen AssetPerCapita = TotalAsset/NumInd;
gen LnAssetPerCapita = ln(AssetPerCapita);

egen TotalExpense = rowtotal(ValFdCons FrqNonFdExp InfrqNonFdExp LivExp AgrExp UtiExp EdExp MedExp);
gen ExpPerCapita = TotalExpense/NumInd;
gen LnExpPerCapita = ln(ExpPerCapita);

gen ChrIllInd = .;
replace ChrIllInd = 1 if ChrIll == 1;
replace ChrIllInd = 0 if ChrIll == 2;

gen ReadWriteInd = .;
replace ReadWriteInd = 1 if Read == 1 & Write == 1;
replace ReadWriteInd = 0 if Read == 2|Write == 2;

gen DwOwnInd = .;
replace DwOwnInd = 1 if DwOwn == 1;
replace DwOwnInd = 0 if DwOwn == 2;

gen DrainFacInd = .;
replace DrainFacInd = 1 if Santn == 1|Santn == 2;
replace DrainFacInd = 0 if Santn == 3|Santn == 4;  
 
gen GarbDispInd = .;
replace GarbDispInd = 1 if GarbDisp == 1|GarbDisp == 2;
replace GarbDispInd = 0 if GarbDisp == 3|GarbDisp == 4|GarbDisp == 5|GarbDisp == 6;  

gen ModTltInd = .;
replace ModTltInd = 1 if TltTyp == 1|TltTyp == 2;
replace ModTltInd = 0 if TltTyp == 3|TltTyp == 4|TltTyp == 5;

gen ElectricityInd = .;
replace ElectricityInd = 1 if LightSrc == 1;
replace ElectricityInd = 0 if LightSrc == 2|LightSrc == 3|LightSrc == 4|LightSrc == 5;

gen TelorCellInd = .;
replace TelorCellInd = 1 if Tel == 1|Mob == 1;
replace TelorCellInd = 0 if Tel == 2 & Mob == 2;

gen KerGasInd = .;
replace KerGasInd = 1 if CookFuel == 4|CookFuel ==5;
replace KerGasInd = 0 if CookFuel == 1|CookFuel == 2|CookFuel == 3|CookFuel == 6|CookFuel == 7;
 
egen AssetIndex = rowtotal(DwOwnInd DrainFacInd
GarbDispInd ModTltInd ElectricityInd TelorCellInd KerGasInd); 

replace YrsEd = 0 if YrsEd == .;

/*
gen AttSkl = 0;
replace AttSkl = 1 if EdBack == 3;
*/

/***********************************
(33) CLOSE LOG FILE
************************************/ 
drop Sex-EdBack;

/***********************************
(33) SAVE FILE
************************************/
save LSMS2010to11Edited.dta,replace;

/***********************************
(33) CLOSE LOG FILE
Finally, close the log file.
************************************/ 
log close ;
