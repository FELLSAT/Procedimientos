CREATE OR REPLACE PROCEDURE H3i_SP_OBTENER_ENCAB_FACTCNT2
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NU_NUME_FACO IN NUMBER,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT EPS.NO_NOMB_EPS Administradora  ,
            (CD_CODI_CONV || ' ' || CD_NOMB_CONV) Convenio  ,
            CD_NIT_EPS Nit_asegurador  ,
            NU_HIST_PAC Historia_No  ,
            MOSTRARTIPODOCUMENTO(NU_TIPD_PAC) Doc  ,
            NU_DOCU_PAC NumDoc  ,
            FE_FECH_FACO Fecha  ,
            (DE_PRAP_PAC || ' ' || DE_SGAP_PAC || ' ' || NO_NOMB_PAC || ' ' || NO_SGNO_PAC) Paciente  ,
            CARNE Carne  ,
            CASE NU_SEXO_PAC
                WHEN 1 THEN 'Maculino'
                WHEN 0 THEN 'Femenico'   
            END Sexo  ,
            (TO_CHAR(SYSDATE,'YYYY') - TO_CHAR(FE_NACI_PAC,'YYYY')) Edad,
            (   SELECT NU_AUTO_LABO 
                FROM LABORATORIO 
                INNER JOIN MOVI_CARGOS    
                    ON NU_NUME_MOVI = NU_NUME_MOVI_LABO
                WHERE  NU_NUME_FACO_MOVI = v_NU_NUME_FACO AND ROWNUM <= 1 ) Autorizacion  ,
            (   SELECT D.NO_NOMB_DPTO 
                FROM MOVI_CARGOS MC
                INNER JOIN LUGAR_ATENCION LA   
                    ON MC.CD_CODI_LUAT_MOVI = LA.CD_CODI_LUAT
                INNER JOIN DEPARTAMENTOS D   
                    ON LA.CD_CODI_DPTO_LUAT = D.CD_CODI_DPTO
                INNER JOIN PAISES P   
                    ON LA.CD_CODI_PAIS_LUAT = P.CD_CODI_PAIS
                WHERE  MC.NU_NUME_MOVI = NU_NUME_MOVI 
                    AND ROWNUM <= 1 ) Ciudad  ,
            FACTURAS_CONTADO.CAJERO Cajero  ,
            PACIENTES.DE_DIRE_PAC Direccion  ,            
            0 FacturaVentacontado ,
            SUM(VL_UNID_MOVI)  TotalCargos ,
            VL_RECU_FACO ValorRecuperacion ,
            (SUM(VL_UNID_MOVI)  - VL_RECU_FACO) ValorAdministradora ,--'' ValorAdministradora,
            NVL(VL_ABON_FACO, 0) ValorAbonos  ,
            DE_MONT_FACO TotalAdmLetras  ,
            NVL(VL_SUBS_FACO, 0) ValorSubsidiado  ,
            ' ' CopagoUsuario  ,
            DE_OBSE_FACO Observaciones  ,
            VL_RECA_FACO ValorRecargo  ,
            VL_FINA_FACO ValorFinanciado  ,
            DE_MONT_FACO Son  ,
            VL_TOTA_FACO TotalPagarPaciente  ,
            NU_NUME_FACO 
        FROM FACTURAS_CONTADO 
        INNER JOIN MOVI_CARGOS    
            ON NU_NUME_FACO_MOVI = NU_NUME_FACO
        INNER JOIN PACIENTES    
            ON NU_HIST_PAC_MOVI = NU_HIST_PAC
        INNER JOIN CONVENIOS    
            ON NU_NUME_CONV_MOVI = NU_NUME_CONV
        INNER JOIN EPS    
            ON CD_NIT_EPS_CONV = CD_NIT_EPS
        INNER JOIN LABORATORIO    
            ON NU_NUME_MOVI = NU_NUME_MOVI_LABO
        WHERE  NU_NUME_FACO = v_NU_NUME_FACO
        GROUP BY NO_NOMB_EPS,CD_CODI_CONV,
            CD_NOMB_CONV,CD_NIT_EPS,
            NU_HIST_PAC,NU_DOCU_PAC,
            NU_TIPD_PAC,FE_FECH_FACO,
            DE_PRAP_PAC,DE_SGAP_PAC,
            NO_NOMB_PAC,NO_SGNO_PAC,
            CARNE,NU_SEXO_PAC,
            FE_NACI_PAC,CAJERO,
            DE_DIRE_PAC,VL_TOTA_FACO,
            VL_RECU_FACO,VL_ABON_FACO,
            VL_SUBS_FACO,DE_OBSE_FACO,
            VL_RECA_FACO,VL_FINA_FACO,
            DE_MONT_FACO,NU_NUME_FACO ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;