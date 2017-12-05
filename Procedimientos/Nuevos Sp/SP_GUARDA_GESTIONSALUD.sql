CREATE OR REPLACE PROCEDURE HIMS.SP_GUARDA_GESTIONSALUD
-- =============================================      
-- Author:  Nelson Galeano
-- ============================================= 
(
    v_NU_HIST_PAC_GESA IN VARCHAR2,
    v_FE_FERE_GESA IN DATE,
    v_CD_CODI_TIAC_GESA IN VARCHAR2,
    v_TX_DETA_GESA IN VARCHAR2,
    v_CD_CODI_ACAS_GESA IN VARCHAR2,
    v_TX_DEAS_GESA IN VARCHAR2,
    v_CD_ESTA_GESA IN NUMBER,--0:Anulada, 1:Activa  2:Cerrada  
    v_NU_NUME_CONE_GESA IN NUMBER,
    v_NU_NUME_GESA IN NUMBER
)
aS

BEGIN
    

    IF ( v_NU_NUME_GESA = 0 ) THEN        
        BEGIN
            INSERT INTO GESTION_SALUD
            ( NU_HIST_PAC_GESA, FE_FERE_GESA, CD_CODI_TIAC_GESA, TX_DETA_GESA, CD_CODI_ACAS_GESA, TX_DEAS_GESA, CD_ESTA_GESA, NU_NUME_CONE_GESA )
            VALUES ( v_NU_HIST_PAC_GESA, v_FE_FERE_GESA, v_CD_CODI_TIAC_GESA, v_TX_DETA_GESA, v_CD_CODI_ACAS_GESA, v_TX_DEAS_GESA, v_CD_ESTA_GESA, v_NU_NUME_CONE_GESA );           
        END;
    ELSE       
        BEGIN
            UPDATE GESTION_SALUD
            SET FE_FERE_GESA = v_FE_FERE_GESA, CD_CODI_TIAC_GESA = v_CD_CODI_TIAC_GESA, TX_DETA_GESA = v_TX_DETA_GESA, CD_CODI_ACAS_GESA = v_CD_CODI_ACAS_GESA,
            TX_DEAS_GESA = v_TX_DEAS_GESA, CD_ESTA_GESA = v_CD_ESTA_GESA, NU_NUME_CONE_GESA = v_NU_NUME_CONE_GESA
            WHERE  NU_NUME_GESA = v_NU_NUME_GESA;       
        END;
    END IF;
/*
EXCEPTION 
    WHEN OTHERS THEN 
        RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);*/
END;
/