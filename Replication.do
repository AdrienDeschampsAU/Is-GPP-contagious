* Table 3:

import delimited "...logit.csv", clear
generate logpop_2020 = log(population_2020)
encode prefecture, generate(prefecture_ind)

logistic gpp_2020 logpop_2020 income_2020 debt_2020 liberal_2020 sector_1_2020 sector_2_2020 liveable_2020, vce(cluster prefecture) coef
logistic gpp_2020 logpop_2020 income_2020 debt_2020 liberal_2020 sector_1_2020 sector_2_2020 liveable_2020 i.prefecture_ind, vce(cluster prefecture) coef
logistic gpp_2020 is_prefectural_capital logpop_2020 income_2020 debt_2020 liberal_2020 sector_1_2020 sector_2_2020 liveable_2020 i.prefecture_ind, vce(cluster prefecture) coef



* Table 4:

import delimited "...survival.csv", clear
generate logpop = log(population)
replace year = year - 2010
tostring year, gen(year_str)
encode year_str, gen(year_ind)
encode prefecture, gen(prefecture_ind)
stset year, id(id) failure(gpp) exit(time 10)

stcox logpop income debt liberal sector_1 sector_2 liveable neighbors_mean_population neighbors_mean_income liberal_prefecture if nb_neighbors_contiguous > 0, shared(prefecture) nohr
stcox logpop income debt liberal sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km liberal_prefecture if nb_neighbors_10km > 0, shared(prefecture) nohr
stcox logpop income debt liberal sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km liberal_prefecture if nb_neighbors_20km > 0, shared(prefecture) nohr
stcox logpop income debt liberal sector_1 sector_2 liveable mean_log_pop_30km mean_income_30km liberal_prefecture if nb_neighbors_30km > 0, shared(prefecture) nohr
stcox logpop income debt liberal sector_1 sector_2 liveable mean_log_pop_40km mean_income_40km liberal_prefecture if nb_neighbors_40km > 0, shared(prefecture) nohr
stcox logpop income debt liberal sector_1 sector_2 liveable mean_log_pop_50km mean_income_50km liberal_prefecture if nb_neighbors_50km > 0, shared(prefecture) nohr



* Table 5:

import delimited "...survival.csv", clear
replace year = year - 2010
tostring year, gen(year_str)
encode year_str, gen(year_ind)
encode prefecture, gen(prefecture_ind)
drop if year == 1
stset year, id(id) failure(gpp) exit(time 10)

stcox mean_neighbors_lag_1 if nb_neighbors_contiguous > 0, shared(prefecture) nohr
stcox mean_gpp_10km_lag_1 if nb_neighbors_10km > 0, shared(prefecture) nohr
stcox mean_gpp_20km_lag_1 if nb_neighbors_20km > 0, shared(prefecture) nohr
stcox mean_gpp_30km_lag_1 if nb_neighbors_30km > 0, shared(prefecture) nohr
stcox mean_gpp_40km_lag_1 if nb_neighbors_40km > 0, shared(prefecture) nohr
stcox mean_gpp_50km_lag_1 if nb_neighbors_50km > 0, shared(prefecture) nohr



* Table 6:

import delimited "...survival.csv", clear
generate logpop = log(population)
replace year = year - 2010
tostring year, gen(year_str)
encode year_str, gen(year_ind)
encode prefecture, gen(prefecture_ind)
drop if year == 1
stset year, id(id) failure(gpp) exit(time 10)

stcox mean_neighbors_lag_1 mean_not_neigh_lag_1 logpop income debt sector_1 sector_2 liveable neighbors_mean_population neighbors_mean_income liberal_prefecture if nb_neighbors_contiguous > 0, shared(prefecture) nohr
stcox mean_gpp_10km_lag_1 mean_gpp_beyond_10km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km liberal_prefecture if nb_neighbors_10km > 0, shared(prefecture) nohr
stcox mean_gpp_20km_lag_1 mean_gpp_beyond_20km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km liberal_prefecture if nb_neighbors_20km > 0, shared(prefecture) nohr
stcox mean_gpp_30km_lag_1 mean_gpp_beyond_30km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_30km mean_income_30km liberal_prefecture if nb_neighbors_30km > 0, shared(prefecture) nohr
stcox mean_gpp_40km_lag_1 mean_gpp_beyond_40km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_40km mean_income_40km liberal_prefecture if nb_neighbors_40km > 0, shared(prefecture) nohr
stcox mean_gpp_50km_lag_1 mean_gpp_beyond_50km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_50km mean_income_50km liberal_prefecture if nb_neighbors_50km > 0, shared(prefecture) nohr



