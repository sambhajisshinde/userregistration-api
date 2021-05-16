DELIMITER //
/*----------------------------------
Author : Sambhaji S
Created Date : '14-May-2021'
Created For : 'Validate user already exists or not'
-----------------------------------*/
DELIMITER //

CREATE FUNCTION fnUserExists (POtp varchar(6))
RETURNS int DETERMINISTIC
BEGIN
   
   DECLARE count int;
   SET count = 0;
   
   SELECT count(sm.ID) into count FROM SignupMaster sm INNER JOIN SignupTemp st on (sm.MobileNumber = st.MobileNumber)
   Where st.Otp = POtp; 
   
   
   RETURN count;
END; //

DELIMITER ;