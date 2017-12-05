CREATE OR REPLACE FUNCTION fn_CalculaFactores
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NUMHISTPAC IN VARCHAR2,
    v_VARIABLE IN VARCHAR2
)
RETURN NUMBER
AS
    v_RTA NUMBER(18,4);
    -------------------------------------
    TYPE RECORDTYPE IS RECORD (
      COL1 NUMBER(18), COL2 NUMBER(10), 
      COL3 NUMBER(18)
    );
    -------------------------------------   
    OUTTABLE RECORDTYPE;
    ------------------------------------- 
    CURSOR CV_1 IS
        SELECT DISTINCT F.NU_NUME_PLHI_FAVA ,
            ( SELECT MAX(NU_NUME_HICL)  
              FROM HISTORIACLINICA HC
              INNER JOIN LABORATORIO L   
                  ON HC.NU_NUME_LABO_HICL = L.NU_NUME_LABO
              INNER JOIN MOVI_CARGOS M   
                  ON M.NU_NUME_MOVI = L.NU_NUME_MOVI_LABO
              WHERE  HC.NU_NUME_PLHI_HICL = NU_NUME_PLHI_FAVA) ULTIMA,
            V.NU_OPERACION_VAIN 
        FROM VARIABLE_INDICADOR V
        INNER JOIN FACTOR_VAIN F   
            ON V.NU_AUTO_VAIN = F.NU_AUTO_VAIN_FAVA
        WHERE  V.TX_CODIGO_VAIN = v_VARIABLE
        ORDER BY 1;

BEGIN

    OPEN CV_1;
    FETCH CV_1 INTO OUTTABLE;

    WHILE CV_1%FOUND
    LOOP
      INSERT INTO tt_v_tmpPalntilla
      VALUES (
          OUTTABLE.COL1, OUTTABLE.COL2,
          OUTTABLE.COL3);
      FETCH CV_1 INTO OUTTABLE;
    END LOOP;

    CLOSE CV_1;

    SELECT 
        CASE OPERADOR
            WHEN 0 THEN SUM(NU_PESO_FAVA) 
            WHEN 1 THEN MAX(NU_PESO_FAVA)    
        END RTA  
    INTO v_RTA
    FROM tt_v_tmpPalntilla T
    INNER JOIN HIST_NUME HN   
        ON T.UltimaHC = HN.NU_NUME_HICL_HINU
    INNER JOIN FACTOR_VAIN F   
        ON F.NU_NUME_PLHI_FAVA = T.Plantilla
        AND F.NU_INDI_RPC_FAVA = HN.NU_INDI_HINU
    INNER JOIN VARIABLE_INDICADOR V   
        ON V.NU_AUTO_VAIN = F.NU_AUTO_VAIN_FAVA
    WHERE  NU_DESC_HINU BETWEEN F.NU_VALMIN_FAVA AND F.NU_VALMAX_FAVA
        AND V.TX_CODIGO_VAIN = v_VARIABLE
    GROUP BY Operador;

    RETURN v_RTA;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;