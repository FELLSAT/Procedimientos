CREATE OR REPLACE PROCEDURE SP_ACOMER_CONSULTA_ROL
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	IN_CEDULA IN TAB_REL_ROL.TERCOD%TYPE, -- CODIGO DE QUIEN INICIA SESION
	OUT_PERFIL OUT VARCHAR2				  -- PERFIL QUE POSEE QUIEN INICIA SESION
)
AS
BEGIN
-- CONSULTA EL ROL DE QUIEN INGRESA
	SELECT NOMBREROL
	INTO OUT_PERFIL
	FROM TAB_REL_ROL A
	INNER JOIN TAB_ROLES B
		ON A.IDROL = B.IDROL
	WHERE TERCOD = IN_CEDULA;
END;