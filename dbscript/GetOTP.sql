DELIMITER //
/*----------------------------------
Author : Sambhaji S
Created Date : '14-May-2021'
Created For : 'Get OTP Id from db'
-----------------------------------*/
create procedure SPGetOTP(in PNumber varchar(10), out POtp varchar(6))
LANGUAGE SQL
 DETERMINISTIC
 SQL SECURITY DEFINER
 COMMENT 'SP commit'
BEGIN	
 
  DECLARE exit handler for sqlexception
   BEGIN
     -- ERROR
   ROLLBACK;
 END;
   
 DECLARE exit handler for sqlwarning
  BEGIN
     -- WARNING
  ROLLBACK;
 END;
 

 START TRANSACTION;
    insert into SignUpTemp (MobileNumber, OTP, CreatedDate) values (PNumber, LPAD(FLOOR(RAND() * 999999.99), 6, '0'), CURDATE());        
 COMMIT;      
 SELECT otp into POtp FROM SignUpTemp where MobileNumber = PNumber order by id desc limit 1;
	
END //

DELIMITER ;