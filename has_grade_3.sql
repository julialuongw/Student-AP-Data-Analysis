CREATE DEFINER=`root`@`localhost` FUNCTION `has_grade_3`(grade_range VARCHAR(10)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
    DECLARE has_grade_3 BOOL;
    SET has_grade_3 = grade_range IN ('1-5', 'K-5', 'K-8', 'K-6', 'K-12', 'P-5', '3-6', 'K-3', 'P-6', 'P-8', 'K-4', '3-5' );
    RETURN has_grade_3;
END