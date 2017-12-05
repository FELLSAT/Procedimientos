CREATE OR REPLACE VIEW FACT_REGNOPAQUELEM
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- ============================================= 
AS
    SELECT  PACIENTES.NU_HIST_PAC HISTORIA_PAC  ,
        PACIENTES.NU_DOCU_PAC DOCUMENTO_PAC  ,
        PACIENTES.NU_TIPD_PAC TIPODOC_PAC  ,
        PACIENTES.NO_NOMB_PAC || ' ' ||  
          PACIENTES.NO_SGNO_PAC || ' ' ||  
          PACIENTES.DE_PRAP_PAC || ' ' ||  
          PACIENTES.DE_SGAP_PAC NOMBRE_PAC  ,
        PACIENTES.FE_NACI_PAC FECHA_NAC_PAC  ,
        PACIENTES.DE_DIRE_PAC DIRECCION_PAC  ,
        PACIENTES.DE_TELE_PAC TELEFONO_PAC  ,
        PACIENTES.NU_SEXO_PAC SEXO_PAC  ,
        EPS.CD_NIT_EPS NIT_EPS  ,
        EPS.DE_DIRE_EPS DIRECCION_EPS  ,
        EPS.DE_TELE_EPS TELEFONO_EPS  ,
        EPS.NO_NOMB_EPS NOMBRE_EPS  ,
        CONVENIOS.NU_NUME_CONV NUM_CONVENIO  ,
        CONVENIOS.CD_CODI_CONV NOMBRE_CONVENIO  ,
        REGIMEN.CD_CODI_REG CODIGO_NIVEL  ,
        REGIMEN.NO_NOMB_REG NOMBRE_NIVEL  ,
        R_TIUS_TIUSF.TX_DESC_RTT REGIMEN  ,
        HONORARIOS.VL_CIRU_HONO VALOR_CIRUJANO  ,
        HONORARIOS.VL_ANES_HONO VALOR_ANESTESIOLOGO  ,
        HONORARIOS.VL_AYUD_HONO VALOR_AYUDANTE  ,
        HONORARIOS.VL_DESA_HONO VALOR_DERECHOSALA  ,
        HONORARIOS.VL_MASU_HONO VALOR_MATERIALSUTURA  ,
        HONORARIOS.ES_INCRUENTO PROC_INCRUENTO  ,
        FORMULAS.NU_NUME_FORM NUM_DETALLE  ,
        ARTICULO.CD_CODI_ARTI CODIGO_SERVICIO  ,
        ARTICULO.CD_RIPS_ARTI CODIGO_ALTERNO_SERVICIO  ,
        ARTICULO.NO_NOMB_ARTI NOMBRE_SERVICIO  ,
        FORMULAS.CT_CANT_FORM CANTIDAD_SERVICIO  ,
        FORMULAS.VL_UNID_FORM VALOR_UNITARIO_SERVICIO  ,
        FORMULAS.VL_COPA_FORM VALOR_COPAGO_SERVICIO  ,
        FORMULAS.CT_CANT_FORM *  FORMULAS.VL_UNID_FORM VL_TOTAL_SERVICIO  ,
        LUGAR_ATENCION_MOVI.CD_CODI_LUAT CODIGO_LUGARATENCION  ,
        LUGAR_ATENCION_MOVI.NO_NOMB_LUAT NOMBRE_LUGARATENCION  ,
        LUGAR_ATENCION_MOVI.DE_DIRE_LUAT DIRECCION_LUGARATENCION  ,
        LUGAR_ATENCION_MOVI.DE_TELE_LUAT TELEFONO_LUGARATENCION  ,
        MOVI_CARGOS.FE_FECH_MOVI FECHA_HORA_MOVIMIENTO  ,
        MOVI_CARGOS.NU_NUME_PAQU_MOVI NUM_PAQUETE  ,
        FACTURAS_CONTADO.NU_NUME_FACO NUM_FAC_CONT  ,
        FACTURAS_CONTADO.FE_FECH_FACO FECHA_FAC_CONT  ,
        FACTURAS_CONTADO.DE_HORA_FACO HORA_FAC_CONT  ,
        FACTURAS_CONTADO.CAJERO CAJERO_FAC_CONT  ,
        FACTURAS_CONTADO.VL_TOTA_FACO TOTAL_FACTURA  ,
        FACTURAS_CONTADO.DE_MONT_FACO TOTAL_FACTURA_ESCRITO  ,
        FACTURAS_CONTADO.VL_SUBS_FACO VALOR_SUBSIDIADO_FACT  ,
        FACTURAS_CONTADO.VL_RECU_FACO VALOR_RECUPERA_FACT  ,
        FACTURAS_CONTADO.VL_ABON_FACO VALOR_ABONADO_FACT  ,
        FACTURAS_CONTADO.NU_FOPA_FACO FORMA_PAGO_FACT  ,
        FACTURAS_CONTADO.NU_ESTA_FACO ESTADO_FACTURA  ,
        LUGAR_ATENCION_FACO.CD_CODI_LUAT CODIGO_LUGARFACTURACION  ,
        LUGAR_ATENCION_FACO.NO_NOMB_LUAT NOMBRE_LUGARFACTURACION  ,
        MOVI_CARGOS.NU_NUME_MOVI NUM_MOVIMIENTO  ,
        FACTURAS_CONTADO.VL_RECA_FACO VALOR_RECARGO_FACT  ,
        FACTURAS_CONTADO.VL_FINA_FACO VALOR_FINANCIADO_FACT  ,
        0 GRUPO_PAQUETE  ,
        LUGAR_ATENCION_FACO.DE_DIRE_LUAT DIRECCION_LUGARFACTURACION  ,
        LUGAR_ATENCION_FACO.DE_TELE_LUAT TELEFONO_LUGARFACTURACION  ,
        'D' TIPOREG_PAQUETE  ,
        MOVI_CARGOS.NU_TIPO_MOVI TIPO_MOVIMIENTO  ,
        REGISTRO.NU_NUME_REG NUM_REGISTRO  ,
        REGISTRO.FE_INGR_REG FECHA_INGRESO  ,
        REGISTRO.FE_HOIN_REG HORA_INGRESO  ,
        REGISTRO.FE_SALI_REG FECHA_SALIDA  ,
        REGISTRO.FE_HOSA_REG HORA_SALIDA  ,
        REGISTRO.NU_TIAT_REG TIPO_ATENCION_REGISTRO  ,
        R_PAC_EPS.CD_CARN_RPE ,
        FACTURAS_CONTADO.DE_OBSE_FACO ,
        MOVI_CARGOS.NU_ORDE_MOVI ,
        MOVI_CARGOS.CD_CODI_CECO_MOVI 
    FROM HONORARIOS 
    RIGHT JOIN LUGAR_ATENCION LUGAR_ATENCION_FACO
    RIGHT JOIN R_REGISTRO_CONV 
    INNER JOIN EPS 
    INNER JOIN CONVENIOS    
        ON EPS.CD_NIT_EPS = CONVENIOS.CD_NIT_EPS_CONV
    INNER JOIN PACIENTES 
    INNER JOIN R_PAC_EPS    
        ON PACIENTES.NU_HIST_PAC = R_PAC_EPS.NU_HIST_PAC_RPE
    INNER JOIN REGIMEN    
        ON R_PAC_EPS.CD_CODI_REG_RPE = REGIMEN.CD_CODI_REG
    INNER JOIN R_TIUS_TIUSF    
        ON REGIMEN.TX_CODI_RTT_REG = R_TIUS_TIUSF.TX_CODI_RTT
        ON EPS.CD_NIT_EPS = R_PAC_EPS.CD_NIT_EPS_RPE
    INNER JOIN REGISTRO    
        ON PACIENTES.NU_HIST_PAC = REGISTRO.NU_HIST_PAC_REG
    INNER JOIN FORMULAS 
    INNER JOIN MOVI_CARGOS    
        ON  FORMULAS.NU_NUME_MOVI_FORM =  MOVI_CARGOS.NU_NUME_MOVI
    INNER JOIN ARTICULO    
        ON FORMULAS.CD_CODI_ELE_FORM = ARTICULO.CD_CODI_ARTI
        ON REGISTRO.NU_NUME_REG = MOVI_CARGOS.NU_NUME_REG_MOVI
        ON R_REGISTRO_CONV.NU_NUME_REG_RECO = REGISTRO.NU_NUME_REG
        AND R_REGISTRO_CONV.NU_NUME_CONV_RECO = CONVENIOS.NU_NUME_CONV
    RIGHT JOIN FACTURAS_CONTADO 
        ON R_REGISTRO_CONV.NU_NUME_FACO_RECO = FACTURAS_CONTADO.NU_NUME_FACO
        AND MOVI_CARGOS.NU_NUME_FACO_MOVI = FACTURAS_CONTADO.NU_NUME_FACO
        ON LUGAR_ATENCION_FACO.CD_CODI_LUAT = FACTURAS_CONTADO.CD_CODI_LUAT_FACO
    LEFT JOIN LUGAR_ATENCION LUGAR_ATENCION_MOVI   
        ON MOVI_CARGOS.CD_CODI_LUAT_MOVI = LUGAR_ATENCION_MOVI.CD_CODI_LUAT
        ON HONORARIOS.NU_NUME_MOVI_HONO =  MOVI_CARGOS.NU_NUME_MOVI
    WHERE (MOVI_CARGOS.NU_NUME_REG_MOVI > 0 )
        AND (FACTURAS_CONTADO.NU_NUME_FACO > 0 );