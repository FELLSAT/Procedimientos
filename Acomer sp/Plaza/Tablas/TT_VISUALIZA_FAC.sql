
CREATE GLOBAL TEMPORARY TABLE TT_VISUALIZA_FAC(
	ID_CONSECUTIVO NUMBER,
	DESCRIPCION_PRODUCTO CHAR(200),
	UNIDADES_PRODUCTO NUMBER, 
	VALOR_PRODUCTO NUMBER
) ON COMMIT PRESERVE ROWS;