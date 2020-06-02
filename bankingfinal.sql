

create table ACCOUNT_TYPE(
	id int primary key identity(1020,2),
	account_type_name varchar(20) NOT NULL
	);


	insert into ACCOUNT_TYPE
	values ('Savings'),('Salary'),('Rural'),('Fixed')


	select * from ACCOUNT_TYPE

create table BRANCH(
	id varchar(20) primary key,
	branch_name varchar(20) NOT NULL
	);


	insert into BRANCH
	values ('BRANCHID01','BAGALURU CROSS'),('BRANCHID02','DEVANAHALLI'),('BRANCHID03','HEBBALA'),('BRANCHID04','KOGILU CROSS'),
	('BRANCHID05','MALLESHWARAM'),('BRANCHID06','MAJESTIC'),('BRANCHID07','HUNASEMARANAHALLI')

	SELECT * FROM BRANCH

create table CUSTOMER(
	id int primary key identity(1010,1),
	customer_name varchar(20) NOT NULL,
	fathers_name varchar(20) NOT NULL,
	date_of_birth DateTime NOT NULL,
	customer_age int NOT NULL,
	martial_status varchar(10),
	customer_address varchar(100) NOT NULL,
	customer_city varchar(20) NOT NULL,
	customer_state varchar(20) NOT NULL,
	customer_country varchar(20) NOT NULL,
	pincode int NOT NULL,
	phone bigint NOT NULL,
	email_id varchar(50),
	user_password varchar(20) ,
);

select * from CUSTOMER


INSERT INTO CUSTOMER 
VALUES ('Shandar','FATHER','19970625',23,'unmarried','bc road','mangalore'
,'karnataka','India',575056,8050855690,'shandar246@gmail.com','123456')

INSERT into CUSTOMER 
VALUES ('Sudha', 'Sangamesh', '19971007',23, 'unmarried', 'rc road', 'Mudhol', 'Karnataka','India', 587313, 9934101010, 'sudha7@gmail.com', 'sudha123' )

INSERT into CUSTOMER 
VALUES ('Natesh', 'Father', '19971008',23, 'unmarried', 'mg road', 'Bangolore', 'Karnataka','India', 560003,2043015100, 'Natesh@gmail.com', 'n123' )

select * from CUSTOMER


create table ACCOUNT(
	account_no bigint primary key identity(110010001111,1),
	debit_card_no bigint NOT NULL,
	branch_id varchar(20) NOT NULL,
	foreign key (branch_id) references BRANCH (id),
	account_type_id int NOT NULL ,
	foreign key (account_type_id) references ACCOUNT_TYPE (id),
	customer_id int,
	foreign key (customer_id) references CUSTOMER (id),
	balance bigint NOT NULL,
	check_book_id varchar(10)

	);

	select * from ACCOUNT

	select * from ACCOUNT_TYPE

	INSERT INTO ACCOUNT 
	VALUES (1234567891011,'BRANCHID01',1020,1010,100000,'CHECK01');

	INSERT INTO ACCOUNT 
	VALUES (1234567891012,'BRANCHID02',1020,1012,150000,'CHECK02');

	INSERT INTO ACCOUNT 
	VALUES (1234567891013,'BRANCHID03',1020,1013,1000200,'CHECK03');

	--update ACCOUNT
 --   SET 
	--account_type_id=1024
	--WHERE account_no=1234567891012;

create table USER_DETAILS(
	id int primary key identity(100,1),
	user_name varchar(20) NOT NULL,
	user_password varchar(20)  NOT NULL,
	account_no bigint,
	foreign key (account_no) references ACCOUNT (account_no)
);

/*	DROP TABLE TRANSACTION_DETAILS */

	CREATE TABLE DEBIT_TRANSACTION_DETAILS(
		id int primary key identity(1050,1),
		debit_account_no bigint not null ,
		foreign key (debit_account_no) references ACCOUNT (account_no),
		debit_amount int,
		debit_date_time datetime not null,
	);

	SELECT * FROM DEBIT_TRANSACTION_DETAILS

	CREATE TABLE CREDIT_TRANSACTION_DETAILS(
		id_debit int ,
		foreign key (id_debit) references DEBIT_TRANSACTION_DETAILS (id),
		credit_account_no bigint not null ,
		foreign key (credit_account_no) references ACCOUNT (account_no),
		credit_amount int,
		credit_date_time datetime not null,
	);

	select * from CREDIT_TRANSACTION_DETAILS
	SELECT * FROM DEBIT_TRANSACTION_DETAILS

	alter table DEBIT_TRANSACTION_DETAILS
	ADD debit_account_balance bigint 

		alter table CREDIT_TRANSACTION_DETAILS
	ADD credit_account_balance bigint 

