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

gen DistOtherVotes = DistTotTop5Votes -  distClientVotes

save "2008Top5.dta", replace

gen DistOtherTurnout = DistOtherVotes/DistTotVotes
gen DistClientTurnout = distClientVotes/DistTotVotes


collapse (mean) DistNumCandidates DistTotVotes distClientVotes distOtherVotes DistTotTop5Votes DistOtherVotes DistOtherTurnout DistClientTurnout, by (District)

save "DistLevCollapsed2008.dta", replace

/*

collapse (mean) DistVoteCount DistClientCount DistClientTurnout DistTotTop5Votes DistOtherCount DistOtherTurnout, by (District)


bysort DISTRICT_ENG: egen DistVotes = total(y*consvotes)
sort ConsName TOTALVOTE 
generate ord = _n

sort ConsName TOTALVOTE 
bysort ConsName: egen rk = rank(TOTALVOTE)

gen Rank = abs(rk - numCandidates) + 1

sort ConsName Rank
gen RankInt = int(Rank)
drop Rank
rename RankInt Rank

save "fptpclean2013.dta", replace

keep if Rank < 6
save "topFive2013.dta"

use "/Users/Apoorva/Documents/Google Drive/5Thesis/Final Election Datasets/Cleaned/topFive2013.dta"
br

codebook PartyName_eng, tabulate (40)

drop PartyConst
gen str PartyDist = PartyName_eng + "-" + string(DISTRICT)
bysort PartyDist: egen TotDistVotes = total(TOTALVOTE)
sort ConsName Rank

gen clientelistDummy = (PartyName_eng == "Nepal Communist Party (UML)" |PartyName_eng == "Nepali Congress") 
bysort DISTRICT: egen ClientDistVotes = total(TOTALVOTE*clientelistDummy)

sort ConsName Rank
label variable Rank "Rank within constituency"
label variable PartyDist "Party + District for egen"
label variable TotDistVotes "Votes received by party in district"
label variable ClientDistVotes "Votes received by clientelist party in district"

gen OtherDummy = (PartyName_eng != "Nepal Communist Party (UML)"  & PartyName_eng != "Nepali Congress") 

bysort DISTRICT: egen OtherDistVotes = total(TOTALVOTE*OtherDummy)

gen DistClientTurnout = ClientDistVotes / DistVotes
gen DistOtherTurnout = OtherDistVotes / DistVotes
gen logTransformationClient = ln(DistClientTurnout / (1 - DistClientTurnout - DistOtherTurnout))

save "/Users/Apoorva/Documents/Google Drive/5Thesis/Final Election Datasets/Cleaned/topFive2013.dta", replace

collapse (mean) numCandidates logTransformationClient, by (DISTRICT_ENG)

cd "/Users/Apoorva/Documents/Google Drive/5Thesis/Final Election Datasets/Cleaned/"
save "DistrictLevel2013.dta", replace
