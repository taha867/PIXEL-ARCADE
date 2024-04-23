
use project12


CREATE TABLE SignUp 
(
    UserID INT,
    Name VARCHAR(50) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Contactno INT NOT NULL,
    Email VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(50) NOT NULL,
    SecurityQ VARCHAR(50) NOT NULL
    primary key(userID)
)
 

CREATE TABLE Menu
(
    ItemID INT PRIMARY KEY,
    Itemname VARCHAR(50) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Price INT NOT NULL,
    Description VARCHAR(200),
    TopSellingitem INT DEFAULT 0
)
 
CREATE TABLE Login 
(
    UserID INT ,
    Email VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(50) NOT NULL
    primary key(UserID),
    foreign key (UserID) references SignUp(UserID)
)
 
CREATE TABLE Profile 
(
    UserID INT ,
    Name VARCHAR(50) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Contactno VARCHAR(20) NOT NULL,
    Timeremaining DECIMAL (10,2),
    Totalhoursplayed INT NOT NULL,
    Pixel_stuff INT
    PRIMARY KEY (userID),
    foreign key (userID) references SignUp(userID)
)
 
CREATE TABLE MenuPC
(
    ItemID INT,
    Itemname VARCHAR(50) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Price INT NOT NULL,
    Description VARCHAR(200),
    TopSellingitem INT DEFAULT 0
    Foreign key(ItemID) references Menu(ItemID)
)
 
CREATE TABLE MenuPS5
(
    ItemID INT,
    Itemname VARCHAR(50) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Price INT NOT NULL,
    Description VARCHAR(200),
    TopSellingitem INT DEFAULT 0
    Foreign key(ItemID) references Menu(ItemID)
)

 
CREATE TABLE MenuPCA
(
    ItemID INT,
    Itemname VARCHAR(50) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Price INT NOT NULL,
    Description VARCHAR(200),
    TopSellingitem INT DEFAULT 0
    Foreign key(ItemID) references Menu(ItemID)
)
 
CREATE TABLE MenuPS5A
(
    ItemID INT,
    Itemname VARCHAR(50) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Price INT NOT NULL,
    Description VARCHAR(200),
    TopSellingitem INT DEFAULT 0
    Foreign key(ItemID) references Menu(ItemID)
)
 
CREATE TABLE Booking
(
    BookingID INT PRIMARY KEY,
    UserID INT NOT NULL,
    itemID INT NOT NULL,
    Quantity INT NOT NULL,
    Bookingtime DATETIME NOT NULL,
    Totalamount INT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES SignUp(userID),
    FOREIGN KEY (ItemID) REFERENCES Menu(itemID)
)
 
CREATE TABLE Cart 
(
    UserID INT PRIMARY KEY,
    ItemID INT NOT NULL,
    Quantity INT NOT NULL,
    Bookingtime DATETIME NOT NULL,
    Totalamount INT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES SignUp(UserID),
    FOREIGN KEY (ItemID) REFERENCES Menu(ItemID)
)
 
CREATE TABLE Premiumcustomers 
(
    UserID INT PRIMARY KEY,
    Username varchar(20),
    Ispremium int DEFAULT 0,
    FOREIGN KEY (UserID) REFERENCES SignUp(UserID)
)
 
CREATE TABLE Feedback 
(
    UserID INT NOT NULL,
    Feedbacktext VARCHAR(200) NOT NULL,
    Feedbackdate DATETIME NOT NULL,
    FOREIGN KEY (UserID) REFERENCES SignUp(UserID)
)
 
CREATE TABLE OrderHistory 
(
    userID int NOT NULL,
    itemID int NOT NULL,
    quantity int NOT NULL,
    deliveryType varchar(20) NOT NULL,
    deliveryTime datetime NOT NULL,
    totalAmount int NOT NULL,
    FOREIGN KEY (UserID) REFERENCES SignUp(UserID),
    FOREIGN KEY (ItemID) REFERENCES Menu(ItemID)
)
 