--create table FIXED_DEPOSIT(
--    deposit_id int primary key identity(100,1),
--	account_no bigint,
--	foreign key (account_no) references ACCOUNT (account_no),
--	fd_date datetime,
--	fd_amount bigint,
--	duration Datetime,
--	rate_of_interest  int,
--	maturity_date datetime NOT NULL,
--	maturity_amount bigint,
--	nominee varchar(50)
--);

drop table FIXED_DEPOSIT


create table FIXEDDEPOSIT(
    deposit_id int primary key identity(100,1),
	account_no bigint,
	foreign key (account_no) references ACCOUNT (account_no),
	fd_date datetime,
	fd_amount bigint,
	duration Datetime,
	rate_of_interest  int,
	maturity_date datetime NOT NULL,
	maturity_amount bigint,
	nominee varchar(50)
	);


SELECT * FROM FIXEDDEPOSIT
SELECT * FROM BRANCH
SELECT * FROM ACCOUNT
SELECT * FROM ACCOUNT_TYPE
SELECT * FROM CUSTOMER


/**********************	STORED PROCEDURE TO UPDATE THE BALANCE AMOUNT********************************/

--create procedure p_insert_transaction
--@DEBIT_ACCOUNT_NO BIGINT,
--@CREDIT_ACCOUNT_NO BIGINT,
--@AMOUNT INT
--AS
--BEGIN
--/*INSERT DATA INTO TRANSACTION TABLES THAT IS CREDIT AND DEBIT TRANSACTION DETAILS*/
--	DECLARE @DATE_TIME DATETIME;
--	SET @DATE_TIME=GETDATE();                                             /*VARIABLE STORES CURRENT DATETIME*/

--	/*INSERT INTO DEBIT_TRANSACTION_DETAILS*/
--	INSERT INTO DEBIT_TRANSACTION_DETAILS(debit_account_no,debit_amount,debit_date_time) 
--	VALUES(@DEBIT_ACCOUNT_NO,@AMOUNT,@DATE_TIME)

--	/*ID VARIABLE GETS THE id from DEBIT_TRANSACTION_DETAILS
--	HERE WE ARE ARRANGING THE ROWS IN DESC ORDER w.r.t id and SELECTING TOP 1st id that is it gets the id of recently added row*/
--	DECLARE @ID INT;
--	SET @ID= (SELECT TOP 1 id FROM DEBIT_TRANSACTION_DETAILS ORDER BY id DESC );


--		/*INSERT INTO CREDIT_TRANSACTION_DETAILS*/
--	INSERT INTO CREDIT_TRANSACTION_DETAILS(id_debit,credit_account_no,credit_amount,credit_date_time) 
--	VALUES(@ID,@CREDIT_ACCOUNT_NO,@AMOUNT,@DATE_TIME)


--	/* update the balance amount in ACCOUNT table based on the transactions*/
--	/*In debit account update balance amount by balance-amount
--	and in credit amount update balance amount by balance+amount*/
	
--	DECLARE @VAR_AMOUNT INT;
--	SET @VAR_AMOUNT = (SELECT TOP 1 debit_amount from DEBIT_TRANSACTION_DETAILS ORDER BY id DESC   );

--	DECLARE @VAR_DEBITS_ACCOUNT_NO BIGINT;
--	SET @VAR_DEBITS_ACCOUNT_NO = (SELECT TOP 1 debit_account_no from DEBIT_TRANSACTION_DETAILS ORDER BY id DESC);

--	DECLARE @VAR_CREDITS_ACCOUNT_NO BIGINT;
--	SET @VAR_CREDITS_ACCOUNT_NO=(SELECT TOP 1 credit_account_no from	CREDIT_TRANSACTION_DETAILS ORDER BY id_debit DESC);

--	DECLARE @VAR_BALANCE_CREDIT BIGINT;
--	SET @VAR_BALANCE_CREDIT = (SELECT   balance from ACCOUNT   WHERE account_no= @VAR_CREDITS_ACCOUNT_NO);

--	DECLARE @VAR_BALANCE_DEBIT BIGINT;
--	SET @VAR_BALANCE_DEBIT = (SELECT   balance from ACCOUNT WHERE account_no= @VAR_DEBITS_ACCOUNT_NO);

