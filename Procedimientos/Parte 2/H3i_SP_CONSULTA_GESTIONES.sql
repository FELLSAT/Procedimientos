CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_GESTIONES
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- ============================================= 

(
  v_HISTORIA IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT NU_HIST_PAC_GESA ,
             TX_NOMBRECOMPLETO_PAC ,
             NU_NUME_GESA ,
             FE_FERE_GESA ,
             CD_CODI_TIAC_GESA ,
             TX_DETA_GESA ,
             CD_CODI_ACAS_GESA ,
             TX_DEAS_GESA ,
             CASE CD_ESTA_GESA
                              WHEN 0 THEN 'Anulada'
                              WHEN 1 THEN 'En proceso'
                              WHEN 2 THEN 'Cerrada'   END CD_ESTA_GESA  ,
             NU_NUME_CONE_GESA ,
             USUARIO ,
             NVL(TX_NOMB_PA, ' ') TX_NOMB_PA  
        FROM GESTION_SALUD G
               JOIN PACIENTES P   ON P.NU_HIST_PAC = G.NU_HIST_PAC_GESA
               LEFT JOIN PACIENTES_ANEXO_UNAL PU   ON PU.NU_HIST_PAC_PAU = NU_HIST_PAC_GESA
               LEFT JOIN CONEXIONES C   ON G.NU_NUME_CONE_GESA = C.NU_NUME_CONE
               LEFT JOIN PROGRAMA_ACADEMICO PA   ON PA.CD_CODI_PA = PU.CD_CODI_PA_PAU
       WHERE  NU_HIST_PAC_GESA = v_HISTORIA
                AND CD_ESTA_GESA = 1 ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_CONSULTA_GESTIONES;