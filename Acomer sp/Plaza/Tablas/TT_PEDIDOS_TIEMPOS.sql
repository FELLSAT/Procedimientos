CREATE GLOBAL TEMPORARY TABLE TT_PEDIDOS_TIEMPOS(
	CONSECUTIVO NUMBER,
	PLATO VARCHAR2(200),
	MESA NUMBER,
	FECHA CHAR(10),
	HORA CHAR(8),
	EMPRESA CHAR(13),
	TIEMPO NUMBER,
	TIEMPOACUMU NUMBER DEFAULT 0
) ON COMMIT PRESERVE ROWS;
