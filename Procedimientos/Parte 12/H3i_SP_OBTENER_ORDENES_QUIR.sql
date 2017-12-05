CREATE OR REPLACE PROCEDURE H3i_SP_OBTENER_ORDENES_QUIR
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT NU_NUME_HICL_HPRO ,
            CD_MED_ASIG_HICL ,
            CD_CODI_SER_HPRO ,
            SERVICIOS.NO_NOMB_SER ,
            DE_INDI_HPRO ,
            NU_HIST_PAC_MOVI ,
            R_ESP_SER.CD_CODI_ESP_RES 
        FROM HIST_PROC 
        INNER JOIN HISTORIACLINICA    
            ON HIST_PROC.NU_NUME_HICL_HPRO = HISTORIACLINICA.NU_NUME_HICL
        INNER JOIN LABORATORIO    
            ON LABORATORIO.NU_NUME_LABO = NU_NUME_LABO_HICL
        INNER JOIN MOVI_CARGOS    
            ON MOVI_CARGOS.NU_NUME_MOVI = LABORATORIO.NU_NUME_MOVI_LABO
        INNER JOIN SERVICIOS    
            ON SERVICIOS.CD_CODI_SER = CD_CODI_SER_HPRO
        INNER JOIN R_ESP_SER    
            ON R_ESP_SER.CD_CODI_SER_RES = SERVICIOS.CD_CODI_SER
        INNER JOIN MEDICOS    
            ON CD_CODI_MED = CD_MED_ASIG_HICL -- para filtrar medicos que ya no existen y no genere errores en agendas
        INNER JOIN PACIENTES    ON NU_HIST_PAC_MOVI = NU_HIST_PAC -- para filtrar pacientes que ya no existen, por Numero de historia clinica
        WHERE  NU_TIPO_HPRO = 3 --PARA OBTENER SOLAMENTE ORDENES QUIRURGICAS
            AND NU_NUME_SOLIC_HPRO = 0
        ORDER BY NU_NUME_HICL_HPRO DESC ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;