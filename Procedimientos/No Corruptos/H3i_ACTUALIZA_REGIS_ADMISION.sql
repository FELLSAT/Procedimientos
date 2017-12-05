CREATE OR REPLACE PROCEDURE HIMS.H3i_ACTUALIZA_REGIS_ADMISION
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    V_NU_HISTO_PAC IN VARCHAR2,
    V_COD_DIAGNOSTICO IN VARCHAR2,
    V_CAUSA_EXTERNA IN VARCHAR2    
)
    
AS
    V_COD_REG_ADM NUMBER;
    V_EXISTE NUMBER;
BEGIN
    SELECT COUNT(NU_NUME_REG)
    INTO V_EXISTE
    FROM REGISTRO    
    WHERE NU_HIST_PAC_REG = V_NU_HISTO_PAC
        AND NU_ESCU_REG = 0
        AND ID_CODI_CAEX_REG IS NULL;

    IF(V_EXISTE <> 0) THEN
        BEGIN
            SELECT NU_NUME_REG 
            INTO V_COD_REG_ADM
            FROM REGISTRO 
            WHERE NU_HIST_PAC_REG = V_NU_HISTO_PAC 
                AND NU_ESCU_REG = 0;

            SELECT COUNT(NU_NUME_LABO_RLAD)
            INTO V_EXISTE 
            FROM R_LABO_DIAG 
            WHERE NU_NUME_LABO_RLAD = V_COD_REG_ADM 
                AND ID_TIPO_DIAG_RLAD='IN' 
                AND ID_TIPO_RLAD='1';

            IF(V_EXISTE = 0) THEN
                BEGIN
                    UPDATE REGISTRO
                    SET ID_CODI_CAEX_REG = V_CAUSA_EXTERNA
                    WHERE NU_NUME_REG = V_COD_REG_ADM;

                    INSERT INTO R_LABO_DIAG(
                        NU_NUME_LABO_RLAD,
                        ID_TIPO_DIAG_RLAD,
                        ID_TIPO_RLAD,
                        CD_CODI_DIAG_RLAD,
                        CD_PROF_DX)
                    VALUES(
                        V_COD_REG_ADM,
                        'IN',
                        '1',
                        V_COD_DIAGNOSTICO,
                        0);
                END;
            END IF;
        END;
    END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;
