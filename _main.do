//----------------------------------------------------------------------------//
//
// Paper: Analysis of voting patterns Nepal - clean census raw data first
//
// do.file: analysis
//
// Author(s): Apoorva Lal
//
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Shortcuts
//----------------------------------------------------------------------------//

gl sys "win" // mac or win - change when switching systems
gl path_win "C:/Users/Apoorva Lal/Desktop/Research/Nepal_Voting/analysis"
gl path_mac "/Users/apoorvalal/Desktop/projects/nepal_voting_patterns/analysis"
gl path "${path_${sys}}"
gl input "${path}/input" 
gl output "${path}/output"
gl code_win "${path_win}/code/"
gl code_mac "${path_mac}/code/"
gl code "${code_${sys}}" 

gl temp "${path}/tmp"
gl tmp "${path}/tmp"

// Data Sources
gl raw_2011 "${input}/Nepal Census 2011/pums/assets/datafiles"
gl raw_2001 "${input}/Nepal Census 2001/Files Downloaded from Cornell"

cd "${input}"


//----------------------------------------------------------------------------//
// Preface
//----------------------------------------------------------------------------//

// log using "$path/analysis/output/analysis.log"
cap log close
clear all
//  set graphics off

cd "${code}/"

/* 
General Macros
 */

 set tracedepth 1
 set r on, perm
 pause on
 
//----------------------------------------------------------------------------//
// Main
//----------------------------------------------------------------------------//

do "${code}/sub/c2011_0_extract_labels"
do "${code}/sub/c2011_1_clean_hh_data"
do "${code}/sub/c2011_1_clean_ind_data"
do "${code}/sub/c2011_2_hh_full"

do "${code}/sub/c2001_0_extract_labels"
do "${code}/sub/c2001_1_clean_ind_data"
do "${code}/sub/c2001_2_hh_data"




