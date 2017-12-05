CREATE OR REPLACE PROCEDURE H3i_SP_CONS_FACO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_FACINICIAL IN NUMBER,
    iv_FACFINAL IN NUMBER DEFAULT NULL ,
    cv_1 OUT SYS_REFCURSOR
)
AS
    v_FACFINAL NUMBER := iv_FACFINAL;

BEGIN

    IF ( v_FACFINAL IS NULL ) THEN
        v_FACFINAL := v_FACINICIAL ;
    END IF;

    OPEN  cv_1 FOR
        SELECT NU_NUME_FACO ,
            FE_FECH_FACO ,
            VL_TOTA_FACO ,
            VL_RECU_FACO ,
            VL_SUBS_FACO ,
            DE_MONT_FACO ,
            VL_ABON_FACO ,
            NU_FOPA_FACO ,
            CAJERO ,
            EPS ,
            REGIMEN ,
            CARNE ,
            NU_ESTA_FACO ,
            DE_OBSE_FACO ,
            DE_HORA_FACO ,
            VL_RECA_FACO ,
            NU_CONE_ANUL_FACO ,
            CD_CODI_MOTI_FACO ,
            NU_CONS_MOVI_FACO ,
            CD_COMP_MOVI_FACO ,
            NU_TIPO_SEVE_FACO ,
            VL_FINA_FACO ,
            CD_CODI_LUAT_FACO ,
            ME_OBSMOD_FACO ,
            TX_PREFIJO_SEDE_FACO ,
            NU_NUME_SEDE_FACO ,
            NU_LIQSER_FACO ,
            NU_NUME_CAJA_FACO ,
            NU_CONSE_FACCAJA_FACO ,
            NU_CONEX_FACO ,
            NU_NUME_ZETA_FACO ,
            VL_IMPU_FACO ,
            MOVI.NU_HIST_PAC_MOVI ,
            TO_NUMBER(0) CREAR_FACTURA_CREDITO  
        FROM FACTURAS_CONTADO 
        INNER JOIN( SELECT DISTINCT NU_HIST_PAC_MOVI ,
                        NU_NUME_FACO_MOVI 
                    FROM MOVI_CARGOS 
                    WHERE  NU_NUME_FACO_MOVI BETWEEN v_FACINICIAL AND v_FACFINAL) MOVI   
            ON NU_NUME_FACO = NU_NUME_FACO_MOVI
        WHERE  NU_NUME_FACO BETWEEN v_FACINICIAL AND v_FACFINAL ;


EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;