CREATE OR REPLACE FUNCTION FN_Diagnostico_NoPOS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  V_NumNoPOS IN NUMBER,
  V_EsMedicamento IN NUMBER,
  V_Orden IN NUMBER
)
RETURN TYPE_TAB_Diagnostico_NoPOS
AS
    V_TABLA  TYPE_TAB_Diagnostico_NoPOS := TYPE_TAB_Diagnostico_NoPOS();
    -------------------------------------
    TYPE RECORDTYPE IS RECORD (
      COL1 VARCHAR2(4), COL2 VARCHAR2(255), 
      COL3 NUMBER(19)
    );
    ------------------------------------- 
    CURSOR CV_1 IS
        SELECT  CD_CODI_DIAG, DE_DESC_DIAG, 
            V_NumNoPOS
        FROM  NOPOS_DX 
        INNER JOIN DIAGNOSTICO 
            ON CD_CODI_DIAG =CD_CODI_DIAG_NDX
        WHERE NU_AUTO_NOP_NDX = V_NumNoPOS
            AND   NU_TIPO_NDX = V_EsMedicamento
            AND   NU_ORDEN_NDX = V_Orden;
    -------------------------------------   
    OUTTABLE RECORDTYPE;
BEGIN
    
    OPEN CV_1;
    FETCH CV_1 INTO OUTTABLE;

    WHILE CV_1%FOUND
    LOOP
      V_TABLA.EXTEND;
      V_TABLA(V_TABLA.LAST) := TYPE_FN_Diagnostico_NoPOS(
          OUTTABLE.COL1, OUTTABLE.COL2,
          OUTTABLE.COL3
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
CREATE TYPE TYPE_FN_Diagnostico_NoPOS AS OBJECT (
  CD_CODI_DIAG VARCHAR2(4),
  DE_DESC_DIAG VARCHAR2(255),
  NumNoPOS NUMBER  
);

--CREACION DEL TYPE COMO UNA TBLA DE ESE TIPOP
CREATE TYPE TYPE_TAB_Diagnostico_NoPOS IS TABLE OF TYPE_FN_Diagnostico_NoPOS;
