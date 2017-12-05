CREATE OR REPLACE PROCEDURE H3i_SP_CREARESM
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_CODIGO IN VARCHAR2,
    v_NOMBRE IN VARCHAR2,
    v_SIGLA IN VARCHAR2,
    v_MUNICIPIO IN VARCHAR2,
    v_DEPARTAMENTO IN VARCHAR2,
    v_FUERZA IN VARCHAR2,
    v_MODALIDAD IN VARCHAR2,
    v_ORDENXTIPO IN NUMBER,
    v_CODSERV IN VARCHAR2,
    v_NOMSERV IN VARCHAR2,
    v_ESTADO IN NUMBER
)
AS
    v_temp NUMBER(1, 0) := 0;

BEGIN

    BEGIN
        SELECT 1 INTO v_temp
        FROM DUAL
        WHERE EXISTS( SELECT CD_CODI_ESM 
                      FROM AUDI_ESM 
                      WHERE  CD_CODI_ESM = v_CODIGO );
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;
      
    IF v_temp = 1 THEN
    
        BEGIN
            UPDATE AUDI_ESM
            SET NO_NOMB_ESM = v_NOMBRE,
                TX_SIGLA_ESM = v_SIGLA,
                TX_CODI_MUNI = v_MUNICIPIO,
                TX_CODI_DPTO = v_DEPARTAMENTO,
                NU_ORDE_X_TIPO_ESM = v_ORDENXTIPO,
                TX_FUER_ESM = v_FUERZA,
                TX_MODA_ESM = v_MODALIDAD,
                CD_CODI_DROSERV = v_CODSERV,
                NO_NOMB_DROSERV = v_NOMSERV,
                ESTADO = v_ESTADO
            WHERE  CD_CODI_ESM = v_CODIGO;
        END;

    ELSE
   
        BEGIN
            INSERT INTO AUDI_ESM( 
                CD_CODI_ESM, NO_NOMB_ESM, 
                TX_SIGLA_ESM, TX_CODI_MUNI, 
                TX_CODI_DPTO, NU_ORDE_X_TIPO_ESM, 
                TX_FUER_ESM, TX_MODA_ESM, 
                CD_CODI_DROSERV, NO_NOMB_DROSERV, 
                ESTADO )
            VALUES ( v_CODIGO, v_NOMBRE, 
              v_SIGLA, v_MUNICIPIO, 
              v_DEPARTAMENTO, v_ORDENXTIPO, 
              v_FUERZA, v_MODALIDAD, 
              v_CODSERV, v_NOMSERV, 
              v_ESTADO );
        END;

    END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;