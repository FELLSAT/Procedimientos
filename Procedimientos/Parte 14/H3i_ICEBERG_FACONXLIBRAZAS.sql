CREATE OR REPLACE PROCEDURE H3i_ICEBERG_FACONXLIBRAZAS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_DESDE IN DATE,
    v_HASTA IN DATE,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT IFC.tx_prefijo_iceberg ,
            IFC.nu_nume_iceberg ,
            IFC.dt_elabora_fac ,
            RFOP.NU_NUME_FACO_RFF ,
            FP.DE_DESC_FOPA ,
            RFOP.NU_MONTO_RFF ,
            FC.VL_TOTA_FACO ,
            0 SALDO  ,
            PAC.NO_NOMB_PAC ,
            PAC.NO_SGNO_PAC ,
            PAC.DE_PRAP_PAC ,
            PAC.DE_SGAP_PAC ,
            PAC.NU_TIPD_PAC ,
            PAC.NU_DOCU_PAC ,
            PAC.DE_DIRE_PAC ,
            PAC.DE_TELE_PAC 
        FROM iceberg_facturas_contado IFC
        INNER JOIN FACTURAS_CONTADO FC   
            ON IFC.NU_NUME_FACO = FC.NU_NUME_FACO
        INNER JOIN MOVI_CARGOS MV   
            ON FC.NU_NUME_FACO = MV.NU_NUME_FACO_MOVI
        INNER JOIN R_FOP_FACO RFOP   
            ON FC.NU_NUME_FACO = RFOP.NU_NUME_FACO_RFF
        INNER JOIN FORMA_PAGO FP   
            ON RFOP.NU_NUME_FOPA_RFF = FP.NU_NUME_FOPA
        INNER JOIN PACIENTES PAC   
            ON PAC.NU_HIST_PAC = MV.NU_HIST_PAC_MOVI
        WHERE  RFOP.NU_NUME_FOPA_RFF = 3
                AND TO_CHAR(FC.FE_FECH_FACO,'yymmdd') BETWEEN TO_CHAR(v_DESDE,'yymmdd') AND TO_CHAR(v_HASTA,'yymmdd')
        ORDER BY PAC.NU_DOCU_PAC,
                 IFC.tx_prefijo_iceberg,
                 IFC.nu_nume_iceberg ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;