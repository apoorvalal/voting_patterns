

**Results in table2.out and table3.out (drop first column)
**OLS-FE (table2.out), NB-FE (table3.out)

clear all
set more 1
set more off
set mem 500m
*log using Output6.log, replace

use smalldataset_rainfall2, clear

