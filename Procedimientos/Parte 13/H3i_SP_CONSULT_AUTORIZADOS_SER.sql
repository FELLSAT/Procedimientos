CREATE OR REPLACE PROCEDURE H3i_SP_CONSULT_AUTORIZADOS_SER
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    V_NU_HIST_PAC_SOSE IN VARCHAR2,
    CV_1 OUT SYS_REFCURSOR
)

AS
BEGIN
    OPEN CV_1 FOR
        SELECT NU_AUTO_AUSE,
            TX_AUTORI_AUSE,
            TX_PESO_AUSE,
            TX_PEAU_AUSE,
            TX_OBSE_AUSE,
            NU_VIGE_AUSE,
            FE_FECH_AUSE,
            NU_AUTO_SOSE_AUSE,
            CD_REFE_AUSE,
            CD_SERV_SOSE,
            DE_SERV_SOSE
        FROM AUTORIZACION_SERVICIOS A_S 
        INNER JOIN solicitud_servicios SS 
            ON A_S.NU_AUTO_SOSE_AUSE = SS.NU_AUTO_SOSE
        WHERE SS.NU_HIST_PAC_SOSE = V_NU_HIST_PAC_SOSE;


EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;