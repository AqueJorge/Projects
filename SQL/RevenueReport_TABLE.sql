CREATE TABLE transac(
id int AUTO_INCREMENT primary key,
dt timestamp, -- Transaction timestamp
customer VARCHAR(64), -- Customer email address
type_tran VARCHAR(4), -- Transaction type
amount DECIMAL(4,2), -- Transaction amount
status_tran VARCHAR(9) -- Transaction status
);
