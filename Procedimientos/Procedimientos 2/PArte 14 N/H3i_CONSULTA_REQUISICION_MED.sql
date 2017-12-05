CREATE OR REPLACE PROCEDURE H3i_CONSULTA_REQUISICION_MED
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    V_CODIGO_REQUISICION IN NUMBER,
    CV_1 OUT SYS_REFCURSOR,
    CV_2 OUT SYS_REFCURSOR
)

AS
    V_regimen VARCHAR2(2);
    V_convenio NUMBER;
BEGIN   

    INSERT INTO TT_REQ(
        SELECT RME.CD_CODI_REQU_RMED,
            RME.CD_CODI_CECO_RMED,
            RME.FE_FECH_REQU_RMED,
            RME.DE_FAR_BOD_RMED,
            NVL(CCO.NO_NOMB_CECO, '') AS NO_NOMB_CECO        
        FROM REQUISICION_MED RME
            LEFT JOIN CENTRO_COSTO CCO
                ON RME.CD_CODI_CECO_RMED = CCO.CD_CODI_CECO
        WHERE RME.CD_CODI_REQU_RMED = V_CODIGO_REQUISICION
            AND RME.ID_ESTA_RMED = 1);

    ------------

    INSERT INTO TT_DETALLE(
        SELECT
            RME.CD_CODI_REQU_RMED,
            SME.CD_CODI_ARTI_SMED,
            SME.NO_NOMB_ARTI_SMED,
            NVL(hme.NU_CANT_HMED,SME.NU_CANT_SMED) AS CANTIDAD_ORDENADA,
            SME.NU_CANT_SMED AS CANTIDAD_SOLICITADA,
            TO_CHAR(NVL(SME.DE_DOSIS_SMED,'')) AS DOSIS,
            NVL(SME.DE_CTRA_SMED,'') AS DE_CTRA_SMED,
            CASE 
                WHEN SME.ID_ORDENO_SMED = 0 
                    THEN 'Enfermeria' 
                ELSE 'Medico' 
            END AS ORIGEN,
            SME.CD_CODI_MED_SMED,
            MED.NO_NOMB_MED,
            SME.NU_DOCU_PAC_SMED,
            NVL(SME.NU_NUME_HICL_SMED,0) AS NU_NUME_HICL_SMED,
            NVL(SME.NU_NUME_HMED_SMED,0) AS NU_NUME_HMED_SMED,
            SME.NU_ESTA_DEVO_SMED,
            TO_CHAR('') as CD_CODI_ESP,
            TO_CHAR('') AS NO_NOMB_ESP,
            NVL(REG.NU_TIAT_REG,1) AS NU_TIAT,
            SME.NU_NUME_SOLI_SMED,
            CASE SME.NU_CIR_SMED
                WHEN NULL THEN mca.CD_REGIMEN_MOVI
                WHEN 0 THEN mca.CD_REGIMEN_MOVI
                ELSE (  SELECT CD_CODI_REG_RPE
                        FROM R_PAC_EPS 
                        INNER JOIN CONVENIOS
                            ON CD_NIT_EPS_RPE = CD_NIT_EPS_CONV
                        INNER JOIN SOLI_CIR sca 
                            ON sca.CD_CODI_CONV = NU_NUME_CONV
                        INNER JOIN PROG_CIR ON NU_NUME_SOL_CIR = CD_CODI_SOL
                            WHERE NU_HIST_PAC_RPE =  PAC.NU_HIST_PAC
                              AND CD_CODI_PROG = SME.NU_CIR_SMED    )
            END,
            CASE SME.NU_CIR_SMED
                WHEN NULL THEN mca.NU_NUME_CONV_MOVI
                WHEN 0 THEN mca.NU_NUME_CONV_MOVI
                ELSE (  SELECT CD_CODI_CONV
                        FROM PROG_CIR pc 
                        INNER JOIN SOLI_CIR sc 
                            ON sc.NU_NUME_SOL_CIR = pc.CD_CODI_SOL
                        WHERE CD_CODI_PROG = SME.NU_CIR_SMED)
            END
        FROM TT_REQ RME
        INNER JOIN R_RMED_SMED RRS 
            ON RRS.CD_CODI_REQU_RMED_RRS = RME.CD_CODI_REQU_RMED
        INNER JOIN SOLICITUD_MED SME
            ON RRS.NU_NUME_SOLI_SMED_RRS = SME.NU_NUME_SOLI_SMED
        inner JOIN HIST_MEDI hme
            ON SME.NU_NUME_HICL_SMED = hme.NU_NUME_HICL_HMED
                AND hme.CD_CODI_ARTI_HMED = SME.CD_CODI_ARTI_SMED
        INNER JOIN MEDICOS MED 
            ON SME.CD_CODI_MED_SMED = MED.CD_CODI_MED
        INNER JOIN PACIENTES PAC 
            ON SME.NU_DOCU_PAC_SMED = PAC.NU_DOCU_PAC  
        LEFT JOIN REGISTRO REG 
            ON PAC.NU_HIST_PAC = REG.NU_HIST_PAC_REG 
            AND REG.ID_ESTA_ASIS_REG <> '1'
        LEFT JOIN HISTORIACLINICA hcl
            ON hme.NU_NUME_HICL_HMED = hcl.NU_NUME_HICL 
        LEFT JOIN  LABORATORIO lab
            ON hcl.NU_NUME_LABO_HICL = lab.NU_NUME_LABO 
        LEFT JOIN  MOVI_CARGOS mca
            ON lab.NU_NUME_MOVI_LABO = mca.NU_NUME_MOVI
    GROUP BY
        RME.CD_CODI_REQU_RMED,
        SME.CD_CODI_ARTI_SMED,
        SME.NO_NOMB_ARTI_SMED,
        hme.NU_CANT_HMED,
        SME.NU_CANT_SMED,
        TO_CHAR(NVL(SME.DE_DOSIS_SMED,'')),
        NVL(SME.DE_CTRA_SMED,''),
        CASE 
            WHEN SME.ID_ORDENO_SMED = 0 THEN 'Enfermeria' 
            ELSE 'Medico' 
        END,
        SME.CD_CODI_MED_SMED,
        MED.NO_NOMB_MED,
        SME.NU_DOCU_PAC_SMED,
        NVL(SME.NU_NUME_HICL_SMED,0),
        NVL(SME.NU_NUME_HMED_SMED,0),
        SME.NU_ESTA_DEVO_SMED,
        NVL(REG.NU_TIAT_REG,1),
        SME.NU_NUME_SOLI_SMED,
        mca.CD_REGIMEN_MOVI,
        mca.NU_NUME_CONV_MOVI,
        SME.NU_CIR_SMED,
        PAC.NU_HIST_PAC);
    
    ---------   
    SELECT CD_REGIMEN_MOVI,
        NU_NUME_CONV_MOVI
    INTO V_regimen, 
        V_convenio
    FROM TT_DETALLE
    WHERE ORIGEN = 'Medico'
        AND CD_REGIMEN_MOVI IS NOT NULL
        AND NU_NUME_CONV_MOVI IS NOT NULL
        AND ROWNUM <= 1;
        
    ---------
    UPDATE TT_DETALLE
    SET CD_REGIMEN_MOVI = V_regimen, 
        NU_NUME_CONV_MOVI = V_convenio
    WHERE CD_REGIMEN_MOVI IS NULL
        AND NU_NUME_CONV_MOVI IS NULL;
        
        
    -------
    --Actualizar la especialidad del medico
    INSERT INTO TT_T1 (
        SELECT MIN(X.CD_CODI_ESP_RMP) AS CD_CODI_ESP, 
            X.CD_CODI_MED_RMP AS COD_MEDICO    
        FROM TT_DETALLE det
            INNER JOIN R_MEDI_ESPE X
            ON X.CD_CODI_MED_RMP = DET.CD_CODI_MED_SMED
            AND X.NU_ESTADO_RMP = 1
        GROUP BY X.CD_CODI_MED_RMP);

    ----------
    UPDATE (
            SELECT T.CD_CODI_ESP AS CD_CODI_ESP,
                ESP.NO_NOMB_ESP AS NO_NOMB_ESP
            FROM TT_DETALLE DET
            INNER JOIN TT_T1 T 
                ON DET.CD_CODI_MED_SMED = T.COD_MEDICO
            INNER JOIN ESPECIALIDADES ESP 
                ON T.CD_CODI_ESP = ESP.CD_CODI_ESP) CU
    SET CU.CD_CODI_ESP = CU.CD_CODI_ESP,
        CU.NO_NOMB_ESP = CU.NO_NOMB_ESP;
     
     
    ---------
    OPEN CV_1 FOR
        SELECT * FROM TT_REQ;
    
    OPEN CV_2 FOR
        SELECT * FROM TT_DETALLE;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;
    