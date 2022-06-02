DELIMITER ;
DROP PROCEDURE IF EXISTS `YearEndBalance`;
DELIMITER $$
CREATE PROCEDURE YearEndBalance(
)

BEGIN
	DECLARE balance DECIMAL(10,2);
    DECLARE numonth INT;

    DECLARE total DECIMAL(10,2);
	DECLARE countranc INT;
    DECLARE tab VARCHAR(20);
    SET balance = 0;
    SET numonth = 1;

    --WHILE OF MONTHS
    WHILE numonth <=12 DO

		SET total = (SELECT SUM(ABS(amount)) FROM transactions WHERE month(dt) = numonth);  -- SELECTING THE TOTAL SUM BY MONTH
		SET countranc = (SELECT count(dt) FROM transactions WHERE month(dt) = numonth);   -- SELECTING THE NUMBER OF TRANSACTIONS

        -- CONDITIONALS
		IF(total < 100) AND (countranc < 3) THEN
		SET balance = balance + total + 5;

		ELSEIF(countranc >=3) AND (countranc<=5) AND (total > 100) THEN
		SET balance = balance + total + 3;

		ELSEIF(countranc>= 6 OR total>= 100) THEN
		SET balance = balance + total;
		END IF;

		SET numonth = numonth + 1;

    END WHILE;


    SELECT balance;

END$$


