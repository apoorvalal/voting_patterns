rm(list=ls())
pkg=c('haven','dplyr','ggplot2')
lapply(pkg, require, character.only=TRUE)


sys = c("win") # mac / win
if (sys=="mac") {
  path = c("/Users/apoorvalal/Desktop/projects/nepal_voting_patterns/analysis/")
} else {
  if (sys=="win") {
    path = c("C:/Users/Apoorva Lal/Desktop/Research/Nepal_Voting/analysis/")
  }
  else {
    print("incorrect sys")
  }
}

input = paste0(path,"/input/")
temp = paste0(path,"/tmp/")
setwd(path)
census01 = paste0(input,"/Nepal Census 2001/Files Downloaded from Cornell/")
# Read in data files
batchid=read_dta(paste0(census01,"batchid.dta"))
h1=read_dta(paste0(census01,"smplhi01.dta"))

names(batchid)
names(h1)
h1_f = merge(h1,batchid,id=batchid,all.x=TRUE)
rm(batchid,h1)

names(h1_f)


