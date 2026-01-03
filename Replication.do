* Table 3

import delimited " *logit file ", clear
generate logpop_2020 = log(population_2020)
encode prefecture, generate(prefecture_ind)

logistic gpp_2020 logpop_2020 income_2020 debt_2020 sector_1_2020 sector_2_2020 liveable_2020 i.prefecture_ind, vce(cluster prefecture) coef


import delimited " *survival file ", clear
generate logpop = log(population)
replace year = year - 2010
tostring year, gen(year_str)
encode year_str, gen(year_ind)
encode prefecture, gen(prefecture_ind)
stset year, id(id) failure(gpp) exit(time 10)

stcox logpop income debt  sector_1 sector_2 liveable neighbors_mean_population neighbors_mean_income  if nb_neighbors_contiguous > 0, shared(prefecture_ind) nohr
estat phtest

stcox logpop income debt  sector_1 sector_2 liveable neighbors_mean_population neighbors_mean_income  if nb_neighbors_contiguous > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox logpop income debt  sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km  if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox logpop income debt  sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km  if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest



* Table 4

import delimited " *survival file ", clear
generate logpop = log(population)
generate inter_neighbors_pop = logpop*mean_neighbors_lag_1
generate inter_neighbors_income = income*mean_neighbors_lag_1
generate inter_10km_pop = logpop*mean_gpp_10km_lag_1
generate inter_10km_income = income*mean_gpp_10km_lag_1
generate inter_20km_pop = logpop*mean_gpp_20km_lag_1
generate inter_20km_income = income*mean_gpp_20km_lag_1
replace year = year - 2010
tostring year, gen(year_str)
encode year_str, gen(year_ind)
encode prefecture, gen(prefecture_ind)
drop if year == 1
stset year, id(id) failure(gpp) exit(time 10)

stcox mean_neighbors_lag_1 mean_not_neigh_lag_1 if nb_neighbors_contiguous > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox mean_neighbors_lag_1 mean_not_neigh_lag_1 nb_neighbors_contiguous logpop income debt sector_1 sector_2 liveable neighbors_mean_population neighbors_mean_income  if nb_neighbors_contiguous > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox mean_gpp_10km_lag_1 mean_gpp_beyond_10km_lag_1 if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox mean_gpp_10km_lag_1 mean_gpp_beyond_10km_lag_1 nb_neighbors_10km logpop income debt sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km  if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox mean_gpp_20km_lag_1 mean_gpp_beyond_20km_lag_1 if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox mean_gpp_20km_lag_1 mean_gpp_beyond_20km_lag_1 nb_neighbors_20km logpop income debt sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km  if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest


import delimited " *survival file ", clear
generate logpop = log(population)
generate inter_neighbors_pop = logpop*mean_neighbors_lag_2
generate inter_neighbors_income = income*mean_neighbors_lag_2
generate inter_10km_pop = logpop*mean_gpp_10km_lag_2
generate inter_10km_income = income*mean_gpp_10km_lag_2
generate inter_20km_pop = logpop*mean_gpp_20km_lag_2
generate inter_20km_income = income*mean_gpp_20km_lag_2
replace year = year - 2010
tostring year, gen(year_str)
encode year_str, gen(year_ind)
encode prefecture, gen(prefecture_ind)
drop if year == 1
drop if year == 2
stset year, id(id) failure(gpp) exit(time 10)

stcox mean_neighbors_lag_2 mean_not_neigh_lag_2 if nb_neighbors_contiguous > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox mean_neighbors_lag_2 mean_not_neigh_lag_2 nb_neighbors_contiguous logpop income debt sector_1 sector_2 liveable neighbors_mean_population neighbors_mean_income  if nb_neighbors_contiguous > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox mean_gpp_10km_lag_2 mean_gpp_beyond_10km_lag_2 if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox mean_gpp_10km_lag_2 mean_gpp_beyond_10km_lag_2 nb_neighbors_10km logpop income debt sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km  if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox mean_gpp_20km_lag_2 mean_gpp_beyond_20km_lag_2 if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox mean_gpp_20km_lag_2 mean_gpp_beyond_20km_lag_2 nb_neighbors_20km logpop income debt sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km  if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest


