clear all
cd "C:\Users\marcy\Documents\Dauphine\Mémoire\Stata\Database"
use "data_trade.dta", clear
egen w_id=group(country)

xtset w_id time

gen ln_GDP=ln(gdp+1)
gen ln_auscn=ln(auscn_exp+1)

xtreg servicepib ln_GDP ln_auscn  c.time, fe

gen agri_value=agripib*gdp
gen service_value=servicepib*gdp
gen indu_value=indupib*gdp
gen ln_agri_value=ln(agri_value)
gen ln_service_value=ln(service_value)
gen ln_indu_value=ln(indu_value)

xtreg ln_agri_value ln_auscn  ln_service_value ln_indu_value c.time, fe
xtreg ln_service_value ln_auscn  ln_agri_value  ln_indu_value c.time, fe
xtreg ln_indu_value ln_auscn ln_service_value ln_agri_value c.time, fe

gen ln_expcn=ln(exp_cn)
gen ln_expworld=ln(exp_world)

xtreg ln_expcn ln_auscn ln_expworld ln_service_value ln_indu_value ln_agri_value gdp c.time, fe
xtreg ln_expworld ln_auscn ln_service_value ln_indu_value ln_agri_value gdp c.time, fe
