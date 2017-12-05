CREATE OR REPLACE TRIGGER TR_HIST_PROC_NUMEROAUTOR
AFTER INSERT
ON HIST_PROC
FOR EACH ROW
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- ============================================= 
DECLARE
    V_ACT_HIST VARCHAR2(15);
    V_LAST_CONC VARCHAR2(2);
    V_ACT_ID NUMBER;
    V_NUM_AUTO_PROC NUMBER;
    V_NUM_AUTO_MED NUMBER;
    V_NUM_AUTO_OT_CONCEPTO NUMBER;
    V_AUTORIZACION NUMBER;
    V_CODI_SER_INSD VARCHAR2(15);
BEGIN											
    -- NUMERO HIST ACTUAL   
    SELECT :NEW.NU_NUME_HICL_HPRO
    INTO V_ACT_HIST
    FROM DUAL;
    ------------------------------------------------------
    -- CODIGO SERV ACTUAL
    SELECT :NEW.CD_CODI_SER_HPRO 
    INTO V_CODI_SER_INSD
    FROM DUAL;
    ------------------------------------------------------
    -- ID HISTPROC ACTUAL
    SELECT :NEW.NU_NUME_HPRO 
    INTO V_ACT_ID
    FROM DUAL;
    ------------------------------------------------------
    -- OTRO REGISTRO CON EL MISMO CONCEPTO MEDICO 
    SELECT CONCEPTOS_SERV.CD_CODI_COSE
    INTO V_LAST_CONC
    FROM ((SERVICIOS SERVICIOS
    INNER JOIN CONCEPTOS_SERV CONCEPTOS_SERV                  
        ON (SERVICIOS.CD_CODI_COSE_SER = CONCEPTOS_SERV.CD_CODI_COSE))
    INNER JOIN HIST_PROC HIST_PROC
        ON (HIST_PROC.CD_CODI_SER_HPRO = SERVICIOS.CD_CODI_SER))
    INNER JOIN HISTORIACLINICA HISTORIACLINICA
        ON (HISTORIACLINICA.NU_NUME_HICL = HIST_PROC.NU_NUME_HICL_HPRO)
    WHERE HISTORIACLINICA.NU_NUME_HICL = V_ACT_HIST 
        AND  HIST_PROC.CD_CODI_SER_HPRO = V_CODI_SER_INSD
        AND ROWNUM<=1;
    ------------------------------------------------------
   -- VERIFICAMOS SI YA SE REGISTRO UN NUMERO POR CONCEPTO
    SELECT MAX(HIST_PROC.NUM_AUTORIZACION)
    INTO V_NUM_AUTO_OT_CONCEPTO
    FROM ((HIST_PROC HIST_PROC
    INNER JOIN SERVICIOS SERVICIOS
        ON (HIST_PROC.CD_CODI_SER_HPRO = SERVICIOS.CD_CODI_SER))
    INNER JOIN CONCEPTOS_SERV CONCEPTOS_SERV
        ON (SERVICIOS.CD_CODI_COSE_SER = CONCEPTOS_SERV.CD_CODI_COSE))
    INNER JOIN HISTORIACLINICA HISTORIACLINICA
        ON (HISTORIACLINICA.NU_NUME_HICL = HIST_PROC.NU_NUME_HICL_HPRO)
    WHERE HISTORIACLINICA.NU_NUME_HICL = V_ACT_HIST
    AND CONCEPTOS_SERV.CD_CODI_COSE = V_LAST_CONC
    AND HIST_PROC.NU_NUME_HPRO != V_ACT_ID;
    ------------------------------------------------------
    IF (V_NUM_AUTO_OT_CONCEPTO IS NULL) THEN
        BEGIN
            -- EL NUMERO POR OTRO PROCESO
            SELECT MAX(NUM_AUTORIZACION)
            INTO V_NUM_AUTO_PROC
            FROM HIST_PROC
            WHERE NU_NUME_HICL_HPRO = V_ACT_HIST
                AND CD_CODI_SER_HPRO != V_CODI_SER_INSD;
            ------------------------------------------------------         
            SELECT MAX(NUM_AUTORIZACION)
            INTO V_NUM_AUTO_MED
            FROM HIST_MEDI
            WHERE NU_NUME_HICL_HMED = V_ACT_HIST;
            ------------------------------------------------------
            IF (V_NUM_AUTO_PROC IS NULL) THEN
                BEGIN
                  V_NUM_AUTO_PROC := 0;
                END;
            END IF;
            ------------------------------------------------------                           
            IF (V_NUM_AUTO_MED IS NULL) THEN
                BEGIN
                    V_NUM_AUTO_MED := 0;
                END;
            END IF;
            ------------------------------------------------------
            -- NO SE ENCONTRO UN NUMERO CON EL MISMO HISTORIA RECURIMOS AL ANTERIOR
            IF (V_NUM_AUTO_MED = 0 AND V_NUM_AUTO_PROC = 0) THEN
                BEGIN
                    SELECT MAX(NUM_AUTORIZACION) 
                    INTO V_NUM_AUTO_PROC
                    FROM HIST_PROC;
                    ------------------------------------------------------
                    SELECT MAX(NUM_AUTORIZACION) 
                    INTO V_NUM_AUTO_MED 
                    FROM HIST_MEDI;
                    ------------------------------------------------------
                    -- RECU
                    IF (V_NUM_AUTO_PROC IS NULL) THEN
                        BEGIN
                          V_NUM_AUTO_PROC := 0;
                        END;
                    END IF;
                    ------------------------------------------------------
                    IF (V_NUM_AUTO_MED IS NULL) THEN
                        BEGIN
                            V_NUM_AUTO_MED := 0;
                        END;
                    END IF;
                END;
            END IF;
            ------------------------------------------------------
            IF V_NUM_AUTO_PROC > V_NUM_AUTO_MED THEN
                BEGIN
                    V_AUTORIZACION := V_NUM_AUTO_PROC;
                END;

            ELSE
                BEGIN
                    V_AUTORIZACION := V_NUM_AUTO_MED;
                END;
            END IF;
            ------------------------------------------------------
            -- HASTA ACA EL NUMERO DE AUTORIZACION ES EL ULTIMO SE DEBE DE ADICIONAR A UNO
            V_AUTORIZACION := V_AUTORIZACION + 1;
        END;
    ELSE
        BEGIN
           -- NO SE INCREMENTA POR QUE EXISTE OTRO REGISTRO CON EL MISMO CONCEPTO MEDICO
           V_AUTORIZACION := V_NUM_AUTO_OT_CONCEPTO;
        END;
    END IF;
    ------------------------------------------------------
    -- ACTUALIZAMOS EL NUMERO DE AUTORIZACION
    UPDATE HIST_PROC
    SET NUM_AUTORIZACION = V_AUTORIZACION
    WHERE NU_NUME_HPRO = :NEW.NU_NUME_HPRO;
END;