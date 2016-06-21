clear
cd "/Users/Apoorva/Downloads/Data/Constituency-Level Election Archive Dataset/"
use "Nepal2008"
br
gen str Constituency = ltrim(cst_n)
gen str Party = ltrim(pty_n)
gen str Country = ltrim(ctr_n)
gen str CandidateName = ltrim(can)
drop cst_n pty_n ctr_n can
label variable Constituency "Constituency"
label variable Party "Party Name"

bysort Constituency: egen CandidateCount = count(yr)

gen locateSpace = strpos(Constituency, " ")
gen District = substr(Constituency, 1,locateSpace-1)
drop locateSpace
label variable District "District Name"

bysort Constituency: egen WinPct = max(pvs1)
gen windummy = (WinPct == pvs1)
label variable CandidateCount "Number of Candidates in Constituency"
label variable WinPct "% votes received by winning candidate"
label variable CandidateName "Candidate Name"

gen NCDummy =  (Party == "nepali congress")
gen UMLDummy = (Party == "communist party of nepal (unified-marxist- leninist)")
gen MAODummy =(Party == "communist party of nepal (maoist)")
gen MADHDummy = (Party == "terai-madesh loktantrik party"| Party == "madeshi jana adhikar forum nepal"| Party == "nepal shadvawana party (ananda devi)")
gen PANDummy = (Party == "rastriya janasshakti party"| Party == "rastriya prajatantra party nepal"| Party == " rastriya prajatantra party")


/*bysort Constituency: egen NCVoteTally = total (NCDummy*pv1)
bysort Constituency: egen UMLVoteTally = total (UMLDummy*pv1)
bysort Constituency: egen MAOVoteTally = total (MAODummy*pv1)
bysort Constituency: egen MADHVoteTally = total (MADHDummy*pv1)
*/
save Nepal2008, replace


bysort Constituency: gen NCVoteShare = pvs1*NCDummy
bysort Constituency: gen UMLVoteShare = pvs1*UMLDummy
bysort Constituency: gen MAOVoteShare = pvs1*MAODummy
bysort Constituency: gen MADHVoteShare = pvs1*MADHDummy
bysort Constituency: gen PANVoteShare = pvs1*PANDummy


gen WinningParty = Party if windummy == 1
gen WinningCandidate = CandidateName if windummy == 1

collapse (firstnm) WinningCandidate  WinningParty (max) NCVoteShare UMLVoteShare MAOVoteShare MADHVoteShare PANVoteShare , by (Constituency)

save "2008ConsLevWParties.dta", replace

/*

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
