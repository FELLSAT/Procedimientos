CREATE OR REPLACE PROCEDURE H3i_SP_CONS_REPUESTA_DESPACHO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_DOCU_PAC IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT RME.CD_CODI_REQU_RMED ,
            HCO.MENSAJE_RESPUESTA ,
            HCO.FECHA_RESPUESTA 
        FROM REQUISICION_MED RME
        INNER JOIN R_RMED_SMED RRS   
            ON RRS.CD_CODI_REQU_RMED_RRS = RME.CD_CODI_REQU_RMED
        INNER JOIN SOLICITUD_MED SME   
            ON RRS.NU_NUME_SOLI_SMED_RRS = SME.NU_NUME_SOLI_SMED
        INNER JOIN HL7_CONTROL HCO   
            ON HCO.CD_CODI_REQU_RMED = RME.CD_CODI_REQU_RMED
        WHERE  HCO.RETORNA_RESPUESTA = 1
            AND HCO.FECHA_RESPUESTA IS NOT NULL
            AND HCO.MENSAJE_RESPUESTA IS NOT NULL
            AND SME.NU_DOCU_PAC_SMED = v_NU_DOCU_PAC
            AND HCO.IDENTITY_MESSAGE = 'ORM-O01'
            AND HCO.RESPUESTA_PROCESADA = 0
        GROUP BY RME.CD_CODI_REQU_RMED,RME.CD_CODI_CECO_RMED,RME.FE_FECH_REQU_RMED,HCO.MENSAJE_RESPUESTA,HCO.FECHA_RESPUESTA ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;