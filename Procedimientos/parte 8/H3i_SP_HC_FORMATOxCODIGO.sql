CREATE OR REPLACE PROCEDURE H3i_SP_HC_FORMATOxCODIGO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_NUME_PLHI IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT DISTINCT CD_NOMB_FIN ,
                      CD_CODI_FIN ,
                      NU_NUME_PLHI ,
                      NU_SERV_PLHI ,
                      NU_AUTO_ENPL_PLHI ,
                      NU_PERMADJARCHIVO_PLHI 
        FROM PLANTILLA_HIST ,
             R_PLANTILLA_HIST ,
             FINALIDAD_HIST ,
             R_ESPE_PLHI 
       WHERE  NU_NUME_PLHI = NU_NUME_PLHI_R
                AND NU_FINA_PLHI = CD_CODI_FIN
                AND NU_NUME_PLHI = NU_PLHI
                AND NU_ESTA_PLHI = 1
                AND NU_NUME_PLHI = v_NU_NUME_PLHI
        ORDER BY NU_SERV_PLHI DESC,
                 CD_NOMB_FIN ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;