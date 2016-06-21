cd "/Users/localmacaccount/Desktop/Output Tables/"
use "/Users/localmacaccount/Documents/Google Drive/5Thesis/Outreg Results/FinalPanel.dta", clear
/*
 outreg using MigReg, /*bdec(2 5 3 2)*/ varlabels replace              ///
                  starlevels(10 5 1) sigsymbols(*,**,***) summstat(N \ F \ r2_a)  ///
                  summtitle(N \ F statistic \ Adjusted R-squared) summdec(0 1 2)
*/        

label variable DiffClient "Difference in Client turnout"
label variable DiffMig "Difference in % of households with Migrant"
label variable DiffProxyMeans "Difference in Income Proxy"
label variable DiffAg "Difference in % of households engaged in Agriculture"
label variable ERPol2011 "Esteban-Ray polarisation measure"
label variable norm_nkilled_96_06 "Number of casualties in district"
label variable  BorderDummy "Constituency is a border district"
label variable  MadheshDummy "Constituency is a Madhesh district"
label variable  MadheshMig "Interaction term between DiffMig and Madhesh Dummy"


*merge 1:1 DistCons using turnout.dta, update

*merge m:1 District using rainfallDistLev.dta, update
*label variable DiffMargin "Difference in Winning Margin"

* Big Table
quietly reg DiffClient DiffMig DiffProxyMeans DiffAg ERPol2011 norm_nkilled_96_06 MadheshDummy, cluster(distname)
coefplot , drop(_cons) xline(0) xtitle (Effect on Clientelist Vote Share)

outreg2 using Results0404.doc, replace ctitle(Diff in Client Vote Share) label


quietly reg DiffClient DiffMig DiffProxyMeans DiffAg ERPol2011 norm_nkilled_96_06 MadheshDummy MadheshMig, cluster(distname)
outreg2 using Results0404.doc, append ctitle(Diff in Client Turnout) label
quietly reg diffTurnout DiffMig DiffProxyMeans DiffAg ERPol2011 norm_nkilled_96_06 MadheshDummy, cluster(distname)
outreg2 using  Results0404.doc, append ctitle(Diff in Overall Turnout) label

*Electoral competitiveness

reg DiffMargin DiffMig  DiffProxyMeans DiffAg ERPol2011 norm_nkilled_96_06 MadheshDummy, cluster(distname)
outreg2 using Comp.doc, replace ctitle(Diff in winning Margin) label
reg DiffMargin DiffMig NonClientWin DiffProxyMeans DiffAg ERPol2011 norm_nkilled_96_06 MadheshDummy, cluster(distname)
outreg2 using Comp.doc, ctitle(Diff in winning Margin) label
reg DiffCandidates DiffMig DiffProxyMeans DiffAg ERPol2011 norm_nkilled_96_06 MadheshDummy, cluster(distname)
outreg2 using Comp.doc, append ctitle(Diff in number of candidates) label


gen nCLWin2008 = (ConsWinner2008 != "nepali congress" & ConsWinner2008 != "communist party of nepal (unified-marxist- leninist)")

reg DiffMargin DiffMig DiffProxyMeans DiffAg ERPol2011 norm_nkilled_96_06 MadheshDummy NCLW2008 diffMarginNCL , cluster(distname)


* NC
reg NCDiff DiffMig DiffProxyMeans DiffAg ERPol2011 norm_nkilled_96_06 MadheshDummy, cluster(distname)
outreg2 using PartyLev1.doc, replace ctitle(Diff NC) label
* UML
reg UMLDiff DiffMig DiffProxyMeans DiffAg ERPol2011 norm_nkilled_96_06 MadheshDummy, cluster(distname)
outreg2 using PartyLev1.doc, append ctitle(Diff UML) label
* MAO
reg MAODiff DiffMig DiffProxyMeans DiffAg ERPol2011 norm_nkilled_96_06 MadheshDummy, cluster(distname)
outreg2 using PartyLev1.doc, append ctitle(Diff MAOIST) label
* MADHESHI PARTIES
reg MADHDiff DiffMig DiffProxyMeans DiffAg ERPol2011 norm_nkilled_96_06 MadheshDummy, cluster(distname)
outreg2 using PartyLev1.doc, append ctitle(Diff MADHESH) label
* PANCHEY PARTIES
reg PANDiff DiffMig DiffProxyMeans DiffAg ERPol2011 norm_nkilled_96_06 MadheshDummy, cluster(distname)
outreg2 using PartyLev1.doc, append ctitle(Diff PANCH) label




 reg DiffClient DiffMig DiffProxyMeans DiffAg ERPol2011 norm_nkilled_96_06 MadheshDummy, cluster(distname)
