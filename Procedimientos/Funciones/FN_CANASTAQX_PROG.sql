CREATE OR REPLACE FUNCTION FN_CANASTAQX_PROG
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    V_NUMPROQX IN NUMBER
)
RETURN TYPE_TAB_CANASTAQX_PROG
IS   
    V_NumAQ NUMBER;
    V_CodMed HONORARIOS.CD_CIRU_MEDI_HONO%TYPE;
    V_CodSer LABORATORIO.CD_CODI_SER_LABO%TYPE;
    V_EXISTE NUMBER;
    --------------------------------------
    V_TABLA  TYPE_TAB_CANASTAQX_PROG := TYPE_TAB_CANASTAQX_PROG();
    --------------------------------------
    TYPE RECORDTYPE IS RECORD (
        COL1 VARCHAR2(30), COL2 VARCHAR2(255), 
        COL3 NUMBER(3), COL4 NUMBER(10),
        COL5 VARCHAR2(255), COL6 VARCHAR2(30)
    );
    --------------------------------------
    CURSOR CV_1 IS
        SELECT  DISTINCT CD_CIRU_MEDI_HONO, 
            CD_CODI_SER_LABO
        FROM  ACTO_QX A 
        INNER JOIN R_ACQX_MOVI R 
            ON A.NU_NUME_ACQX = R.NU_NUME_ACQX_RAM
        INNER JOIN HONORARIOS H 
            ON R.NU_NUME_MOVI_RAM = H.NU_NUME_MOVI_HONO
        INNER JOIN LABORATORIO L 
            ON  R.NU_NUME_MOVI_RAM = L.NU_NUME_MOVI_LABO
        WHERE NU_NUME_ACQX = V_NumAQ;
    -------------------------------------   
    OUTTABLE RECORDTYPE;
BEGIN
    --------------------------------------
    SELECT NU_NUME_ACQX_PRQX
    INTO V_NumAQ
    FROM  PROGRAMACION_QX
    WHERE NU_AUTO_PRQX = V_NUMPROQX;
    ---------------------------------------
    FETCH CV_1 INTO V_CodMed, V_CodSer;

    WHILE CV_1%FOUND
    LOOP
        SELECT COUNT(*)
        INTO V_EXISTE
        FROM R_ART_SER RAS 
        WHERE RAS.CD_CODI_MED_RAS = V_CodMed 
            AND RAS.CD_CODI_SER_RAS= V_CodSer;

        IF(V_EXISTE > 0 ) THEN

            DECLARE
                CURSOR CV_2 IS
                    SELECT  CD_CODI_ARTI_RAS,  
                        NO_NOMB_ARTI,  
                        A.ID_TIPO_ARTI,  
                        R.NU_CANTIDAD_RAS,  
                        DE_UNME_ARTI,  
                        DE_CTRA_ARTI    
                    FROM  R_ART_SER R 
                    INNER JOIN ARTICULO A 
                        ON R.CD_CODI_ARTI_RAS = A.CD_CODI_ARTI
                    WHERE R.CD_CODI_MED_RAS = V_CodMed 
                    AND   R.CD_CODI_SER_RAS= V_CodSer;
            BEGIN
                OPEN CV_2;
                FETCH CV_2 INTO OUTTABLE;

                WHILE CV_2%FOUND
                LOOP
                    V_TABLA.EXTEND;
                    V_TABLA(V_TABLA.LAST) := TYPE_FN_CANASTAQX_PROG(
                        OUTTABLE.COL1, OUTTABLE.COL2,
                        OUTTABLE.COL3, OUTTABLE.COL4,
                        OUTTABLE.COL5, OUTTABLE.COL6
                    );
                    FETCH CV_2 INTO OUTTABLE;
                END LOOP;

                CLOSE CV_2;
            END;

        ELSE

            DECLARE
                CURSOR CV_3 IS
                    SELECT  CD_CODI_ARTI_RAS,
                        NO_NOMB_ARTI,
                        A.ID_TIPO_ARTI,
                        R.NU_CANTIDAD_RAS, 
                        DE_UNME_ARTI, 
                        DE_CTRA_ARTI      
                    FROM  R_ART_SER R 
                    INNER JOIN ARTICULO A 
                        ON R.CD_CODI_ARTI_RAS = A.CD_CODI_ARTI
                    WHERE R.CD_CODI_MED_RAS = '<<SINESPECIFICAR>>'
                    AND   R.CD_CODI_SER_RAS= V_CodSer;
            BEGIN
                OPEN CV_3;
                FETCH CV_3 INTO OUTTABLE;

                WHILE CV_3%FOUND
                LOOP
                    V_TABLA.EXTEND;
                    V_TABLA(V_TABLA.LAST) := TYPE_FN_CANASTAQX_PROG(
                        OUTTABLE.COL1, OUTTABLE.COL2,
                        OUTTABLE.COL3, OUTTABLE.COL4,
                        OUTTABLE.COL5, OUTTABLE.COL6
                    );
                    FETCH CV_3 INTO OUTTABLE;
                END LOOP;
                
                CLOSE CV_3;
            END;

        END IF;

        FETCH CV_1 INTO V_CodMed, V_CodSer;
    END LOOP;
EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;




--CREACION DEL TYPO COMO OBJECTO QUE SERA LA TABLA
CREATE TYPE TYPE_FN_CANASTAQX_PROG AS OBJECT (
    COD VARCHAR2(30), 
    NOMBRE VARCHAR2(255),  
    TIPO NUMBER(3),
    CANTIDAD NUMBER(10),
    DESCRIPCION VARCHAR2(255), 
    CONCENTRACION VARCHAR2(30) 
);

--CREACION DEL TYPE COMO UNA TBLA DE ESE TIPOP
CREATE TYPE TYPE_TAB_CANASTAQX_PROG IS TABLE OF TYPE_FN_CANASTAQX_PROG;