* Table 7:

import delimited "...survival.csv", clear
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


stcox inter_neighbors_pop mean_neighbors_lag_1 mean_not_neigh_lag_1 logpop income debt sector_1 sector_2 liveable neighbors_mean_population neighbors_mean_income liberal_prefecture if nb_neighbors_contiguous > 0, shared(prefecture) nohr
stcox inter_neighbors_income mean_neighbors_lag_1 mean_not_neigh_lag_1 logpop income debt sector_1 sector_2 liveable neighbors_mean_population neighbors_mean_income liberal_prefecture if nb_neighbors_contiguous > 0, shared(prefecture) nohr
stcox inter_10km_pop mean_gpp_10km_lag_1 mean_gpp_beyond_10km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km liberal_prefecture if nb_neighbors_10km > 0, shared(prefecture) nohr
stcox inter_10km_income mean_gpp_10km_lag_1 mean_gpp_beyond_10km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km liberal_prefecture if nb_neighbors_10km > 0, shared(prefecture) nohr
stcox inter_20km_pop mean_gpp_20km_lag_1 mean_gpp_beyond_20km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km liberal_prefecture if nb_neighbors_20km > 0, shared(prefecture) nohr
stcox inter_20km_income mean_gpp_20km_lag_1 mean_gpp_beyond_20km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km liberal_prefecture if nb_neighbors_20km > 0, shared(prefecture) nohr



* Table 8:

import delimited "...survival.csv", clear
generate logpop = log(population)
replace year = year - 2010
tostring year, gen(year_str)
encode year_str, gen(year_ind)
encode prefecture, gen(prefecture_ind)
drop if year == 1
stset year, id(id) failure(gpp) exit(time 10)

stcox mean_publish_10km_lag_1 mean_gpp_10km_lag_1 mean_gpp_beyond_10km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km liberal_prefecture if nb_neighbors_10km > 0, shared(prefecture) nohr
stcox mean_publish_20km_lag_1 mean_gpp_20km_lag_1 mean_gpp_beyond_20km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km liberal_prefecture if nb_neighbors_20km > 0, shared(prefecture) nohr
stcox count_publish_10km_lag_1 count_gpp_10km_lag_1 count_gpp_beyond_10km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km liberal_prefecture if nb_neighbors_10km > 0, shared(prefecture) nohr
stcox count_publish_20km_lag_1 count_gpp_20km_lag_1 count_gpp_beyond_20km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km liberal_prefecture if nb_neighbors_20km > 0, shared(prefecture) nohr



* Table 9:

import delimited "...logit.csv", clear
generate logpop_2020 = log(population_2020)
encode prefecture, generate(prefecture_ind)
encode with_designated, generate(with_designated_ind)

logistic gpp_2020 with_designated_ind logpop_2020 income_2020 debt_2020 sector_1_2020 sector_2_2020 population_prefecture_excl_2020 income_prefecture_excl_2020 liberal_prefecture_2020, vce(cluster prefecture) coef

import delimited "C:\Users\desch\OneDrive\Documents\doctorat\Waseda\panel10\submission\survival.csv", clear
generate logpop = log(population)
generate logpop_prefecture = log(population_prefecture_excl)
replace year = year - 2010
tostring year, gen(year_str)
encode year_str, gen(year_ind)
encode prefecture, gen(prefecture_ind)
drop if year == 1
stset year, id(id) failure(gpp) exit(time 10)

stcox with_designated logpop income debt sector_1 sector_2 population_prefecture_excl income_prefecture_excl liberal_prefecture, shared(prefecture) nohr



* Table F.11:

import delimited "...survival.csv", clear
generate logpop = log(population)
replace year = year - 2010
tostring year, gen(year_str)
encode year_str, gen(year_ind)
encode prefecture, gen(prefecture_ind)
stset year, id(id) failure(gpp) exit(time 10)

stcox logpop income debt liberal sector_1 sector_2 liveable neighbors_mean_population neighbors_mean_income  if nb_neighbors_contiguous > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox logpop income debt liberal sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km  if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox logpop income debt liberal sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km  if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox logpop income debt liberal sector_1 sector_2 liveable mean_log_pop_30km mean_income_30km  if nb_neighbors_30km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox logpop income debt liberal sector_1 sector_2 liveable mean_log_pop_40km mean_income_40km  if nb_neighbors_40km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox logpop income debt liberal sector_1 sector_2 liveable mean_log_pop_50km mean_income_50km  if nb_neighbors_50km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest



