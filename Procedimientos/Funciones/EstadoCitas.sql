CREATE OR REPLACE FUNCTION EstadoCitas
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_FechaCit IN VARCHAR2,
    v_CodMedico IN VARCHAR2,
    v_CodServicio IN VARCHAR2
)
RETURN NUMBER
AS
    v_NumEstados NUMBER(10,0);
    v_EsGrupal NUMBER(10,0);
    v_ESTADO NUMBER(10,0);

BEGIN
    SELECT 1 
    INTO v_EsGrupal
    FROM SERVICIOS 
    WHERE  CD_CODI_SER = v_CodServicio
        AND NU_ESGRUPAL_SER = 1;

    IF NOT (v_EsGrupal IS NULL) THEN    

        BEGIN
            SELECT COUNT(DISTINCT NU_ESTA_CIT)  
            INTO v_NumEstados
            FROM CITAS_MEDICAS 
            WHERE  CD_CODI_MED_CIT = v_CodMedico
                AND FE_FECH_CIT = v_FechaCit
                AND CD_CODI_SER_CIT = v_CodServicio;

            IF v_NumEstados <= 1 THEN
                SELECT NU_ESTA_CIT 
                INTO v_ESTADO
                FROM CITAS_MEDICAS 
                WHERE  CD_CODI_MED_CIT = v_CodMedico
                AND FE_FECH_CIT = v_FechaCit
                AND CD_CODI_SER_CIT = v_CodServicio AND ROWNUM <= 1;
            ELSE
                v_ESTADO := -1 ;--PARA CUANDO EN UNA CITA GRUPAL HAY MARCADOS MÁS DE UN ESTADO
            END IF;
        END;

    ELSE
        SELECT NU_ESTA_CIT 
        INTO v_ESTADO
        FROM CITAS_MEDICAS 
        WHERE  CD_CODI_MED_CIT = v_CodMedico
            AND FE_FECH_CIT = v_FechaCit
            AND CD_CODI_SER_CIT = v_CodServicio AND ROWNUM <= 1;
    END IF;
    
    RETURN v_ESTADO;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;