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

replace l = strpos(Constituency," ")
replace Dist = substr(Constituency,1,l-1)



replace District = subinstr(District, "chitawan", "chitwan",.)
replace District = subinstr( District, "kapilbastu", "kapilvastu",.)
replace District = subinstr( District, "parvat", "parbat",.)
replace  District = subinstr( District, "paanchthar", "panchthar",.)
replace District = subinstr( District, "udaypur", "udayapur",.)
replace District = subinstr( District, "kavrepalanchowk", "kavrepalanchok",.)
replace District = subinstr( District, "sindhupalchowk", "sindhupalchok",.)

foreach x of varlist ConsWinner ConsWinningMargin vv1 ConsNumCandidates ConsClientVotes ConsTotTop5Votes ConsOtherVotes ConsOtherTurnout ConsClientTurnout {
gen `x'2008 = `x'
drop `x'
}



use "/Users/Apoorva/Downloads/Data/Nepal Census 2011/Feb/PanelConsLevel.dta"
merge 1:1 Constituency using "/Users/Apoorva/Downloads/Data/Nepal Census 2011/Feb/ConsLevel1999.dta", update

foreach x of varlist ConsWinningMargin ConsWinner ConsNumCandidates ConsVotesCast ClientTally ConsClientTurnout ConsTotTop5Votes ConsOtherCount ConsOtherTurnout {
gen `x'1999 = `x'
drop `x'
}

