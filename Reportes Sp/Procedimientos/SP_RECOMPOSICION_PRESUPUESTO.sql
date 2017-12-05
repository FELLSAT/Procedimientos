CREATE PROCEDURE SP_RECOMPOSICION_PRESUPUESTO
(
	@IN_FECHA_INI DATE,
	@IN_FECHA_FIN DATE,
	@IN_VIGENCIA INT
)
AS
	SET NOCOUNT ON
	-----------------------------------------------------------------------------------
	-- CREACION DE LA TABLA 
	DECLARE @TABLAREPORTE NVARCHAR(MAX);

	IF(ISNULL(OBJECT_ID('tempdb..##TablaReporte3'), 0) <> 0)	
		BEGIN
			DROP TABLE ##TablaReporte3;
		END

	SET @TABLAREPORTE = N' 
			CREATE TABLE ##TablaReporte3 (CODI_ESM VARCHAR(15), PRESU_INI FLOAT';


	-- MANEJO DEL CURSOR
	DECLARE @CURSORDATA1 INT;
	DECLARE @CURSORDATA2 DATE;
	DECLARE @NOMBRECOLUMNAS NVARCHAR(MAX);

	DECLARE CURSOR1 CURSOR FOR
		SELECT DISTINCT A.MPRDOCN, FEC_AUTORI
		FROM AUDI_ESM A
		WHERE A.OPNCOD IN ('ADI_ING','RED_ING')
			AND A.FEC_AUTORI BETWEEN @IN_FECHA_INI AND @IN_FECHA_FIN
			AND A.VIGENCIA = @IN_VIGENCIA
			ORDER BY A.FEC_AUTORI


	OPEN CURSOR1
	FETCH NEXT FROM CURSOR1 INTO @CURSORDATA1, @CURSORDATA2
	WHILE @@FETCH_STATUS = 0
	BEGIN		
		SET @TABLAREPORTE = CONCAT(@TABLAREPORTE, ', DOC', @CURSORDATA1,'_',YEAR(@CURSORDATA2),'_',MONTH(@CURSORDATA2),'_',DAY(@CURSORDATA2), ' FLOAT  DEFAULT 0');		
		SET @NOMBRECOLUMNAS = CONCAT(@NOMBRECOLUMNAS, 'DOC', @CURSORDATA1,'_',YEAR(@CURSORDATA2),'_',MONTH(@CURSORDATA2),'_',DAY(@CURSORDATA2),'*_');

		FETCH NEXT FROM CURSOR1 INTO @CURSORDATA1, @CURSORDATA2
	END
	CLOSE CURSOR1
	DEALLOCATE CURSOR1

	SET @TABLAREPORTE = CONCAT(@TABLAREPORTE, ', PRESU_FINAL FLOAT DEFAULT 0)');

	EXEC(@TABLAREPORTE);

	-----------------------------------------------------------------------------------
	-- INSERCION DE LOS CODI_ESM
	DECLARE @CURSORDATA3 VARCHAR(15);

	DECLARE CURSOR2 CURSOR FOR
		SELECT DISTINCT  A.CODI_ESM
		FROM AUDI_ESM A
		WHERE A.OPNCOD IN ('ADI_ING','RED_ING')
			AND A.FEC_AUTORI BETWEEN @IN_FECHA_INI AND @IN_FECHA_FIN
			AND A.VIGENCIA = @IN_VIGENCIA

	OPEN CURSOR2
	FETCH NEXT FROM CURSOR2 INTO @CURSORDATA3
	WHILE @@FETCH_STATUS = 0
	BEGIN			
		INSERT INTO ##TablaReporte3(CODI_ESM) VALUES (@CURSORDATA3)
		FETCH NEXT FROM CURSOR2 INTO @CURSORDATA3
	END
	CLOSE CURSOR2
	DEALLOCATE CURSOR2

	-----------------------------------------------------------------------------------
	-- INSERCION DE LOS PRESUPUESTOS INICIALES
	DECLARE @CURSORDATA4 VARCHAR(15);
	DECLARE @CURSORDATA5 FLOAT;

	DECLARE CURSOR3 CURSOR FOR
		SELECT (A.CODI_ESM), 
			(SELECT E.MPRVAL FROM AUDI_ESM E WHERE E.OPNCOD='PRE_ING' AND E.VIGENCIA = '2015' AND E.CODI_ESM = A.CODI_ESM) PRESU_INICIAL
		FROM AUDI_ESM A
		WHERE A.OPNCOD IN ('ADI_ING','RED_ING')
			AND A.FEC_AUTORI BETWEEN @IN_FECHA_INI AND @IN_FECHA_FIN
				AND A.VIGENCIA = @IN_VIGENCIA
		ORDER BY A.CODI_ESM

	OPEN CURSOR3
	FETCH NEXT FROM CURSOR3 INTO @CURSORDATA4, @CURSORDATA5
	WHILE @@FETCH_STATUS = 0
	BEGIN		
		UPDATE ##TablaReporte3
			SET PRESU_INI = @CURSORDATA5
		WHERE CODI_ESM = @CURSORDATA4

		FETCH NEXT FROM CURSOR3 INTO @CURSORDATA4, @CURSORDATA5
	END
	CLOSE CURSOR3
	DEALLOCATE CURSOR3

	-----------------------------------------------------------------------------------
	-- INSERCION DE LOS VALORES DE LAS ADICIONES Y REDUCCIONES 
	DECLARE @CURSORDATA6 INT;
	DECLARE @CURSORDATA7 VARCHAR(15);
	DECLARE @CURSORDATA8 FLOAT;
	DECLARE @CURSORDATA9 DATE;
	DECLARE @UPDATETABLA NVARCHAR(MAX);

	DECLARE CURSOR4 CURSOR FOR
		SELECT A.MPRDOCN, A.CODI_ESM,
			ISNULL((SELECT E.MPRVAL FROM AUDI_ESM E WHERE E.OPNCOD='ADI_ING' AND E.VIGENCIA = '2015' AND E.CODI_ESM = A.CODI_ESM AND E.MPRDOCN = A.MPRDOCN),
				   (SELECT E.MPRVAL FROM AUDI_ESM E WHERE E.OPNCOD='RED_ING' AND E.VIGENCIA = '2015' AND E.CODI_ESM = A.CODI_ESM AND E.MPRDOCN = A.MPRDOCN)) VALOR,
			A.FEC_AUTORI
		FROM AUDI_ESM A
		WHERE A.OPNCOD IN ('ADI_ING','RED_ING')
			AND A.FEC_AUTORI BETWEEN @IN_FECHA_INI AND @IN_FECHA_FIN
				AND A.VIGENCIA = @IN_VIGENCIA
		ORDER BY FEC_AUTORI
		
	OPEN CURSOR4
	FETCH NEXT FROM CURSOR4 INTO @CURSORDATA6, @CURSORDATA7, @CURSORDATA8, @CURSORDATA9
	WHILE @@FETCH_STATUS = 0
	BEGIN		
		SET @UPDATETABLA = CONCAT('UPDATE ##TablaReporte3 SET DOC',@CURSORDATA6,'_',YEAR(@CURSORDATA9),'_',MONTH(@CURSORDATA9),'_',DAY(@CURSORDATA9),
								  ' =', @CURSORDATA8,' WHERE CODI_ESM = ',@CURSORDATA7);

		EXEC (@UPDATETABLA);

		FETCH NEXT FROM CURSOR4 INTO @CURSORDATA6, @CURSORDATA7, @CURSORDATA8, @CURSORDATA9
	END
	CLOSE CURSOR4
	DEALLOCATE CURSOR4

	-----------------------------------------------------------------------------------
	-- INSERCION DEL PRESUPUESTO FINAL 
	DECLARE @CURSORDATA10 VARCHAR(15);
	DECLARE @SUMAADI FLOAT;
	DECLARE @SUMARED FLOAT;
	DECLARE @PRESUTOTAL FLOAT;

	DECLARE CURSOR5 CURSOR FOR
		SELECT DISTINCT CODI_ESM
		FROM ##TablaReporte3

	OPEN CURSOR5
	FETCH NEXT FROM CURSOR5 INTO @CURSORDATA10
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @SUMAADI = (SELECT ISNULL(SUM(VALOR),0)
						FROM(
							SELECT A.CODI_ESM,
								ISNULL((SELECT E.MPRVAL FROM AUDI_ESM E WHERE E.OPNCOD='ADI_ING' AND E.VIGENCIA = '2015' AND E.CODI_ESM = A.CODI_ESM AND E.MPRDOCN = A.MPRDOCN),
									   (SELECT E.MPRVAL FROM AUDI_ESM E WHERE E.OPNCOD='RED_ING' AND E.VIGENCIA = '2015' AND E.CODI_ESM = A.CODI_ESM AND E.MPRDOCN = A.MPRDOCN)) VALOR,
								 A.OPNCOD
							FROM AUDI_ESM A
							WHERE A.OPNCOD IN ('ADI_ING')
								AND A.FEC_AUTORI BETWEEN @IN_FECHA_INI AND @IN_FECHA_FIN
								AND A.VIGENCIA = @IN_VIGENCIA
								AND A.CODI_ESM = @CURSORDATA10) RESULT);

		SET @SUMARED = (SELECT ISNULL(SUM(VALOR),0)
						FROM(
							SELECT A.CODI_ESM,
								ISNULL((SELECT E.MPRVAL FROM AUDI_ESM E WHERE E.OPNCOD='ADI_ING' AND E.VIGENCIA = '2015' AND E.CODI_ESM = A.CODI_ESM AND E.MPRDOCN = A.MPRDOCN),
									   (SELECT E.MPRVAL FROM AUDI_ESM E WHERE E.OPNCOD='RED_ING' AND E.VIGENCIA = '2015' AND E.CODI_ESM = A.CODI_ESM AND E.MPRDOCN = A.MPRDOCN)) VALOR,
								 A.OPNCOD
							FROM AUDI_ESM A
							WHERE A.OPNCOD IN ('RED_ING')
								AND A.FEC_AUTORI BETWEEN @IN_FECHA_INI AND @IN_FECHA_FIN
								AND A.VIGENCIA = @IN_VIGENCIA
								AND A.CODI_ESM = @CURSORDATA10) RESULT);

		SET @PRESUTOTAL = ( SELECT DISTINCT PRESU_INI
							FROM ##TablaReporte3
							WHERE CODI_ESM = @CURSORDATA10) + (@SUMAADI) - (@SUMARED);

		UPDATE ##TablaReporte3
		SET PRESU_FINAL = @PRESUTOTAL
		WHERE CODI_ESM = @CURSORDATA10;

		FETCH NEXT FROM CURSOR5 INTO @CURSORDATA10
	END
	CLOSE CURSOR5
	DEALLOCATE CURSOR5

	---------------------------------------------------------------------

	SET @NOMBRECOLUMNAS = CONCAT('CODI_ESM*_PRESU_INI*_', @NOMBRECOLUMNAS, 'PRESU_FINAL');

	SELECT @NOMBRECOLUMNAS NOMBRES_COLUMNAS,* FROM ##TablaReporte3

GO