* Table G.12:

import delimited "...survival.csv", clear
generate logpop = log(population)
replace year = year - 2010
tostring year, gen(year_str)
encode year_str, gen(year_ind)
encode prefecture, gen(prefecture_ind)
stset year, id(id) failure(gpp) exit(time 10)

stcox logpop income debt sector_1 sector_2 liveable neighbors_mean_population neighbors_mean_income liberal_prefecture if nb_neighbors_contiguous > 0, shared(prefecture) nohr
stcox logpop income debt sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km liberal_prefecture if nb_neighbors_10km > 0, shared(prefecture) nohr
stcox logpop income debt sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km liberal_prefecture if nb_neighbors_20km > 0, shared(prefecture) nohr
stcox logpop income debt sector_1 sector_2 liveable mean_log_pop_30km mean_income_30km liberal_prefecture if nb_neighbors_30km > 0, shared(prefecture) nohr
stcox logpop income debt sector_1 sector_2 liveable mean_log_pop_40km mean_income_40km liberal_prefecture if nb_neighbors_40km > 0, shared(prefecture) nohr
stcox logpop income debt sector_1 sector_2 liveable mean_log_pop_50km mean_income_50km liberal_prefecture if nb_neighbors_50km > 0, shared(prefecture) nohr



* Table G.13:

import delimited "...survival.csv", clear
generate logpop = log(population)
replace year = year - 2010
tostring year, gen(year_str)
encode year_str, gen(year_ind)
encode prefecture, gen(prefecture_ind)
stset year, id(id) failure(gpp) exit(time 10)

stcox logpop income debt sector_1 sector_2 liveable neighbors_mean_population neighbors_mean_income  if nb_neighbors_contiguous > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox logpop income debt sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km  if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox logpop income debt sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km  if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox logpop income debt sector_1 sector_2 liveable mean_log_pop_30km mean_income_30km  if nb_neighbors_30km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox logpop income debt sector_1 sector_2 liveable mean_log_pop_40km mean_income_40km  if nb_neighbors_40km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox logpop income debt sector_1 sector_2 liveable mean_log_pop_50km mean_income_50km  if nb_neighbors_50km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest



* Table H.14:

import delimited "...survival.csv", clear
generate logpop = log(population)
replace year = year - 2010
tostring year, gen(year_str)
encode year_str, gen(year_ind)
encode prefecture, gen(prefecture_ind)
drop if year == 1
stset year, id(id) failure(gpp) exit(time 10)

stcox mean_neighbors_lag_1 if nb_neighbors_contiguous > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox mean_gpp_10km_lag_1 if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox mean_gpp_20km_lag_1 if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox mean_gpp_30km_lag_1 if nb_neighbors_30km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox mean_gpp_40km_lag_1 if nb_neighbors_40km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox mean_gpp_50km_lag_1 if nb_neighbors_50km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest



* Table J.15:

import delimited "...survival.csv", clear
generate logpop = log(population)
replace year = year - 2010
tostring year, gen(year_str)
encode year_str, gen(year_ind)
encode prefecture, gen(prefecture_ind)
drop if year == 1
stset year, id(id) failure(gpp) exit(time 10)

stcox mean_neighbors_lag_1 mean_not_neigh_lag_1 logpop income debt sector_1 sector_2 liveable neighbors_mean_population neighbors_mean_income  if nb_neighbors_contiguous > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox mean_gpp_10km_lag_1 mean_gpp_beyond_10km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km  if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox mean_gpp_20km_lag_1 mean_gpp_beyond_20km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km  if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox mean_gpp_30km_lag_1 mean_gpp_beyond_30km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_30km mean_income_30km  if nb_neighbors_30km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox mean_gpp_40km_lag_1 mean_gpp_beyond_40km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_40km mean_income_40km  if nb_neighbors_40km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox mean_gpp_50km_lag_1 mean_gpp_beyond_50km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_50km mean_income_50km  if nb_neighbors_50km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest



* Table K.16:

import delimited "...survival.csv", clear
generate logpop = log(population)
replace year = year - 2010
tostring year, gen(year_str)
encode year_str, gen(year_ind)
encode prefecture, gen(prefecture_ind)
drop if year == 1
drop if year == 2
stset year, id(id) failure(gpp) exit(time 10)

