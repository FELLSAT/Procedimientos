CREATE PROCEDURE SP_REPORTES_ANTICIPO
(
	@IN_FECHA_INI DATE,
	@IN_FECHA_FIN DATE,
	@IN_VIGENCIA INT
)
AS
	SET NOCOUNT ON

	IF(ISNULL(OBJECT_ID('tempdb..##TablaReporte3'), 0) <> 0)	
		BEGIN
			DROP TABLE ##TablaReporte3;
		END

	-- CREA LA TABLA TEMPORAL 
	CREATE TABLE ##TablaReporte3(
		NUM_DOC VARCHAR(50),
		CODI_ESM VARCHAR(15),
		VAL_AMORT INT,
		FECHA_AUT DATE,
		SALDO_AMORT FLOAT,
		MES_FAC VARCHAR(50)
	)

	-- VARIABLE PARA TENER DECREMEMTO 
	DECLARE @ANTICIPO FLOAT = 35000000000;
	DECLARE @NOMBREMES VARCHAR(20);
	DECLARE @NOMBRECOL VARCHAR(100) = 'NUM_DOC*_CODI_ESM*_VAL_AMORT*_FECHA_AUT*_SALDO_AMORT*_MES_FAC';

	-- DATOS PARA EL CURSOR
	DECLARE @CURSORDATA1 INT;
	DECLARE @CURSORDATA2 VARCHAR(15);
	DECLARE @CURSORDATA3 INT;
	DECLARE @CURSORDATA4 DATE
	DECLARE @CURSORDATA5 VARCHAR(50);


	-- CREA LA TABLA TEMPORAL 
	DECLARE CURSOR1 CURSOR FOR
		SELECT MPRDOCN, CODI_ESM, 
			AMORTIZACION, FEC_AUTORI,
			MES_FACTURA
		FROM AUDI_ESM
		WHERE VIGENCIA = @IN_VIGENCIA
			AND FEC_AUTORI BETWEEN @IN_FECHA_INI AND @IN_FECHA_FIN
			AND OPNCOD = 'AUT_PAG'
		ORDER BY FEC_AUTORI

	OPEN CURSOR1
	FETCH NEXT FROM CURSOR1 INTO @CURSORDATA1, @CURSORDATA2, @CURSORDATA3, @CURSORDATA4, @CURSORDATA5
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @ANTICIPO =  @ANTICIPO - @CURSORDATA3;
		SET @NOMBREMES = CONCAT('01-0',@CURSORDATA5,'-2015');

		INSERT INTO ##TablaReporte3
			(NUM_DOC, CODI_ESM, VAL_AMORT, FECHA_AUT, SALDO_AMORT, MES_FAC)
		VALUES (CONCAT('Autorizacion # ',@CURSORDATA1), @CURSORDATA2, @CURSORDATA3, @CURSORDATA4, @ANTICIPO, DATENAME(MONTH,@NOMBREMES))

		FETCH NEXT FROM CURSOR1 INTO @CURSORDATA1, @CURSORDATA2, @CURSORDATA3, @CURSORDATA4, @CURSORDATA5
	END
	CLOSE CURSOR1
	DEALLOCATE CURSOR1

	SELECT @NOMBRECOL NOMBRES_COLUMNAS, * 
	FROM ##TablaReporte3


	

GO