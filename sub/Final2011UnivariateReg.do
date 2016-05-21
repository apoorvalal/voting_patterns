clear
  * insert filepath here
 cd "/Users/Apoorva/Downloads/Data/Nepal Census 2011/"
use "hhldcollapsed.dta"

merge 1:1 DistrictName using "/Users/Apoorva/Documents/Google Drive/5Thesis/Final Election Datasets/Cleaned/DistrictLevel2013.dta"
reg logTransformationClient pctremit, robust

