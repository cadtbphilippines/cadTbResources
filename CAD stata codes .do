
use "/Users/nichelmarquez/CAD data/CAD_main.dta"
**CAD ANALYSIS**
gen str20 mtb_or_not = ""
replace mtb_or_not = "MTB" if officialrdtresults == "MTB Trace Detected"
replace mtb_or_not = "MTB" if officialrdtresults == "MTB detected, RIF resistance not detected (T)"
replace mtb_or_not = "MTB" if officialrdtresults == "MTB detected, RIF resistance indeterminate (TI)"
replace mtb_or_not = "MTB" if officialrdtresults == "MTB detected, RIF resistance detected (RR)"
replace mtb_or_not = "Not MTB" if officialrdtresults == " MTB Not Detected"
tab mtb_or_not
gen mtbcode = .
replace mtbcode=1 if mtb_or_not == "MTB"
replace mtbcode=0 if mtb_or_not == "Not MTB"
gen str20 age_group = ""
replace age_group = "23 and younger" if age <= 23
replace age_group = "24 to 33" if age  >= 24 & age <= 33
replace age_group = "34 to 49" if age  >= 34 & age <= 49
replace age_group = "50 and older" if age  >= 50 

gen age_group_code = .
replace age_group_code = 0 if age <= 23
replace age_group_code = 1 if age  >= 24 & age <= 33
replace age_group_code = 2 if age  >= 34 & age <= 49
replace age_group_code = 3 if age  >= 50 

gen previoustbtx_code = .
replace previoustbtx_code=1 if previoustbtreatment == "Yes"
replace previoustbtx_code=0 if previoustbtreatment == "No"

gen realprebyssx_code = .
replace realprebyssx_code=1 if realpresumptivebyssx == "Yes"
replace realprebyssx_code=0 if realpresumptivebyssx == "No"

gen type_code = .
replace type_code=0 if type == "ACF WP"
replace type_code=1 if type == "ACF community"
replace type_code=2 if type == "ICF"

gen aicode = .
replace aicode=1 if aiscore >= 0.5
replace aicode=0 if aiscore < 0.5
tab aicode
tab aiimpression

gen sexcode = .
replace sexcode=1 if sex == "Female"
replace sexcode=0 if sex == "Male"
tab sexcode

*Descriptive/Frequency analysis*
*Comparison between MTB and Not MTB by factor*
tab sex mtb_or_not, row col all
summarize age
sort mtb_or_not
by mtb_or_not: summarize age
ttest age, by(mtb_or_not)
tab age_group mtb_or_not, row col  all
tab previoustbtreatment mtb_or_not, row col all
tab realpresumptivebyssx mtb_or_not, row col all
tab type mtb_or_not, row col all
tab year mtb_or_not, row col all
tab aiimpression mtb_or_not, row col all

***Compare Sensitivity and Specificity rates between sex groups ****
**Sensitivity under MTB groups**
**Specificity under Not MTB group**
tab sex
sort mtb_or_not
by mtb_or_not: tab sex aiimpression, all row

***Compare PPV and NPV rates between sex groups ****
**PPV under TB presumptive groups**
**NPV under Non-suggestive group**
tab sex
sort aiimpression
by aiimpression: tab sex mtb_or_not, all row 

***Compare Sensitivity and Specificity rates among age groups ****
**Sensitivity under MTB groups**
**Specificity under Not MTB group**
tab age_group
sort mtb_or_not
by mtb_or_not: tab age_group aiimpression, all col row

***Compare PPV and NPV rates among age groups ****
**PPV under TB presumptive groups**
**NPV under Non-suggestive group**
tab age_group
sort aiimpression
by aiimpression: tab age_group mtb_or_not, all row

***Compare Sensitivity and Specificity rates among TB hx groups ****
**Sensitivity under MTB groups**
**Specificity under Not MTB group**
tab previoustbtreatment
sort mtb_or_not
by mtb_or_not: tab previoustbtreatment aiimpression, all row

