CREATE DEFINER=`root`@`localhost` FUNCTION `compute_ap_pass_rate`(
	n1 INT, 
    n2 INT, 
    n3 INT, 
    n4 INT, 
    n5 INT
) RETURNS float
    DETERMINISTIC
BEGIN
DECLARE pass_rate FLOAT;
	IF n1 IS NULL OR n2 IS NULL OR n3 IS NULL OR n4 IS NULL OR n5 IS NULL THEN
			RETURN NULL;
	END IF;
	
    SET pass_rate = (n3 + n4 + n5) / (n1 + n2 + n3 + n4 + n5);
RETURN pass_rate;
END