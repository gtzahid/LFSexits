
*============================================================*
//This file merges all monthly LFS data into one dataset, runs  multinomial logistic regression, and saves predicted probabilities data to be exported to R for visualization
*============================================================*


//Merge LFS monthly data into annual data 
clear all
set more off

* Use forward slashes + trailing slash
// local folder "" ** Specify local folder path: insert your data location between quotation marks

* File stems and month codes (paired by position)
local files  "pub0124 pub0224 pub0324 pub0424 pub0524 pub0624 pub0724 pub0824 pub0924 pub1024 pub1124 pub1224"
local months "01 02 03 04 05 06 07 08 09 10 11 12"

* Collect the list of temp files we actually save (only for files that exist)
local templist
local i = 1

foreach f of local files {
    local m : word `i' of `months'
    local full "`folder'`f'.csv"   // no extra slash here

    capture confirm file "`full'"
    if _rc {
        di as error "Missing: `full' (skipping)"
    }
    else {
        di as txt "Importing: `full'"
        import delimited "`full'", clear varnames(1)

        gen str2 month = "`m'"
        gen byte  month_num = real("`m'")

        local tmp "`folder'temp_`f'.dta"
        save "`tmp'", replace
        local templist "`templist' `tmp'"
    }

    local i = `i' + 1
}

if "`templist'" == "" {
    di as error "No input files were found. Check the folder path and file names."
    exit 601
}

* Append all temps we actually created
local n = wordcount("`templist'")
use `"`=word("`templist'",1)'"', clear
forvalues j = 2/`n' {
    local t : word `j' of `templist'
    append using `"`t'"'
}

save "`folder'lfs_2024pooled.dta", replace

* (Optional) clean up temps
foreach t of local templist {
    capture erase `"`t'"'
}

use "`folder'lfs_2024pooled.dta", clear

//------------------------------------------------------------------------------------
//Recode variables of interest

//Family type (married & kids)
gen famtype_simple = .
replace famtype_simple = 1 if inlist(famtype, 1)                    // Married/common-law, no kids
replace famtype_simple = 2 if inlist(famtype, 2,3,4)                // Married/common-law, with kids
replace famtype_simple = 3 if inlist(famtype, 5)                    // Single, no kids
replace famtype_simple = 4 if inlist(famtype, 6,7,8)                // Single, with kids
label define famtype_s 1 "M/CL no kids" 2 "M/CL with kids" 3 "Single no kids" 4 "Single with kids"
label values famtype_simple famtype_s

//Age
gen age3 = .
replace age3 = 1 if inlist(age_12, 1, 2)                   // <25 years (15–24)
replace age3 = 2 if inlist(age_12, 3, 4, 5, 6, 7, 8)       // 25–54 years
replace age3 = 3 if inlist(age_12, 9, 10, 11, 12)          // 55+ years

label define age3_lbl 1 "<25 years" 2 "25–54 years" 3 "55+ years"
label values age3 age3_lbl
label var age3 "Age group (3 categories)"

//Immigrants
gen imm=.
replace imm=0 if immig==3
replace imm=1 if inlist(immig, 1, 2)

//Create composite variable: gender × immigrant
gen byte genderimm = .
replace genderimm = 1 if gender == 1 & imm == 0   // Male non-immigrant
replace genderimm = 2 if gender == 2 & imm == 0   // Female non-immigrant
replace genderimm = 3 if gender == 1 & imm == 1   // Male immigrant
replace genderimm = 4 if gender == 2 & imm == 1   // Female immigrant

label define genderimm_lbl ///
1 "Male non-immigrant" ///
2 "Female non-immigrant" ///
3 "Male immigrant" ///
4 "Female immigrant"
label values genderimm genderimm_lbl
label var genderimm "Gender × Immigrant (4 categories)"


//Education
gen BA=.
replace BA = 0 if inrange(educ, 0, 2)
replace BA = 1 if inrange(educ, 3, 6)

//Multinomial logistic regression for reasons for labour market exit
mlogit whylefto i.gender##i.famtype_simple##i.immig i.age3 i.BA i.prov [pweight=finalwt], difficult rrr

// Model
mlogit whylefto i.genderimm##i.famtype_simple i.age3 i.BA i.prov [pweight=finalwt], rrr

//Predicted probabilities for each outcome, by genderimm × family type
margins genderimm#famtype_simple, predict(outcome(2))

// Save predicted probabilities for export to R
margins genderimm#famtype_simple, predict(outcome(2)) saving(pp_out2, replace)

// Predicted probabilities for all whylefto outcomes (0–5)
foreach o of numlist 0/5 {
    di "Now computing predicted probabilities for outcome = `o'"
    quietly margins genderimm#famtype_simple, predict(outcome(`o')) saving(pp_out`o', replace)
}

// Combine all predicted probability files into one dataset
use pp_out0, clear
gen outcome = 0
forvalues o = 1/5 {
    append using pp_out`o'
    replace outcome = `o' if missing(outcome)
}
save pp_all, replace
















