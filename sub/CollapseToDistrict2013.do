clear
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

