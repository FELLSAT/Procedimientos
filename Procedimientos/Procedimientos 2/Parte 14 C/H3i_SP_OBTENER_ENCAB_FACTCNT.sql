CREATE OR REPLACE PROCEDURE H3i_SP_OBTENER_ENCAB_FACTCNT
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NO_HISTORIA IN VARCHAR2,
    v_CODIGO IN NUMBER,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT MOV.NU_NUME_MOVI Codigo  ,
            EPS.NO_NOMB_EPS Administradora  ,
            (CON.CD_CODI_CONV || ' ' || CON.CD_NOMB_CONV) Convenio  ,
            EPS.CD_NIT_EPS Nit_asegurador  ,
            PACIENTES.NU_HIST_PAC Historia_No  ,
            MOSTRARTIPODOCUMENTO(PACIENTES.NU_TIPD_PAC) Doc  ,
            PACIENTES.NU_DOCU_PAC NumDoc  ,
            MOV.FE_FECH_MOVI Fecha  ,
            (PACIENTES.DE_PRAP_PAC || ' ' || PACIENTES.DE_SGAP_PAC || ' ' || PACIENTES.NO_NOMB_PAC || ' ' || PACIENTES.NO_SGNO_PAC) Paciente  ,
            FACTURAS_CONTADO.CARNE Carne  ,
            CASE PACIENTES.NU_SEXO_PAC
                WHEN 1 THEN 'Maculino'
                WHEN 0 THEN 'Femenico'   
            END Sexo  ,
            (TO_CHAR(SYSDATE,'YYYY') - TO_CHAR(PACIENTES.FE_NACI_PAC,'YYYY')) Edad  ,
            REGIMEN.NO_NOMB_REG Regimen  ,
            ' ' Autorizacion  ,
            ( SELECT D.NO_NOMB_DPTO 
              FROM MOVI_CARGOS MC
              INNER JOIN LUGAR_ATENCION LA   
                  ON MC.CD_CODI_LUAT_MOVI = LA.CD_CODI_LUAT
              INNER JOIN DEPARTAMENTOS D   
                  ON LA.CD_CODI_DPTO_LUAT = D.CD_CODI_DPTO
              INNER JOIN PAISES P   
                  ON LA.CD_CODI_PAIS_LUAT = P.CD_CODI_PAIS
              WHERE  MC.NU_NUME_MOVI = MOV.NU_NUME_MOVI 
                  AND ROWNUM <= 1 ) Ciudad  ,
            FACTURAS_CONTADO.CAJERO Cajero  ,
            PACIENTES.DE_DIRE_PAC Direccion  ,
            SERVICIOS.NO_NOMB_SER Servicio  ,
            0 FacturaVentacontado ,-- NO SE CONOCE

            -- apartir de esta parte son los datos de la parte inforior
            FACTURAS_CONTADO.VL_TOTA_FACO TotalCargos  ,
            FACTURAS_CONTADO.VL_RECU_FACO ValorRecuperacion  ,
            ' ' ValorAdministradora  ,
            FACTURAS_CONTADO.VL_ABON_FACO ValorAbonos  ,
            ' ' TotalAdmLetras  ,
            FACTURAS_CONTADO.VL_SUBS_FACO ValorSubsidiado  ,
            ' ' CopagoUsuario  ,
            FACTURAS_CONTADO.DE_OBSE_FACO Observaciones  ,
            FACTURAS_CONTADO.VL_RECA_FACO ValorRecargo  ,
            FACTURAS_CONTADO.VL_FINA_FACO ValorFinanciado  ,
            FACTURAS_CONTADO.DE_MONT_FACO Son  ,
            ' ' TotalPagarPaciente  
        FROM MOVI_CARGOS MOV
        INNER JOIN MEDICOS MED   
            ON MED.CD_CODI_MED = MOV.CD_MEDI_ORDE_MOVI
            AND MOV.NU_HIST_PAC_MOVI = v_NO_HISTORIA -- '123'
        INNER JOIN PACIENTES    
            ON ( PACIENTES.NU_HIST_PAC = MOV.NU_HIST_PAC_MOVI )
        INNER JOIN R_PAC_EPS R_PAC_EPS   
            ON ( PACIENTES.NU_HIST_PAC = R_PAC_EPS.NU_HIST_PAC_RPE )
        INNER JOIN REGIMEN REGIMEN   
            ON ( R_PAC_EPS.CD_CODI_REG_RPE = REGIMEN.CD_CODI_REG )
            AND MOV.NU_ESTA_MOVI <> 2 -- SE EXCLUYEN LOS ANULADOS
        INNER JOIN LABORATORIO LAB   
            ON LAB.NU_NUME_MOVI_LABO = MOV.NU_NUME_MOVI
        INNER JOIN ESPECIALIDADES ESP   
            ON ESP.CD_CODI_ESP = LAB.CD_CODI_ESP_LABO
        INNER JOIN CONVENIOS CON   
            ON MOV.NU_NUME_CONV_MOVI = CON.NU_NUME_CONV
        INNER JOIN EPS EPS   
            ON CON.CD_NIT_EPS_CONV = EPS.CD_NIT_EPS
        INNER JOIN LABORATORIO LABORATORIO   
            ON ( LABORATORIO.NU_NUME_MOVI_LABO = MOV.NU_NUME_MOVI )
        INNER JOIN SERVICIOS SERVICIOS   
            ON ( SERVICIOS.CD_CODI_SER = LABORATORIO.CD_CODI_SER_LABO )
        INNER JOIN FACTURAS_CONTADO FACTURAS_CONTADO   
            ON ( MOV.NU_NUME_FACO_MOVI = FACTURAS_CONTADO.NU_NUME_FACO )
        WHERE  MOV.NU_NUME_MOVI = v_CODIGO ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;