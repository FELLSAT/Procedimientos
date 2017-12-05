CREATE OR REPLACE PROCEDURE H3i_SP_REPORTEGESTIONES
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    V_FechaInicioDia IN NUMBER,             
    V_FechaInicioMes IN NUMBER,             
    V_FechaInicioAnio IN NUMBER,            
    V_FechaFinDia IN NUMBER,             
    V_FechaFinMes IN NUMBER,             
    V_FechaFinAnio IN NUMBER,    
    V_TipoActividad IN VARCHAR2,
    CV_1 OUT SYS_REFCURSOR
)  
AS            
    V_COUNT VARCHAR2(100);
BEGIN   
    DELETE FROM TT_PRUEBA_SP_A;
    --         
    INSERT INTO TT_PRUEBA_SP_A
    SELECT * 
    FROM TABLE(fnSplit(V_TipoActividad, ','));

    
    --           
    OPEN CV_1 FOR             
        SELECT NU_HIST_PAC_GESA,      
            TX_NOMBRECOMPLETO_PAC,      
            NU_NUME_GESA,              
            FE_FERE_GESA,              
            CD_CODI_TIAC_GESA,              
            TX_DETA_GESA,              
            CD_CODI_ACAS_GESA,              
            TX_DEAS_GESA,              
            CASE CD_ESTA_GESA 
                WHEN 0 THEN 'Anulada' 
                WHEN 1 THEN 'En proceso' 
                WHEN 2 THEN 'Cerrada' 
            END CD_ESTA_GESA,              
            NU_NUME_CONE_GESA,              
            USUARIO,            
            NVL(TX_NOMB_PA, '') TX_NOMB_PA,  
            TX_DETA_SEGE  
        FROM GESTION_SALUD G              
        LEFT JOIN SEGUIMIENTO_GESTION_SALUD SGS 
            ON G.NU_NUME_GESA = SGS.NU_NUME_GESA_SEGE  
        INNER JOIN PACIENTES P 
            ON P.NU_HIST_PAC = G.NU_HIST_PAC_GESA      
        LEFT JOIN PACIENTES_ANEXO_UNAL PU 
            ON PU.NU_HIST_PAC_PAU = NU_HIST_PAC_GESA              
        LEFT JOIN CONEXIONES C 
            ON G.NU_NUME_CONE_GESA = C.NU_NUME_CONE              
        LEFT JOIN PROGRAMA_ACADEMICO PA 
            ON PA.CD_CODI_PA = PU.CD_CODI_PA_PAU      
        WHERE (TO_CHAR(FE_FERE_GESA,'MM') BETWEEN v_FechaInicioMes AND v_FechaFinMes            
            AND TO_CHAR(FE_FERE_GESA,'YYYY') BETWEEN v_FechaInicioAnio AND v_FechaFinAnio)        
            AND CD_CODI_TIAC_GESA IN (SELECT * FROM TT_PRUEBA_SP_A);  
            
            --RAISE_APPLICATION_ERROR(-20001,'COUNT: '||V_COUNT);
END;