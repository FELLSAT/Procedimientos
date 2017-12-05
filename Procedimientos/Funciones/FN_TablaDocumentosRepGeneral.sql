CREATE OR REPLACE FUNCTION FN_TablaDocumentosRepGeneral
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    V_FECHA_INICIO IN DATE,
    V_FECHA_FIN IN DATE
)
RETURN TYPE_TAB_TablaDocumnRepGeneral
AS
    V_TABLA  TYPE_TAB_TablaDocumnRepGeneral := TYPE_TAB_TablaDocumnRepGeneral();
    -------------------------------------
    TYPE RECORDTYPE IS RECORD (
        COL1 NUMBER(19), COL2 DATE,
        COL3 FLOAT(126), COL4 NUMBER(10) 
    );
    ------------------------------------- 
    CURSOR CV_1 IS
        SELECT COD_AUDI_DOCUM,
          FECHA_ASIG_AAD,
          DOCUMENTO_VALOR_TOTAL,
          ESTADO_ARG 
        FROM AUDITAR_REGISTRO_GLOSADO ARG 
        INNER JOIN AUDITAR_DOCUMENTO AD 
          ON ARG.COD_AUDI_DOCUM_ARG = AD.COD_AUDI_DOCUM
        INNER JOIN AUDITAR_ASIGNACION_DOCUM 
          ON COD_AUDI_DOCUM_AAD = AD.COD_AUDI_DOCUM
        WHERE AUTO_REG_GLOSA = (SELECT MAX(ARG_AUX.AUTO_REG_GLOSA)
                    FROM AUDITAR_REGISTRO_GLOSADO ARG_AUX 
                    WHERE ARG_AUX.COD_AUDI_DOCUM_ARG = ARG.COD_AUDI_DOCUM_ARG)
          AND FECHA_ASIG_AAD BETWEEN V_FECHA_INICIO AND V_FECHA_FIN;
    -------------------------------------   
    OUTTABLE RECORDTYPE;

BEGIN

    OPEN CV_1;
    FETCH CV_1 INTO OUTTABLE;

    WHILE CV_1%FOUND
    LOOP
      V_TABLA.EXTEND;
      V_TABLA(V_TABLA.LAST) := TYPE_FN_TablaDocumenRepGeneral(
          OUTTABLE.COL1, OUTTABLE.COL2,
          OUTTABLE.COL3, OUTTABLE.COL4
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
CREATE TYPE TYPE_FN_TablaDocumenRepGeneral AS OBJECT (
  COD_AUDI_DOCUM NUMBER(19),
  FECHA_ASIG_AAD DATE,
  DOCUMENTO_VALOR_TOTAL FLOAT(126),
  ESTADO_ARG NUMBER(10) 
);

--CREACION DEL TYPE COMO UNA TBLA DE ESE TIPOP
CREATE TYPE TYPE_TAB_TablaDocumnRepGeneral IS TABLE OF TYPE_FN_TablaDocumenRepGeneral;