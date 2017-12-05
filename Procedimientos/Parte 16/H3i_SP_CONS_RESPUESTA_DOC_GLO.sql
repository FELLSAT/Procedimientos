CREATE OR REPLACE PROCEDURE H3i_SP_CONS_RESPUESTA_DOC_GLO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
      V_CODIGO IN NUMBER,
      CV_1 OUT SYS_REFCURSOR 
)

AS
BEGIN
      OPEN CV_1 FOR
      	SELECT AUTO_RESP_DOC_OBJ,
                  CODIGO_DOC_OBJETADO,
                  IDEN_USUARIO_RESP_RDO,
                  TXT_RESPUESTA_RDO,
                  FECHA_RESP_RDO,
                  NU_NUM_RESPUESTA,
                  NU_VALOR_RATIFICADO_RDO,
                  NU_VALOR_LEVANTADO_RDO,
                  DE_CAUSAL_RDO,
                  DE_OBSERVACION_RDO,
            	NU_VALOR_ACEPTADO_RDO,
            	BT_ACEPTA_TODO
      	FROM AUDITAR_RESPUESTA_DOCU_OBJET 
            WHERE  CODIGO_DOC_OBJETADO = V_CODIGO;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;