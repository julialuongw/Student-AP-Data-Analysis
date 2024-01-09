CREATE TABLE Math (
    CDSCode BIGINT, # We choose to not make CDSCode a foreign key as there are codes in Ela which are not in Vosd
    Total_Tested_At_Entity_Level INT,
    Total_Tested_with_Scores INT,
    Grade ENUM('3', '8', '11'),
    CAASPP_Reported_Enrollment INT,
    Students_Tested INT,
    Mean_Scale_Score FLOAT,
    Percent_Standard_Exceeded FLOAT,
    Percentage_Standard_Met FLOAT,
    Percentage_Standard_Met_and_Above FLOAT,
    Percentage_Standard_Nearly_Met FLOAT,
    Percentage_Standard_Not_Met FLOAT,
    Students_with_Scores INT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Math.csv'
INTO TABLE Math
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(CDSCode, @Total_Tested_At_Entity_Level, @Total_Tested_with_Scores, Grade, @CAASPP_Reported_Enrollment, @Students_Tested, @Mean_Scale_Score, @Percent_Standard_Exceeded, @Percentage_Standard_Met, @Percentage_Standard_Met_and_Above, @Percentage_Standard_Nearly_Met, @Percentage_Standard_Not_Met, @Students_with_Scores)
SET # accomodate fields that may be empty
Total_Tested_At_Entity_Level = NULLIF(@Total_Tested_At_Entity_Level, ''),
Total_Tested_with_Scores = NULLIF(@Total_Tested_with_Scores, ''),
CAASPP_Reported_Enrollment = NULLIF(@CAASPP_Reported_Enrollment, ''),
Students_Tested = NULLIF(@Students_Tested, ''),
Mean_Scale_Score = NULLIF(@Mean_Scale_Score, ''),
Percent_Standard_Exceeded = NULLIF(@Percent_Standard_Exceeded, ''),
Percentage_Standard_Met = NULLIF(@Percentage_Standard_Met, ''),
Percentage_Standard_Met_and_Above = NULLIF(@Percentage_Standard_Met_and_Above, ''),
Percentage_Standard_Nearly_Met = NULLIF(@Percentage_Standard_Nearly_Met, ''),
Percentage_Standard_Not_Met = NULLIF(@Percentage_Standard_Not_Met, ''),
Students_with_Scores = NULLIF(@Students_with_Scores, '')
;

SELECT * FROM Math;