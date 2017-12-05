CREATE OR REPLACE PROCEDURE SP_ACOMER_UNION_MESAS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	IN_MESA IN DETMESA.MESCOD%TYPE,			  -- CODIGO DE LA MESA
	IN_PUESTOS IN DETMESA.PUESTOS%TYPE, 	  -- CANTIDAD DE PUESTOS QUE SE VAN A USA 	
	IN_MESAS_ARRAY IN OUT PKG_ACOMER_RESTAURANTES.TYPE_PEDIDOS_ARRAY  -- MESAS QUE SE UNEN
)
AS
	V_MESAS_UNIDAS VARCHAR2(10) := '';
BEGIN
	-- SE ACTUALIZA LA TABLA QUE TIENE LA MESAS QUE SE UNIERON
	FOR I IN IN_MESAS_ARRAY.FIRST..IN_MESAS_ARRAY.LAST
	LOOP
		INSERT INTO UNIONMESA (MESCOD, MESCODUNI)
		VALUES(IN_MESA, TO_NUMBER(IN_MESAS_ARRAY(I)));
		--
		UPDATE DETMESA
		SET PUESTOS = IN_PUESTOS
		WHERE MESCOD = IN_MESAS_ARRAY(I);
	END LOOP;

	-- ACTUALIZA LA CANTIDAD DE PUESTOS SELECCIONADOSEN LA MESA
	UPDATE DETMESA
	SET PUESTOS = IN_PUESTOS
	WHERE MESCOD = IN_MESA;
END;