***Compare PPV and NPV rates among TB hx groups ****
**PPV under TB presumptive groups**
**NPV under Non-suggestive group**
tab previoustbtreatment
sort aiimpression
by aiimpression: tab previoustbtreatment mtb_or_not, all row 

***Compare Sensitivity and Specificity rates among TB symptoms groups ****
**Sensitivity under MTB groups**
**Specificity under Not MTB group**
tab realpresumptivebyssx
sort mtb_or_not
by mtb_or_not: tab realpresumptivebyssx aiimpression, all row


***Compare PPV and NPV rates among TB symptoms groups ****
**PPV under TB presumptive groups**
**NPV under Non-suggestive group**
tab realpresumptivebyssx
sort aiimpression
by aiimpression: tab realpresumptivebyssx mtb_or_not, all row 

***Compare Sensitivity and Specificity rates among Population setting *type* groups ****
**Sensitivity under MTB groups**
**Specificity under Not MTB group**
tab type
sort mtb_or_not
by mtb_or_not: tab type aiimpression, all row

***Compare PPV and NPV rates among Population setting *type* groups ****
**PPV under TB presumptive groups**
**NPV under Non-suggestive group**
tab type
sort aiimpression
by aiimpression: tab type mtb_or_not, all row 

***Compare Sensitivity and Specificity rates among Year groups ****
**Sensitivity under MTB groups**
**Specificity under Not MTB group**
tab year
sort mtb_or_not
by mtb_or_not: tab year aiimpression, all row

***Compare PPV and NPV rates among Year groups ****
**PPV under TB presumptive groups**
**NPV under Non-suggestive group**
tab year
sort aiimpression
by aiimpression: tab year mtb_or_not, all row 

*AUROC and PRAUC-overall*
roctab mtbcode aiscore, detail graph
prcurve mtbcode aiscore
tab sex
roctab mtbcode aiscore if sex == "Male", detail graph
prcurve mtbcode aiscore if sex == "Male"
roctab mtbcode aiscore if sex == "Female", detail graph
prcurve mtbcode aiscore if sex == "Female"
tab age_group
roctab mtbcode aiscore if age_group == "23 and younger", detail graph
prcurve mtbcode aiscore if age_group == "23 and younger"
roctab mtbcode aiscore if age_group == "24 to 33", detail graph
prcurve mtbcode aiscore if age_group == "24 to 33"
roctab mtbcode aiscore if age_group == "34 to 49", detail graph
prcurve mtbcode aiscore if age_group == "34 to 49"
roctab mtbcode aiscore if age_group == "50 and older", detail graph
prcurve mtbcode aiscore if age_group == "50 and older"
tab previoustbtreatment
roctab mtbcode aiscore if previoustbtreatment == "Yes", detail graph
prcurve mtbcode aiscore if previoustbtreatment == "Yes"
roctab mtbcode aiscore if previoustbtreatment == "No", detail graph
prcurve mtbcode aiscore if previoustbtreatment == "No"
tab realpresumptivebyssx
roctab mtbcode aiscore if realpresumptivebyssx == "Yes", detail graph
prcurve mtbcode aiscore if realpresumptivebyssx == "Yes"
roctab mtbcode aiscore if realpresumptivebyssx == "No", detail graph
prcurve mtbcode aiscore if realpresumptivebyssx == "No"
tab type
roctab mtbcode aiscore if type == "ICF", detail graph
prcurve mtbcode aiscore if type == "ICF"
roctab mtbcode aiscore if type == "ACF community", detail graph
prcurve mtbcode aiscore if type == "ACF community"
roctab mtbcode aiscore if type == "ACF WP", detail graph
prcurve mtbcode aiscore if type == "ACF WP"
tab year
roctab mtbcode aiscore if year == 2021, detail graph
prcurve mtbcode aiscore if year == 2021
roctab mtbcode aiscore if year == 2022, detail graph
prcurve mtbcode aiscore if year == 2022
roctab mtbcode aiscore if year == 2023, detail graph
prcurve mtbcode aiscore if year == 2023
roctab mtbcode aiscore if year == 2024, detail graph
prcurve mtbcode aiscore if year == 2024

