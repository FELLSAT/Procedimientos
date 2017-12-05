CREATE OR REPLACE PROCEDURE H3i_SP_PREPA_MEDIC_RANGO_FECHA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_INI IN VARCHAR2,
  v_FIN IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT P.CD_PREP ,
             P.NU_NUME_HICL_HMED ,
             P.FCH_PREPARADO ,
             P.FCH_VENC_ETR_15G_20G ,
             P.FCH_VENC_8G ,
             P.FOTOSENSIBLE ,
             P.REFRIGERADO ,
             PM.CD_PREP_MEDI ,
             PM.CD_CODI_ARTI ,
             PM.NOMBRE_MEDICAMENTO ,
             PM.VOLUMEN ,
             PM.CONCENTRACION ,
             PM.NUM_LOTE_MEDICAMENTO ,
             PM.NUM_LOTE_PREPARADO ,
             PM.PREPARADO_EN ,
             PA.NO_NOMB_PAC ,
             PA.DE_PRAP_PAC ,
             PA.DE_SGAP_PAC ,
             PA.TX_NOMBRECOMPLETO_PAC ,
             PA.NU_TIPD_PAC ,
             PA.NU_DOCU_PAC ,
             E.NO_NOMB_EPS 
        FROM PREPARADO_MEDICAMENTO PM
               INNER JOIN PREPARADO P   ON PM.NU_NUME_HICL_HMED = P.NU_NUME_HICL_HMED
               INNER JOIN HISTORIACLINICA HC   ON HC.NU_NUME_HICL = P.NU_NUME_HICL_HMED
               INNER JOIN LABORATORIO L   ON L.NU_NUME_LABO = HC.NU_NUME_LABO_HICL
               INNER JOIN MOVI_CARGOS MG   ON L.NU_NUME_MOVI_LABO = MG.NU_NUME_MOVI
               INNER JOIN PACIENTES PA   ON PA.NU_HIST_PAC = MG.NU_HIST_PAC_MOVI
               INNER JOIN CONVENIOS C   ON C.NU_NUME_CONV = MG.NU_NUME_CONV_MOVI
               INNER JOIN EPS E   ON C.CD_NIT_EPS_CONV = E.CD_NIT_EPS
       WHERE  FCH_PREPARADO <= v_FIN
                AND FCH_PREPARADO >= v_INI
        ORDER BY P.NU_NUME_HICL_HMED ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;