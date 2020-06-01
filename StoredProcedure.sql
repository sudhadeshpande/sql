
CREATE PROCEDURE Usp_InsertUpdateDelete_CUSTOMER
@id int = 0,
@customer_name varchar(20),
@fathers_name varchar(20),
@date_of_birth DateTime,
@customer_age int,
@martial_status varchar(10),
@customer_address varchar(100) ,
@customer_city varchar(20),
@customer_state varchar(20),
@customer_country varchar(20),
@pincode int,
@phone bigint ,
@email_id varchar(50),

@Query INT
AS
BEGIN
IF (@Query = 1)
BEGIN
INSERT INTO CUSTOMER(
customer_name,
fathers_name,
date_of_birth,
customer_age,
martial_status,
customer_address,
customer_city,
customer_state,
customer_country,
pincode,
phone,
email_id
)

VALUES (
@customer_name,
@fathers_name,
@date_of_birth,
@customer_age,
@martial_status,
@customer_address,
@customer_city,
@customer_state,
@customer_country,
@pincode,
@phone,
@email_id
)

IF (@@ROWCOUNT > 0)
BEGIN
SELECT 'Insert'
END
END

IF (@Query = 2)
BEGIN
UPDATE CUSTOMER
SET customer_name = @customer_name,
fathers_name      = @fathers_name,
date_of_birth     = @date_of_birth,
customer_age     = @customer_age,
martial_status    = @martial_status,
customer_address = @customer_address,
customer_city = @customer_city,
customer_state = @customer_state,
customer_country = @customer_country,
pincode =@pincode,
phone = @phone,
email_id =@email_id
WHERE CUSTOMER.id = @id
SELECT 'Update'
END

IF (@Query = 3)
BEGIN
DELETE
FROM CUSTOMER
WHERE CUSTOMER.id = @id
SELECT 'Deleted'
END

IF (@Query = 4)
BEGIN
SELECT * FROM CUSTOMER
END
END

IF (@Query = 5)
BEGIN
SELECT * FROM CUSTOMER
WHERE CUSTOMER.id = @id
END


