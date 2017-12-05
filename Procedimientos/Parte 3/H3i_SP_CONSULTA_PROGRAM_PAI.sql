CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_PROGRAM_PAI
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
 	V_COD_SERVICIO_VACU IN VARCHAR2,
 	CV_1 OUT SYS_REFCURSOR
)
AS
BEGIN
 	OPEN CV_1 FOR
 		SELECT * 
 		FROM PROGM_VACUNAS 
 		WHERE COD_SERVICIO = V_COD_SERVICIO_VACU;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);

END H3i_SP_CONSULTA_PROGRAM_PAI;