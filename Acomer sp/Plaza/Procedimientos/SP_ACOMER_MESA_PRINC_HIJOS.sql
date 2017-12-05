CREATE OR REPLACE PROCEDURE SP_ACOMER_MESA_PRINC_HIJOS
(
	IN_CODIGO_MESA IN VEN0104.MESCOD%TYPE, -- CODIGO DE LA MESA QUE HA HECHO PEDIDO
	OUT_MESAS OUT VARCHAR2				   -- MESAS QUE ESTAN UNIDAS EN EL PEDIDO
)
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
AS
	V_MESA_PRINCIPAL UNIONMESA.MESCOD%TYPE;
	V_MESA_SECUNDARIA UNIONMESA.MESCODUNI%TYPE;
	V_CADENA_MESAS VARCHAR2(200);
	-- CONSULTA LAS MESAS QUE ESTAN UNIDAS 
	CURSOR CURSOR1 (CUR_MESA_PRINCIPAL NUMBER) IS 
		SELECT DISTINCT MESCODUNI
		FROM UNIONMESA
		WHERE MESCOD = CUR_MESA_PRINCIPAL;
BEGIN
	-- CONSULTA CON EL CODIGO DE LA MESA CUAL ES LA PRINCIPAL 
	SELECT DISTINCT MESCOD
	INTO V_MESA_PRINCIPAL
	FROM UNIONMESA
	WHERE MESCOD = IN_CODIGO_MESA
		OR MESCODUNI = IN_CODIGO_MESA;

	-- ABRE EL CURSOR
	OPEN CURSOR1 (V_MESA_PRINCIPAL);
	-- RECORRE EL CURSOR
	LOOP
		FETCH CURSOR1 INTO V_MESA_SECUNDARIA;
		-- SALE DEL CICLO CUANDO NO ENCUENTRE NINGUN DATO  EN EL CURSOR
		EXIT WHEN CURSOR1%NOTFOUND;
		
		--LLENO CON LOS CODIGOS DE LAS MESAS QUE ESTAN UNIDAS \
		V_CADENA_MESAS := V_CADENA_MESAS || V_MESA_SECUNDARIA || '_*';		
	END LOOP;
	-- CIERRA EL CURSRO
	CLOSE CURSOR1;
	--QUITA EL ULTIMA *_
	V_CADENA_MESAS =: SUBSTR(V_CADENA_MESAS, 0,LENGTH(V_CADENA_MESAS)-2);
	-- CONCATENA LOS CODIGOS DE LAS MESAS CON LA PRINCIPAL 
	V_CADENA_MESAS := TO_CHAR(V_MESA_PRINCIPAL) || '_*' || V_CADENA_MESAS;
	-- ASIGNA EL RESULTADO A LA VARIABLE DE SALIDA
	OUT_MESAS := V_CADENA_MESAS;
END;