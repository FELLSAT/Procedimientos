CREATE OR REPLACE PROCEDURE H3i_SP_CITA_LIMITE
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_EPS IN VARCHAR2,
    v_CONVENIO IN NUMBER,
    v_ESPECIALIDAD IN VARCHAR2,
    v_DEPENDENCIA IN VARCHAR2,
    v_SERVICIO IN VARCHAR2,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT ID_IDEN_CL ,
            CD_NIT_EPS_CL ,
            NU_NUME_CONV_CL ,
            CD_CODI_ESP_CL ,
            CD_CODI_CECO_CL ,
            CD_CODI_SER_CL ,
            NU_NUME_UNI_CL ,
            NU_NUME_PER_CL ,
            NU_NUME_CIT_CL ,
            NU_NUME_EST_CL ,
            FE_FECH_CL ,
            NO_NOMB_EPS ,
            CD_NOMB_CONV ,
            CD_CODI_CONV ,
            NO_NOMB_ESP ,
            NO_NOMB_CECO ,
            NO_NOMB_SER 
        FROM CITAS_LIMITE CL
        INNER JOIN EPS    
            ON CD_NIT_EPS_CL = CD_NIT_EPS
        INNER JOIN CONVENIOS    
            ON NU_NUME_CONV_CL = NU_NUME_CONV
        INNER JOIN ESPECIALIDADES    
            ON CD_CODI_ESP_CL = CD_CODI_ESP
        INNER JOIN CENTRO_COSTO    
            ON CD_CODI_CECO_CL = CD_CODI_CECO
        INNER JOIN SERVICIOS    
            ON CD_CODI_SER_CL = CD_CODI_SER
        WHERE  CD_NIT_EPS_CL = v_EPS
            AND NU_NUME_CONV_CL = v_CONVENIO
            AND CD_CODI_ESP_CL = v_ESPECIALIDAD
            AND CD_CODI_CECO_CL = v_DEPENDENCIA
            AND CD_CODI_SER_CL = v_SERVICIO
            AND NU_NUME_EST_CL = 1 ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;