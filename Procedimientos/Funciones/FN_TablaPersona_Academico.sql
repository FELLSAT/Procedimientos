CREATE OR REPLACE FUNCTION FN_TablaPersona_Academico
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  V_TipoPersona IN NUMBER
)
RETURN TYPE_TAB_TablaPersona_Academic
AS
    V_TABLA  TYPE_TAB_TablaPersona_Academic := TYPE_TAB_TablaPersona_Academic();
    -------------------------------------
    TYPE RECORDTYPE IS RECORD (
      COL1 VARCHAR2(20), COL2 NUMBER(18)
    );   
    -------------------------------------   
    OUTTABLE RECORDTYPE;
BEGIN

    IF(V_TipoPersona = 1) THEN

        DECLARE
            CURSOR CV_1 IS
                SELECT  CD_CODI_MED_RGE, 
                    NU_AUTO_HOGR_RGE
                FROM  R_GRU_EST_2;
        BEGIN
            OPEN CV_1;
            FETCH CV_1 INTO OUTTABLE;

            WHILE CV_1%FOUND
            LOOP
              V_TABLA.EXTEND;
              V_TABLA(V_TABLA.LAST) := TYPE_FN_TablaPersona_Academico(
                  OUTTABLE.COL1, OUTTABLE.COL2
              );
              FETCH CV_1 INTO OUTTABLE;
            END LOOP;

            CLOSE CV_1;
        END;

    ELSE

        DECLARE
            CURSOR CV_2 IS
                SELECT CD_CODI_MED_RGD, 
                    NU_AUTO_HOGR_RGD
                FROM  R_GRU_DOC_2;
        BEGIN
            OPEN CV_2;
            FETCH CV_2 INTO OUTTABLE;

            WHILE CV_2%FOUND
            LOOP
              V_TABLA.EXTEND;
              V_TABLA(V_TABLA.LAST) := TYPE_FN_TablaPersona_Academico(
                  OUTTABLE.COL1, OUTTABLE.COL2
              );
              FETCH CV_2 INTO OUTTABLE;
            END LOOP;

            CLOSE CV_2;
        END;

    END IF;

    RETURN V_TABLA;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;


--CREACION DEL TYPO COMO OBJECTO QUE SERA LA TABLA
CREATE TYPE TYPE_FN_TablaPersona_Academico AS OBJECT (
    CD_CODI_MED_RGE VARCHAR2(20), 
    NU_AUTO_HOGR_RGE NUMBER(18)
);

--CREACION DEL TYPE COMO UNA TBLA DE ESE TIPOP
CREATE TYPE TYPE_TAB_TablaPersona_Academic IS TABLE OF TYPE_FN_TablaPersona_Academico;