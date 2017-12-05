CREATE OR REPLACE PROCEDURE SP_AUTOGES_MENUITEM_PREDETERM
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	V_IN_ROL_EPL IN VARCHAR2,
	V_OUT_MENU OUT SYS_REFCURSOR
)
AS
	ITEM_MENU NUMBER;				 -- DATOS DEVUELTOS EN EL CURSOR
	CURSOR CURSOR_MENU_COD IS 		 -- CODIGOS DE TODOS LOS MENUS EXISTENTES
		SELECT COD_MENU
		FROM T_MENU;
	CURSOR CURSOR_MENU IS 		     -- CURSOR CONSULTA ITEM DE MENU ASIGNADOS AL ROL ESPECIAL
		SELECT DISTINCT TSM.COD_MENU MENU
		FROM T_SUB_MENU TSM
		INNER JOIN T_RELACION_MENU_ROL TRMR
		    ON TSM.COD_SUB_MENU = TRMR.COD_SUB_MENU  
		INNER JOIN T_ROLES TR
            ON TR.COD_ROL = TRMR.COD_ROL
		    AND TR.TIPO_ROL = V_IN_ROL_EPL;
BEGIN
	DELETE FROM TT_MENU;
	-- INSERTO TODOS LOS MENUS EN FALSO
	OPEN CURSOR_MENU_COD;
	
	LOOP
		FETCH CURSOR_MENU_COD INTO ITEM_MENU;
		EXIT WHEN CURSOR_MENU_COD%NOTFOUND;		

		INSERT INTO TT_MENU VALUES(ITEM_MENU,'FALSE');
	END LOOP;

	CLOSE CURSOR_MENU_COD;

	-- ACTUALIZO LOS MENUS QUE ESTAN ASIGNADOS AL ROL EN VERDADERO
	OPEN CURSOR_MENU;	

	LOOP
		FETCH CURSOR_MENU INTO ITEM_MENU;
		EXIT WHEN CURSOR_MENU%NOTFOUND;

		UPDATE TT_MENU 
		SET VALOR = 'TRUE'
		WHERE MENU = ITEM_MENU;		
	END LOOP;

	CLOSE CURSOR_MENU;

	-- CONSULTO LOS DATOS EN LA TABLA TEMPORAL ASIGNANDOLOS EN LA VARIABLE DE SALIDA
	OPEN V_OUT_MENU FOR
		SELECT TTM.MENU,TM.NOM_MENU,TTM.VALOR
		FROM T_MENU TM
		INNER JOIN TT_MENU TTM
			ON TTM.MENU = TM.COD_MENU;
END;



