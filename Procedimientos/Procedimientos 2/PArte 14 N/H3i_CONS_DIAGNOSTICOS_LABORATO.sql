CREATE OR REPLACE PROCEDURE H3i_CONS_DIAGNOSTICOS_LABORATO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    V_NU_NUME_MOVI_LABO IN NUMBER
)

AS
    V_DIAG_CONTADOR NUMBER;
BEGIN
    ------------------------
    INSERT INTO TMP                                                                --TABLA DEL SQL SERVER
        (   SELECT RLD.ID_TIPO_DIAG_RLAD,
                RLD.CD_CODI_DIAG_RLAD
            FROM LABORATORIO LAB
            INNER JOIN R_LABO_DIAG RLD
                ON LAB.NU_NUME_LABO = RLD.NU_NUME_LABO_RLAD
            WHERE LAB.NU_NUME_LABO = V_NU_NUME_MOVI_LABO);

    ------------------------
    --diagnostico principal
    SELECT COUNT(*) 
    INTO V_DIAG_CONTADOR
    FROM TMP                                                                        --TABLA DEL SQL SERVER
    WHERE TIPO_DIAGNOSTICO = 'PR';

    IF(V_DIAG_CONTADOR <= 0) THEN

        BEGIN
            INSERT INTO TMP (                                                        --TABLA DEL SQL SERVER
                TIPO_DIAGNOSTICO, CD_CODI_DIAG_RLAD)
            VALUES(
                'PR','NA');
        END;

    END IF;

    ------------------------
    --diagnostico rel1
    SELECT COUNT(*)
    INTO V_DIAG_CONTADOR
    FROM TMP                                                                          --TABLA DEL SQL SERVER
    WHERE TIPO_DIAGNOSTICO = 'R1';

    IF(V_DIAG_CONTADOR <= 0) THEN

        BEGIN
            INSERT INTO TMP(                                                            --TABLA DEL SQL SERVER
                TIPO_DIAGNOSTICO, CD_CODI_DIAG_RLAD)                                   
            VALUES( 
                'R1','NA');
        END;

    END IF;

    -----------------------
    --diagnostico rel2
    SELECT COUNT(*)
    INTO V_DIAG_CONTADOR
    FROM TMP                                                                            --TABLA DEL SQL SERVER
    WHERE TIPO_DIAGNOSTICO = 'R2';

    IF (V_DIAG_CONTADOR <= 0) THEN

        BEGIN
            INSERT INTO TMP(                                                           --TABLA DEL SQL SERVER
                TIPO_DIAGNOSTICO, CD_CODI_DIAG_RLAD)
            VALUES(
                'R2','NA');
        END;

    END IF;

    ----------------------
    --diagnostico rel3
    SELECT COUNT(*) 
    INTO V_DIAG_CONTADOR
    FROM TMP                                                                            --TABLA DEL SQL SERVER
    WHERE TIPO_DIAGNOSTICO = 'R3';

    IF(V_DIAG_CONTADOR <= 0) THEN

        BEGIN
            INSERT INTO TMP(                                                            --TABLA DEL SQL SERVER
                TIPO_DIAGNOSTICO, CD_CODI_DIAG_RLAD)
            VALUES( 
                'R3','NA');
        END

    END IF;

    --------------------
    --diagnostico compl
    SELECT COUNT(*) 
    INTO V_DIAG_CONTADOR                    
    FROM TMP                                                                           --TABLA DEL SQL SERVER
    WHERE TIPO_DIAGNOSTICO = 'CO';      

    IF(V_DIAG_CONTADOR <= 0) THEN
        BEGIN
            INSERT INTO TMP(                                                           --TABLA DEL SQL SERVER
                TIPO_DIAGNOSTICO, CD_CODI_DIAG_RLAD)
            VALUES(
                'CO','NA');
        END;
    END IF;

    ------------------------
    --diagnostico salida
    SELECT COUNT(*) 
    INTO V_DIAG_CONTADOR        
    FROM TMP                                                                       --TABLA DEL SQL SERVER
    WHERE TIPO_DIAGNOSTICO = 'SA';      

    IF(V_DIAG_CONTADOR <= 0) THEN
        BEGIN
            INSERT INTO TMP(                                                        --TABLA DEL SQL SERVER
                TIPO_DIAGNOSTICO, CD_CODI_DIAG_RLAD)
            VALUES(
                'SA','NA');
        END;
    END IF;

    -----------------------
    --diagnostico muerte
    SELECT COUNT(*) 
    INTO V_DIAG_CONTADOR
    FROM TMP                                                                      --TABLA DEL SQL SERVER
    WHERE TIPO_DIAGNOSTICO = 'MU';

    IF(V_DIAG_CONTADOR <= 0) THEN
        BEGIN
            INSERT INTO TMP(                                                     --TABLA DEL SQL SERVER
                TIPO_DIAGNOSTICO, CD_CODI_DIAG_RLAD)
            VALUES(
                'MU','NA');
        END;
    END IF;

    ---------------------------
    OPEN CV_1 FOR
        SELECT *
        FROM TMP;                                                                 --TABLA DEL SQL SERVER


EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;

    CREATE TABLE #tmp(TIPO_DIAGNOSTICO VARCHAR(2), CD_CODI_DIAG_RLAD [varchar](4))   
    
