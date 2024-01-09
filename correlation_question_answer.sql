# This script joins to each school reporting AP scores the 3 closest elementary schools containing grade 3 and belonging to the correct district (determined by a more complex criteria). It then computes the weighted average of the CAASPP ELA & MATH scores of those 3 schools. The output is all 84 AP-reporting schools paired with an ELA-weighted average and MATH-weighted average, ready to be graphed. 
# Dependencies: the functions compute_ap_pass_rate, great_circle_distance, and has_grade_3. the tables Ap_schools, Vosd, Math, Ela. 
WITH Candidate_feeders AS (
	SELECT A.CDSCode AS AP_CDSCode, A.School AS AP_School_Name, ap_pass_rate, E.CDSCode AS C_CDSCode, E.School AS C_School_Name, E.GSoffered AS Grades, ROW_NUMBER() OVER (PARTITION BY A.School ORDER BY great_circle_distance(E.Latitude, E.Longitude, A.Latitude, A.Longitude) ASC) AS dist_rank
	FROM Ap_schools A
		LEFT JOIN ( 
			SELECT * FROM Vosd WHERE has_grade_3(Vosd.GSoffered) # includes K-12 schools
		) AS E
			ON CASE 
				WHEN E.GSoffered = 'K-12' THEN E.CDSCode = A.CDSCode # Only include K-12 schools as a candidate feeder if it is A's school (so just at most 1). The rest of K-12 schools die. Indeed, filtering by K-12 shows 5 schools, matching with the number of K-12 schools that have unobfuscated AP score counts. 
				WHEN A.DOCType = 'High School District' THEN (E.District = A.District) OR FIND_IN_SET(E.District, (SELECT ES_Districts_List FROM Hsd_feeders WHERE HS_District = A.District)) > 0 # For ele schools in High School Districts, only include them if it's in the same district as A's school OR is in one of the neighboring Elementary School Districts
				ELSE (E.District = A.District) # For AP schools that are in Unified School District or Elementary School District or SPECIAL Distrcts, we include this ele school as a feeder if and only if it is in the same district as that of A's school. No K-12 schools are considered because they all but at most 1 die at the first check. 
			END
) 
SELECT AP_School_Name, ap_pass_rate, 
	SUM(Ela.Mean_Scale_Score * Ela.Students_with_Scores) / SUM(Ela.Students_with_Scores) AS Feeders_ELA_Weighted_Mean,
    SUM(Math.Mean_Scale_Score * Math.Students_with_Scores) / SUM(Math.Students_with_Scores) AS Feeders_MATH_Weighted_Mean
FROM Candidate_feeders C
	LEFT JOIN Ela
		ON (C.C_CDSCode = Ela.CDSCode) AND (Ela.Grade = '3')
	LEFT JOIN Math
		ON (C.C_CDSCode = Math.CDSCode) AND (Math.Grade = '3')
WHERE dist_rank <= 3
GROUP BY AP_School_Name, ap_pass_rate
ORDER BY ap_pass_rate DESC
;