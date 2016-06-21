clear
cd "/Users/Apoorva/Documents/Google Drive/5Thesis/Final Election Datasets/Cleaned"
use "fptpclean2013.dta"
sort ConsName

br if PartyName_eng == "Nepali Congress"

*fix Kapilbastu and Dolpa

merge m:1 ConsName using "/Users/Apoorva/Documents/Google Drive/5Thesis/Final Election Datasets/VoterTurnout2013.dta", update


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
