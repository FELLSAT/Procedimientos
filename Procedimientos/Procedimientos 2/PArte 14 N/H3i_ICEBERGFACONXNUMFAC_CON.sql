CREATE OR REPLACE PROCEDURE H3i_ICEBERGFACONXNUMFAC_CON
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NU_NUME_FACO IN NUMBER,
    cv_1 OUT SYS_REFCURSOR
)
AS
  tt_agrup_ser
  tt_agrup_art
BEGIN  
    -------------------------------------------------------
    INSERT INTO tt_agrup_ser ( 
   	    SELECT IFC.NU_NUME_FACO ,
            MV.NU_HIST_PAC_MOVI ,
            LB.VL_UNID_LABO VL_UNID_MOVI  ,
            SUM(LB.VL_UNID_LABO)  SUBTOTAL  ,
            SR.CD_CODI_SER ,
            COUNT(SR.CD_CODI_SER)  CANTIDAD  
   	    FROM iceberg_facturas_contado IFC
        INNER JOIN FACTURAS_CONTADO FC   
            ON IFC.NU_NUME_FACO = FC.NU_NUME_FACO
        INNER JOIN MOVI_CARGOS MV   
            ON FC.NU_NUME_FACO = MV.NU_NUME_FACO_MOVI
        INNER JOIN LABORATORIO LB   
            ON LB.NU_NUME_MOVI_LABO = MV.NU_NUME_MOVI
        INNER JOIN SERVICIOS SR  
            ON LB.CD_CODI_SER_LABO = SR.CD_CODI_SER
   	    WHERE  IFC.NU_NUME_FACO = v_NU_NUME_FACO
            AND MV.NU_TIPO_MOVI IN ( 0,2,3,4,5,6)
        GROUP BY IFC.NU_NUME_FACO,MV.NU_HIST_PAC_MOVI,
            LB.VL_UNID_LABO,SR.CD_CODI_SER);

    -------------------------------------------------------
    INSERT INTO tt_agrup_art ( 
        SELECT IFC.NU_NUME_FACO ,
            MV.NU_HIST_PAC_MOVI ,
            FO.VL_UNID_FORM ,
            SUM(VL_COPA_FORM)  SUBTOTAL  ,
            FO.CD_CODI_ELE_FORM ,
            SUM(FO.CT_CANT_FORM)  CANTIDAD  
        FROM iceberg_facturas_contado IFC
        INNER JOIN FACTURAS_CONTADO FC   
            ON IFC.NU_NUME_FACO = FC.NU_NUME_FACO
        INNER JOIN MOVI_CARGOS MV   
            ON FC.NU_NUME_FACO = MV.NU_NUME_FACO_MOVI
        INNER JOIN FORMULAS FO   
            ON FO.NU_NUME_MOVI_FORM = MV.NU_NUME_MOVI
        WHERE  IFC.NU_NUME_FACO = v_NU_NUME_FACO
            AND MV.NU_TIPO_MOVI = 1 
        GROUP BY IFC.NU_NUME_FACO,MV.NU_HIST_PAC_MOVI,FO.VL_UNID_FORM,FO.CD_CODI_ELE_FORM );

    -------------------------------------------------------
    INSERT INTO tt_agru_ice ( 
   	SELECT tt_agrup_ser.NU_NUME_FACO ,
           tt_agrup_ser.VL_UNID_MOVI ,
           tt_agrup_ser.SUBTOTAL ,
           tt_agrup_ser.CD_CODI_SER ,
           tt_agrup_ser.CANTIDAD ,
           PACIENTES.NO_NOMB_PAC ,
           PACIENTES.NO_SGNO_PAC ,
           PACIENTES.DE_PRAP_PAC ,
           PACIENTES.DE_SGAP_PAC ,
           PACIENTES.NU_TIPD_PAC ,
           PACIENTES.NU_DOCU_PAC ,
           PACIENTES.DE_DIRE_PAC ,
           PACIENTES.DE_TELE_PAC ,
           iceberg_referencias.cd_codi_iceberg ,
           iceberg_referencias.no_nomb_iceberg 
   	  FROM tt_agrup_ser ,
           PACIENTES ,
           iceberg_referencias ,
           iceberg_servicios 
   	 WHERE  tt_agrup_ser.CD_CODI_SER = iceberg_servicios.cd_codi_ser
              AND iceberg_referencias.cd_codi_iceberg = iceberg_servicios.cd_codi_iceberg
              AND tt_agrup_ser.NU_HIST_PAC_MOVI = PACIENTES.NU_HIST_PAC
   	UNION 
   	SELECT tt_agrup_art.NU_NUME_FACO ,
           tt_agrup_art.VL_UNID_FORM ,
           tt_agrup_art.SUBTOTAL ,
           tt_agrup_art.CD_CODI_ELE_FORM ,
           tt_agrup_art.CANTIDAD ,
           PACIENTES.NO_NOMB_PAC ,
           PACIENTES.NO_SGNO_PAC ,
           PACIENTES.DE_PRAP_PAC ,
           PACIENTES.DE_SGAP_PAC ,
           PACIENTES.NU_TIPD_PAC ,
           PACIENTES.NU_DOCU_PAC ,
           PACIENTES.DE_DIRE_PAC ,
           PACIENTES.DE_TELE_PAC ,
           iceberg_referencias.cd_codi_iceberg ,
           iceberg_referencias.no_nomb_iceberg 
   	  FROM tt_agrup_art ,
           PACIENTES ,
           iceberg_referencias ,
           iceberg_articulos 
   	 WHERE  tt_agrup_art.CD_CODI_ELE_FORM = iceberg_articulos.cd_codi_arti
              AND iceberg_referencias.cd_codi_iceberg = iceberg_articulos.cd_codi_iceberg
              AND tt_agrup_art.NU_HIST_PAC_MOVI = PACIENTES.NU_HIST_PAC );
   OPEN  cv_1 FOR
      SELECT IFC.NU_NUME_FACO ,
             IFC.TX_PREFIJO_ICEBERG ,
             IFC.NU_NUME_ICEBERG ,
             IFC.DT_ELABORA_FAC ,
             FC.FE_FECH_FACO ,
             FC.VL_TOTA_FACO ,
             tt_agru_ice.VL_UNID_MOVI ,
             tt_agru_ice.SUBTOTAL ,
             tt_agru_ice.CANTIDAD ,
             tt_agru_ice.CD_CODI_ICEBERG ,
             tt_agru_ice.NO_NOMB_ICEBERG ,
             0 VL_RECU_FACO  ,
             FC.DE_MONT_FACO ,
             tt_agru_ice.NO_NOMB_PAC ,
             tt_agru_ice.NO_SGNO_PAC ,
             tt_agru_ice.DE_PRAP_PAC ,
             tt_agru_ice.DE_SGAP_PAC ,
             tt_agru_ice.NU_TIPD_PAC ,
             tt_agru_ice.NU_DOCU_PAC ,
             tt_agru_ice.DE_DIRE_PAC ,
             tt_agru_ice.DE_TELE_PAC 
        FROM iceberg_facturas_contado IFC
               JOIN tt_agru_ice    ON IFC.NU_NUME_FACO = tt_agru_ice.NU_NUME_FACO
               JOIN FACTURAS_CONTADO FC   ON IFC.NU_NUME_FACO = FC.NU_NUME_FACO
               JOIN iceberg_servicios ISR   ON tt_agru_ice.CD_CODI_SER = ISR.CD_CODI_SER
      UNION 
      SELECT IFC.NU_NUME_FACO ,
             IFC.TX_PREFIJO_ICEBERG ,
             IFC.NU_NUME_ICEBERG ,
             IFC.DT_ELABORA_FAC ,
             FC.FE_FECH_FACO ,
             FC.VL_TOTA_FACO ,
             tt_agru_ice.VL_UNID_MOVI ,
             tt_agru_ice.SUBTOTAL ,
             tt_agru_ice.CANTIDAD ,
             tt_agru_ice.CD_CODI_ICEBERG ,
             tt_agru_ice.NO_NOMB_ICEBERG ,
             0 VL_RECU_FACO  ,
             FC.DE_MONT_FACO ,
             tt_agru_ice.NO_NOMB_PAC ,
             tt_agru_ice.NO_SGNO_PAC ,
             tt_agru_ice.DE_PRAP_PAC ,
             tt_agru_ice.DE_SGAP_PAC ,
             tt_agru_ice.NU_TIPD_PAC ,
             tt_agru_ice.NU_DOCU_PAC ,
             tt_agru_ice.DE_DIRE_PAC ,
             tt_agru_ice.DE_TELE_PAC 
        FROM iceberg_facturas_contado IFC
               JOIN tt_agru_ice    ON IFC.NU_NUME_FACO = tt_agru_ice.NU_NUME_FACO
               JOIN FACTURAS_CONTADO FC   ON IFC.NU_NUME_FACO = FC.NU_NUME_FACO
               JOIN iceberg_articulos IAR   ON tt_agru_ice.CD_CODI_SER = IAR.CD_CODI_ARTI
       WHERE  tt_agru_ice.NU_NUME_FACO = v_NU_NUME_FACO ;
   EXECUTE IMMEDIATE ' TRUNCATE TABLE tt_agrup_ser ';
   EXECUTE IMMEDIATE ' TRUNCATE TABLE tt_agrup_art ';
   EXECUTE IMMEDIATE ' TRUNCATE TABLE tt_agru_ice ';

EXCEPTION WHEN OTHERS THEN utils.handleerror(SQLCODE,SQLERRM);
END;