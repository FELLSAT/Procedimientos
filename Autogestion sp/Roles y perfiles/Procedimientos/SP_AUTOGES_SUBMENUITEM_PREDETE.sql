CREATE OR REPLACE PROCEDURE SP_AUTOGES_SUBMENUITEM_PREDETE
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	V_IN_ROL_EPL IN VARCHAR2,
	V_OUT_SUBMENU OUT SYS_REFCURSOR
)
AS
	ITEM_MENU NUMBER;				 -- DATOS DEVUELTOS EN EL CURSOR
	CURSOR CURSOR_SUBMENU_COD IS 		 -- CODIGOS DE TODOS LOS MENUS EXISTENTES
		SELECT COD_SUB_MENU 
		FROM T_SUB_MENU;   
	CURSOR CURSOR_SUBMENU IS		 -- CURSOR CONSULTA ITEM DE SUBMENU ASIGNADOS AL ROL ESPECIAL
		SELECT TSM.COD_SUB_MENU
		FROM T_SUB_MENU TSM 	
		INNER JOIN T_RELACION_MENU_ROL TRMR
		    ON TSM.COD_SUB_MENU = TRMR.COD_SUB_MENU  
		INNER JOIN T_ROLES TR
            ON TR.COD_ROL = TRMR.COD_ROL
            AND TR.TIPO_ROL = V_IN_ROL_EPL;
BEGIN
	DELETE FROM TT_SUBMENU;
	-- INSERTO TODOS LOS MENUS EN FALSO
	OPEN CURSOR_SUBMENU_COD;
	
	LOOP
		FETCH CURSOR_SUBMENU_COD INTO ITEM_MENU;
		EXIT WHEN CURSOR_SUBMENU_COD%NOTFOUND;		

		INSERT INTO TT_SUBMENU VALUES(ITEM_MENU,'FALSE');
	END LOOP;

	CLOSE CURSOR_SUBMENU_COD;

	-- ACTUALIZO LOS SUBMENUS QUE ESTAN ASIGNADOS AL ROL EN VERDADERO
	OPEN CURSOR_SUBMENU;	

	LOOP
		FETCH CURSOR_SUBMENU INTO ITEM_MENU;
		EXIT WHEN CURSOR_SUBMENU%NOTFOUND;

		UPDATE TT_SUBMENU 
		SET VALOR = 'TRUE'
		WHERE SUBMENU = ITEM_MENU;		
	END LOOP;

	CLOSE CURSOR_SUBMENU;

	OPEN V_OUT_SUBMENU FOR
		SELECT TTS.SUBMENU,TSM.NOM_SUB_MENU,TTS.VALOR
		FROM T_SUB_MENU TSM
		INNER JOIN TT_SUBMENU TTS
			ON TTS.SUBMENU = TSM.COD_SUB_MENU;	
END;