*Compare AUROC between risk groups subcategories *
roccomp mtbcode  aiscore, by(sex) graph summary title("ROC, by Sex")
roccomp mtbcode  aiscore, by(age_group) graph summary title("ROC, by Age")
roccomp mtbcode  aiscore, by(previoustbtreatment) graph summary title("ROC, by TB History")
roccomp mtbcode  aiscore, by(realpresumptivebyssx) graph summary title("ROC, by TB Symptoms")
roccomp mtbcode  aiscore, by(type) graph summary title("ROC, by Population Setting")
roccomp mtbcode  aiscore, by(year) graph summary title("ROC, by Year")

*AUROC*
roctab mtbcode aiscore, detail graph title("A. ROC Curve", size (medium))

*AUPRC* 
prcurve mtbcode aiscore, title("B. Precision-Recall Curve", size (medium))

*F-score*
prcurve  mtbcode aiscore, fscore
prtab  mtbcode aiscore, fscore

*Determination of 95% CI for performance metrics*
diagtest aicode mtbcode if sexcode == 1
diagtest aicode mtbcode if sexcode == 0
diagtest aicode mtbcode if age_group_code == 0
diagtest aicode mtbcode if age_group_code == 1
diagtest aicode mtbcode if age_group_code == 2
diagtest aicode mtbcode if age_group_code == 3
diagtest aicode mtbcode if previoustbtx_code == 0
diagtest aicode mtbcode if previoustbtx_code == 1
diagtest aicode mtbcode if realprebyssx_code == 0
diagtest aicode mtbcode if realprebyssx_code == 1
diagtest aicode mtbcode if type_code == 0
diagtest aicode mtbcode if type_code == 1
diagtest aicode mtbcode if type_code == 2
diagtest aicode mtbcode if year == 2021
diagtest aicode mtbcode if year == 2022
diagtest aicode mtbcode if year == 2023
diagtest aicode mtbcode if year == 2024
*end*



