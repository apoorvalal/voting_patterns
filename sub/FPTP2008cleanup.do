clear
use "/Users/Apoorva/Google Drive/5Thesis/Final Election Data/fptp2008.dta"

/*drop onTime Districtname CandidateName PartyName SymbolName 
gen str15 consName = Districtname_eng + "-" + string(Constituency)
label variable consName "Name of Constituency"
bysort consName: egen consvotes = total(TotalVote)
save "C:\Users\al6\Desktop\AL Data\fptp2013.dta", replace
gen candidatenum = 0
gen num = 0

label variable consvotes "Total Number of Votes in Constituency"

br
gen num = 1
drop n

by consName, sort: egen numCandidates = count(num)
label variable numCandidates "Number of Candidates in Constituency"
drop num

gen pctvotes = (TotalVote/consvotes) * 100
by consName, sort: egen totalpct = total(pctvotes)
gen windummy = 1 if Status == "E"
by Partyid, sort: egen totalwins = count(windummy)

rename totalwins partytally
*/

label variable partytally "Total Number of wins by Candidate's Party"

save "C:\Users\al6\Desktop\AL Data\fptp2008.dta", replace


