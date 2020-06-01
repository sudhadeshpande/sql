
CREATE PROCEDURE Usp_InsertUpdateDelete_TRANSACTION_DETAILS
@id int = 0,
@from_account_no bigint,
@to_account_no bigint,
@debit_amount int,
@credit_amount int,
@transaction_date DateTime,
@transaction_description varchar(50),

@Query INT
AS
BEGIN
IF (@Query = 1)
BEGIN
INSERT INTO TRANSACTION_DETAILS(
from_account_no,
to_account_no,
debit_amount,
credit_amount,
transaction_date,
transaction_description
)

VALUES (
@from_account_no,
@to_account_no,
@debit_amount,
@credit_amount,
@transaction_date,
@transaction_description
)

IF (@@ROWCOUNT > 0)
BEGIN
SELECT 'Insert'
END
END

IF (@Query = 2)
BEGIN
UPDATE TRANSACTION_DETAILS
SET from_account_no = @from_account_no,
to_account_no = @to_account_no,
 debit_amount = @debit_amount,
 credit_amount = @credit_amount,
transaction_date = @transaction_date,
transaction_description  = @transaction_description 

WHERE TRANSACTION_DETAILS.id = @id
SELECT 'Update'
END

IF (@Query = 3)
BEGIN
DELETE
FROM TRANSACTION_DETAILS
WHERE TRANSACTION_DETAILS.id = @id
SELECT 'Deleted'
END

IF (@Query = 4)
BEGIN
SELECT * FROM TRANSACTION_DETAILS
END
END

IF (@Query = 5)
BEGIN
SELECT * FROM TRANSACTION_DETAILS
WHERE TRANSACTION_DETAILS.id = @id
END







