clear
use "/Users/Apoorva/Documents/Google Drive/5Thesis/Final Election Datasets/DistLevCollapsed2008.dta"

foreach x of varlist DistNumCandidates DistTotVotes distClientVotes distOtherVotes DistTotTop5Votes DistOtherVotes DistOtherTurnout DistClientTurnout {
	gen `x'2008 = `x'
	drop `x'
	}
label variable DistNumCandidates2008 "Number of candidates in District in 2008"
 

label variable DistTotVotes2008 "Total Number of Votes cast in District in 2008"
label variable distClientVotes2008 "Votes received by Clientelists in District in 2008"
label variable DistClientTurnout2008 "Share of votes for clientelists in District in 2008"
label variable distOtherVotes2008 "Competitive segment of votes cast in District in 2008"
label variable DistTotTop5Votes2008  "Votes received by closest competitors in District in 2008"
label variable DistOtherTurnout2008	"Share of votes for competitors in District in 2008"



replace District = "panchthar" if  District == "paanchthar"
replace District = "parbat" if  District == "parvat"
replace District = "ramechap" if  District == "ramechhap"
replace District = "sindhupalchowk" if District == "sindhupalchok"
replace District = "kavrepalanchowk" if District == "kavrepalanchok"
replace District = "terhathum" if District == "tehrathum"

save "/Users/Apoorva/Documents/Google Drive/5Thesis/Final Election Datasets/DistLevCollapsed2008.dta", replace


