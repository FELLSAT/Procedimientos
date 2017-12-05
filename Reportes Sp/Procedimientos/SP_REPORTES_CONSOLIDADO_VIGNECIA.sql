CREATE PROCEDURE SP_REPORTES_CONSOLIDADO_VIGNECIA
(	
	@IN_FECHA_INI DATE,
	@IN_FECHA_FIN DATE,
	@IN_MODALIDAD VARCHAR(30),
	@IN_FUERZA VARCHAR(100),
	@IN_VIGENCIA INT
)
AS 	
	SET NOCOUNT ON

	--
	DECLARE @SALDO_EJECUTAR NVARCHAR(MAX);
	DECLARE @PROYECCION NVARCHAR(MAX);
	DECLARE @NUMEROMESES NVARCHAR(10);

	-- EJECUTA EL PROCEDIMIENTO PARA EL LLENADO DE LA TABLA TablaReporte1
	EXEC SP_REPORTE2 @IN_CODIGO_OPN = 'AUT_PAG', @IN_FECHA_INI = @IN_FECHA_INI , @IN_FECHA_FIN = @IN_FECHA_FIN 

	-- NOMBRE DE LAS COLUMNAS DE LA TABLA TablaReporte1 
	DECLARE @COLUMNS_TEMP1 NVARCHAR(MAX);
	DECLARE @NOMBRES_TEMP1 NVARCHAR(MAX);
	EXECUTE SP_NOMBRE_TABLAS
		N'##TablaReporte1', @OUT_CADENA = @COLUMNS_TEMP1 OUTPUT, @OUT_NOMBRE = @NOMBRES_TEMP1 OUTPUT;

	-- DATOS DE ENTRADA	
	DECLARE @RED_ING VARCHAR(15) = 'RED_ING';
	DECLARE @PRE_ING VARCHAR(15) = 'PRE_ING';
	DECLARE @ADI_ING VARCHAR(15) = 'ADI_ING';
	DECLARE @MENSAJEERROR VARCHAR(15) = 'Sin proyeccion';
	DECLARE @MENSAJEMES VARCHAR(13) = ' meses'

	-- SALDO POR EJECUTAR
	SET @SALDO_EJECUTAR = REPLACE(@NOMBRES_TEMP1,'*_','+');
	SET @SALDO_EJECUTAR = SUBSTRING(@SALDO_EJECUTAR,1,LEN(@SALDO_EJECUTAR)-1);
	SET @SALDO_EJECUTAR = CONCAT('PRESU_DEFI - (', @SALDO_EJECUTAR, ') AS SALDO_EJEC');

	-- NUMERO DE MESES
	SET @NUMEROMESES = (select (len(@NOMBRES_TEMP1) - len(replace(@NOMBRES_TEMP1, '*_', ''))) / len('*_')) ;

	-- PROYECCION
	SET @PROYECCION = REPLACE(@NOMBRES_TEMP1,'*_','+');
	SET @PROYECCION = SUBSTRING(@PROYECCION,1,LEN(@PROYECCION)-1);
	SET @PROYECCION = CONCAT( 'CASE WHEN((', @PROYECCION, ') = 0) THEN @MENSAJEERROR ELSE CAST(ROUND((PRESU_DEFI - (', @PROYECCION,'))/((', @PROYECCION, ')/', @NUMEROMESES, '),0,1) AS VARCHAR)+@MENSAJEMES END AS PROYECCION')

	SET @NOMBRES_TEMP1 = CONCAT('RUBRO*_DESCRIPCION*_PRESU_INI*_ADICIONES*_REDUCCION*_PRESU_DEFI*_', @NOMBRES_TEMP1, 'SALDO_EJEC');

	-- CONSULTA CONSOLIDADO VIGENCIA
	 DECLARE @QUERY NVARCHAR(MAX);
	 DECLARE @PARAMS NVARCHAR(MAX);

	  SET @QUERY = 
			N'SELECT *, '+@SALDO_EJECUTAR+', '+@PROYECCION+'
			  FROM(
			  	  SELECT @NOMBRES_TEMP1 AS NOMBRES_COLUMNAS,
	      		 	--AE.CODI_ESM, AE.TX_FUERZA, 
	     			AE.NOM_ESM AS RUBRO, AM.NOMBRE_MODALIDAD AS DESCRIPCION, 
	     			ROUND(AE.MPRVAL,0) AS PRESU_INI,
	    			ISNULL((
	         			 SELECT SUM(E.MPRVAL) 
				         FROM AUDI_ESM E 
				         WHERE E.VIGENCIA=@IN_VIGENCIA 
				           AND E.OPNCOD=@ADI_ING 
				           AND E.CODI_ESM = AE.CODI_ESM),0) AS ADICIONES,
				    ISNULL((
				         SELECT SUM(E.MPRVAL) 
				         FROM AUDI_ESM E 
				         WHERE E.VIGENCIA=@IN_VIGENCIA 
				           AND E.OPNCOD=@RED_ING 
				           AND E.CODI_ESM = AE.CODI_ESM),0) AS REDUCCION,
				    ISNULL(
				         ISNULL((SELECT SUM(E.MPRVAL) 
				         FROM AUDI_ESM E 
				         WHERE E.VIGENCIA=@IN_VIGENCIA 
				           AND E.OPNCOD=@PRE_ING
				           AND E.CODI_ESM = AE.CODI_ESM),0)+
				         ISNULL((SELECT SUM(E.MPRVAL) 
				         FROM AUDI_ESM E 
				         WHERE E.VIGENCIA=@IN_VIGENCIA 
				           AND E.OPNCOD=@ADI_ING
				           AND E.CODI_ESM = AE.CODI_ESM),0)-
				         ISNULL((SELECT SUM(E.MPRVAL) 
				         FROM AUDI_ESM E 
				         WHERE E.VIGENCIA=@IN_VIGENCIA 
				           AND E.OPNCOD=@RED_ING
				           AND E.CODI_ESM = AE.CODI_ESM),0),ROUND(ae.MPRVAL,0)) AS PRESU_DEFI,'+
				       @COLUMNS_TEMP1+
			   	 'FROM AUDI_ESM AE, AUDI_MODALIDAD AM
			      WHERE AE.MPRFEC BETWEEN @IN_FECHA_INI AND @IN_FECHA_FIN
			     	 AND AE.OPNCOD =@PRE_ING
			         AND AE.TX_MODALIDAD=@IN_MODALIDAD
			     	 AND AE.TX_FUERZA=@IN_FUERZA
			     	 AND AE.TX_MODALIDAD = AM.CODIGO_MODALIDAD
			  ) GENERAL';

	SET @PARAMS = 
		N'@NOMBRES_TEMP1 NVARCHAR(MAX),
		  @ADI_ING VARCHAR(15),
		  @RED_ING VARCHAR(15),
		  @PRE_ING VARCHAR(15),
		  @IN_FECHA_INI DATE,
		  @IN_FECHA_FIN DATE,
		  @IN_MODALIDAD VARCHAR(30),
		  @IN_FUERZA VARCHAR(100),
		  @IN_VIGENCIA INT,
		  @MENSAJEERROR VARCHAR(15),
		  @MENSAJEMES VARCHAR(15)';

	EXECUTE sp_executesql @QUERY, @PARAMS, @NOMBRES_TEMP1 = @NOMBRES_TEMP1, @ADI_ING = @ADI_ING, @RED_ING = @RED_ING, @PRE_ING = @PRE_ING,
						  @IN_FECHA_INI =  @IN_FECHA_INI, @IN_FECHA_FIN = @IN_FECHA_FIN, @IN_MODALIDAD = @IN_MODALIDAD,
						  @IN_FUERZA = @IN_FUERZA, @IN_VIGENCIA = @IN_VIGENCIA, @MENSAJEERROR = @MENSAJEERROR,
						  @MENSAJEMES = @MENSAJEMES;


	
	
GO

















BEGIN 
	DECLARE @RESULT VARCHAR(MAX); 	
	EXECUTE SP_NOMBRE_TABLAS
		N'##TablaReporte1', @OUT_CADENA = @RESULT OUTPUT;

	PRINT @RESULT;
END