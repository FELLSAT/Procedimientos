CREATE OR REPLACE PROCEDURE H3i_SP_AUDIT_CONS_DOCXUSUARIO_
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_USUARIOID IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS
   v_USUARIOID_N VARCHAR2(30);

BEGIN

    v_USUARIOID_N := v_USUARIOID ;
    -- Con Respuesta
    OPEN  cv_1 FOR
        SELECT * 
        FROM (  SELECT CD_ASIG_DOCU ,
                    COD_AUDI_DOCUM_AAD ,
                    IDEN_USUARIO_AAD ,
                    FE_FECHA_ARG ,
                    --	AD.VALOR_TOTAL_UNITARIO_ITEM,
                    COD_AUDI_DOCUM ,
                    DOCUMENTO_TIPO ,
                    DOCUMENTO_CONSECUTIVO ,
                    ESTADO_ARG ,
                    CANT_RESPUESTA ,
                    REPLACE(DOCUMENTO_TIPO_CONSEC, '-', ' ') ID_DOCUM_INTERFAZ ,-- (AD.DOCUMENTO_TIPO + CAST(AD.DOCUMENTO_CONSECUTIVO AS varchar(MAX))) ID_DOCUM_INTERFAZ,

                    DOCUMENTO_TIPO_CONSEC IDENTIFICADOR_ADJUNTOS  ,
                    --Datos tipo documento
                    ATD.NU_DATO_INTER_ATD ,
                    ATD.CD_CODI_ATD ,
                    ATD.NO_NOMB_ATD ,
                    AUTO_REG_GLOSA ,
                    COD_REG_GLO_PADRE ,
                    FUERZA_NOMBRE 
                FROM TABLE(FN_TablaDocumentosObjetados(v_USUARIOID_N, 2)) 
                INNER JOIN AUDITAR_TIPO_DOCU ATD   
                    ON ATD.NU_DATO_INTER_ATD = REPLACE(DOCUMENTO_TIPO, TO_NUMBER(BODEGA_CODIGO), ' ')--Valores R, P, H, A                
                WHERE  IDEN_USUARIO_AAD = v_USUARIOID_N
                    AND ESTADO_ARG = 2
                    AND FE_FECHA_ARG > TO_DATE('2015-09-26 00:00:00','yyyy-mm-dd hh24:mi:ss')-- SE PONE DE MOMENTO ESTA RESTRICCIÓN HASTA QUE CONCILIEN. (ESTA FECHA ES FECHA_ASIG_AAD que viene en la funcion)
               --ESTADO_ARG DESC ,               
                ORDER BY CD_ASIG_DOCU ASC)
        WHERE ROWNUM <= 5 ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;