rm(list=ls())
root = 'C:/Users/Apoorva Lal/Desktop/Research Papers/Nepal_Voting/analysis/'
tmp = paste0(root,"tmp/")
pkg = c('dplyr','ggplot2','haven','devtools')
lapply(pkg,require,character.only=TRUE)
setwd("~/Desktop/Research Papers/Nepal_Voting/analysis/input/Nepal Demographic and Health Surveys/")
list.files()

hh_01 = read_dta('01_nep_hh.dta')
str(hh_01)
names(hh_01)
