CREATE OR REPLACE PROCEDURE CONSPARAM_PRUSOL_RESUL_LABCLIN
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_CD_CODI_PRM IN NUMBER,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN
   
    INSERT INTO tt_TEMP_12 ( 
        SELECT NU_TOPEIN_TPDA ,
            NU_TOPESU_TPDA ,
            NU_AUTO_DAEX_TPDA ,
            TX_NOMB_GPET ,
            TX_NOMB_ITGE 
        FROM GRUPO_ETAREO 
        INNER JOIN ITEM_GRUPOETAREO    
            ON TX_CODI_GPET = TX_CODI_GPET_ITGE
        INNER JOIN TOPE_DATOEXAMEN    
            ON NU_AUTO_ITGE = NU_AUTO_ITGE_TPDA
        WHERE  NU_SEXO_ITGE = ( SELECT NU_SEXO_PAC 
                                FROM PROCESAMIENTO_MUESTRA 
                                INNER JOIN PACIENTES    
                                    ON NU_HIST_PAC = NU_HIST_PAC_PRM
                                WHERE  CD_CODI_PRM = v_CD_CODI_PRM 
                                    AND ROWNUM <= 1 )
            AND NU_UNMED_ITGE = ( SELECT CalcularEdad(FE_NACI_PAC, SYSDATE, 1) 
                                  FROM PROCESAMIENTO_MUESTRA 
                                  INNER JOIN PACIENTES    
                                      ON NU_HIST_PAC = NU_HIST_PAC_PRM
                                  WHERE  CD_CODI_PRM = v_CD_CODI_PRM AND ROWNUM <= 1 )
                                      AND ( SELECT CalcularEdad(FE_NACI_PAC, SYSDATE, 0) 
                                            FROM PROCESAMIENTO_MUESTRA 
                                            INNER JOIN PACIENTES    
                                                ON NU_HIST_PAC = NU_HIST_PAC_PRM
                                            WHERE  CD_CODI_PRM = v_CD_CODI_PRM 
                                                AND ROWNUM <= 1 ) BETWEEN NU_EDADIN_ITGE AND NU_EDADFI_ITGE
            AND NU_TOPEIN_TPDA <> NU_TOPESU_TPDA );


    --SELECT * FROM tt_TEMP_12
    OPEN  cv_1 FOR
        SELECT NO_NOMB_SER ,
            NU_GRUP_DAEX ,
            NO_NOMB_DAEX ,
            DE_VALO_DARE ,
            DE_UNDM_DAEX ,
            NVL(( SELECT NU_TOPEIN_TPDA 
                  FROM tt_TEMP_12 
                  WHERE  NU_AUTO_DAEX_TPDA = NU_AUTO_DAEX 
                      AND ROWNUM <= 1 ), 0) VL_INRE_DARE  ,
            NVL(( SELECT NU_TOPESU_TPDA 
                  FROM tt_TEMP_12 
                  WHERE  NU_AUTO_DAEX_TPDA = NU_AUTO_DAEX 
                      AND ROWNUM <= 1 ), 0) VL_SURE_DARE  ,
            NU_NUME_RESU ,
            CD_CODI_DAEX ,
            NVL(( SELECT TX_NOMB_GPET 
                  FROM tt_TEMP_12 
                  WHERE  NU_AUTO_DAEX_TPDA = NU_AUTO_DAEX 
                      AND ROWNUM <= 1 ), 0) TX_NOMB_GPET  ,
            NVL(( SELECT TX_NOMB_ITGE 
                  FROM tt_TEMP_12 
                  WHERE  NU_AUTO_DAEX_TPDA = NU_AUTO_DAEX 
                      AND ROWNUM <= 1 ), 0) TX_NOMB_ITGE  
        FROM PROCESAMIENTO_MUESTRA 
        INNER JOIN SERVICIOS    
            ON CD_CODI_SER = CD_CODI_SER_PRM
        INNER JOIN DATOS_EXAMEN    
            ON CD_CODI_SER_DAEX = CD_CODI_SER_PRM
        LEFT JOIN RESULTADOS1    
            ON CD_CODI_PRM = CD_CODI_PRM_RESU
        LEFT JOIN DATOS_RESU    
            ON NU_NUME_RESU = NU_NUME_RESU_DARE
        AND CD_CODI_DAEX = CD_CODI_DAEX_DARE
        WHERE  NU_ESTA_DAEX = 1
            AND ( CD_CODI_ESM_PRM = 1
              OR CD_CODI_ESM_PRM = 2 )
            AND CD_CODI_PRM = v_CD_CODI_PRM
            AND NU_NUME_RESU_REPE_RESU IS NULL ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;