CREATE TABLE About 
(
    Pixel_ID int,
    Pixel_locator varchar(100) NOT NULL,
    Email varchar(50) NOT NULL,
    Contactno varchar(20) NOT NULL
    PRIMARY KEY (Pixel_ID)
)
 
CREATE TABLE Coupons 
(
    CouponID int,
    Couponcode VARCHAR(20) UNIQUE,
    Discountpercentage DECIMAL(5,2),
    Expirationdate DATE,
    Minimumorderamount int,
    PRIMARY KEY (CouponID)
)








select * from SignUp
select * from [Profile]
select * from [Login]
select * from Feedback


delete from SignUp where Email = 'asa@gmail.com'
delete from Login where Email = 'asa@gmail.com'



--PROCEDURES
--1
drop procedure RegisterUser

Create PROCEDURE 
RegisterUser 
	@Name VARCHAR(50),
	@City varchar(50),
	@Contactno varchar(11),
	@Address varchar(50),
	@Email varchar(50),
    @Password varchar(10),
	@SecurityQ varchar(50)
AS
BEGIN
    	SET NOCOUNT ON;
		declare @UserID INT
		select @UserID = coalesce((select max(UserID) + 1 from SignUp), 1)

   	 -- Check if user already exists
    IF EXISTS (SELECT 1 FROM [SignUp] WHERE Email=@Email)
   	 BEGIN
        RAISERROR('User already exists.', 16, 1)
        RETURN
   	 END

   	 -- Insert new user into Users table
   	 INSERT INTO SignUp(UserID,Name,City,Contactno,Address,Email,Password,SecurityQ)
   	 VALUES (@userID,@Name,@City,@Contactno,@Address,@Email,@Password,@SecurityQ)

	 INSERT INTO [Profile](UserID,Name,City,Contactno,Address,Timeremaining,Totalhoursplayed,Pixel_stuff)
   	 VALUES (@userID,@Name,@City,@Contactno,@Address,'0','0','0')

	 INSERT INTO Login(UserID,Email,Password)
   	 VALUES (@userID,@Email,@Password)

 END



--This will be used to allow the user to register himself/herself. It checks whether the user with same username already exists or not and perform actions accordingly.
--2

drop procedure LoginUser

CREATE PROCEDURE LoginUser
    	@Email VARCHAR(50),
    	@Password nvarchar(50)
AS
BEGIN
    	SET NOCOUNT ON;

    	-- Check if user exists and password is correct
    	IF EXISTS (SELECT 1 FROM Login WHERE Email = @Email AND Password = @Password)
    		BEGIN
        	print('Successful')
    		END
    		ELSE
    		BEGIN
       	 RAISERROR('Invalid username or password.', 16, 1)
       	 RETURN
    		END
END
--This will be used to allow the registered user to log in successfully if correct credentials are entered. Otherwise, error message will be displayed
--3
CREATE PROCEDURE ForgotPassword
    	@UserID INT,
    	@SecurityQ varchar(13),
	    @Password varchar(10)
AS
BEGIN
   	 SET NOCOUNT ON;

    -- Check if user exists and email is correct
    IF EXISTS (SELECT 1 FROM SignUp WHERE UserID = @UserID AND SecurityQ = @SecurityQ)
    BEGIN
        -- Generate a new password and update the user's record
        DECLARE @NewPassword nvarchar(50);
        SET @NewPassword = @Password;
        UPDATE SignUp SET Password = @NewPassword WHERE UserID = @UserID AND SecurityQ = @SecurityQ;
    END
    ELSE
    BEGIN
        RAISERROR('Invalid username or email.', 16, 1)
        RETURN
    END
END
--This will allow the user to change his/her password upon entering valid username and email.
--VIEWS
--1   x
CREATE VIEW 
Booking_by_user_view
AS
SELECT Booking.Bookingid, Booking.Bookingdate, Booking.Totalamount
FROM Booking
WHERE Booking.UserID = @UserID

