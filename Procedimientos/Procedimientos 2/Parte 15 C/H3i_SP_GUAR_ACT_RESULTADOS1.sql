CREATE OR REPLACE PROCEDURE H3i_SP_GUAR_ACT_RESULTADOS1
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NU_NUME_RESU IN VARCHAR2,
    v_NU_NUME_MOVI_RESU IN NUMBER,
    v_CD_CODI_SER_RESU IN VARCHAR2,
    v_NU_HIST_PAC_RESU IN VARCHAR2,
    v_DE_NOTA_RESU IN VARCHAR2,
    v_DE_DIRI_RESU IN VARCHAR2,
    v_NU_NUME_CONE_RESU IN NUMBER,
    v_FE_FECH_RESU IN VARCHAR2,
    v_CD_CODI_SEC_RESU IN VARCHAR2,
    v_NU_NUME_REPE_RESU IN VARCHAR2,
    v_HO_HORA_RESU IN VARCHAR2,
    v_NU_NUME_CONS_REPE IN NUMBER,
    v_NU_NUME_MAX_REPE IN NUMBER,
    v_CD_CODI_PRM_RESU IN NUMBER,
    v_MED_ACTUAL_RESU IN VARCHAR2,
    v_NU_ESTA_RESU IN NUMBER,
    v_CD_CODI_RELA_RESU IN VARCHAR2
)
AS
    v_temp NUMBER(1, 0) := 0;

BEGIN

    BEGIN
        SELECT 1 INTO v_temp
        FROM DUAL
        WHERE(  SELECT COUNT(NU_NUME_RESU)  
                FROM RESULTADOS1 
                WHERE  NU_NUME_RESU = v_NU_NUME_RESU ) > 0;
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;
      
    IF v_temp = 1 THEN
      
        BEGIN
            UPDATE RESULTADOS1
            SET NU_NUME_MOVI_RESU = v_NU_NUME_MOVI_RESU,
                 CD_CODI_SER_RESU = v_CD_CODI_SER_RESU,
                 NU_HIST_PAC_RESU = v_NU_HIST_PAC_RESU,
                 DE_NOTA_RESU = v_DE_NOTA_RESU,
                 DE_DIRI_RESU = v_DE_DIRI_RESU,
                 NU_NUME_CONE_RESU = v_NU_NUME_CONE_RESU,
                 FE_FECH_RESU = v_FE_FECH_RESU,
                 CD_CODI_SEC_RESU = v_CD_CODI_SEC_RESU,
                 NU_NUME_REPE_RESU = v_NU_NUME_REPE_RESU,
                 HO_HORA_RESU = v_HO_HORA_RESU,
                 NU_NUME_CONS_REPE = v_NU_NUME_CONS_REPE,
                 NU_NUME_MAX_REPE = v_NU_NUME_MAX_REPE,
                 CD_CODI_PRM_RESU = v_CD_CODI_PRM_RESU,
                 MED_ACTUAL_RESU = v_MED_ACTUAL_RESU,
                 NU_ESTA_RESU = v_NU_ESTA_RESU,
                 CD_CODI_RELA_RESU = v_CD_CODI_RELA_RESU
            WHERE  NU_NUME_RESU = v_NU_NUME_RESU;   
        END;

    ELSE
     
        BEGIN
            INSERT INTO RESULTADOS1( 
                NU_NUME_RESU, NU_NUME_MOVI_RESU, 
                CD_CODI_SER_RESU, NU_HIST_PAC_RESU, 
                DE_NOTA_RESU, DE_DIRI_RESU, 
                NU_NUME_CONE_RESU, FE_FECH_RESU, 
                CD_CODI_SEC_RESU, NU_NUME_REPE_RESU, 
                HO_HORA_RESU, NU_NUME_CONS_REPE, 
                NU_NUME_MAX_REPE, CD_CODI_PRM_RESU, 
                MED_ACTUAL_RESU, NU_ESTA_RESU, 
                CD_CODI_RELA_RESU )
            VALUES( 
                v_NU_NUME_RESU, v_NU_NUME_MOVI_RESU, 
                v_CD_CODI_SER_RESU, v_NU_HIST_PAC_RESU, 
                v_DE_NOTA_RESU, v_DE_DIRI_RESU, 
                v_NU_NUME_CONE_RESU, v_FE_FECH_RESU, 
                v_CD_CODI_SEC_RESU, v_NU_NUME_REPE_RESU, 
                v_HO_HORA_RESU, v_NU_NUME_CONS_REPE, 
                v_NU_NUME_MAX_REPE, v_CD_CODI_PRM_RESU, 
                v_MED_ACTUAL_RESU, v_NU_ESTA_RESU, 
                v_CD_CODI_RELA_RESU );   
        END;
    END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;