stcox mean_neighbors_lag_2 mean_not_neigh_lag_2 logpop income debt sector_1 sector_2 liveable neighbors_mean_population neighbors_mean_income liberal_prefecture if nb_neighbors_contiguous > 0, shared(prefecture) nohr
stcox mean_gpp_10km_lag_2 mean_gpp_beyond_10km_lag_2 logpop income debt sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km liberal_prefecture if nb_neighbors_10km > 0, shared(prefecture) nohr
stcox mean_gpp_20km_lag_2 mean_gpp_beyond_20km_lag_2 logpop income debt sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km liberal_prefecture if nb_neighbors_20km > 0, shared(prefecture) nohr


import delimited "...survival.csv", clear
generate logpop = log(population)
replace year = year - 2010
tostring year, gen(year_str)
encode year_str, gen(year_ind)
encode prefecture, gen(prefecture_ind)
drop if year == 1
drop if year == 2
drop if year == 3
stset year, id(id) failure(gpp) exit(time 10)

stcox mean_neighbors_lag_3 mean_not_neigh_lag_3 logpop income debt sector_1 sector_2 liveable neighbors_mean_population neighbors_mean_income liberal_prefecture if nb_neighbors_contiguous > 0, shared(prefecture) nohr
stcox mean_gpp_10km_lag_3 mean_gpp_beyond_10km_lag_3 logpop income debt sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km liberal_prefecture if nb_neighbors_20km > 0, shared(prefecture) nohr
stcox mean_gpp_20km_lag_3 mean_gpp_beyond_20km_lag_3 logpop income debt sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km liberal_prefecture if nb_neighbors_20km > 0, shared(prefecture) nohr



* Table K.17:

import delimited "...survival.csv", clear
generate logpop = log(population)
replace year = year - 2010
tostring year, gen(year_str)
encode year_str, gen(year_ind)
encode prefecture, gen(prefecture_ind)
drop if year == 1
drop if year == 2
stset year, id(id) failure(gpp) exit(time 10)

stcox mean_neighbors_lag_2 mean_not_neigh_lag_2 logpop income debt sector_1 sector_2 liveable neighbors_mean_population neighbors_mean_income  if nb_neighbors_contiguous > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox mean_gpp_10km_lag_2 mean_gpp_beyond_10km_lag_2 logpop income debt sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km  if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox mean_gpp_20km_lag_2 mean_gpp_beyond_20km_lag_2 logpop income debt sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km  if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest


import delimited "...survival.csv", clear
generate logpop = log(population)
replace year = year - 2010
tostring year, gen(year_str)
encode year_str, gen(year_ind)
encode prefecture, gen(prefecture_ind)
drop if year == 1
drop if year == 2
drop if year == 3
stset year, id(id) failure(gpp) exit(time 10)

stcox mean_neighbors_lag_3 mean_not_neigh_lag_3 logpop income debt sector_1 sector_2 liveable neighbors_mean_population neighbors_mean_income  if nb_neighbors_contiguous > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox mean_gpp_10km_lag_3 mean_gpp_beyond_10km_lag_3 logpop income debt sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km  if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox mean_gpp_20km_lag_3 mean_gpp_beyond_20km_lag_3 logpop income debt sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km  if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest



* Table L.18:

import delimited "...survival.csv", clear
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

stcox inter_neighbors_pop mean_neighbors_lag_1 mean_not_neigh_lag_1 logpop income debt sector_1 sector_2 liveable neighbors_mean_population neighbors_mean_income if nb_neighbors_contiguous > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox inter_neighbors_income mean_neighbors_lag_1 mean_not_neigh_lag_1 logpop income debt sector_1 sector_2 liveable neighbors_mean_population neighbors_mean_income if nb_neighbors_contiguous > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox inter_10km_pop mean_gpp_10km_lag_1 mean_gpp_beyond_10km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox inter_10km_income mean_gpp_10km_lag_1 mean_gpp_beyond_10km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox inter_20km_pop mean_gpp_20km_lag_1 mean_gpp_beyond_20km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox inter_20km_income mean_gpp_20km_lag_1 mean_gpp_beyond_20km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km  if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest



* Table M.19:

import delimited "...survival.csv", clear
generate logpop = log(population)
replace year = year - 2010
tostring year, gen(year_str)
encode year_str, gen(year_ind)
encode prefecture, gen(prefecture_ind)
drop if year == 1
stset year, id(id) failure(gpp) exit(time 10)

