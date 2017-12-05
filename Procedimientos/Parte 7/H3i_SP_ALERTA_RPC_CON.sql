CREATE OR REPLACE PROCEDURE H3i_SP_ALERTA_RPC_CON
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_Plantilla IN NUMBER,
  v_IDCONCEPTO IN NUMBER,
  v_ORDEN IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT NU_NUME_PLHI_RPC_ALRP ,
             NU_NUME_COHI_RPC_ALRP ,
             NU_INDI_RPC_ALRP ,
             TX_ALERT_ALRP 
        FROM ALERTA_RPC 
       WHERE  NU_NUME_PLHI_RPC_ALRP = v_Plantilla
                AND NU_NUME_COHI_RPC_ALRP = v_IDCONCEPTO
                AND NU_INDI_RPC_ALRP = v_ORDEN ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;