--	DECLARE @TRANSACTION_ID INT ;
--	SET @TRANSACTION_ID=(SELECT TOP 1 id FROM DEBIT_TRANSACTION_DETAILS ORDER BY id DESC);

--	IF @VAR_AMOUNT>0
--	BEGIN
--		UPDATE ACCOUNT SET ACCOUNT.balance = @VAR_BALANCE_DEBIT- @VAR_AMOUNT WHERE account_no = @VAR_DEBITS_ACCOUNT_NO;

--		UPDATE ACCOUNT SET ACCOUNT.balance = @VAR_BALANCE_CREDIT + @VAR_AMOUNT WHERE account_no = @VAR_CREDITS_ACCOUNT_NO;

--		UPDATE CREDIT_TRANSACTION_DETAILS SET credit_account_balance=@VAR_BALANCE_CREDIT + @VAR_AMOUNT
--		WHERE id_debit =@TRANSACTION_ID;

--			UPDATE DEBIT_TRANSACTION_DETAILS SET debit_account_balance=@VAR_BALANCE_DEBIT - @VAR_AMOUNT
--		WHERE id = @TRANSACTION_ID;		
--	END
--END

DROP procedure p_insert_transaction

select * from account
select * from DEBIT_TRANSACTION_DETAILS
select * from CREDIT_TRANSACTION_DETAILS

create procedure p_insert_transaction
@DEBIT_ACCOUNT_NO BIGINT,
@CREDIT_ACCOUNT_NO BIGINT,
@AMOUNT INT
AS
BEGIN
/*INSERT DATA INTO TRANSACTION TABLES THAT IS CREDIT AND DEBIT TRANSACTION DETAILS*/
	DECLARE @DATE_TIME DATETIME;
	SET @DATE_TIME=GETDATE();                                             /*VARIABLE STORES CURRENT DATETIME*/

	DECLARE @BALANCE_AMOUNT BIGINT;
	SET @BALANCE_AMOUNT=(SELECT balance from ACCOUNT WHERE account_no=@DEBIT_ACCOUNT_NO);

	IF @BALANCE_AMOUNT>@AMOUNT
	BEGIN

	/*INSERT INTO DEBIT_TRANSACTION_DETAILS*/
	INSERT INTO DEBIT_TRANSACTION_DETAILS(debit_account_no,debit_amount,debit_date_time) 
	VALUES(@DEBIT_ACCOUNT_NO,@AMOUNT,@DATE_TIME)

	/*ID VARIABLE GETS THE id from DEBIT_TaRANSACTION_DETAILS
	HERE WE ARE ARRANGING THE ROWS IN DESC ORDER w.r.t id and SELECTING TOP 1st id that is it gets the id of recently added row*/
	DECLARE @ID INT;
	SET @ID= (SELECT TOP 1 id FROM DEBIT_TRANSACTION_DETAILS ORDER BY id DESC );


		/*INSERT INTO CREDIT_TRANSACTION_DETAILS*/
	INSERT INTO CREDIT_TRANSACTION_DETAILS(id_debit,credit_account_no,credit_amount,credit_date_time) 
	VALUES(@ID,@CREDIT_ACCOUNT_NO,@AMOUNT,@DATE_TIME)


	/* update the balance amount in ACCOUNT table based on the transactions*/
	/*In debit account update balance amount by balance-amount
	and in credit amount update balance amount by balance+amount*/
	
	DECLARE @VAR_AMOUNT INT;
	SET @VAR_AMOUNT = (SELECT TOP 1 debit_amount from DEBIT_TRANSACTION_DETAILS ORDER BY id DESC   );

	DECLARE @VAR_DEBITS_ACCOUNT_NO BIGINT;
	SET @VAR_DEBITS_ACCOUNT_NO = (SELECT TOP 1 debit_account_no from DEBIT_TRANSACTION_DETAILS ORDER BY id DESC);

	DECLARE @VAR_CREDITS_ACCOUNT_NO BIGINT;
	SET @VAR_CREDITS_ACCOUNT_NO=(SELECT TOP 1 credit_account_no from	CREDIT_TRANSACTION_DETAILS ORDER BY id_debit DESC);

	DECLARE @VAR_BALANCE_CREDIT BIGINT;
	SET @VAR_BALANCE_CREDIT = (SELECT   balance from ACCOUNT   WHERE account_no= @VAR_CREDITS_ACCOUNT_NO);

	DECLARE @VAR_BALANCE_DEBIT BIGINT;
	SET @VAR_BALANCE_DEBIT = (SELECT   balance from ACCOUNT WHERE account_no= @VAR_DEBITS_ACCOUNT_NO);

	DECLARE @TRANSACTION_ID INT ;
	SET @TRANSACTION_ID=(SELECT TOP 1 id FROM DEBIT_TRANSACTION_DETAILS ORDER BY id DESC);

	IF @VAR_AMOUNT>0
	BEGIN
		UPDATE ACCOUNT SET ACCOUNT.balance = @VAR_BALANCE_DEBIT- @VAR_AMOUNT WHERE account_no = @VAR_DEBITS_ACCOUNT_NO;

		UPDATE ACCOUNT SET ACCOUNT.balance = @VAR_BALANCE_CREDIT + @VAR_AMOUNT WHERE account_no = @VAR_CREDITS_ACCOUNT_NO;

		UPDATE CREDIT_TRANSACTION_DETAILS SET credit_account_balance=@VAR_BALANCE_CREDIT + @VAR_AMOUNT
		WHERE id_debit =@TRANSACTION_ID;

			UPDATE DEBIT_TRANSACTION_DETAILS SET debit_account_balance=@VAR_BALANCE_DEBIT - @VAR_AMOUNT
		WHERE id = @TRANSACTION_ID;		
	END
