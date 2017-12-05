CREATE OR REPLACE PROCEDURE H3i_ICEBERGFACONXNUMHCL_CON
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_HIST_PAC IN VARCHAR2,
  v_DESDE IN DATE,
  v_HASTA IN DATE,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT DISTINCT IFC.NU_NUME_FACO ,
            IFC.tx_prefijo_iceberg ,
            NU_NUME_ICEBERG ,
            FC.FE_FECH_FACO ,
            FC.VL_TOTA_FACO ,
            FC.CAJERO ,
            FC.NU_ESTA_FACO ,
            IFC.is_manual ,
            IFC.nu_nume_impre ,
            0 SALDO  
        FROM iceberg_facturas_contado IFC
        INNER JOIN FACTURAS_CONTADO FC   
            ON IFC.NU_NUME_FACO = FC.NU_NUME_FACO
        INNER JOIN MOVI_CARGOS MV   
            ON FC.NU_NUME_FACO = MV.NU_NUME_FACO_MOVI
        WHERE  MV.NU_HIST_PAC_MOVI = v_NU_HIST_PAC
                AND TO_CHAR(FC.FE_FECH_FACO,'yymmdd') BETWEEN TO_CHAR(v_DESDE,'yymmdd') AND TO_CHAR(v_HASTA,'yymmdd') ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;