import delimited " *survival file ", clear
generate logpop = log(population)
generate inter_neighbors_pop = logpop*mean_neighbors_lag_1
generate inter_neighbors_income = income*mean_neighbors_lag_1
generate inter_10km_pop = logpop*mean_gpp_10km_lag_1
generate inter_10km_income = income*mean_gpp_10km_lag_1
generate inter_20km_pop = logpop*mean_gpp_20km_lag_1
generate inter_20km_income = income*mean_gpp_20km_lag_1
replace year = year - 2010
tostring year, gen(year_str)
encode year_str, gen(year_ind)
encode prefecture, gen(prefecture_ind)
drop if year == 1
drop if year == 2
drop if year == 3
stset year, id(id) failure(gpp) exit(time 10)

stcox mean_neighbors_lag_3 mean_not_neigh_lag_3 if nb_neighbors_contiguous > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox mean_neighbors_lag_3 mean_not_neigh_lag_3 nb_neighbors_contiguous logpop income debt sector_1 sector_2 liveable neighbors_mean_population neighbors_mean_income  if nb_neighbors_contiguous > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox mean_gpp_10km_lag_3 mean_gpp_beyond_10km_lag_3 if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox mean_gpp_10km_lag_3 mean_gpp_beyond_10km_lag_3 nb_neighbors_10km logpop income debt sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km  if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox mean_gpp_20km_lag_3 mean_gpp_beyond_20km_lag_3 if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox mean_gpp_20km_lag_3 mean_gpp_beyond_20km_lag_3 nb_neighbors_20km logpop income debt sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km  if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest



* Table 5

import delimited " *survival file ", clear
generate logpop = log(population)
generate inter_neighbors_pop = logpop*mean_neighbors_lag_1
generate inter_neighbors_income = income*mean_neighbors_lag_1
generate inter_10km_pop = logpop*mean_gpp_10km_lag_1
generate inter_10km_income = income*mean_gpp_10km_lag_1
generate inter_20km_pop = logpop*mean_gpp_20km_lag_1
generate inter_20km_income = income*mean_gpp_20km_lag_1
replace year = year - 2010
tostring year, gen(year_str)
encode year_str, gen(year_ind)
encode prefecture, gen(prefecture_ind)
drop if year == 1
stset year, id(id) failure(gpp) exit(time 10)

stcox count_gpp_10km_lag_1 count_gpp_beyond_10km_lag_1 if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox count_gpp_10km_lag_1 count_gpp_beyond_10km_lag_1 nb_neighbors_10km logpop income debt sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km  if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox count_gpp_20km_lag_1 count_gpp_beyond_20km_lag_1 if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox count_gpp_20km_lag_1 count_gpp_beyond_20km_lag_1 nb_neighbors_20km logpop income debt sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km  if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest


import delimited " *survival file ", clear
generate logpop = log(population)
generate inter_neighbors_pop = logpop*mean_neighbors_lag_2
generate inter_neighbors_income = income*mean_neighbors_lag_2
generate inter_10km_pop = logpop*mean_gpp_10km_lag_2
generate inter_10km_income = income*mean_gpp_10km_lag_2
generate inter_20km_pop = logpop*mean_gpp_20km_lag_2
generate inter_20km_income = income*mean_gpp_20km_lag_2
replace year = year - 2010
tostring year, gen(year_str)
encode year_str, gen(year_ind)
encode prefecture, gen(prefecture_ind)
drop if year == 1
drop if year == 2
stset year, id(id) failure(gpp) exit(time 10)

stcox count_gpp_10km_lag_2 count_gpp_beyond_10km_lag_2 if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox count_gpp_10km_lag_2 count_gpp_beyond_10km_lag_2 nb_neighbors_10km logpop income debt sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km  if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox count_gpp_20km_lag_2 count_gpp_beyond_20km_lag_2 if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox count_gpp_20km_lag_2 count_gpp_beyond_20km_lag_2 nb_neighbors_20km logpop income debt sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km  if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest


import delimited " *survival file ", clear
generate logpop = log(population)
generate inter_neighbors_pop = logpop*mean_neighbors_lag_1
generate inter_neighbors_income = income*mean_neighbors_lag_1
generate inter_10km_pop = logpop*mean_gpp_10km_lag_1
generate inter_10km_income = income*mean_gpp_10km_lag_1
generate inter_20km_pop = logpop*mean_gpp_20km_lag_1
generate inter_20km_income = income*mean_gpp_20km_lag_1
replace year = year - 2010
tostring year, gen(year_str)
encode year_str, gen(year_ind)
encode prefecture, gen(prefecture_ind)
drop if year == 1
drop if year == 2
drop if year == 3
stset year, id(id) failure(gpp) exit(time 10)

