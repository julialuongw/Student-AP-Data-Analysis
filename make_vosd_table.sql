CREATE TABLE Vosd (
    CDSCode BIGINT PRIMARY KEY,
    District TEXT,
    School TEXT,
    Street TEXT,
    StreetAbr TEXT,
    City TEXT,
    ZipCode TEXT,
    State VARCHAR(2),
    Phone TEXT,
    OpenDate DATE,
    Charter BOOL,
    DOCType ENUM('Unified School District', 'Elementary School District', 'Statewide Benefit Charter', 'High School District', 'County Office of Education (COE)','State Board of Education'),
    SOCType ENUM('Alternative Schools of Choice', 'Elementary Schools (Public)', 'Intermediate/Middle Schools (Public)', 'High Schools (Public)', 'K-12 Schools (Public)', 'Junior High Schools (Public)'),
    GSoffered ENUM ('K-12', '9-12', '1-5', '3-6', '4-5', '4-6', '4-8', '7-12', 'K-6', 'K-8', '6-8', '7-8', 'K-1', 'K-3', 'K-5', 'P-5', 'P-8', 'K-4', '3-5', 'K-2', 'P-6', 'P-K', '11-12', '5-8', '5-6', '6-12', '7-9'),
    Latitude FLOAT,
    Longitude FLOAT,
    LastUpdate DATE,
    Enrollment_2016_2017 INT,
    Enrollment_Grades_10_12_2015_2016 INT,
    AP_Number_Tested_2015_2016 INT,
    AP_Score_1_2015_2016 INT,
    AP_Score_2_2015_2016 INT,
    AP_Score_3_2015_2016 INT,
    AP_Score_4_2015_2016 INT,
    AP_Score_5_2015_2016 INT
);

# https://stackoverflow.com/questions/2675323/mysql-load-null-values-from-csv-data
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Vosd.csv'
INTO TABLE Vosd
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' # Windows terminates with \r\n, while Linux uses \n. 
IGNORE 1 ROWS
(CDSCode, District, School, Street, StreetAbr, City, ZipCode, State, Phone, @OpenDate, @Charter, DOCType, SOCType, GSoffered, Latitude, Longitude, @LastUpdate, @Enrollment_2016_2017, @Enrollment_Grades_10_12_2015_2016, @AP_Number_Tested_2015_2016, @AP_Score_1_2015_2016, @AP_Score_2_2015_2016, @AP_Score_3_2015_2016, @AP_Score_4_2015_2016, @AP_Score_5_2015_2016)
SET # accomodate fields that may be empty
OpenDate = IF(@OpenDate = '', NULL, STR_TO_DATE(@OpenDate, "%m/%d/%Y")),
Charter = IF(@Charter = 'Y', TRUE, FALSE),
Enrollment_2016_2017 = NULLIF(@Enrollment_2016_2017, ''),
Enrollment_Grades_10_12_2015_2016 = NULLIF(@Enrollment_Grades_10_12_2015_2016, ''),
AP_Number_Tested_2015_2016 = NULLIF(@AP_Number_Tested_2015_2016, ''),
AP_Score_1_2015_2016 = NULLIF(@AP_Score_1_2015_2016, ''),
AP_Score_2_2015_2016 = NULLIF(@AP_Score_2_2015_2016, ''),
AP_Score_3_2015_2016 = NULLIF(@AP_Score_3_2015_2016, ''),
AP_Score_4_2015_2016 = NULLIF(@AP_Score_4_2015_2016, ''),
AP_Score_5_2015_2016 = NULLIF(@AP_Score_5_2015_2016, '')
;

SELECT * FROM Vosd;