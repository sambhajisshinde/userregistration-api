//This is master table maintain the data for user sign up details.
create table SignUpMaster
(
	Id int NOT NULL AUTO_INCREMENT,		
	MobileNumber varchar(10) Not null,
	CreatedDate date,
	UpdatedDate date,
	IsActive char(1) default 1,
	IsDeleted char(1) default 1,
	PRIMARY KEY (Id)
);

//This is master table maintain the data for user details.
create table UserMaster
(
	Id int NOT NULL AUTO_INCREMENT,		
	Signup_Id int not null,
	FullName varchar(25) not null,
	Email varchar(25) not null,
	CreatedDate date,
	UpdatedDate date,
	IsActive char(1) default 1,
	IsDeleted char(1) default 1,
	PRIMARY KEY (Id),
    	FOREIGN KEY (Signup_Id)
        REFERENCES SignUpMaster(Id)
);

//This is temporary table maintain the data for sign up details.
create table SignUpTemp
(
	Id int NOT NULL AUTO_INCREMENT,		
	MobileNumber varchar(10) Not null,
    OTP varchar(6) not null,
	CreatedDate date,
	UpdatedDate date,
	IsActive char(1) default 1,
	IsDeleted char(1) default 1,
	PRIMARY KEY (Id)
);