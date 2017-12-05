CREATE OR REPLACE VIEW DXEGRESO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
AS 
	SELECT REGISTRO.NU_NUME_REG ,
		R_LABO_DIAG.CD_CODI_DIAG_RLAD 
	FROM REGISTRO 
	INNER JOIN R_LABO_DIAG    
		ON REGISTRO.NU_NUME_REG = R_LABO_DIAG.NU_NUME_LABO_RLAD
	WHERE (R_LABO_DIAG.ID_TIPO_DIAG_RLAD = 'SA');