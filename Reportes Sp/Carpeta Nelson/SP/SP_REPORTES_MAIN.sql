USE [presama]
GO
/****** Object:  StoredProcedure [dbo].[SP_REPORTES_MAIN]    Script Date: 18/10/2017 14:44:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_REPORTES_MAIN]

AS
	SET NOCOUNT ON

	IF(ISNULL(OBJECT_ID('tempdb..##TableConsolidado'), 0) <> 0)	
		BEGIN
			DROP TABLE ##TableConsolidado;
		END

	-- CREA LA TABLA TEMPORAL 
	CREATE TABLE ##TableConsolidado(
		VIGEN VARCHAR(200),
		VALOR_PRE FLOAT,
		VALOR_AUTO FLOAT,
		SALDO FLOAT
	)

	-- VARIABLE PARA TENER DECREMEMTO 
	DECLARE @NOMBRECOL VARCHAR(100) = 'VIGEN*_ VALOR_PRE*_ VALOR_AUTO*_ SALDO*_TOTAL';

	-- DATOS PARA EL CURSOR
	DECLARE @CURSORDATA1 VARCHAR(200);
	DECLARE @CURSORDATA2 FLOAT;
	DECLARE @CURSORDATA3 FLOAT;
	DECLARE @CURSORDATA4 FLOAT;
	DECLARE @VAR1 FLOAT;
	DECLARE @VAR2 FLOAT;
	DECLARE @VAR3 FLOAT;
	DECLARE @TOTAL_AMORTIZADO FLOAT;

	-- CREA LA TABLA TEMPORAL 
	DECLARE CURSOR1 CURSOR FOR
		SELECT distinct(concat('Vigencia ',a.vigencia)), 
			isnull(round((select sum(e.MPRVAL) from AUDI_ESM_PRESUP e where e.opncod='PRE_ING' and e.VIGENCIA=a.vigencia),0),0),
			isnull(round((select sum(e.MPRVAL) from AUDI_ESM_PRESUP e where e.opncod='AUT_PAG' and e.VIGENCIA=a.vigencia),0),0),
			isnull(round((select sum(e.MPRVAL) from AUDI_ESM_PRESUP e where e.opncod='PRE_ING' and e.VIGENCIA=a.vigencia),0),0)-
			isnull(round((select sum(e.MPRVAL) from AUDI_ESM_PRESUP e where e.opncod='AUT_PAG' and e.VIGENCIA=a.vigencia),0),0)
		from AUDI_ESM_PRESUP a
		group by a.VIGENCIA,a.MPRVAL

	OPEN CURSOR1
	FETCH NEXT FROM CURSOR1 INTO @CURSORDATA1, @CURSORDATA2, @CURSORDATA3, @CURSORDATA4
	WHILE @@FETCH_STATUS = 0
	BEGIN

		INSERT INTO ##TableConsolidado
			(VIGEN, VALOR_PRE, VALOR_AUTO, SALDO)
		VALUES (@CURSORDATA1, @CURSORDATA2, @CURSORDATA3, @CURSORDATA4)

		FETCH NEXT FROM CURSOR1 INTO @CURSORDATA1, @CURSORDATA2, @CURSORDATA3, @CURSORDATA4
	END
	CLOSE CURSOR1
	DEALLOCATE CURSOR1

	select @TOTAL_AMORTIZADO =sum(amortizacion) 
	from AUDI_ESM_PRESUP 

	SELECT @VAR1=SUM(VALOR_PRE),@VAR2=SUM(VALOR_AUTO),@VAR3=SUM(SALDO)
	FROM ##TableConsolidado;

	INSERT INTO ##TableConsolidado
		(VIGEN, VALOR_PRE, VALOR_AUTO, SALDO)
	VALUES ('Presupuesto Total', @VAR1, @VAR2, @VAR3)

	SELECT @NOMBRECOL NOMBRE_COLUMNA, * , @TOTAL_AMORTIZADO TOTAL
	FROM ##TableConsolidado