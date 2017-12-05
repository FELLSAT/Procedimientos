CREATE OR REPLACE FUNCTION FN_DatosMedico_NoPOS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  V_NumNoPOS IN NUMBER
)
RETURN TYPE_TAB_DatosMedico_NoPOS
AS
    V_NumHC NUMBER;
    V_NumEV NUMBER;
    -------------------------------
    V_TABLA  TYPE_TAB_DatosMedico_NoPOS := TYPE_TAB_DatosMedico_NoPOS();
    -------------------------------------
    TYPE RECORDTYPE IS RECORD (
        COL1 VARCHAR2(10), COL2 NUMBER(3), 
        COL3 VARCHAR2(100), COL4 VARCHAR2(100),
        COL5 VARCHAR2(100), COL6 VARCHAR2(100),
        COL7 VARCHAR2(30), COL8 RAW(32767),
        COL9 NUMBER 
    );
    -------------------------------------   
    OUTTABLE RECORDTYPE;
BEGIN

    SELECT NU_NUME_HICL_NOPM, NU_NUME_HEVO_NOPM
    INTO V_NumHC, V_NumEV
    FROM  NOPOS_MEDI
    WHERE NU_AUTO_NOPM = V_NumNoPOS;

    IF(V_NumEV <> 0) THEN

        DECLARE
            CURSOR CV_1 IS
                SELECT  CD_CODI_MED, NU_DOCU_MED, 
                    NO_NOMB1_MED, NO_NOMB2_MED, 
                    NO_APEL1_MED, NO_APEL2_MED, 
                    DE_REGI_MED, NU_FIRMA,
                    V_NumNoPOS
                FROM HIST_EVOLUCION 
                INNER JOIN MEDICOS 
                    ON CD_CODI_MED_HEVO = CD_CODI_MED
                INNER JOIN USUARIOS 
                    ON NU_DOCU_USUA = NU_DOCU_MED
                WHERE NU_NUME_HEVO = V_NumEV;
        BEGIN

            OPEN CV_1;
            FETCH CV_1 INTO OUTTABLE;

            WHILE CV_1%FOUND
            LOOP
                V_TABLA.EXTEND;
                V_TABLA(V_TABLA.LAST) := TYPE_FN_DatosMedico_NoPOS(
                    OUTTABLE.COL1, OUTTABLE.COL2,
                    OUTTABLE.COL3, OUTTABLE.COL4,
                    OUTTABLE.COL5, OUTTABLE.COL6,
                    OUTTABLE.COL7, OUTTABLE.COL8,
                    OUTTABLE.COL9
                  );
                FETCH CV_1 INTO OUTTABLE;
            END LOOP;

            CLOSE CV_1;

        END;

    ELSE

         DECLARE
            CURSOR CV_2 IS
                SELECT CD_CODI_MED, NU_DOCU_MED, 
                    NO_NOMB1_MED, NO_NOMB2_MED, 
                    NO_APEL1_MED, NO_APEL2_MED, 
                    DE_REGI_MED, NU_FIRMA,
                    V_NumNoPOS
                FROM HISTORIACLINICA 
                INNER JOIN MEDICOS 
                    ON CD_MED_REAL_HICL = CD_CODI_MED  
                INNER JOIN USUARIOS 
                    ON NU_DOCU_USUA = NU_DOCU_MED 
                WHERE NU_NUME_HICL = V_NumHC;
        BEGIN

            OPEN CV_2;
            FETCH CV_2 INTO OUTTABLE;

            WHILE CV_2%FOUND
            LOOP
                V_TABLA.EXTEND;
                V_TABLA(V_TABLA.LAST) := TYPE_FN_DatosMedico_NoPOS(
                    OUTTABLE.COL1, OUTTABLE.COL2,
                    OUTTABLE.COL3, OUTTABLE.COL4,
                    OUTTABLE.COL5, OUTTABLE.COL6,
                    OUTTABLE.COL7, OUTTABLE.COL8,
                    OUTTABLE.COL9
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
CREATE TYPE TYPE_FN_DatosMedico_NoPOS AS OBJECT (
    CD_CODI_MED VARCHAR2(10),
    NU_DOCU_MED NUMBER(3),
    NO_NOMB1_MED VARCHAR2(100),
    NO_NOMB2_MED VARCHAR2(100),
    NO_APEL1_MED VARCHAR2(100),
    NO_APEL2_MED VARCHAR2(100),
    DE_REGI_MED VARCHAR2(30),
    NU_FIRMA RAW(32767),
    NUMNOPOS NUMBER 
);
       
--CREACION DEL TYPE COMO UNA TBLA DE ESE TIPOP
CREATE TYPE TYPE_TAB_DatosMedico_NoPOS IS TABLE OF TYPE_FN_DatosMedico_NoPOS;
