CREATE OR REPLACE FUNCTION FN_TablaDocumentosObjetados
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    V_USUARIO IN VARCHAR2,
    V_ESTADO IN NUMBER
)
RETURN TYPE_TAB_TablaDocumenObjetados
AS
    V_TABLA  TYPE_TAB_TablaDocumenObjetados := TYPE_TAB_TablaDocumenObjetados();
    -------------------------------------
    TYPE RECORDTYPE IS RECORD (
        COL1 NUMBER(19), COL2 NUMBER(19),
        COL3 VARCHAR2(30), COL4 DATE,
        COL5 NUMBER(19), COL6 NUMBER(10),
        COL7 NUMBER(10), COL8 VARCHAR(255),
        COL9 FLOAT(126), COL10 NUMBER(19),
        COL11 NUMBER(19), COL12 FLOAT(126),
        COL13 VARCHAR2(100), COL14 VARCHAR2(286)
    );
    ------------------------------------- 
  CURSOR CV_1 IS
      SELECT CD_ASIG_DOCU, COD_AUDI_DOCUM_AAD,
          IDEN_USUARIO_AAD, FE_FECHA_ARG,
          COD_AUDI_DOCUM, ESTADO_ARG,
          CANT_RESPUESTA, DOCUMENTO_TIPO,
          DOCUMENTO_CONSECUTIVO, AUTO_REG_GLOSA,
          COD_REG_GLO_PADRE, BODEGA_CODIGO,
          FUERZA_NOMBRE, DOCUMENTO_TIPO_CONSEC
      FROM(SELECT CD_ASIG_DOCU,COD_AUDI_DOCUM_AAD,
              IDEN_USUARIO_AAD,
              FECHA_ASIG_AAD FE_FECHA_ARG,
              COD_AUDI_DOCUM, ESTADO_ARG,
              (SELECT MAX(NU_NUM_RESPUESTA) FROM AUDITAR_RESPUESTA_DOCU_OBJET WHERE CODIGO_DOC_OBJETADO = COD_AUDI_DOCUM) CANT_RESPUESTA,
              DOCUMENTO_TIPO, DOCUMENTO_CONSECUTIVO,
              AUTO_REG_GLOSA, COD_REG_GLO_PADRE,
              BODEGA_CODIGO,FUERZA_NOMBRE,
              DOCUMENTO_TIPO_CONSEC
          FROM AUDITAR_REGISTRO_GLOSADO ARG 
          INNER JOIN AUDITAR_DOCUMENTO 
              ON ARG.COD_AUDI_DOCUM_ARG = COD_AUDI_DOCUM
          INNER JOIN AUDITAR_ASIGNACION_DOCUM 
              ON COD_AUDI_DOCUM_AAD = COD_AUDI_DOCUM
          WHERE ESTADO_ARG = V_ESTADO
              AND IDEN_USUARIO_AAD = V_USUARIO
              AND (DOC_FUE_REPORTADO IS NULL OR DOC_FUE_REPORTADO = 0)
          ORDER BY COD_AUDI_DOCUM_AAD DESC)
      WHERE ROWNUM <= 20;
  -------------------------------------   
  OUTTABLE RECORDTYPE;
BEGIN
    
    OPEN CV_1;
    FETCH CV_1 INTO OUTTABLE;

    WHILE CV_1%FOUND
    LOOP
      V_TABLA.EXTEND;
      V_TABLA(V_TABLA.LAST) := TYPE_FN_TablaDocumentObjetados(
          OUTTABLE.COL1, OUTTABLE.COL2,
          OUTTABLE.COL3, OUTTABLE.COL4,
          OUTTABLE.COL5, OUTTABLE.COL6,
          OUTTABLE.COL7, OUTTABLE.COL8,
          OUTTABLE.COL9, OUTTABLE.COL10,
          OUTTABLE.COL11, OUTTABLE.COL12,
          OUTTABLE.COL13, OUTTABLE.COL14
        );
      FETCH CV_1 INTO OUTTABLE;
    END LOOP;

    CLOSE CV_1;

    RETURN V_TABLA;


EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;


--CREACION DEL TYPO COMO OBJECTO QUE SERA LA TABLA
CREATE TYPE TYPE_FN_TablaDocumentObjetados AS OBJECT (
   CD_ASIG_DOCU NUMBER(19),
    COD_AUDI_DOCUM_AAD NUMBER(19),
    IDEN_USUARIO_AAD VARCHAR2(30),
    FE_FECHA_ARG DATE,
    COD_AUDI_DOCUM NUMBER(19),
    ESTADO_ARG NUMBER(10),
    CANT_RESPUESTA NUMBER(10),
    DOCUMENTO_TIPO VARCHAR(255),
    DOCUMENTO_CONSECUTIVO FLOAT(126),
    AUTO_REG_GLOSA NUMBER(19),
    COD_REG_GLO_PADRE NUMBER(19),
    BODEGA_CODIGO FLOAT(126),
    FUERZA_NOMBRE VARCHAR2(100),
    DOCUMENTO_TIPO_CONSEC VARCHAR2(286)
);

--CREACION DEL TYPE COMO UNA TBLA DE ESE TIPOP
CREATE TYPE TYPE_TAB_TablaDocumenObjetados IS TABLE OF TYPE_FN_TablaDocumentObjetados;