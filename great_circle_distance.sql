CREATE DEFINER=`root`@`localhost` FUNCTION `great_circle_distance`(lat0 FLOAT, lon0 FLOAT, lat1 FLOAT, lon1 FLOAT) RETURNS float
    DETERMINISTIC
BEGIN
DECLARE distance FLOAT;
	SET distance = CASE WHEN lat0 = lat1 AND lon0 = lon1 THEN 0 # To eliminate any very small float values being returned or null
    ELSE 6371 * acos( 
      cos(radians( lat0 ))
    * cos(radians( lat1 ))
    * cos(radians( lon0 ) - radians( lon1 ))
    + sin(radians( lat0 )) 
    * sin(radians( lat1 ))
  )
  END;
RETURN distance;
END