DELIMITER ;
DROP PROCEDURE IF EXISTS `RevenueReport`;
DELIMITER $$
CREATE PROCEDURE RevenueReport(
customer_mail VARCHAR(30)
)

BEGIN
	DECLARE large INT;
    DECLARE var_ttran VARCHAR(15);
    DECLARE var_amon DECIMAL(10,2);
    DECLARE var_status VARCHAR(15);

    DECLARE num INT;
    DECLARE var_BUY FLOAT;
    DECLARE var_SELL FLOAT;
    DECLARE var_TOTAL FLOAT;
    DECLARE iter INT;
    DECLARE var_penal FLOAT;

    SET num := 1;
    SET iter := 1;
    SET large = (SELECT count(*) FROM transac WHERE customer = customer_mail);

    SET var_BUY := 0;
    SET var_SELL := 0;

	WHILE iter <= large DO
		SET var_ttran := (SELECT type_tran FROM transac WHERE id = num AND customer = customer_mail);
        SET var_amon := (SELECT amount FROM transac WHERE id = num AND customer = customer_mail);
        SET var_status := (SELECT status_tran FROM transac WHERE id = num AND customer = customer_mail);

		-- CASE BUY
        IF (var_ttran = 'BUY' AND var_status = 'COMPLETED') THEN
		SET var_BUY = var_BUY + var_amon;

        ELSEIF (var_ttran = 'BUY' AND var_status = 'CANCELED') THEN
        SET var_penal := var_amon * -0.01;
        SET var_BUY := var_BUY + var_penal;
        END IF;

        -- CASE SELL

        IF (var_ttran = 'SELL' AND var_status = 'COMPLETED') THEN
		SET var_SELL = var_SELL + var_amon;


        ELSEIF (var_ttran = 'SELL' AND var_status = 'CANCELED') THEN
        SET var_penal := var_amon * -0.01;
        SET var_SELL := var_penal;
        END IF;

        SET num := num + 1;
        SET iter := iter + 1;



    END WHILE;

    SET var_TOTAL := var_BUY + var_SELL;

	SELECT customer_mail, var_BUY, var_SELL, var_TOTAL;

END$$
