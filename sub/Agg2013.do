*2013 results agg
clear
use "/Users/Apoorva/Documents/Google Drive/5Thesis/Final Election Datasets/Cleaned/fptpclean2013.dta"
/*
drop Constituency
gen Constituency = lower(DISTRICT_ENG) + " " + string(CONST)
*/
br

replace Constituency = subinstr(Constituency, "chitawan", "chitwan",.)
replace Constituency = subinstr(Constituency, "kapilbastu", "kapilvastu",.)
replace Constituency = subinstr(Constituency, "parvat", "parbat",.)
replace Constituency = subinstr(Constituency, "paanchthar", "panchthar",.)
replace Constituency = subinstr(Constituency, "udaypur", "udayapur",.)
replace Constituency = subinstr(Constituency, "dhanusa", "dhanusha",.)
replace Constituency = subinstr(Constituency, "ramechhap", "ramechap",.)
replace Constituency = subinstr(Constituency, "kavrepalanchowk", "kavrepalanchok",.)
replace Constituency = subinstr(Constituency, "sindhupalchowk", "sindhupalchok",.)
replace Constituency = subinstr( Constituency, "udaypur", "udayapur",.)
replace Constituency = subinstr( Constituency, "dolpo", "dolpa",.)



drop if Constituency == "."

rename windummy WinDummy
rename consvotes ConsVotesCast
bysort Constituency: egen ConsNumCandidates = count(TOTALVOTE)



sort Constituency TOTALVOTE

gen ClientDummy = (PartyName == "Nepal Communist Party (UML)" | PartyName == "Nepali Congress")
label variable Constituency "Constituency Name"
label variable  ConsVotesCast "Valid Votes cast in constituency"

label variable ConsNumCandidates "Number of Candidates in Constituency"
label variable ClientDummy "NC or UML"

bysort Constituency: egen ClientTally = total (TOTALVOTE*ClientDummy)

/*
sort ConsName Votecount
bysort ConsName: egen rk = rank(Votecount)
gen Rank = abs(rk -ConsNumCandidates) + 1
*/

save "/Users/Apoorva/Documents/Google Drive/5Thesis/Final Election Datasets/Final2013.dta", replace


keep if Rank <6


bysort Constituency: egen ConsTotTop5Votes = total(TOTALVOTE)
bysort Constituency: gen ConsOtherCount = ConsTotTop5Votes - ClientTally

gen vs1 = TOTALVOTE / ConsVotesCast
sort Constituency vs1 

bysort Constituency: egen WinPct = max(vs1)

gen ConsWinningMargin = WinPct - vs1 * (Rank == 2) if Rank == 2
bysort Constituency: gen ConsWinner = Party if WinDummy == 1


gen ConsClientTurnout = ClientTally/ConsVotesCast
gen ConsOtherTurnout = ConsOtherCount/ConsVotesCast

        
collapse (firstnm) ConsWinningMargin ConsWinner (mean) ConsNumCandidates ConsVotesCast ClientTally ConsClientTurnout ConsTotTop5Votes ConsOtherCount ConsOtherTurnout, by (Constituency)

save "/Users/Apoorva/Documents/Google Drive/5Thesis/Final Election Datasets/ConsLevel2013.dta", replace

   
foreach x of varlist ConsWinningMargin ConsWinner ConsNumCandidates ConsVotesCast ClientTally ConsClientTurnout ConsTotTop5Votes ConsOtherCount ConsOtherTurnout {
gen `x'2013 = `x'
drop `x'
}

use "/Users/Apoorva/Documents/Google Drive/5Thesis/Final Election Datasets/ConsLevel2013.dta", clear

