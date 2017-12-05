CREATE OR REPLACE PROCEDURE H3i_OBT_PERMISO_ESPECIALIDAD
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_NUME_LABO IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT CD_CODI_ESP ,
             NO_NOMB_ESP ,
             NU_INTCIT_ESP ,
             TX_CODI_EQUI_ESP ,
             ES_APOYO ,
             ES_CONSULTA ,
             ES_QUIRURGICO ,
             ES_MEDICAMENTO ,
             ES_OPTOMETRIA ,
             ES_OTROPROC 
        FROM LABORATORIO LB
               JOIN ESPECIALIDADES ESP   ON LB.CD_CODI_ESP_LABO = ESP.CD_CODI_ESP
               LEFT JOIN ESPECIALIDAD_X_ORDEN EXORD   ON ESP.CD_CODI_ESP = EXORD.CD_CODI_ESP_ESPORDEN
       WHERE  LB.NU_NUME_LABO = v_NU_NUME_LABO
        ORDER BY NO_NOMB_ESP ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_OBT_PERMISO_ESPECIALIDAD;