CREATE OR REPLACE PROCEDURE H3i_SP_CON_PROPIGRA_CyD
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_PLANTILLA IN NUMBER,
  v_IDCONCEPTO IN NUMBER,
  v_ORDEN IN NUMBER,
  v_TIPO IN NUMBER,
  v_SUBTIPO IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT NU_NUME_PLHI_RPC_RGR ,
             NU_NUME_COHI_RPC_RGR ,
             NU_INDI_RPC_RGR ,
             NU_TIPOGR_RGR ,
             NU_SUBTIPO_RGR ,
             NU_XCERO_RGR ,
             NU_YCERO_RGR ,
             NU_XESCALA_RGR ,
             NU_YESCALA_RGR ,
             NU_XINICIO_RGR ,
             NU_YINICIO_RGR ,
             NU_XUNIDAD_RGR ,
             NU_YUNIDAD_RGR ,
             TX_XCONCEPTO_RGR ,
             TX_YCONCEPTO_RGR ,
             NU_PRMANUAL_RGR 
        FROM R_GRACyD_RPC 
       WHERE  NU_NUME_PLHI_RPC_RGR = v_PLANTILLA
                AND NU_NUME_COHI_RPC_RGR = v_IDCONCEPTO
                AND NU_INDI_RPC_RGR = v_ORDEN
                AND NU_TIPOGR_RGR = v_TIPO
                AND NU_SUBTIPO_RGR = v_SUBTIPO ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;