--This view will be use to retrieve order detail of particular user only


--2  x
 CREATE VIEW 
 user_feedback_view 
 AS
 select Feedback.UserID,Feedback.Feedbacktext from Feedback
 JOIN  SignUp ON Feedback.UserID = SignUp.UserID;
 SELECT * from user_feedback_view
--This view will be used to show feedback of particular user


--3
CREATE VIEW v_all_Bookings AS
SELECT BookingID, UserID, Bookingtime, ItemID, Quantity, Totalamount
FROM Booking;


select * from Booking
--TRIGGERS
--1
CREATE TRIGGER increment_feedback_counter
ON Feedback
AFTER INSERT
AS
BEGIN
DECLARE @UserID
  UPDATE Feedback
  SET Numberoffeedbacks = Numberoffeedbacks + 1
  WHERE UserID = NEW.UserID;
END;


--2
CREATE TRIGGER verify_coupon_code
ON Coupons
BEFORE INSERT
AS
BEGIN
  DECLARE @coupon_count INT;
  SELECT @coupon_count = COUNT(*) FROM Coupons WHERE Couponcode = inserted.Couponcode AND Expirationdate >= GETDATE();
  IF @coupon_count = 0
  BEGIN
    RAISERROR('Invalid coupon code', 16, 1);
    ROLLBACK;
    RETURN;
  END
END;
--3
CREATE TRIGGER prevent_late_bookings
ON Booking
AFTER INSERT, UPDATE
AS
BEGIN
  DECLARE @booking_time TIME;
  SELECT @booking_time = Bookingtime FROM inserted;
  IF DATEPART(HOUR, @booking_time) >= 2
  BEGIN
    RAISERROR('Booking time cannot be after 2am', 16, 1);
    ROLLBACK;
    RETURN;
  END
END;




---------------------------------------------------------------------------------------------------------------------------






create table PA

Alter PROCEDURE RegisterUser2 
    @Name varchar(50),
	@Address varchar(100),
	@City varchar(50),
	@Contactno varchar(50),
	@Email varchar(50),
	@Password varchar(50),
    @SecurityQ varchar(50)    
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if user already exists
    IF EXISTS (SELECT 1 FROM SignUp  WHERE Email = @Email And Name=@Name)
    BEGIN
        RAISERROR('User already exists.', 16, 1)
        RETURN
    END

    -- Insert new user into Users table
    INSERT INTO SignUp (Name,Address,City,Contactno,Email,Password,SecurityQ)
    VALUES (@Name,@Address,@City,@Contactno,@Email,@Password,@SecurityQ)
	INSERT INTO PP (Name,PPstuff)
    VALUES (@Name,0)
END

select * From SignUp
select * from CartB



CREATE TABLE Games
(
    ItemID INT IDENTITY(1,1),
    Itemname VARCHAR(50) NOT NULL,
    Price INT NOT NULL,
    Description VARCHAR(200),
	imageurl varchar(50)
	Primary key(ItemID)
)
go

insert into Games (Itemname, Price, Description, imageurl)
values ('FIFA', 2, 'Football game', 'fifa23 cover.jpg');

insert into Games (Itemname, Price, Description, imageurl)
values ('COD', 2, 'FPS game', 'cod cover.jpeg');

insert into Games (Itemname, Price, Description, imageurl)
values ('TEKKEN', 2, 'Action game', 'Tekken cover.jpeg');

select * from CartB

drop table Cart
CREATE TABLE Cart
(
    ItemID INT IDENTITY(1,1),
    Itemname VARCHAR(50) NOT NULL,
    Price INT NOT NULL,
    Quantities INT,
	imageurl varchar(50)
	Primary key(ItemID)
)
go

