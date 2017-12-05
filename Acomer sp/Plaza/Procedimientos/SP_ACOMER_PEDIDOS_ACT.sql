CREATE OR REPLACE PROCEDURE SP_ACOMER_PEDIDOS_ACT
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	IN_CODIGO_PRODUCTO IN VEN0001.PROCOD%TYPE, -- CODIGO DEL ITEM QUE SE ADICIONARA
	IN_CODIGO_PEDIDO IN VEN0104.PEDNRO%TYPE,   -- CODIGO DEL PEDIDO QUE YA TIENE EN LA MESA
	IN_CODIGO_PUESTO IN VEN0004.CCOCOD%TYPE,   -- PUESTO DESDE DONDE SE ESTA PIDIENDO
	IN_CANTIDAD IN VEN0004.PEDUNI%TYPE		   -- CANTIDD DEL PRODUCTO QUE SE ESTA PIDIENDO 
)
AS
	V_CANTIDAD VEN0004.PEDUNI%TYPE;   			-- CANTIDAD TOTAL CON LO PEDIDO Y LO QUE SE VA A PEDIR
	V_VALOR_ITEM_IVA VEN0004.PEDVALIVA%TYPE;	-- VALOR DEL ITEM CON IVA
	V_CODIGO_RESTAURANTE VEN0004.PEDEMPC%TYPE;	-- CODIGO DEL RESTAURANTE
	V_CODIGO_PAIS VEN0004.PEDPAIC%TYPE;			-- CODIGO DEL PAIS 
	V_VALDESC VEN0004.peddcval%TYPE;			-- peddcval
	V_RFPORDTO VEN0001.RFPORDTO%TYPE;			-- RFPORDTO 
	V_PRECIO_ITEM VEN0004.PEDVALIVA%TYPE;		-- VALOR DEL ITEM CON IVA
	V_PEDIDOS_FALTANTES VEN0004.PEDCHECK%TYPE;	-- TOTAL DE PEDIDOS ENTREGADOS 
BEGIN
-- CONSULTA LA CANTDAD ACTUAL QUE HAY PEDIDO DEL 
	SELECT PEDUNI + IN_CANTIDAD
	INTO V_CANTIDAD
	FROM VEN0004
	WHERE CCOCOD = IN_CODIGO_PUESTO
		AND PEDNRO = IN_CODIGO_PEDIDO
		AND PEDPROCOD = IN_CODIGO_PRODUCTO;

	-- CONSULTAMOS EL VALOR DEL ITEM CON IVA INCLUIDO
	SELECT PEDVALIVA * V_CANTIDAD, PEDVALIVA
	INTO V_VALOR_ITEM_IVA, V_PRECIO_ITEM
	FROM VEN0004
	WHERE CCOCOD = IN_CODIGO_PUESTO
		AND PEDNRO = IN_CODIGO_PEDIDO
		AND PEDPROCOD = IN_CODIGO_PRODUCTO;

	--CONSULTA EL CODIGO DEL RESTAURANTE
	SELECT PEDEMPC, PEDPAIC
	INTO V_CODIGO_RESTAURANTE, V_CODIGO_PAIS 
	FROM VEN0004
	WHERE CCOCOD = IN_CODIGO_PUESTO
		AND PEDNRO = IN_CODIGO_PEDIDO
		AND PEDPROCOD = IN_CODIGO_PRODUCTO;

	--
	SELECT RFPORDTO
	INTO V_RFPORDTO
	FROM VEN0001
	WHERE VEN0001.VENEMPPAI = V_CODIGO_PAIS
		AND VEN0001.VENEMPC = V_CODIGO_RESTAURANTE
		AND VEN0001.PROCOD = IN_CODIGO_PRODUCTO;

	--
	IF(V_RFPORDTO > 0) THEN
		BEGIN
			V_VALDESC := (V_PRECIO_ITEM * V_CANTIDAD * V_RFPORDTO) / 100;
		END;
	ELSE
		BEGIN
			V_RFPORDTO := 0;
			V_VALDESC := 0;
		END;
	END IF;

	-- CONSULTO LOS PEDIDOS YA ENTREGADOS 
	SELECT PEDCHECK - IN_CANTIDAD
	INTO V_PEDIDOS_FALTANTES
	FROM VEN0004
	WHERE CCOCOD = IN_CODIGO_PUESTO
		AND PEDNRO = IN_CODIGO_PEDIDO
		AND PEDPROCOD = IN_CODIGO_PRODUCTO;

-- ==============================================
-- ACTUALIZA EL DETALLE DEL PEDIDO 
	UPDATE VEN0004
	SET PEDUNI = V_CANTIDAD,
		PEDVALTUN = V_VALOR_ITEM_IVA,
		PEDPORDC = V_RFPORDTO,
		PEDDCVAL = V_VALDESC,
		PEDSAL = 'N',
		PEDCHECK = V_PEDIDOS_FALTANTES
	WHERE PEDPROCOD = IN_CODIGO_PRODUCTO
		AND PEDNRO = IN_CODIGO_PEDIDO
		AND CCOCOD = IN_CODIGO_PUESTO;
END;