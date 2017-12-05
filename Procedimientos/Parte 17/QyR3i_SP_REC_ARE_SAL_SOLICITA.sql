CREATE OR REPLACE PROCEDURE QyR3i_SP_REC_ARE_SAL_SOLICITA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_SOLICITUD IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT NU_NUME_SAS ,
            NU_NUME_SOL_SAS ,
            ID_IDEN_AS_SAS ,
            TX_NOMB_AS 
        FROM QYR_SOLICITUD_AREA_SALUD 
        INNER JOIN AREA_SALUD    
            ON ID_IDEN_AS_SAS = ID_IDEN_AS
        WHERE  NU_NUME_SOL_SAS = v_SOLICITUD ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;