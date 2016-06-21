

gen n = strpos(Constituency, " ")
gen district = substr(Constituency,1,n-1)

cd "/Users/Apoorva/Desktop/Output Tables/"
use 0704PooledSampleForOLS


gen ClientVoteShare = NCVoteShare + UMLVoteShare + PANVoteShare

gen lnMig = ln(MigDummy*100)


/*quietly reg  ClientVoteShare   MigDummy ERPol AgDummy UrbanDummy PovertyIncidence norm_nkilled_96_06 norm_area_road_90 MadheshDummy t2 ERPolt2 Madhesht2, cluster (district)
outreg2 using BaselineOLS.doc, append label */


gen MigPct = MigDummy * 100

quietly reg  ClientVoteShare   MigPct ERPol AgDummy UrbanDummy  PovertyIncidence norm_nkilled_96_06 norm_area_road_90 MadheshDummy, cluster (district)
outreg2 using BaselineOLS.doc, replace label
quietly reg  ClientVoteShare   MigPct ERPol AgDummy UrbanDummy  PovertyIncidence norm_nkilled_96_06 norm_area_road_90 MadheshDummy t2 , cluster (district)
outreg2 using BaselineOLS.doc, append label
quietly reg  ClientVoteShare   MigPct ERPol AgDummy UrbanDummy  PovertyIncidence norm_nkilled_96_06 norm_area_road_90 MadheshDummy t2 ERPolt2, cluster (district)
outreg2 using BaselineOLS.doc, append label
quietly reg  ClientVoteShare   MigPct ERPol AgDummy UrbanDummy  PovertyIncidence norm_nkilled_96_06 norm_area_road_90 MadheshDummy Madhesht2 t2 ERPolt2, cluster (district)
outreg2 using BaselineOLS.doc, append label


quietly reg  Turnout   MigPct ERPol AgDummy UrbanDummy  PovertyIncidence norm_nkilled_96_06 norm_area_road_90 MadheshDummy, cluster (district)
outreg2 using BaselineTurnoutOLS.doc, replace label
quietly reg  Turnout   MigPct ERPol AgDummy UrbanDummy  PovertyIncidence norm_nkilled_96_06 norm_area_road_90 MadheshDummy t2 , cluster (district)
outreg2 using BaselineTurnoutOLS.doc, append label
quietly reg  Turnout   MigPct ERPol AgDummy UrbanDummy  PovertyIncidence norm_nkilled_96_06 norm_area_road_90 MadheshDummy t2 ERPolt2, cluster (district)
outreg2 using BaselineTurnoutOLS.doc, append label

quietly reg  ConsNumCandidates   MigPct ERPol AgDummy UrbanDummy  PovertyIncidence norm_nkilled_96_06 norm_area_road_90 MadheshDummy, cluster (district)
outreg2 using BaselineNumOLS.doc, replace label
quietly reg  ConsNumCandidates   MigPct ERPol AgDummy UrbanDummy  PovertyIncidence norm_nkilled_96_06 norm_area_road_90 MadheshDummy t2 , cluster (district)
outreg2 using BaselineNumOLS.doc, append label
quietly reg  ConsNumCandidates   MigPct ERPol AgDummy UrbanDummy  PovertyIncidence norm_nkilled_96_06 norm_area_road_90 MadheshDummy t2 ERPolt2, cluster (district)
outreg2 using BaselineNumOLS.doc, append label

quietly reg  ConsWinningMargin   MigPct ERPol AgDummy UrbanDummy  PovertyIncidence norm_nkilled_96_06 norm_area_road_90 MadheshDummy, cluster (district)
outreg2 using BaselineMarginOLS.doc, replace label
quietly reg  ConsWinningMargin   MigPct ERPol AgDummy UrbanDummy  PovertyIncidence norm_nkilled_96_06 norm_area_road_90 MadheshDummy t2 , cluster (district)
outreg2 using BaselineMarginOLS.doc, append label
quietly reg  ConsWinningMargin   MigPct ERPol AgDummy UrbanDummy  PovertyIncidence norm_nkilled_96_06 norm_area_road_90 MadheshDummy t2 NCWin, cluster (district)
outreg2 using BaselineMarginOLS.doc, append label

quietly reg  NCVoteShare   MigPct ERPol AgDummy UrbanDummy MadheshDummy PovertyIncidence norm_nkilled_96_06 norm_area_road_90 t2 ERPolt2, cluster (district)
outreg2 using PartyOLS.doc, replace label
quietly reg  UMLVoteShare   MigPct ERPol AgDummy UrbanDummy MadheshDummy PovertyIncidence norm_nkilled_96_06 norm_area_road_90 t2 ERPolt2,  cluster (district)
outreg2 using PartyOLS.doc, append label
quietly reg  MAOVoteShare   MigPct ERPol AgDummy UrbanDummy MadheshDummy PovertyIncidence norm_nkilled_96_06 norm_area_road_90 t2 ERPolt2,  cluster (district)
outreg2 using PartyOLS.doc, append label
quietly reg  MADHVoteShare   MigPct ERPol AgDummy UrbanDummy MadheshDummy PovertyIncidence norm_nkilled_96_06 norm_area_road_90 t2 ERPolt2,  cluster (district)
outreg2 using PartyOLS.doc, append label
quietly reg  PANVoteShare   MigPct ERPol AgDummy UrbanDummy MadheshDummy PovertyIncidence norm_nkilled_96_06 norm_area_road_90 t2 ERPolt2,  cluster (district)
outreg2 using PartyOLS.doc, append label




reg ClientVoteShare Turnout NCVoteShare UMLVoteShare MAOVoteShare MADHVoteShare PANVoteShare MigDummy ERPol AgDummy UrbanDummy MadheshDummy PovertyIncidence norm_nkilled_96_06 norm_area_road_90
outreg2 using SumStats.doc, sum replace label

gen ERPolt2 = ERPol * t2
gen Madhesht2 = MadheshDummy * t2


 label variable MigDummy "Percentage of Households in constituency with migrant"
 label variable ERPol "RQ Polarisation"
 label variable AgDummy "% Agriculture"
 label variable UrbanDummy "% Urban"
 label variable norm_area_road_90 "Road length normalised to area"
 label variable norm_nkilled_96_06 "Conflict casualties normalised to population"
 label variable MadheshDummy "Constituency is in Madhesh"
 label variable  PovertyIncidence "Poverty Rate"
 label variable  t2 "Year 2008 Dummy"
 label variable ERPolt2 "Interaction term: RQ Polarisation X Year 2 dummy"
 
gen CLWin = (ConsWinner == "Nepal Communist Party (UML)") + (ConsWinner == "Nepali Congress") + ///
 (ConsWinner == "Rastriya Prajatantra Party") + (ConsWinner == "nepali congress") + ///
 (ConsWinner == "communist party of nepal (unified-marxist- leninist)")




