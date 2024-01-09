# Compute the AP pass rate of high schools that have unobfuscated AP exam score counts, and filter them out into a new table. This new table can be exported as is and be used in the correlation question
CREATE TABLE Ap_schools AS
SELECT *, compute_ap_pass_rate(AP_Score_1_2015_2016, AP_Score_2_2015_2016, AP_Score_3_2015_2016, AP_Score_4_2015_2016, AP_Score_5_2015_2016) AS ap_pass_rate
FROM Vosd
WHERE compute_ap_pass_rate(AP_Score_1_2015_2016, AP_Score_2_2015_2016, AP_Score_3_2015_2016, AP_Score_4_2015_2016, AP_Score_5_2015_2016) IS NOT NULL
;

SELECT * 
FROM Ap_Schools;