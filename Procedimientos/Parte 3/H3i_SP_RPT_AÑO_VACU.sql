CREATE OR REPLACE PROCEDURE H3i_SP_RPT_ANO_VACU
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT TO_CHAR(VACUNACION.FE_FECH_VACU, 'YYYY') AS ANO  
        FROM PACIENTES PACIENTES
               JOIN VACUNACION    ON PACIENTES.NU_HIST_PAC = VACUNACION.NU_HIST_PAC_VACU
               JOIN MOVI_CARGOS    ON VACUNACION.NU_NUME_MOVI_VACU = MOVI_CARGOS.NU_NUME_MOVI
               JOIN TIPOUSUARIO    ON MOVI_CARGOS.CD_REGIMEN_MOVI = TIPOUSUARIO.ID_CODI_TIUS
             --INNER JOIN BARRIO ON BARRIO.CD_CODI_BAR = PACIENTES.CD_CODI_BAR_PAC 

               JOIN SERVICIOS    ON VACUNACION.CD_CODI_SERV_VACU = SERVICIOS.CD_CODI_SER
        ORDER BY ANO;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_RPT_ANO_VACU;