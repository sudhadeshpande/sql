create database OnlineBanking1
use onlinebanking1;


/*drop database OnlineBanking*/

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
	email_id varchar(50)
);

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

create table USER_DETAILS(
	id int primary key identity(100,1),
	user_name varchar(20) NOT NULL,
	user_password varchar(20)  NOT NULL,
	account_no bigint,
	foreign key (account_no) references ACCOUNT (account_no)
);

drop table fixed_deposit

create table FIXED_DEPOSIT(
    deposit_id int primary key identity(100,1),
	account_no bigint,
	foreign key (account_no) references ACCOUNT (account_no),
	fddate datetime,
	amount bigint,
	duration Datetime,
	rate_of_interest  int,
	maturity_date datetime NOT NULL,
	maturity_amount bigint,
	nominee varchar(50)
);
--drop table FIXED_DEPOSIT

select * from ACCOUNT
select * from FIXED_DEPOSIT

--@depsit_id int,
--@account_no bigint,
--@fddate datetime,
--@amount bigint,
--@duration datetime,
--@rate_of_interest int,
--@maturity_date datetime,
--@maturity_amount bigint,
--@nominee varchar

select * from FIXED_DEPOSIT
select * from ACCOUNT

create procedure p_insert_fixed_deposit
@account_no bigint,
@amount bigint
AS
BEGIN

DECLARE @fddate DATETIME;
	SET @fddate=GETDATE();    

	DECLARE @deposit_id INT;
	SET @deposit_id= (SELECT TOP 1 deposit_id FROM FIXED_DEPOSIT ORDER BY deposit_id DESC );

	declare @fixed_amount bigint;
	set @fixed_amount=(select amount from FIXED_DEPOSIT where deposit_id=@deposit_id);

	DECLARE @duration DATETIME;
	SET @duration=GETDATE();   

	declare @rate_of_interest int;
	set @rate_of_interest=(select rate_of_interest from FIXED_DEPOSIT where deposit_id=@deposit_id)

   DECLARE @maturity_date DATETIME;
	SET @maturity_date=GETDATE();   

		DECLARE @maturity_amount bigint;
	SET @maturity_amount=(select maturity_amount from FIXED_DEPOSIT);   

	DECLARE @nominee varchar(50);
	SET @nominee=(select nominee from FIXED_DEPOSIT);   

	/********  INSERT INTO FIXED DEPOSIT *********/
	INSERT INTO FIXED_DEPOSIT (account_no,fddate,amount,duration,rate_of_interest,maturity_date, maturity_amount,nominee)
	VALUES( @account_no, @fddate, @amount, @duration, @rate_of_interest, @maturity_date, @maturity_amount, @nominee )


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