use "/Users/nichelmarquez/CAD data/metrics_for_graphs.dta"
*Graphs*
*sensitivity and xpert saved*
twoway line pseudosensitivity xperttestssaved, xlabel(#10) ylabel(#10) title("C. Pseudo-sensitivity vs Xpert Tests Saved", size (medium))

*PPV and xpert saved*
twoway line ppv xperttestssaved, xlabel(#10) ylabel(#10) title("D. PPV vs Xpert Tests Saved", size (medium))

*NNT and threshold scores*
twoway line nnt thresholdscores, xlabel(#10) ylabel(#10) title("E. NNT vs Threshold Scores", size (medium))

*Computation of F-score*
di 2*[(Precision*Recall)/(Precision + Recall)]
*end*



*For table 3 values*
use "/Users/nichelmarquez/CAD data/diff_metrics_thresholds_overall.dta"
use "/Users/nichelmarquez/CAD data/diff_metrics_thresholds_icf.dta"
use "/Users/nichelmarquez/CAD data/diff_metrics_thresholds_acfcom.dta"
use "/Users/nichelmarquez/CAD data/diff_metrics_thresholds_acfwp.dta"
*end*

 
use "/Users/nichelmarquez/CAD data/CAD_main.dta"
*coding for logistics*
*Associations (OR) Between Individual Characteristics and Sensitivity*
gen str20 mtb_or_not = ""
replace mtb_or_not = "MTB" if officialrdtresults == "MTB Trace Detected"
replace mtb_or_not = "MTB" if officialrdtresults == "MTB detected, RIF resistance not detected (T)"
replace mtb_or_not = "MTB" if officialrdtresults == "MTB detected, RIF resistance indeterminate (TI)"
replace mtb_or_not = "MTB" if officialrdtresults == "MTB detected, RIF resistance detected (RR)"
replace mtb_or_not = "Not MTB" if officialrdtresults == " MTB Not Detected"
tab mtb_or_not
drop if mtb_or_not == "Not MTB"
gen mtbcode = .
replace mtbcode=1 if mtb_or_not == "MTB"
replace mtbcode=0 if mtb_or_not == "Not MTB"
gen age_ref_23 = .
replace age_ref_23 = 0 if age <= 23
replace age_ref_23 = 1 if age  >= 24 & age <= 33
replace age_ref_23 = 2 if age  >= 34 & age <= 49
replace age_ref_23 = 3 if age  >= 50 
gen sex_ref_fem = .
replace sex_ref_fem=0 if sex == "Female"
replace sex_ref_fem=1 if sex == "Male"
tab sex_ref_fem
gen prevtx_ref_no = .
replace prevtx_ref_no=1 if previoustbtreatment == "Yes"
replace prevtx_ref_no=0 if previoustbtreatment == "No"
gen realssx_ref_no = .
replace realssx_ref_no=1 if realpresumptivebyssx == "Yes"
replace realssx_ref_no=0 if realpresumptivebyssx == "No"
gen aicodesen = .
replace aicodesen=1 if aiscore >= 0.5
replace aicodesen=0 if aiscore < 0.5
tab aicodesen
tab aiimpression
gen type_ref_icf = .
replace type_ref_icf=0 if type == "ICF"
replace type_ref_icf=1 if type == "ACF community"
replace type_ref_icf=2 if type == "ACF WP"
logistic aicodesen sex_ref_fem
xi: logistic aicodesen i.age_ref_23
logistic aicodesen prevtx_ref_no
logistic aicodesen realssx_ref_no
xi:logistic aicodesen i.type_ref_icf
xi: logistic aicodesen sex_ref_fem i.age_ref_23 prevtx_ref_no realssx_ref_no i.type_ref_icf


use "/Users/nichelmarquez/CAD data/CAD_main.dta"
*Associations (OR) Between Individual Characteristics and Specificity*
gen str20 mtb_or_not = ""
replace mtb_or_not = "MTB" if officialrdtresults == "MTB Trace Detected"
replace mtb_or_not = "MTB" if officialrdtresults == "MTB detected, RIF resistance not detected (T)"
replace mtb_or_not = "MTB" if officialrdtresults == "MTB detected, RIF resistance indeterminate (TI)"
replace mtb_or_not = "MTB" if officialrdtresults == "MTB detected, RIF resistance detected (RR)"
replace mtb_or_not = "Not MTB" if officialrdtresults == " MTB Not Detected"
tab mtb_or_not
drop if mtb_or_not == "MTB"
gen mtbcode = .
replace mtbcode=1 if mtb_or_not == "MTB"
replace mtbcode=0 if mtb_or_not == "Not MTB"
gen age_ref_50 = .
replace age_ref_50 = 0 if age >= 50 
replace age_ref_50 = 1 if age >= 34 & age <= 49
replace age_ref_50 = 2 if age >= 24 & age <= 33
replace age_ref_50 = 3 if age <= 23
gen sex_ref_mal = .
replace sex_ref_mal=0 if sex == "Male"
replace sex_ref_mal=1 if sex == "Female"
tab sex_ref_mal
gen prevtx_ref_yes = .
replace prevtx_ref_yes=1 if previoustbtreatment == "Yes"
replace prevtx_ref_yes=0 if previoustbtreatment == "No"
gen realssx_ref_no = .
replace realssx_ref_no=1 if realpresumptivebyssx == "Yes"
replace realssx_ref_no=0 if realpresumptivebyssx == "No"
gen aicodespec = .
replace aicodespec=1 if aiscore < 0.5
replace aicodespec=0 if aiscore >= 0.5
tab aicodespec
tab aiimpression
gen type_ref_wp = .
replace type_ref_wp=0 if type == "ACF WP"
replace type_ref_wp=1 if type == "ACF community"
replace type_ref_wp=2 if type == "ICF"
logistic aicodesen sex_ref_mal
xi: logistic aicodespec i.age_ref_50
logistic aicodespec prevtx_ref_yes
logistic aicodespec realssx_ref_no
xi:logistic aicodespec i.type_ref_wp
xi: logistic aicodespec sex_ref_mal i.age_ref_50 prevtx_ref_yes realssx_ref_no i.type_ref_wp
*end*







