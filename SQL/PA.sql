create database trying2
use trying2

create database project3



CREATE TABLE SignUp 
(
    UserID INT IDENTITY(1,1),
    Name VARCHAR(50) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Contactno VARCHAR(50) NOT NULL,
    Email VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(50) NOT NULL,
    SecurityQ VARCHAR(50) NOT NULL
    primary key(Name)
)

select * from SignUp
go

CREATE TABLE Users
(
   UserID INT,
   City varchar(50) NOT NULL,
   Name VARCHAR(50) NOT NULL,
   Address varchar(50) NOT NULL,
   Email varchar(50) NOT NULL,
   Password varchar(10) NOT NULL,
   Contactno INT NOT NULL,
   SecurityQ VARCHAR(50) NOT NULL
   primary key(userID)
)
go

CREATE TABLE Menu
(
    ItemID INT PRIMARY KEY,
    Itemname VARCHAR(50) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Price INT NOT NULL,
    Description VARCHAR(200),
    TopSellingitem INT DEFAULT 0
)
go
CREATE TABLE Login 
(
    UserID INT ,
    Email VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(50) NOT NULL,
	Name varchar(50),
	primary key(UserID),
	foreign key (Name) references SignUp(Name)
)
go
CREATE TABLE Profile 
(
    UserID INT ,
    Name VARCHAR(50) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Contactno VARCHAR(20) NOT NULL,
    Timeremaining DECIMAL (10,2),
    Totalhoursplayed INT NOT NULL,
    Ppstuff INT
	PRIMARY KEY (userID),
	foreign key (Name) references SignUp(Name)
)
go
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
go
CREATE TABLE MenuPS5
(
    ItemID INT IDENTITY(1,1),
    Itemname VARCHAR(50) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Price INT NOT NULL,
    Description VARCHAR(200),
    TopSellingitem INT DEFAULT 0,
	imageurl varchar(50)
	Foreign key(ItemID) references Menu(ItemID)
)
go
drop table MenuPS5
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
go
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
go
CREATE TABLE Booking
(
    BookingID INT PRIMARY KEY,
    UserID INT NOT NULL,
    ItemID INT NOT NULL,
	Name varchar(50),
    Quantity INT NOT NULL,
    Bookingdate DATETIME NOT NULL,
    Bookingtime DATETIME NOT NULL,
    Totalamount INT NOT NULL,
    FOREIGN KEY (Name) REFERENCES SignUp(Name),
    FOREIGN KEY (ItemID) REFERENCES Menu(itemID)
)
go
CREATE TABLE Cart 
(
    UserID INT PRIMARY KEY,
    ItemID INT NOT NULL,
    Quantity INT NOT NULL,
	Name varchar(50),
    Bookingtime DATETIME NOT NULL,
    Totalamount INT NOT NULL,
    FOREIGN KEY (Name) REFERENCES SignUp(Name),
    FOREIGN KEY (ItemID) REFERENCES Menu(ItemID)
)
go
CREATE TABLE Premiumcustomers 
(
    UserID INT PRIMARY KEY,
    Username varchar(20),
    Ispremium int DEFAULT 0,
    FOREIGN KEY (UserID) REFERENCES SignUp(UserID)
)
go
CREATE TABLE Feedback 
(
    UserID INT NOT NULL,
	Name varchar(50),
    Feedbacktext VARCHAR(200) NOT NULL,
    Feedbackdate DATETIME NOT NULL,
    Numberoffeedbacks INT,
    FOREIGN KEY (Name) REFERENCES SignUp(Name)
)
go
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
go
CREATE TABLE About 
(
    PpID int,
    Pplocator varchar(100) NOT NULL,
    Email varchar(50) NOT NULL,
    Contactno varchar(20) NOT NULL
	PRIMARY KEY (PpID)
)
go
CREATE TABLE Coupons 
(
  CouponID int,
  Couponcode VARCHAR(20) UNIQUE,
  Discountpercentage DECIMAL(5,2),
  Expirationdate DATE,
  Minimumorderamount int,
  PRIMARY KEY (CouponID)
)
go

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
CREATE PROCEDURE LoginUser
    @Name nvarchar(50),
    @Password nvarchar(50)
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if user exists and password is correct
    IF EXISTS (SELECT 1 FROM SignUp WHERE Name = @Name AND Password = @Password)
    BEGIN
        print('Successful')
    END
    ELSE
    BEGIN
        RAISERROR('Invalid username or password.', 16, 1)
        RETURN
    END
END

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
update PCAcc set imageurl='PCBCCC.jpeg' where Itemname='PC Bluetooth Connector'
CREATE TABLE PP
(
Name varchar(50),
PPstuff int,
FOREIGN KEY (Name) REFERENCES SignUp (Name)
)
drop table PP

insert into PP values('Abdullah',9)
select * from PP
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

CREATE PROCEDURE ForgotPassword
    @Name varchar(50),
    @SecurityQ varchar(13),
	@password varchar(10)
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if user exists and email is correct
    IF EXISTS (SELECT 1 FROM SignUp WHERE Name = @Name AND SecurityQ = @SecurityQ)
    BEGIN
        -- Generate a new password and update the user's record
        DECLARE @NewPassword nvarchar(50);
        SET @NewPassword = @password;
        UPDATE SignUp SET Password = @NewPassword WHERE Name = @Name AND SecurityQ = @SecurityQ;
    END
    ELSE
    BEGIN
        RAISERROR('Invalid username or email.', 16, 1)
        RETURN
    END
END

Create PROCEDURE UpdateUser2 
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
select * from PP
truncate table cartB
select * from cartB
UPDATE PP
SET PPstuff = 10
WHERE Name = 'fawad'