CREATE OR REPLACE PROCEDURE H3i_SP_CONS_CAR_FACT_PAC
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
   V_NO_HISTORIA IN VARCHAR2,
   V_ES_CARGO IN NUMBER,
   CV_1 OUT SYS_REFCURSOR
)
AS
  V_VALFACPAC NUMBER;
BEGIN  
    -----

    SELECT 
        CASE TO_CHAR(CON.VL_VALO_CONT)
           WHEN '1' THEN 1
           ELSE 0
        END
    INTO V_VALFACPAC
    FROM CONTROL  CON
    WHERE CON.CD_CONC_CONT = 'VALFACPAC';

    -----
        
    INSERT INTO TT_CARGOS_PAC
        SELECT MOV.NU_NUME_MOVI,
            MOV.NU_TIPO_MOVI,
            MOV.FE_FECH_MOVI,                              
            ESP.CD_CODI_ESP,
            MED.NO_NOMB_MED,
            MOV.VL_UNID_MOVI,
            MOV.VL_COPA_MOVI,
            EPS.NO_NOMB_EPS,
            EPS.CD_NIT_EPS,
            CON.CD_CODI_CONV,
            CON.CD_NOMB_CONV,
            MOV.NU_NUME_REG_MOVI,
            MOV.NU_NUME_CONV_MOVI,
            MOV.CD_CODI_LUAT_MOVI,
            NVL(MOV.CD_CODI_CECO_MOVI, '10') CD_CODI_CECO_MOVI,
            MOV.CD_CODI_CECO_INV,
            MOV.NU_HIST_PAC_MOVI,
            NVL(MOV.NU_ADSCR_LIQUI, 0) NU_ADSCR_LIQUI,
            CASE( SELECT COUNT(MOVI_CARGOS.NU_NUME_MOVI)
                  FROM ((LABORATORIO LABORATORIO
                  INNER JOIN MOVI_CARGOS MOVI_CARGOS
                      ON (LABORATORIO.NU_NUME_MOVI_LABO = MOVI_CARGOS.NU_NUME_MOVI))
                  INNER JOIN R_LABO_AUTO R_LABO_AUTO
                      ON (R_LABO_AUTO.NU_NUME_LABO_LAAU = LABORATORIO.NU_NUME_LABO))
                  INNER JOIN AUTORIZACION_ADSCRITOS AUTORIZACION_ADSCRITOS
                      ON (R_LABO_AUTO.NU_AUTO_AUAD_LAAU = AUTORIZACION_ADSCRITOS.NU_AUTO_AUAD)
                  WHERE MOVI_CARGOS.NU_NUME_MOVI = MOV.NU_NUME_MOVI)
                WHEN 0
                    THEN 'NO'
                ELSE 'SI'
            END AUTORIZADO,
            (   SELECT CD_IDEN_READ
                FROM AUTORIZACION_ADSCRITOS 
                INNER JOIN R_LABO_AUTO  
                    ON NU_AUTO_AUAD_LAAU = NU_AUTO_AUAD
                INNER JOIN REGISTRO_ADSCRITO 
                    ON CD_CODI_AUTORIZA_AUAD = TXT_COD_BARRA_READ                           
                WHERE NU_NUME_LABO_LAAU = NU_NUME_LABO
                  AND ROWNUM = 1) ID_AUTORIZACION
        FROM MOVI_CARGOS MOV                              
        INNER JOIN LABORATORIO  LAB
            ON  LAB.NU_NUME_MOVI_LABO = MOV.NU_NUME_MOVI
            AND MOV.NU_HIST_PAC_MOVI = V_NO_HISTORIA
            AND MOV.NU_ESTA_MOVI <> 2 -- SE EXCLUYEN LOS ANULADOS
            AND MOV.NU_NUME_FACO_MOVI = 0 -- SE INCLUYEN LOS QUE NO TIENEN FACTURA DE CONTADO
            AND MOV.NU_NUME_FAC_MOVI = 0 -- SE INLUYEN LOS QUE NO TIENEN FACTURA A CREDITO
        INNER JOIN MEDICOS MED
            ON LAB.CD_CODI_MEDI_LABO = MED.CD_CODI_MED
        INNER JOIN ESPECIALIDADES  ESP
            ON ESP.CD_CODI_ESP = LAB.CD_CODI_ESP_LABO
        INNER JOIN CONVENIOS  CON
            ON MOV.NU_NUME_CONV_MOVI = CON.NU_NUME_CONV
        INNER JOIN EPS  EPS
            ON CON.CD_NIT_EPS_CONV = EPS.CD_NIT_EPS
        GROUP BY MOV.NU_NUME_MOVI,
            MOV.NU_TIPO_MOVI,
            MOV.FE_FECH_MOVI,                            
            ESP.CD_CODI_ESP,
            MED.NO_NOMB_MED,
            MOV.VL_UNID_MOVI,
            MOV.VL_COPA_MOVI,
            EPS.NO_NOMB_EPS,
            EPS.CD_NIT_EPS,
            CON.CD_CODI_CONV,
            CON.CD_NOMB_CONV,
            MOV.NU_NUME_REG_MOVI,
            MOV.NU_NUME_CONV_MOVI,
            MOV.CD_CODI_LUAT_MOVI,
            NVL(MOV.CD_CODI_CECO_MOVI, '10'),
            MOV.CD_CODI_CECO_INV,
            MOV.NU_HIST_PAC_MOVI,
            MOV.NU_ADSCR_LIQUI,
            NU_NUME_LABO;
    ----
    --
    -- SELECCIONAR LOS LABORATORIOS CORRESPONDIENTES A LOS CARGOS FACTURABLES
    --
    INSERT INTO TT_LABORATORIOS_PAC
        SELECT LAB.NU_NUME_LABO,
            LAB.NU_NUME_MOVI_LABO,
            LAB.CD_CODI_SER_LABO,
            LAB.CT_CANT_LABO,
            LAB.VL_UNID_LABO,
            LAB.VL_COPA_LABO,
            LAB.ID_ESTA_ASIS_LABO,
            SER.NO_NOMB_SER,
            MED.NO_NOMB_MED,
            LAB.CD_CODI_ESP_LABO,
            LAB.CD_CODI_MEDI_LABO,
            LAB.NU_AUTO_LABO,
            SER.CD_CODI_COSE_SER
        FROM LABORATORIO LAB
        INNER JOIN TT_CARGOS_PAC CAR
            ON LAB.NU_NUME_MOVI_LABO = CAR.NU_NUME_MOVI
            AND LAB.NU_ESTA_LABO <> 2
        LEFT JOIN SERVICIOS SER
            ON SER.CD_CODI_SER = LAB.CD_CODI_SER_LABO
        INNER JOIN MEDICOS MED
            ON LAB.CD_CODI_MEDI_LABO = MED.CD_CODI_MED;
  
    ---
    IF (V_VALFACPAC = 0) THEN
        BEGIN

            DBMS_OUTPUT.PUT_LINE('V_VALFACPAC=' || TO_CHAR(V_VALFACPAC));

            IF (V_ES_CARGO = 1) THEN 
                BEGIN
                    OPEN CV_1 FOR
                        SELECT DISTINCT * 
                        FROM TT_CARGOS_PAC;
                END;

            ELSE

                BEGIN
                    OPEN CV_1 FOR
                        SELECT DISTINCT * 
                        FROM TT_LABORATORIOS_PAC;
                END; 
            END IF;
        END;
    END IF;

    IF (V_VALFACPAC = 1) THEN 
        BEGIN
            DBMS_OUTPUT.PUT_LINE('V_VALFACPAC=' || TO_CHAR(V_VALFACPAC));

            IF (V_ES_CARGO = 1) THEN
                BEGIN
                    OPEN CV_1 FOR
                        SELECT MOV.*
                        FROM TT_CARGOS_PAC  MOV
                        INNER JOIN TT_LABORATORIOS_PAC LAB
                            ON LAB.NU_NUME_MOVI_LABO = MOV.NU_NUME_MOVI
                        WHERE LAB.ID_ESTA_ASIS_LABO = '1';
                END;

            ELSE

                BEGIN
                    OPEN CV_1 FOR
                        SELECT LAB.*
                        FROM TT_CARGOS_PAC  MOV
                        INNER JOIN TT_LABORATORIOS_PAC  LAB
                            ON LAB.NU_NUME_MOVI_LABO = MOV.NU_NUME_MOVI
                        WHERE LAB.ID_ESTA_ASIS_LABO =  '1';
                END;
            END IF;
        END;
    END IF;

END;
