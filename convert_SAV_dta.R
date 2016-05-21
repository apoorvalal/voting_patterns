rm(list=ls())
path = c("C:/Users/Apoorva Lal/Desktop/Research Papers/voting_patterns_nepal/analysis/input/Nepal Census 2011/pums/assets/datafiles")
setwd(path)
require(haven)

list=list.files(pattern=".SAV")

pos = regexpr('.SAV',list)
obj_name =  substr(list,1,pos-1)

outpath = paste0(path,"/",obj_name,".dta")
dfs <- ls()[sapply(mget(ls(), .GlobalEnv), is.data.frame)]

for (n in 1:length(list)){
  assign(paste0(obj_name[n]),read_sav(list[n]))
}  

write_dta(ABSENTEE,paste0(path,"/","absentee.dta"))
write_dta(DEATH,paste0(path,"/","death.dta"))
write_dta(Household,paste0(path,"/","household.dta"))
write_dta(Individual01,paste0(path,"/","Individual01.dta"))
write_dta(Individual02,paste0(path,"/","Individual02.dta"))

