CREATE OR REPLACE PROCEDURE SP_AUTOGES_DETALLE_ROLESPECIAL
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	V_OUT_ROLES_SUBMENUS OUT SYS_REFCURSOR
)
AS 
BEGIN
	OPEN V_OUT_ROLES_SUBMENUS FOR
		SELECT TRE.COD_ROL_ESPECIAL COD_ROL, TRE.NOM_ROL_ESPECIAL NOM_ROL, 
		    TSM.COD_SUB_MENU CODIGO_SUBMENU, TSM.NOM_SUB_MENU NM_SUBMENU  
		FROM T_SUB_MENU TSM
		INNER JOIN T_REL_SUBMENU_ESPECIAL TRSE
		    ON TRSE.T_SUB_MENU = TSM.COD_SUB_MENU
		INNER JOIN T_ROL_ESPECIAL TRE
		    ON TRE.COD_ROL_ESPECIAL = TRSE.COD_ROL_ESPECIAL
		ORDER BY TRE.NOM_ROL_ESPECIAL,TSM.COD_SUB_MENU;
END;