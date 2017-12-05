CREATE OR REPLACE PROCEDURE SP_ACOMER_FACTURA_CLIENTE
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	IN_FECHA_FACTURA IN CAB_FACTURA_GRAL.FACFECHA%TYPE,			-- FECHA QUE SE FACTURA
	IN_HORA_FACTURA IN CAB_FACTURA_GRAL.FACHORA%TYPE,				    -- HORA EN LA QUE SE FACTURA
	IN_FACTURA_GENERAL IN PKG_ACOMER_RESTAURANTES.TYPE_PEDIDOS_ARRAY,	-- NUMERO DE LA FACTURA GENERAL
	IN_CODIGO_MESERO IN INV00018.MESUSUREQ%TYPE,				-- CODIGO DEL MESERO
	OUT_FACTURA_CLIENTE OUT SYS_REFCURSOR						-- DATOS DE LA FACTURA 
)
AS
	V_NUMERO_FACTURA TAB_FACTURA_CLIENTE.FACNROCLI%TYPE;
	V_CONSEC_FACTURA TAB_FACTURA_CLIENTE.FACCONS%TYPE;
	V_CODIGO_CLIENTE VEN0104.PCLICOD%TYPE;
	V_NOMBRE_CLIENTE VEN0104.PCLINOM%TYPE;
	V_VALOR_IVA NUMBER := 0;
	V_VALOR_SUBTOTAL NUMBER := 0;
	V_VALOR_TOTAL NUMBER := 0;
BEGIN
	-- ===========================
	-- SE CALCULA EL NUMERO DE LA FACTURA 
	BEGIN
		SELECT NVL(MAX(FACNROCLI),0) + 1
		INTO V_NUMERO_FACTURA
		FROM TAB_FACTURA_CLIENTE;
	-- SI NO ENCUENTRA DATOS DEVUELVE EL PRIMER NUMERO DE LA FACTURA 
	EXCEPTION 
		WHEN NO_DATA_FOUND THEN 
			V_NUMERO_FACTURA := 1;
	END;

	-- ==========================
	-- CONSULTA EL NOMBRE Y EL CODIGO DEL CLIENTE
	BEGIN
		SELECT DISTINCT B.PCLICOD, B.PCLINOM
		INTO V_CODIGO_CLIENTE, V_NOMBRE_CLIENTE
		FROM CAB_FACTURA_GRAL A
		INNER JOIN VEN0104 B
		  ON A.FACNUMDOCGRAL = B.PEDNUMDOC
		WHERE A.FACNROGRAL = CAST(IN_FACTURA_GENERAL(1) AS NUMBER(10));
	END;	

	-- ==========================
	-- SE RECORRE EL ARRAY DE LOS CODIGOS DE LAS FACTURAS GENERALES
	FOR I IN IN_FACTURA_GENERAL.FIRST..IN_FACTURA_GENERAL.LAST
	LOOP
		-- SE CONSULTA  EL IVA EL SUBTOTAL Y EL TOTAL DE TODA LA FACTURA DEL CLIENTE
		SELECT SUM(IVA) + V_VALOR_IVA, 
			SUM(SUBTOTAL) + V_VALOR_SUBTOTAL, 
			SUM(TOTAL) +V_VALOR_TOTAL
		INTO V_VALOR_IVA, 
			V_VALOR_SUBTOTAL, 
			V_VALOR_TOTAL
		FROM CAB_FACTURA_GRAL
		WHERE FACNROGRAL = CAST(IN_FACTURA_GENERAL(I) AS NUMBER(10));
	END LOOP;	

	-- ========================
	-- SE INSERTA EN LA TABLA FACTURA CLIENTE
	FOR I IN IN_FACTURA_GENERAL.FIRST..IN_FACTURA_GENERAL.LAST
	LOOP
		-- ===========================
		-- SE CALCULA EL NUMERO CONSECUTIVO DE LA FACTURA		
		SELECT NVL(MAX(FACCONS),0) + 1
		INTO V_CONSEC_FACTURA
		FROM TAB_FACTURA_CLIENTE;
		
		

		-- 
		INSERT INTO TAB_FACTURA_CLIENTE(
			FACNROCLI, FACNROGRAL, FACCONS, 
			FACFECH, FACHORA, FACCEDCLI, 
			FACNOMCLI, FACCODMES, FACIVA, 
			FACSUBTOTAL, FACTOTAL)
		VALUES(
			V_NUMERO_FACTURA,  CAST(IN_FACTURA_GENERAL(I) AS NUMBER(10)), V_CONSEC_FACTURA,
			IN_FECHA_FACTURA, IN_HORA_FACTURA, V_CODIGO_CLIENTE,
			V_NOMBRE_CLIENTE, IN_CODIGO_MESERO, V_VALOR_IVA,
			V_VALOR_SUBTOTAL, V_VALOR_TOTAL);

		COMMIT;
	END LOOP;
		


	-- ========================
	-- CURSOR QUE RETORNA LOS DATOS DE LA FACTURA DEL CLIENTE
	OPEN OUT_FACTURA_CLIENTE FOR		
		SELECT LPAD(V_NUMERO_FACTURA,6,0) NUMERO_FAC,
		    IN_FECHA_FACTURA FECHA,
		    V_VALOR_SUBTOTAL SUBTOTAL,
		    V_VALOR_IVA IVA,
		    V_VALOR_TOTAL TOTAL
		FROM DUAL;

	/*RAISE_APPLICATION_ERROR(-20001, 'FAC NRO: '||V_NUMERO_FACTURA||' ||| '||'FAC GRAL: '||IN_FACTURA_GENERAL(0)||' ||| '||
									'CONSEC: ' ||V_CONSEC_FACTURA||' ||| '||'FECHA: '   ||IN_FECHA_FACTURA  ||' ||| '||
									'HORA: '   ||IN_HORA_FACTURA ||' ||| '||'CEDULA: '  ||V_CODIGO_CLIENTE  ||' ||| '||
									'NOMBRE: ' ||V_NOMBRE_CLIENTE||' ||| '||'MESERO: '  ||IN_CODIGO_MESERO  ||' ||| '||
									'IVA: '    ||V_VALOR_IVA     ||' ||| '||'SUBTOTAL: '||V_VALOR_SUBTOTAL  ||' ||| '||
									'TOTAL: '  ||V_VALOR_TOTAL);*/

END;