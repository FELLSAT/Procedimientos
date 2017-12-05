CREATE OR REPLACE PROCEDURE H3i_SP_GUAR_ACT_DATOS_RESU
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NU_NUME_RESU_DARE IN VARCHAR2,
    v_CD_CODI_SER_DARE IN VARCHAR2,
    v_CD_CODI_DAEX_DARE IN VARCHAR2,
    v_DE_VALO_DARE IN VARCHAR2,
    v_VL_INRE_DARE IN VARCHAR2,
    v_VL_SURE_DARE IN VARCHAR2
)
AS
   v_temp NUMBER(1, 0) := 0;

BEGIN

    BEGIN
        SELECT 1 
        INTO v_temp
        FROM DUAL
        WHERE ( SELECT COUNT(NU_NUME_RESU_DARE)  
                FROM DATOS_RESU 
                WHERE  NU_NUME_RESU_DARE = v_NU_NUME_RESU_DARE
                    AND CD_CODI_SER_DARE = v_CD_CODI_SER_DARE
                    AND CD_CODI_DAEX_DARE = v_CD_CODI_DAEX_DARE ) > 0;
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;
      
    IF v_temp = 1 THEN

        BEGIN
            UPDATE DATOS_RESU
            SET DE_VALO_DARE = v_DE_VALO_DARE,
                VL_INRE_DARE = v_VL_INRE_DARE,
                VL_SURE_DARE = v_VL_SURE_DARE
            WHERE  NU_NUME_RESU_DARE = v_NU_NUME_RESU_DARE
                AND CD_CODI_SER_DARE = v_CD_CODI_SER_DARE
                AND CD_CODI_DAEX_DARE = v_CD_CODI_DAEX_DARE;
        END;

    ELSE

        BEGIN
            INSERT INTO DATOS_RESU( 
                NU_NUME_RESU_DARE, CD_CODI_SER_DARE, 
                CD_CODI_DAEX_DARE, DE_VALO_DARE, 
                VL_INRE_DARE, VL_SURE_DARE )
            VALUES ( 
                v_NU_NUME_RESU_DARE, v_CD_CODI_SER_DARE, 
                v_CD_CODI_DAEX_DARE, v_DE_VALO_DARE, 
                v_VL_INRE_DARE, v_VL_SURE_DARE );
        END;

    END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;