CREATE TABLE CartB
(
    ItemID INT IDENTITY(1,1),
    Itemname VARCHAR(50) NOT NULL,
    Price INT NOT NULL,
    Houres INT,
	imageurl varchar(50),
	Primary key(ItemID),
	check (Houres <= 12)
)
go

drop table CartB

select * from cartB

CREATE TABLE Gamespc
(
    ItemID INT IDENTITY(1,1),
    Itemname VARCHAR(50) NOT NULL,
    Price INT NOT NULL,
    Description VARCHAR(200),
	imageurl varchar(50)
	Primary key(ItemID)
)
go

insert into Gamespc (Itemname, Price, Description, imageurl)
values ('CSGO', 2, 'FPS game', 'CSGO PC.png'), 
('Forza', 2, 'Racing game', 'Forza PC.jpeg'),
('WWE', 2, 'Action game', 'WWE PC.jpeg');

CREATE TABLE PS5Acc
(
    ItemID INT IDENTITY(1,1),
    Itemname VARCHAR(50) NOT NULL,
    Price INT NOT NULL,
    Description VARCHAR(200),
	imageurl varchar(50)
	Primary key(ItemID)
)
go

insert into PS5Acc (Itemname, Price, Description, imageurl)
values ('PS5 Bluetooth Connector',2000 , 'Connection', 'PS5BC.jpeg'), 
('PS5 Headphones',15000, 'Sound', 'PS5HS.jpeg'),
('PS5 SSD', 25000, 'Storage', 'PS5SSD.jpeg');


CREATE TABLE PCAcc
(
    ItemID INT IDENTITY(1,1),
    Itemname VARCHAR(50) NOT NULL,
    Price INT NOT NULL,
    Description VARCHAR(200),
	imageurl varchar(50)
	Primary key(ItemID)
)
go


insert into PCAcc (Itemname, Price, Description, imageurl)
values ('PC Bluetooth Connector',2000 , 'Connection', 'PCBC.jpg'), 
('PC Headphones',15000, 'Sound', 'PCHS.jpeg'),
('PC SSD', 25000, 'Storage', 'PCSSD.jpeg');
select * from PCAcc
update PCAcc set imageurl='PCBC.jpeg' where Itemname='PC Bluetooth Connector'

CREATE TABLE PA
(
ID int not null primary key,
Name varchar(50),
PAstuff int,
--FOREIGN KEY (Name) REFERENCES [SignUp] (Name)
)
drop table PA

select * from signup

insert into PA values(1,'Abdullah',9);
insert into PA values(2,'Salman',10);

select * from PA
select * from CartB

DROP table CartB

CREATE TABLE CartB
(
    ItemID INT IDENTITY(1,1),
    Itemname VARCHAR(50) NOT NULL,
    Price INT NOT NULL,
    Houres INT,
	imageurl varchar(50),
	Name varchar(50)
	Primary key(ItemID),
	check (Houres <= 12)
)
go

create procedure total
@tprice INT output
AS
BEgin
	Select tprice=SUM(Price*Houres)
	From CartB
END

Declare @subtotal INT
EXECUTE total @tprice=@subtotal OUTPUT

create table total_
(
	tprice INT
)

select * from total_

drop table total_
truncate table PP
truncate table total_
select * from SignUp


Create PROCEDURE 
UpdateUser2
    @Name varchar(50),
	@Address varchar(100),
	@City varchar(50),
	@Contactno varchar(50),
	@Email varchar(50),
	@Password varchar(50),
    @SecurityQ varchar(50)    
AS
BEGIN
    SET NOCOUNT ON;

    -- Insert new user into Users table
    Update SignUp set Name=@Name,Address=@Address,City=@City,Contactno=@Contactno,Email=@Email,Password=@Password,SecurityQ=@SecurityQ
    where Name=@Name;
END

select * from SignUp
select * from PA
truncate table cartB
select * from cartB


UPDATE PA
SET PAstuff = 30
WHERE Name = 'Salman'
