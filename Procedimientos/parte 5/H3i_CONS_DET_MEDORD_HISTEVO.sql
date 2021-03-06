CREATE OR REPLACE PROCEDURE H3i_CONS_DET_MEDORD_HISTEVO /*PROCEDIMIENTO ALMACENADO PARA CONSULTAR LAS ORDENES MÉDICAS (DETALLES) 	ASOCIADAS A UNA HICL O EVOLUCIÓN*/
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NUMHICL IN NUMBER,
  v_NUMHEVO IN NUMBER DEFAULT 0 ,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT HM.CD_CODI_ARTI_HMED ,
             UPPER(HM.NO_NOMB_ARTI_HMED) NO_NOMB_ARTI ,
               CASE 
                    WHEN HM.NU_AUTO_NOPM_HMED = 0 THEN 0
               ELSE 1
                  END NU_NOPOS_SER,
             TO_NUMBER(0,1.0) NU_NUME_IND_SER  ,
             HM.NU_CANT_HMED ,
             TO_DATE(TO_CHAR(HM.FE_FECH_FORM_HMED,'DD/MM/YYYY')) FE_FECH_FORM_HMED  ,
             HM.NU_POSI_HMED ,
             NVL(HM.NU_NUME_FORM_HMED, 0) NU_NUME_FORM_HMED  ,
             TO_NUMBER(HM.NU_NUME_HMED,18) NU_NUME_HMED  ,
             HM.DE_DOSIS_HMED ,
             HM.DE_FREC_ADMIN_HMED ,
             HM.NU_UNFRE_HMED ,
             HM.DE_CTRA_HMED ,
             HM.DE_VIA_ADMIN_HMED ,
             HM.TX_OBSERV_HED ,
             HM.NU_NUME_DUR_TRAT_HMED ,
             HM.DE_UNME_HMED ,
             TO_NUMBER(HM.NU_TIPO_HMED,10.0) NU_TIPO_HMED,
             HM.NU_ORDE_HMED 
        FROM HIST_MEDI HM
               JOIN HISTORIACLINICA H   ON HM.NU_NUME_HICL_HMED = H.NU_NUME_HICL
               JOIN LABORATORIO L   ON L.NU_NUME_LABO = H.NU_NUME_LABO_HICL
               JOIN MOVI_CARGOS M   ON M.NU_NUME_MOVI = L.NU_NUME_MOVI_LABO
       WHERE  NU_ESTA_MOVI <> 2
                AND NU_ESTA_LABO <> 2
                AND HM.NU_NUME_HICL_HMED = v_NUMHICL
                AND HM.NU_NUME_HEVO_HMED = v_NUMHEVO ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;