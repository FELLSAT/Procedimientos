CREATE OR REPLACE PROCEDURE SP_ACOMER_HISTORIAL_COCINA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	IN_CODIGO_COCINERO IN GEN0011.TERCOD%TYPE, -- CODIGO DEL COCINERO QUE TERMINA EL PEDIDO
	IN_PLATO IN VEN0001.PRODES%TYPE,		   -- CODIGO DEL PLATO QUE TERMINA
	IN_CANTIDAD	IN VEN0004.PEDUNI%TYPE		   -- CANTIDAD DEL PLATO QUE HA TERMINADO 
)
AS
	V_CODIGO_PLATO VEN0001.PROCOD%TYPE;			-- CODIGO DEL PLATO
	V_CODIGO_EMPRESA SEG00011.USUEMPC%TYPE;		-- EMPRESA A LA QUE PERTENECE EL COCINERO
BEGIN
	-- ============================
	-- CONSULTA EL CODIGO DEL PLATO 
	SELECT PROCOD
	INTO V_CODIGO_PLATO
	FROM VEN0001
	WHERE PRODES = IN_PLATO;

	-- ============================
	-- CONSULTA EL CODIGO DE LA EMPRESA A LA Q PERTENECE EL 
	SELECT VENEMPC
	INTO V_CODIGO_EMPRESA
	FROM VEN0001
	WHERE PRODES = IN_PLATO;

	-- ============================
	-- CONSULTA EL CODIGO DEL PLATO 
	INSERT INTO HISTCOCINA (
		CODCOCI, EMPRESA,
		PLATO, CANTIDAD,
		FECHA, HORAFIN,
		ESTADO)
	VALUES(
		IN_CODIGO_COCINERO, V_CODIGO_EMPRESA,
		V_CODIGO_PLATO, IN_CANTIDAD,
		TO_CHAR(SYSDATE,'DD/MM/YYYY'), TO_CHAR(SYSDATE,'HH24:MI:SS'),
		'T');
END;