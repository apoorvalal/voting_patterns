//----------------------------------------------------------------------------//
//
// Paper: Analysis of voting patterns Nepal
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
gl path_win "C:/Users/Apoorva Lal/Desktop/Research Papers/voting_patterns_nepal/analysis/"
gl path_mac "/Users/apoorvalal/Desktop/projects/nepal_voting_patterns/analysis"

gl path "${path_${sys}}"

gl input "${path}/input" 
gl output "${path}/output"
gl code_win "${path_win}/code/voting_patterns/"
gl code_mac "${path_mac}/code/"
gl code "${code_${sys}}" 

gl tmp "${path}/tmp"

cd "${input}"


//----------------------------------------------------------------------------//
// Preface
//----------------------------------------------------------------------------//

* log using "$path/analysis/output/analysis.log"
cap log close
clear all
* set graphics off

cd "${code}/"

//----------------------------------------------------------------------------//
// Main
//----------------------------------------------------------------------------//

do "${code}/sub/clean_census_data"

* // Tables
* 	do "code/sub/analysis_tables.do"
* // Figures
* 	do "code/sub/analysis_figures.do"
* // Regressions
* 	do "code/sub/analysis_regressions.do"

