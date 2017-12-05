CREATE PROCEDURE H3i_SP_RECU_DATOS_CNCILIACIONS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    V_CODIGO_DOCUMENTO IN NUMBER,
    CV_1 OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN CV_1 FOR
        SELECT CAUSA_CODIGO_CONCIL_ARG ,
            VALOR_FACTUR_CONCIL_ARG,
            VALOR_GLOSADA_CONCIL_ARG,
            VALOR_RATIFIC_CONCIL_ARG,
            VALOR_LEVANTADA_CONCIL_ARG,
            VALOR_ACEPTADO_CONCIL_ARG,
            VALOR_MANTENIDO_CONCIL_ARG,
            VALOR_PAGAR_CONCIL_ARG,
            DE_OBSERV_CONCIL_ARG,
            ESTADO_CONCIL_ARG,
            DE_OBSERV_OTRAINST_CONCIL_ARG,
            ESTADO_ARG
        FROM AUDITAR_REGISTRO_GLOSADO
        WHERE COD_AUDI_DOCUM_ARG = V_CODIGO_DOCUMENTO;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;