coefplot , drop(_cons) xline(0) xtitle (Effect on Clientelist Vote Share)
reg DiffClient DiffMig DiffProxyMeans DiffAg ERPol2011 norm_nkilled_96_06 MadheshDummy MadheshMig, cluster(distname)
coefplot , drop(_cons) xline(0) xtitle (Effect on Clientelist Vote Share)

reg diffTurnout DiffMig DiffProxyMeans DiffAg ERPol2011 norm_nkilled_96_06 MadheshDummy, cluster(distname)
coefplot , drop(_cons) xline(0) xtitle (Effect on Turnout)




reg NCDiff DiffMig DiffProxyMeans DiffAg ERPol2011 norm_nkilled_96_06 MadheshDummy, cluster(distname)
estimates store NC
* UML
reg UMLDiff DiffMig DiffProxyMeans DiffAg ERPol2011 norm_nkilled_96_06 MadheshDummy, cluster(distname)
estimates store UML
* MAO
reg MAODiff DiffMig DiffProxyMeans DiffAg ERPol2011 norm_nkilled_96_06 MadheshDummy, cluster(distname)
estimates store MAO
* MADHESHI PARTIES
reg MADHDiff DiffMig DiffProxyMeans DiffAg ERPol2011 norm_nkilled_96_06 MadheshDummy, cluster(distname)
estimates store MADH
* PANCHEY PARTIES
reg PANDiff DiffMig DiffProxyMeans DiffAg ERPol2011 norm_nkilled_96_06 MadheshDummy, cluster(distname)
estimates store PANCH


coefplot NC UML MAO MADH PANCH, drop (DiffAg _cons) xline (0) xtitle (Effect on Party Vote shares)

quietly reg DiffClient DiffMig DiffProxyMeans DiffAg ERPol2011 norm_nkilled_96_06 MadheshDummy, cluster(distname)
coefplot , drop(_cons) xline(0) xtitle (Effect on Clientelist Vote Share)

quietly reg diffTurnout DiffMig DiffProxyMeans DiffAg ERPol2011 norm_nkilled_96_06 MadheshDummy, cluster(distname)
coefplot , drop(_cons) xline(0) xtitle (Effect on Overall Turnout)


/*
gen CLWin2008 = (ConsWinner2008 == "nepali congress") + (ConsWinner2008 == "communist party of nepal (unified-marxist- leninist)")
codebook CLWin2008
reg DiffMargin DiffMig DiffProxyMeans DiffAg ERPol2011 norm_nkilled_96_06 MadheshDummy ERMig CLWin2008, cluster(distname)
gen NCLW2008 = 1-CLWin2008

/*
outreg2 using myreg.doc, replace ctitle(Difference in Client Turnout) label

.  outreg using MigReg, /*bdec(2 5 3 2)*/ varlabels replace              ///
>                   starlevels(10 5 1) sigsymbols(*,**,***) summstat(N \ F \ r2_a)  ///
>                   summtitle(N \ F statistic \ Adjusted R-squared) summdec(0 1 2)

         --------------------------------------------------------------------------------------
                                                                 Difference in Client turnout 
         --------------------------------------------------------------------------------------
          Difference in % of households with Migrant                        -0.058            
                                                                            (0.23)            
          Difference in Income Proxy                                        -0.000            
                                                                            (0.01)            
          Difference in % of households engaged in Agriculture              0.267             
                                                                            (1.65)            
          Esteban-Ray polarisation measure                                  -0.207            
                                                                           (1.81)*            
          Number of casualties in district                                  -0.070            
                                                                          (4.02)***           
          Constituency is a Madhesh district                                -0.159            
                                                                           (2.10)**           
          Interaction term between DiffMig and Madhesh Dummy                0.641             
                                                                           (1.80)*            
          Constant                                                          -0.027            
                                                                            (0.33)            
          N                                                                  202              
          F statistic                                                        4.7              
          Adjusted R-squared                                                 0.17             
         --------------------------------------------------------------------------------------
                                     * p<0.1; ** p<0.05; *** p<0.01
