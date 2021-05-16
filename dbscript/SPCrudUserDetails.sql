DELIMITER //
/*----------------------------------
Author : Sambhaji S
Created Date : '14-May-2021'
Created For : 'Perform Crud operation'
-----------------------------------*/
create procedure SPCrudUserDetails(in POtp varchar(6), in PFullName varchar(25), in PEmail varchar(25), in POperatioType char(1))
LANGUAGE SQL
 DETERMINISTIC
 SQL SECURITY DEFINER
 COMMENT 'SP commit'
BEGIN	
  declare SignupId  int;  
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
	if POperatioType = "C" then    
	  insert into signupmaster (MobileNumber, CreatedDate) 
 	 select MobileNumber, curdate() from signuptemp where otp = POtp;
      
 	 SET SignupId = LAST_INSERT_ID();
     
     SET SQL_SAFE_UPDATES=0;
 	 delete from signuptemp where otp = POtp; 
       
 	 insert into usermaster (Signup_Id, FullName, Email, CreatedDate)
	 values (SignupId, PFullName, PEmail, curdate());     	
     
	 
    elseif POperatioType = "D" then    	
		SET SQL_SAFE_UPDATES=0;
		delete from signuptemp where otp = POtp;
	end if; 
 COMMIT;      
	
END //

DELIMITER ;