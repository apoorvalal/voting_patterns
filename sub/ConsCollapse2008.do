
bysort Constituency: egen ConsNumCandidates = count(ord)

label variable ConsNumCandidates "Number of Candidates"

gen ClientelistDummy = (Party == "communist party of nepal (unified-marxist- leninist)" | Party == "nepali congress")

bysort Constituency: egen ConsClientVotes = total (ClientelistDummy*pv1)
label variable ConsClientVotes "Total turnout for clientelist parties"

sort Constituency pv1
bysort Constituency: egen rk = rank(pv1)

gen Rank = abs(rk -CandidateCount) + 1

save Nepal2008, replace


keep if Rank <6

bysort Constituency: egen ConsTotTop5Votes = total(pv1)

gen ConsOtherVotes = ConsTotTop5Votes -  ConsClientVotes

save "2008Top5_2.dta", replace

gen ConsOtherTurnout = ConsOtherVotes/vv1
gen ConsClientTurnout = ConsClientVotes/vv1

gen ConsWinningMargin = WinPct - pvs1 * (Rank == 2) if Rank == 2
bysort Constituency: gen ConsWinner = Party if windummy == 1



collapse (firstnm) ConsWinner ConsWinningMargin (mean) vv1 ConsNumCandidates ConsClientVotes ConsTotTop5Votes ConsOtherVotes ConsOtherTurnout ConsClientTurnout, by (Constituency)

collapse (firstnm) ConsWinner ConsWinningMargin (mean) vv1 ConsNumCandidates ConsClientVotes ConsTotTop5Votes ConsOtherVotes ConsOtherTurnout ConsClientTurnout, by (Constituency)

save "ConsLevCollapsed2008.dta", replace
