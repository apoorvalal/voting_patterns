clear
import excel "/Users/Apoorva/Documents/Google Drive/5Thesis/Final Election Datasets/Results1999.xlsx", sheet("Sheet1") firstrow
br


gen cons = Constituency

replace cons = cons[_n-1] if cons[_n-1] !=. & cons[_n] ==.  
br Constituency cons

br

gen ConsName = District + "-" + string(cons)

gen WinDummy = (Status == "ELECTED")

bysort ConsName: egen ConsVotesCast = total(Votecount)
bysort ConsName: egen ConsNumCandidates = count(Votecount)
*bysort ConsName: egen ConsNumCandidates = count(Votecount)

sort ConsName Votecount

*gen ClientDummy = (PartyName == "Nepal Communist Party (UML)" | PartyName == "Nepali Congress")

label variable ConsName "Constituency Name"
label variable  ConsVotesCast "Valid Votes cast in constituency"
label variable ConsNumCandidates "Number of Candidates in Constituency"
*label variable ClientDummy "NC or UML"

*bysort ConsName: egen ClientTally = total (Votecount*ClientDummy)

gen UniqueVoteCount = (ConsVotesCast[_n] !=ConsVotesCast[_n-1])

bysort District: egen DistVoteCount = total(ConsVotesCast* UniqueVoteCount)
*bysort District: egen DistClientCount = total(Votecount * ClientDummy)


sort ConsName Votecount
bysort ConsName: egen rk = rank(Votecount)
gen Rank = abs(rk -ConsNumCandidates) + 1
br ConsName Votecount WinDummy Rank if WinDummy == 1

gen pvs1 = pv1 / ConsVotesCast

bysort ConsName: egen WinPct = max(vs1)

rename Votecount pv1
rename PartyName Party
rename ConsName Constituency


gen NCDummy =  (Party == "Nepali Congress")
gen UMLDummy = (Party == "Nepal Communist Party (UML)")
gen MAODummy =(Party == "communist party of nepal (maoist)")
gen MADHDummy = (Party == "Nepal Sadbhawana Party"| Party == "madeshi jana adhikar forum nepal")
gen PANDummy = (Party == "Rastriya Janamukti Party"| Party == "Rastriya Prajatantra Party"| Party == "Rastriya Prajatantra Party (Chand)")

bysort Constituency: gen NCVoteShare = pvs1*NCDummy
bysort Constituency: gen UMLVoteShare = pvs1*UMLDummy
bysort Constituency: gen MAOVoteShare = pvs1*MAODummy
bysort Constituency: gen MADHVoteShare = pvs1*MADHDummy
bysort Constituency: gen PANVoteShare = pvs1*PANDummy

save "/Users/Apoorva/Documents/Google Drive/5Thesis/Final Election Datasets/Final1999.dta", replace

gen ConsWinningMargin = WinPct - pvs1 * (Rank == 2) if Rank == 2
bysort Constituency: gen ConsWinner = Party if WinDummy == 1

gen WinningParty = Party if WinDummy == 1
gen WinningCandidate = Candidate if WinDummy == 1

collapse (firstnm) WinningCandidate  WinningParty (max) NCVoteShare UMLVoteShare MAOVoteShare MADHVoteShare PANVoteShare, by (Constituency)

save "1999ConsLevWParties.dta", replace

/*

use "/Users/Apoorva/Documents/Google Drive/5Thesis/Final Election Datasets/Final1999.dta"

keep if Rank <6

use "/Users/Apoorva/Documents/Google Drive/5Thesis/Final Election Datasets/Final1999.dta"

bysort Constituency: egen ConsTotTop5Votes = total(Votecount)
bysort Constituency: gen ConsOtherCount = ConsTotTop5Votes - ClientTally

gen vs1 = Votecount / ConsVotesCast
sort Constituency vs1 

bysort Constituency: egen WinPct = max(vs1)

gen ConsWinningMargin = WinPct - vs1 * (Rank == 2) if Rank == 2
bysort Constituency: gen ConsWinner = Party if WinDummy == 1


gen ConsClientTurnout = ClientTally/ConsVotesCast
gen ConsOtherTurnout = ConsOtherCount/ConsVotesCast

        
collapse (firstnm) ConsWinningMargin ConsWinner (mean) ConsNumCandidates ConsVotesCast ClientTally ConsClientTurnout ConsTotTop5Votes ConsOtherCount ConsOtherTurnout, by (Constituency)

save "/Users/Apoorva/Documents/Google Drive/5Thesis/Final Election Datasets/ConsLevel1999.dta", replace
   
   /*
   
   Cons
   District
   Candidate
   PartyName
   Votecount
   Status
   Constituency
   
   ConsNumCandidates
   WinDummy
   ClientDummy
   ClientTally
   UniqueVoteCount
   DistVoteCount
   DistClientCount
   DistClientTurnout
   rk
   Rank
   ConsTotTop5Votes
   ConsOtherCount
   vs1
   WinPct
   ConsWinningMargin
   ConsWinner
   ConsOtherTurnout
