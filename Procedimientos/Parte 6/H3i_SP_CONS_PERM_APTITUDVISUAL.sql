CREATE OR REPLACE PROCEDURE	H3i_SP_CONS_PERM_APTITUDVISUAL
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
 (
 	V_CODFORMATO IN NUMBER,
 	CV_1 OUT SYS_REFCURSOR
 )
					
AS
BEGIN
	OPEN CV_1 FOR
		SELECT AGUDEZA_VISUAL,
			VISION_CERCANA,
			VISION_LEJANA,
			PPC,
			BIOMICROSCOPIA,
			OFTALMOSCOPIA,
			DIAG_PRINCIPAL,
			DIAG_RELACIONADO,
			CORREC_OPTICA,
			OBSERVACIONES		
		From PERMISOS_APTITUDVISUAL 
		WHERE COD_FORMA = V_CODFORMATO;
EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
		
END;