clear
cd "/Users/Apoorva/Documents/Google Drive/5Thesis/Final Election Datasets/"
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

save Nepal2008, replace

sort Constituency pv1
gen ord = _n

bysort District: egen DistNumCandidates = count(ord)
label variable DistNumCandidates "Number of Candidates"
gen ClientelistDummy = (Party == "communist party of nepal (unified-marxist- leninist)" | Party == "nepali congress")

bysort District: egen DistTotVotes = total(windummy*vv1)
label variable DistTotVotes "Total Number of Votes cast in District"
bysort District: egen distClientVotes = total (ClientelistDummy*pv1)
label variable distClientVotes "Total turnout for clientelist parties"

sort Constituency pv1
bysort Constituency: egen rk = rank(pv1)

gen Rank = abs(rk -CandidateCount) + 1

save Nepal2008, replace


keep if Rank <6

bysort District: egen DistTotTop5Votes = total(pv1)

*something fishy with Rolpa 1 and 2

replace 


save "2008Top5.dta", replace
replace DistTotVotes = 83498 + 2000 if District == "rolpa"

gen ConsOtherVotes = DistTotTop5Votes -  distClientVotes

save "2008Top5.dta", replace

gen DistOtherTurnout = DistOtherVotes/DistTotVotes
gen DistClientTurnout = distClientVotes/DistTotVotes

use "2008Top5.dta"

bysort Constituency: gen ConsWinner = Party if windummy == 1


collapse (firstnm) ConsWinner (mean) DistNumCandidates DistTotVotes distClientVotes distOtherVotes DistTotTop5Votes DistOtherVotes DistOtherTurnout DistClientTurnout, by (Constituency)


save "ConsLevCollapsed2008.dta", replace

