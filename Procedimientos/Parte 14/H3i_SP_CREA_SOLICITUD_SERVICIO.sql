CREATE OR REPLACE PROCEDURE H3i_SP_CREA_SOLICITUD_SERVICIO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    V_CD_CODI_REQU_RMED IN NUMBER,
    V_NU_NUME_HPRO IN NUMBER,
    V_NU_NUME_HICL_HPRO IN NUMBER,
    V_CD_CODI_SER_HPRO IN VARCHAR2
)
    
AS
BEGIN
    ----Insertar la relacion del detalle(HIST_PROC) con la requisicion(REQUISICION_MED)
    INSERT INTO R_RMED_SMED(
        CD_CODI_REQU_RMED_RRS, NU_NUME_SOLI_SMED_RRS)
    VALUES(
        V_CD_CODI_REQU_RMED, V_NU_NUME_HPRO);
    
    ---------
    --actualizar el servicio a no pendiente, para que no salga en el tablero de pendientes
    UPDATE HIST_PROC
    SET NU_ESTA_HPRO = 2
    WHERE NU_NUME_HICL_HPRO = V_NU_NUME_HICL_HPRO
        AND NU_NUME_HPRO = V_NU_NUME_HPRO        
        AND CD_CODI_SER_HPRO = V_CD_CODI_SER_HPRO;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;

    
