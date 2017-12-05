CREATE OR REPLACE PACKAGE FN_TablaDocumentosOb_pkg
AS
   TYPE tt_FN_TablaDocumentosObje_type IS TABLE OF tt_FN_TablaDocumentosObjeta%ROWTYPE;
END;


CREATE OR REPLACE FUNCTION FN_TablaDocumentosObjetados
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_USUARIO IN VARCHAR2,
  v_ESTADO IN NUMBER
)
RETURN FN_TablaDocumentosOb_pkg.tt_FN_TablaDocumentosObje_type PIPELINED
AS
   v_temp SYS_REFCURSOR;
   v_temp_1 TT_FN_TABLADOCUMENTOSOBJETA%ROWTYPE;

BEGIN
    DELETE tt_FN_TablaDocumentosObjeta;
   
    INSERT INTO tt_FN_TablaDocumentosObjeta
        SELECT * 
        FROM (  SELECT CD_ASIG_DOCU ,
                    COD_AUDI_DOCUM_AAD ,
                    IDEN_USUARIO_AAD ,
                    FECHA_ASIG_AAD FE_FECHA_ARG  ,
                    COD_AUDI_DOCUM ,
                    ESTADO_ARG ,
                    ( SELECT MAX(NU_NUM_RESPUESTA)  
                      FROM AUDITAR_RESPUESTA_DOCU_OBJET 
                      WHERE  CODIGO_DOC_OBJETADO = COD_AUDI_DOCUM 
                    ) CANT_RESPUESTA  ,
                    DOCUMENTO_TIPO ,
                    DOCUMENTO_CONSECUTIVO ,
                    AUTO_REG_GLOSA ,
                    COD_REG_GLO_PADRE ,
                    BODEGA_CODIGO ,
                    FUERZA_NOMBRE ,
                    DOCUMENTO_TIPO_CONSEC 
                FROM AUDITAR_REGISTRO_GLOSADO ARG
                INNER JOIN AUDITAR_DOCUMENTO    
                    ON ARG.COD_AUDI_DOCUM_ARG = COD_AUDI_DOCUM
                INNER JOIN AUDITAR_ASIGNACION_DOCUM    
                    ON COD_AUDI_DOCUM_AAD = COD_AUDI_DOCUM
                WHERE  ESTADO_ARG = v_ESTADO
                    AND IDEN_USUARIO_AAD = v_USUARIO
                    AND ( DOC_FUE_REPORTADO IS NULL
                    OR DOC_FUE_REPORTADO = 0 )
                ORDER BY COD_AUDI_DOCUM_AAD DESC )
        WHERE ROWNUM <= 20;

    OPEN v_temp FOR
        SELECT * 
        FROM tt_FN_TablaDocumentosObjeta;
        
    LOOP
        FETCH v_temp INTO v_temp_1;
        EXIT WHEN v_temp%NOTFOUND;
        PIPE ROW ( v_temp_1 );
    END LOOP;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;