stcox is_prefectural_capital mean_neighbors_lag_1 mean_not_neigh_lag_1 logpop income debt sector_1 sector_2 liveable neighbors_mean_population neighbors_mean_income liberal_prefecture if nb_neighbors_contiguous > 0, shared(prefecture) nohr
stcox is_prefectural_capital mean_gpp_10km_lag_1 mean_gpp_beyond_10km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km liberal_prefecture if nb_neighbors_10km > 0, shared(prefecture) nohr
stcox is_prefectural_capital mean_gpp_20km_lag_1 mean_gpp_beyond_20km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km liberal_prefecture if nb_neighbors_20km > 0, shared(prefecture) nohr
stcox is_prefectural_capital mean_gpp_30km_lag_1 mean_gpp_beyond_30km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_30km mean_income_30km liberal_prefecture if nb_neighbors_30km > 0, shared(prefecture) nohr
stcox is_prefectural_capital mean_gpp_40km_lag_1 mean_gpp_beyond_40km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_40km mean_income_40km liberal_prefecture if nb_neighbors_40km > 0, shared(prefecture) nohr
stcox is_prefectural_capital mean_gpp_50km_lag_1 mean_gpp_beyond_50km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_50km mean_income_50km liberal_prefecture if nb_neighbors_50km > 0, shared(prefecture) nohr



* Table M.20:

import delimited "...survival.csv", clear
generate logpop = log(population)
replace year = year - 2010
tostring year, gen(year_str)
encode year_str, gen(year_ind)
encode prefecture, gen(prefecture_ind)
drop if year == 1
stset year, id(id) failure(gpp) exit(time 10)

stcox is_prefectural_capital mean_neighbors_lag_1 mean_not_neigh_lag_1 logpop income debt sector_1 sector_2 liveable neighbors_mean_population neighbors_mean_income if nb_neighbors_contiguous > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox is_prefectural_capital mean_gpp_10km_lag_1 mean_gpp_beyond_10km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox is_prefectural_capital mean_gpp_20km_lag_1 mean_gpp_beyond_20km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox is_prefectural_capital mean_gpp_30km_lag_1 mean_gpp_beyond_30km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_30km mean_income_30km if nb_neighbors_30km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox is_prefectural_capital mean_gpp_40km_lag_1 mean_gpp_beyond_40km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_40km mean_income_40km if nb_neighbors_40km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox is_prefectural_capital mean_gpp_50km_lag_1 mean_gpp_beyond_50km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_50km mean_income_50km if nb_neighbors_50km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest



* Table N.21:

import delimited "...logit.csv", clear
generate logpop_2020 = log(population_2020)
encode prefecture, generate(prefecture_ind)

logistic publish_2020 is_prefectural_capital mean_neighbors_publish_2020 logpop_2020 income_2020 debt_2020 liberal_2020 sector_1_2020 sector_2_2020 liveable_2020 if gpp_2020 == 1, vce(cluster prefecture) coef
logistic publish_2020 is_prefectural_capital mean_publish_10km_2020 logpop_2020 income_2020 debt_2020 liberal_2020 sector_1_2020 sector_2_2020 liveable_2020 if gpp_2020 == 1, vce(cluster prefecture) coef
logistic publish_2020 is_prefectural_capital mean_publish_20km_2020 logpop_2020 income_2020 debt_2020 liberal_2020 sector_1_2020 sector_2_2020 liveable_2020 if gpp_2020 == 1, vce(cluster prefecture) coef



* Table O.22:

import delimited "...survival.csv", clear
generate logpop = log(population)
replace year = year - 2010
tostring year, gen(year_str)
encode year_str, gen(year_ind)
encode prefecture, gen(prefecture_ind)
drop if year == 1
stset year, id(id) failure(gpp) exit(time 10)

stcox mean_publish_10km_lag_1 mean_gpp_10km_lag_1 mean_gpp_beyond_10km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox mean_publish_20km_lag_1 mean_gpp_20km_lag_1 mean_gpp_beyond_20km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km  if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox count_publish_10km_lag_1 count_gpp_10km_lag_1 count_gpp_beyond_10km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_10km mean_income_10km  if nb_neighbors_10km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest
stcox count_publish_20km_lag_1 count_gpp_20km_lag_1 count_gpp_beyond_20km_lag_1 logpop income debt sector_1 sector_2 liveable mean_log_pop_20km mean_income_20km  if nb_neighbors_20km > 0, strata(prefecture_ind) vce(cluster prefecture) nohr
estat phtest

