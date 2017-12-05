CREATE OR REPLACE PROCEDURE H3i_SP_GUARDA_REPUESTA_FACTURA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    V_NU_NUME_FACO NUMBER,
    V_NUMERO_SAFIX VARCHAR2,
    V_MENSAJE VARCHAR2,
    V_VALOR_COPAGO NUMBER,
    V_VALOR_FACTURA NUMBER   
)
AS
    V_ID NUMBER := 0;
    V_ESFACTURACONTADO NUMBER;
BEGIN
    
    SELECT ID, 
        NVL(NU_NUME_FACO, 0)
    INTO V_ID,
        V_ESFACTURACONTADO
    FROM HL7_CONTROL
    WHERE IDENTITY_MESSAGE = 'DFT-P03'
        AND RESPUESTA_PROCESADA = 0
        AND FECHA_RESPUESTA IS NULL
            AND (NU_NUME_FACO = V_NU_NUME_FACO AND NU_NUME_MOVI IS NULL)
        OR (NU_NUME_MOVI = V_NU_NUME_FACO AND NU_NUME_FACO IS NULL);


    --sigue si existe una factura pendiente por ser procesada
    IF V_ID > 0 THEN
        BEGIN  
            ----------------------
            UPDATE HL7_CONTROL
            SET MENSAJE_RESPUESTA = V_MENSAJE,
                FECHA_RESPUESTA = SYSDATE,
                RESPUESTA_PROCESADA = 1
            WHERE ID = V_ID;

            ----------------------
            IF V_ESFACTURACONTADO = 1 THEN
                BEGIN
                    ----------------------
                    INSERT INTO R_FACO_FADFT(
                        NU_NUME_FACO_RFF,
                        NU_NUME_FADFT_RFF)
                    VALUES(
                        V_NU_NUME_FACO,
                        V_NUMERO_SAFIX);
                    ----------------------
                    UPDATE FACTURAS_CONTADO
                    SET VL_TOTA_FACO = V_VALOR_FACTURA,
                        VL_RECU_FACO = V_VALOR_COPAGO,
                        DE_MONT_FACO = H3i_FN_CONVERTIR_VALOR_LETRAS(V_VALOR_FACTURA);
                    WHERE NU_NUME_FACO = V_NU_NUME_FACO;
                END;
            END IF;

        END;
    END IF;
EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;