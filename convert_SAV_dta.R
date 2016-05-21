rm(list=ls())
sys = c("mac") # mac / win
if (sys=="mac") {
   path = c("/Users/apoorvalal/Desktop/projects/nepal_voting_patterns/analysis/input/Nepal Census 2011/pums/assets/datafiles")
} else {
   if (sys=="win") {
   path = c("C:/Users/Apoorva Lal/Desktop/Research Papers/voting_patterns_nepal/analysis/input/Nepal Census 2011/pums/assets/datafiles")
   }
   else {
      print("incorrect sys")
   }
}

setwd(path)
require(haven)

list=list.files(pattern=".SAV")

pos = regexpr('.SAV',list)
obj_name =  substr(list,1,pos-1)

outpath = paste0(path,"/",obj_name,".dta")

for (n in 1:length(list)){
  assign(paste0(obj_name[n]),read_sav(list[n]))
}

write_dta(ABSENTEE,paste0(path,"/","absentee.dta"))
write_dta(DEATH,paste0(path,"/","death.dta"))
write_dta(Household,paste0(path,"/","household.dta"))
write_dta(Individual01,paste0(path,"/","Individual01.dta"))
write_dta(Individual02,paste0(path,"/","Individual02.dta"))

rm(list= ls()[!(ls() %in% c('path','sys'))])