stcox count_gpp_10km_lag_3 count_gpp_beyond_10km_lag_3 if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox count_gpp_10km_lag_3 count_gpp_beyond_10km_lag_3 nb_neighbors_10km logpop income debt sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km  if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox count_gpp_20km_lag_3 count_gpp_beyond_20km_lag_3 if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox count_gpp_20km_lag_3 count_gpp_beyond_20km_lag_3 nb_neighbors_20km logpop income debt sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km  if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest



* Table 6

import delimited " *survival file ", clear
generate logpop = log(population)
generate inter_neighbors_pop = logpop*mean_neighbors_lag_1
generate inter_neighbors_income = income*mean_neighbors_lag_1
generate inter_10km_pop = logpop*mean_gpp_10km_lag_1
generate inter_10km_income = income*mean_gpp_10km_lag_1
generate inter_20km_pop = logpop*mean_gpp_20km_lag_1
generate inter_20km_income = income*mean_gpp_20km_lag_1
replace year = year - 2010
tostring year, gen(year_str)
encode year_str, gen(year_ind)
encode prefecture, gen(prefecture_ind)
drop if year == 1
stset year, id(id) failure(gpp) exit(time 10)

stcox mean_publish_10km_lag_1 mean_gpp_10km_lag_1 if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox mean_publish_10km_lag_1 mean_publish_beyond_10km_lag_1 nb_neighbors_10km logpop income debt sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km  if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox mean_publish_20km_lag_1 mean_gpp_20km_lag_1 if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox mean_publish_20km_lag_1 mean_publish_beyond_20km_lag_1 nb_neighbors_20km logpop income debt sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km  if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest


import delimited " *survival file ", clear
generate logpop = log(population)
generate inter_neighbors_pop = logpop*mean_neighbors_lag_2
generate inter_neighbors_income = income*mean_neighbors_lag_2
generate inter_10km_pop = logpop*mean_gpp_10km_lag_2
generate inter_10km_income = income*mean_gpp_10km_lag_2
generate inter_20km_pop = logpop*mean_gpp_20km_lag_2
generate inter_20km_income = income*mean_gpp_20km_lag_2
replace year = year - 2010
tostring year, gen(year_str)
encode year_str, gen(year_ind)
encode prefecture, gen(prefecture_ind)
drop if year == 1
drop if year == 2
stset year, id(id) failure(gpp) exit(time 10)

stcox mean_publish_10km_lag_2 mean_gpp_10km_lag_2 if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox mean_publish_10km_lag_2 mean_publish_beyond_10km_lag_2 nb_neighbors_10km logpop income debt sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km  if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox mean_publish_20km_lag_2 mean_gpp_20km_lag_2 if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox mean_publish_20km_lag_2 mean_publish_beyond_20km_lag_2 nb_neighbors_20km logpop income debt sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km  if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest


import delimited " *survival file ", clear
generate logpop = log(population)
generate inter_neighbors_pop = logpop*mean_neighbors_lag_1
generate inter_neighbors_income = income*mean_neighbors_lag_1
generate inter_10km_pop = logpop*mean_gpp_10km_lag_1
generate inter_10km_income = income*mean_gpp_10km_lag_1
generate inter_20km_pop = logpop*mean_gpp_20km_lag_1
generate inter_20km_income = income*mean_gpp_20km_lag_1
replace year = year - 2010
tostring year, gen(year_str)
encode year_str, gen(year_ind)
encode prefecture, gen(prefecture_ind)
drop if year == 1
drop if year == 2
drop if year == 3
stset year, id(id) failure(gpp) exit(time 10)

stcox mean_publish_10km_lag_3 mean_gpp_10km_lag_3 if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox mean_publish_10km_lag_3 mean_publish_beyond_10km_lag_3 nb_neighbors_10km logpop income debt sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km  if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox mean_publish_20km_lag_3 mean_gpp_20km_lag_3 if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

stcox mean_publish_20km_lag_3 mean_publish_beyond_20km_lag_3 nb_neighbors_20km logpop income debt sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km  if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
