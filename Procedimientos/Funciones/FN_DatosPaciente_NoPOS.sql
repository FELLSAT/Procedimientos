CREATE OR REPLACE FUNCTION FN_DatosPaciente_NoPOS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  V_NumNoPOS IN NUMBER
)
RETURN TYPE_TAB_DatosPaciente_NoPOS
AS
    V_NumHC NUMBER;
    V_NumEV NUMBER;
    -------------------------------------
    V_TABLA  TYPE_TAB_DatosPaciente_NoPOS := TYPE_TAB_DatosPaciente_NoPOS();
    -------------------------------------
    TYPE RECORDTYPE IS RECORD (
        COL1 NUMBER(3), COL2 VARCHAR2(20),
        COL3 VARCHAR2(100), COL4 VARCHAR2(100),
        COL5 VARCHAR2(100), COL6 VARCHAR2(100),
        COL7 NUMBER, COL8 NUMBER,
        COL9 VARCHAR2(4000), COL10 VARCHAR2(30),
        COL11 NUMBER(3), COL12 VARCHAR2(40),
        COL13 VARCHAR2(40), COL14 NUMBER
    );
    -------------------------------------   
    OUTTABLE RECORDTYPE;
BEGIN
   
    SELECT NU_NUME_HICL_NOPM, NU_NUME_HEVO_NOPM
    INTO V_NumHC, V_NumEV
    FROM NOPOS_MEDI
    WHERE NU_AUTO_NOPM = V_NumNoPOS;
    --------------------------------------

    IF (V_NumEV <> 0) THEN

        DECLARE
            CURSOR CV_1 IS
                SELECT  DISTINCT NU_TIPD_PAC, NU_DOCU_PAC, 
                    DE_PRAP_PAC, DE_SGAP_PAC, 
                    NO_NOMB_PAC, NO_SGNO_PAC,
                    EDADPACIENTE(NU_HIST_PAC, 1), 
                    EDADPACIENTE(NU_HIST_PAC, 0),
                    DE_DIRE_PAC, DE_TELE_PAC, 
                    NU_TIAT_MOVI, 
                    (SELECT NO_NOMB_REG FROM REGIMEN WHERE CD_CODI_REG = MOVI_CARGOS.CD_REGIMEN_MOVI AND ROWNUM <= 1), 
                    (SELECT NO_NOMB_LUAT FROM LUGAR_ATENCION WHERE CD_CODI_LUAT = CD_CODI_LUAT_MOVI AND ROWNUM <= 1),
                    V_NumNoPOS 
                FROM  PACIENTES 
                INNER JOIN MOVI_CARGOS 
                    ON NU_HIST_PAC = NU_HIST_PAC_MOVI
                INNER JOIN LABORATORIO 
                    ON NU_NUME_MOVI = NU_NUME_MOVI_LABO
                INNER JOIN HISTORIACLINICA 
                    ON NU_NUME_LABO = NU_NUME_LABO_HICL
                INNER JOIN HIST_EVOLUCION 
                    ON NU_NUME_HICL_HEVO = NU_NUME_HICL
                WHERE NU_NUME_HEVO = V_NumEV;
        BEGIN
            OPEN CV_1;
            FETCH CV_1 INTO OUTTABLE;

            WHILE CV_1%FOUND
            LOOP
              V_TABLA.EXTEND;
              V_TABLA(V_TABLA.LAST) := TYPE_FN_DatosPaciente_NoPOS(
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
        END;

    ELSE

        DECLARE
            CURSOR CV_2 IS
                SELECT  DISTINCT NU_TIPD_PAC, NU_DOCU_PAC, 
                    DE_PRAP_PAC, DE_SGAP_PAC, 
                    NO_NOMB_PAC, NO_SGNO_PAC,
                    EDADPACIENTE(NU_HIST_PAC, 1), 
                    EDADPACIENTE(NU_HIST_PAC, 0),
                    DE_DIRE_PAC, DE_TELE_PAC, 
                    NU_TIAT_MOVI, 
                    (SELECT NO_NOMB_REG FROM REGIMEN WHERE CD_CODI_REG = MOVI_CARGOS.CD_REGIMEN_MOVI AND ROWNUM <= 1), 
                    (SELECT NO_NOMB_LUAT FROM LUGAR_ATENCION WHERE CD_CODI_LUAT = CD_CODI_LUAT_MOVI),
                    V_NumNoPOS 
                FROM PACIENTES 
                INNER JOIN MOVI_CARGOS 
                    ON NU_HIST_PAC = NU_HIST_PAC_MOVI
                INNER JOIN LABORATORIO 
                    ON NU_NUME_MOVI = NU_NUME_MOVI_LABO
                INNER JOIN HISTORIACLINICA 
                    ON NU_NUME_LABO = NU_NUME_LABO_HICL        
                WHERE NU_NUME_HICL = V_NumHC;
        BEGIN
            OPEN CV_2;
            FETCH CV_2 INTO OUTTABLE;

            WHILE CV_2%FOUND
            LOOP
              V_TABLA.EXTEND;
              V_TABLA(V_TABLA.LAST) := TYPE_FN_DatosPaciente_NoPOS(
                  OUTTABLE.COL1, OUTTABLE.COL2,
                  OUTTABLE.COL3, OUTTABLE.COL4,
                  OUTTABLE.COL5, OUTTABLE.COL6,
                  OUTTABLE.COL7, OUTTABLE.COL8,
                  OUTTABLE.COL9, OUTTABLE.COL10,
                  OUTTABLE.COL11, OUTTABLE.COL12,
                  OUTTABLE.COL13, OUTTABLE.COL14
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
CREATE TYPE TYPE_FN_DatosPaciente_NoPOS AS OBJECT (
    NU_TD NUMBER(3),
    NU_DOCU_PAC VARCHAR2(20),
    DE_PRAP_PAC VARCHAR2(100),
    DE_SGAP_PAC VARCHAR2(100),
    NO_NOMB_PAC VARCHAR2(100),
    NO_SGNO_PAC VARCHAR2(100),
    EDAD_VAL NUMBER,
    EDAD_UME NUMBER,
    DE_DIRE_PAC VARCHAR2(4000),
    DE_TELE_PAC VARCHAR2(30),
    NU_TIAT_MOVI NUMBER(3),
    REGIMEN VARCHAR2(40),
    IPS VARCHAR2(40),
    NumNoPOS_P NUMBER
);

--CREACION DEL TYPE COMO UNA TBLA DE ESE TIPOP
CREATE TYPE TYPE_TAB_DatosPaciente_NoPOS IS TABLE OF TYPE_FN_DatosPaciente_NoPOS;