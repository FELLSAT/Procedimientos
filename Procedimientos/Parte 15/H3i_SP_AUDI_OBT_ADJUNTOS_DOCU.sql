CREATE OR REPLACE PROCEDURE H3i_SP_AUDI_OBT_ADJUNTOS_DOCU
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
		V_DOC_TIPO_CONSEC IN VARCHAR2,
		CV_1 OUT SYS_REFCURSOR
)

AS
BEGIN
	
	OPEN CV_1 FOR
		SELECT NOMBRE_ADJUNTO
		FROM AUDITAR_DOCUS_ADJUNTOS
		WHERE DOCUMENTO_TIPO_CONSEC_ADA = V_DOC_TIPO_CONSEC
		ORDER BY AUTO_ADJ_DOC_ADA;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;