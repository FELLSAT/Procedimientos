CREATE OR REPLACE PROCEDURE H3I_SP_CONSULTA_ULTIMAS_EVOLUC
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_ATENCION_ACTUAL IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT * 
        FROM HIST_EVOLUCION 
               INNER JOIN HISTORIACLINICA    ON NU_NUME_HICL = NU_NUME_HICL_HEVO
               INNER JOIN LABORATORIO L   ON NU_NUME_LABO_HICL = L.NU_NUME_LABO
               INNER JOIN MOVI_CARGOS M   ON L.NU_NUME_MOVI_LABO = M.NU_NUME_MOVI
               INNER JOIN MEDICOS MED   ON MED.CD_CODI_MED = HIST_EVOLUCION.CD_CODI_MED_HEVO
               INNER JOIN DIAGNOSTICO D   ON D.CD_CODI_DIAG = HIST_EVOLUCION.CD_CODI_DX_HEVO
       WHERE  NU_NUME_HICL = v_ATENCION_ACTUAL ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;