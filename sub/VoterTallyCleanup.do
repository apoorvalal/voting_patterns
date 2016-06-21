import excel "/Users/Apoorva/Documents/Google Drive/5Thesis/Final Election Datasets/voterstally2013.xlsx", sheet("voters in each constituencies, ") firstrow
br
drop in 1
drop DNep
br
gen ConsName = District + "-" + Constituency
label variable ConsName "Name of Constituency"
destring TotalEligibleVoters, gen (VoterCount)
destring Constituency, gen (Cons)
destring VotesCast, gen (VoteCount)
destring TurnoutPercentage, gen (Turnout)
destring ValidVotes, gen (Valid)
destring ValidPercentage, gen (ValidPct)
destring InvalidVotes, gen (Invalid)
destring InvalidPercentage, gen (InvalidPct)

drop TotalEligibleVoters VotesCast TurnoutPercentage ValidVotes ValidPercentage InvalidVotes InvalidPercentage Constituency

cd "/Users/Apoorva/Documents/Google Drive/5Thesis/Final Election Datasets/"
save "VoterTurnout2013.dta", replace

