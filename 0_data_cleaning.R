# Hello

# Packages
(.packages())
sessionInfo()
rm(list=ls())
packages = c("ggplot2","dplyr","glmnet","haven","data.table")
lapply(packages,require,character.only=TRUE)

# Read in data

input=c("C:/Users/Apoorva Lal/Desktop/Research Papers/voting_patterns_nepal/analysis/")
setwd(input)
getwd()
list.files()
pov <- read.csv("C:/Users/Apoorva Lal/Desktop/Research Papers/voting_patterns_nepal/analysis/input/poverty-rates-on-district-level-2001.csv", header = TRUE)

rahat <- read.csv("C:/Users/Apoorva Lal/Desktop/Research Papers/voting_patterns_nepal/analysis/input/rahatpayo_responses.csv", header=TRUE)
names(rahat)
drop_vars <- names(rahat) %in% c("X_Location_latitude","X_Location_longitude","X_Location_altitude","X_Location_precision","Photo","Any.comments","Start","end","username","simserial","deviceid","phonenumber","meta.instanceID","X_uuid","X_submission_time","X_tag","X_notes","start","today","subscriberid","X_tags","New_Question")
rahat <- rahat[!drop_vars]

setnames(rahat, old = c('Ward.No','Got.Help','Gov.Capacity',"All..injured..houses.destroyed.damaged","Affected..Other","Imp..food","Imp..emergency.medical.treatment","Imp..cash","Imp..tents","Imp..building.materials","Imp..all.of.the.above"), new = c('ward.no','got.help','gov.capacity',"injured.houses.destroyed.damaged","affected.other","imp.food","imp.emergency.medical.treatment","imp.cash","imp.tents","imp.building.materials","imp.all.of.the.above"))



# "all.injured.houses.destroyed.damaged"
# "affected.Other"
# "new_question"
# "Imp..food"
#  "Imp.sanitation"
#  "Imp..emergency.medical.treatment"
#  "Imp..cash"
#  "Imp..tents"
#  "Imp..building.materials"
#  "Imp..all.of.the.above"
#  "not.accesible..food.supplies"
#  "not.accessible..sanitation"
#  "not.accessible..emergency.supplies"
#  "Not.accessible..cash"
#  "Not.accessible..tents"
#  "Not.accessible..building.materials"
#  "Not.accessible..All.of.the.above"
#  "Top.priority..foreign.employmnet"
#  "Top.priority..farm.business"
#  "Top.priority..not.sure"
#  "Top.priority..education"
#  "Top.priority..rebuilding"
#  "Top.priority..employment"
#  "How.do.you.think.relief.response.could.be.improved.next.time"




