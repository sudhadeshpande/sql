
Create procedure fixed_deposit_sp
 @account_no bigint,
@amount int,
@duration INT,
@nominee varchar(10)

As 
 Begin

Declare @fddate datetime ;
Set @fddate=convert (date,getdate());

DECLARE @BALANCE_AMOUNT BIGINT;
SET @BALANCE_AMOUNT=(SELECT  balance from ACCOUNT  WHERE account_no=@account_no);

Declare @rate_of_interest decimal;
Declare @maturity_amount decimal;
Declare @maturity_date Datetime;
set @maturity_date=DATEADD(MM,4,@fddate)

IF ((@BALANCE_AMOUNT>@AMOUNT) and (@amount>=5000))
Begin

If (@duration <6)
Begin
set @Rate_of_interest=4;
set @maturity_amount=@amount+((@amount*@Rate_of_interest*@duration)/100);

Insert into fixeddeposit (account_no,fd_date,fd_amount,duration,rate_of_interest,maturity_date,maturity_amount,nominee)
Values(@account_no,GETDATE(),@amount,@duration,@Rate_of_interest,@maturity_date,@maturity_amount,@nominee)
End

Else 
Begin
set @rate_of_interest =4.25;
set @maturity_amount=@amount+((@amount*@Rate_of_interest*@duration)/100);
Insert into fixeddeposit (account_no,fd_date,fd_amount,duration,rate_of_interest,maturity_date,maturity_amount,nominee)
Values(@account_no,@fddate,@amount,@duration,@Rate_of_interest,@maturity_date,@maturity_amount,@nominee);
end
end

Else 
Begin RAISERROR ('FIXED DEPOSIT FAILED AS ENTERED AMOUNT IS LESSER THAN THE AVAILABLE BALANCE',1,1);
end

declare @balance bigint;
	set @balance =(select balance from ACCOUNT where account_no=@account_no);

IF @AMOUNT>5000
	BEGIN
		UPDATE ACCOUNT SET ACCOUNT.balance = @balance- @AMOUNT WHERE account_no = @account_no;

		UPDATE ACCOUNT SET balance=@balance- @amount
		WHERE account_no =@account_no;
	END
END

drop procedure fixed_deposit_sp
Exec fixed_deposit_sp 110010001116,30000,8,'natesh';
exec fixed_deposit_sp 110010001116,50000,5,'shandar';

SELECT * FROM ACCOUNT
SELECT * FROM FIXEDDEPOSIT