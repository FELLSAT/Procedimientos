CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_ARCH_ADS_ANUL
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_FECHAINI IN DATE,
    v_FECHAFIN IN DATE,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT CD_IDEN_READ ,
        --AA.NU_AUTO_AUAD, 
        CD_CODI_AUTORIZA_AUAD ,
        FE_AUTORIZA_AUAD ,
        TX_NOM_ADSCR_READ ,
        USUARIO ,
        TX_NOMBRECOMPLETO_PAC ,
        NU_ESTA_ANULA_AUAD ,
        ID_ANUL ,
        ID_IDEN_USUA USU_ANULA  
        FROM AUTORIZACION_ADSCRITOS AA
        INNER JOIN REGISTRO_ADSCRITO    
            ON CD_CODI_AUTORIZA_AUAD = TXT_COD_BARRA_READ
        INNER JOIN PACIENTES    
            ON NU_HIST_PAC = NU_HIST_PAC_READ
        INNER JOIN CONEXIONES    
            ON NU_NUME_CONE = NU_NUME_CONE_AUAD
        INNER JOIN ANULACION_AUTORIZACION_ADS AAA   
            ON TXT_COD_BARRA_READ = AAA.CD_CODI_AUTORIZA_AUAD_ANUL
        INNER JOIN USUARIOS    
            ON NU_DOCU_USUA = NU_DOCU_USUA_ANUL
        WHERE  FE_AUTORIZA_AUAD BETWEEN v_FECHAINI AND v_FECHAFIN ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;