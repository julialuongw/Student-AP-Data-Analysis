CREATE TABLE Vosd_joined AS 
WITH Math_g3 AS (
  SELECT CONCAT(County_Code, District_Code, LPAD(CAST(School_Code AS CHAR), 7, '0')) AS CDSCode,
  Mean_Scale_Score AS MATH_Mean_Scale_Score,
  Students_with_Scores AS MATH_Students_with_Scores
  FROM Math
  WHERE Grade = 3
),
Ela_g3 AS (
  SELECT CONCAT(County_Code, District_Code, LPAD(CAST(School_Code AS CHAR), 7, '0')) AS CDSCode,
  Mean_Scale_Score AS ELA_Mean_Scale_Score,
  Students_with_Scores AS ELA_Students_with_Scores
  FROM Ela
  WHERE Grade = 3
)
# Select all columns but the dupliate CDSCode columns from Math_g3 and Ela_g3
SELECT Vosd.CDSCode, District, School, Street, StreetAbr, City, Zip_Code, State, Phone, OpenDate, Charter, DOCType, SOC, SOCType, GSoffered, Latitude, Longitude, LastUpdate, Total_Enrollment_2016_2017, ELA_Current_Status_2015_2016, ELA_Prior_Status_2015_2016, ELA_Status_Level_2015_2016, Math_Current_Status_2015_2016, Math_Prior_Status_2015_2016, Math_Change_2015_2016, English_Language_Learners_2016_2017, Percent_English_Language_Learners_2016_2017, FRPM_Count_2016_2017, Percent_FRPM_Count_2016_2017, Enrollment_Grades_10_12_2015_2016, AP_Number_Tested_2015_2016, Percent_AP_Number_Tested_2015_2016, AP_Score_1_2015_2016, AP_Score_2_2015_2016, AP_Score_3_2015_2016, AP_Score_4_2015_2016, AP_Score_5_2015_2016, Percent_AP_Score_1_2015_2016, Percent_AP_Score_2_2015_2016, Percent_AP_Score_3_2015_2016, Percent_AP_Score_4_2015_2016, Percent_AP_Score_5_2015_2016, MATH_Mean_Scale_Score, MATH_Students_with_Scores, ELA_Mean_Scale_Score, ELA_Students_with_Scores
FROM Vosd
LEFT JOIN Math_g3
ON Vosd.CDSCode = Math_g3.CDSCode
LEFT JOIN Ela_g3
ON Vosd.CDSCode = Ela_g3.CDSCode;
