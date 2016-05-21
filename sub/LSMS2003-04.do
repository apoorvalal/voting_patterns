clear 
set more off 

/***********************************************************
(6) CLOSE ANY ALREADY OPEN LOG FILES
************************************************************/
capture log close

/***********************************************************
(7) DEFINE THE CURRENT DIRECTORY
*************************************************************/ 
cd "/Users/Apoorva/Downloads/Data/LSMS 2003-04/Household Data/" 

/***********************************************************
(8) RECORD RESULTS TO AN EXTERNAL LOG FILE
************************************************************/
log using LSMS03to04.log, replace

use "Z00 HH Info.dta"


