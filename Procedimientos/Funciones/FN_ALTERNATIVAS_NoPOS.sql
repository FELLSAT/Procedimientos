CREATE OR REPLACE FUNCTION FN_ALTERNATIVAS_NoPOS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NumNoPOS IN NUMBER,
    v_Orden IN NUMBER
)
RETURN TYPE_TAB_ALTERNATIVAS_NoPOS
AS
    V_TABLA TYPE_TAB_ALTERNATIVAS_NoPOS := TYPE_TAB_ALTERNATIVAS_NoPOS();
    -----------------------------
    TYPE RECORDTYPE IS RECORD (
        COL1 VARCHAR2(100), COL2 VARCHAR2(40), 
        COL3 VARCHAR2(20), COL4 NUMBER(1),
        COL5 NUMBER(1), COL6 NUMBER(1),
        COL7 NUMBER
    );
    -----------------------------
    CURSOR CV_1 IS
        SELECT  TX_PRINCIP_ALTN, TX_TIEMUTI_ALTN, 
            TX_DOSIS_ALTN, NU_NOMEJOR_ALTN, 
            NU_REACADV_ALTN, NU_INTOLER_ALTN, v_NumNoPOS
        FROM  ALT_NPOSM 
        WHERE NU_AUTO_NOPM_ALTN = v_NumNoPOS 
        AND   NU_ORDEN_ALTN = v_Orden;
    -------------------------------------   
    OUTTABLE RECORDTYPE;
BEGIN
    OPEN CV_1;
    FETCH CV_1 INTO OUTTABLE;

    WHILE CV_1%FOUND
    LOOP
      V_TABLA.EXTEND;
      V_TABLA(V_TABLA.LAST) := TYPE_FN_ALTERNATIVAS_NoPOS(
          OUTTABLE.COL1, OUTTABLE.COL2,
          OUTTABLE.COL3, OUTTABLE.COL4,
          OUTTABLE.COL5, OUTTABLE.COL6,
          OUTTABLE.COL7
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
CREATE TYPE TYPE_FN_ALTERNATIVAS_NoPOS AS OBJECT (
    TX_PRINCIP_ALTN VARCHAR2(100),
    TX_TIEMUTI_ALTN VARCHAR2(40),
    TX_DOSIS_ALTN VARCHAR2(20),
    NU_NOMEJOR_ALTN NUMBER(1),
    NU_REACADV_ALTN NUMBER(1),
    NU_INTOLER_ALTN NUMBER(1),
    NUMNOPOS NUMBER
);

--CREACION DEL TYPE COMO UNA TBLA DE ESE TIPOP
CREATE TYPE TYPE_TAB_ALTERNATIVAS_NoPOS IS TABLE OF TYPE_FN_ALTERNATIVAS_NoPOS;