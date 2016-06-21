clear
cd "/Users/Apoorva/Documents/Google Drive/5Thesis/Final Election Datasets/"
use "DistLevCollapsed2008.dta"

foreach x of varlist DistNumCandidates DistTotVotes distClientVotes distOtherVotes DistTotTop5Votes DistOtherVotes DistOtherTurnout DistClientTurnout {
	gen `x'2008 = `x'
	}

merge 1:1 District using "DistLev1999.dta", update