END

ELSE 
     BEGIN RAISERROR ('TRANSACTION FAILED AS ENTERED AMOUNT IS GREATER THAN THE AVAILABLE BALANCE',1,1);
	 END

	 END


	 select * from DEBIT_TRANSACTION_DETAILS
SELECT * FROM CREDIT_TRANSACTION_DETAILS
SELECT * FROM ACCOUNT

DELETE FROM DEBIT_TRANSACTION_DETAILS
DELETE FROM CREDIT_TRANSACTION_DETAILS

EXEC p_insert_transaction 110010001115,110010001116,100

EXEC p_insert_transaction 110010001117,110010001115,1000000
                                                                          
EXEC p_insert_transaction 110010001117,110010001115,1000000

exec p_insert_transaction 110010001116, 110010001115, 15020

exec p_insert_transaction 110010001115, 110010001117, 50000


select * from FIXEDDEPOSIT
select * from ACCOUNT

create procedure p_insert_fixed_deposit
@account_no bigint,
@amount bigint
AS
BEGIN

DECLARE @fd_date DATETIME;
	SET @fd_date=GETDATE();    

	DECLARE @deposit_id INT;
	SET @deposit_id= (SELECT TOP 1 deposit_id FROM FIXEDDEPOSIT ORDER BY deposit_id DESC );

	declare @fd_amount bigint;
	set @fd_amount=(select @fd_amount from FIXEDDEPOSIT where deposit_id=@deposit_id);

	DECLARE @duration DATETIME;
	SET @duration=GETDATE();   

	declare @rate_of_interest int;
	set @rate_of_interest=(select rate_of_interest from FIXEDDEPOSIT where deposit_id=@deposit_id)

   DECLARE @maturity_date DATETIME;
	SET @maturity_date=GETDATE();   

		DECLARE @maturity_amount bigint;
	SET @maturity_amount=(select maturity_amount from FIXEDDEPOSIT);   

	DECLARE @nominee varchar(50);
	SET @nominee=(select nominee from FIXEDDEPOSIT);   

	/********  INSERT INTO FIXED DEPOSIT *********/
	INSERT INTO FIXEDDEPOSIT (account_no,fd_date,fd_amount,duration,rate_of_interest,maturity_date, maturity_amount,nominee)
	VALUES( @account_no, @fd_date, @amount, @duration, @rate_of_interest, @maturity_date, @maturity_amount, @nominee )


	declare @balance bigint;
	set @balance =(select balance from ACCOUNT where account_no=@account_no);
	IF @AMOUNT>5000
	BEGIN
		UPDATE ACCOUNT SET ACCOUNT.balance = @BALANCE- @AMOUNT WHERE account_no = @account_no;

		UPDATE ACCOUNT SET balance=@balance- @amount
		WHERE account_no =@account_no;
	END
END


drop procedure p_insert_fixed_deposit

exec p_insert_fixed_deposit 110010001115,64840;

select * from ACCOUNT

exec p_insert_fixed_deposit 11001000111,50000;