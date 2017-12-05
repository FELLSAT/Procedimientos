CREATE OR REPLACE PROCEDURE H3i_SP_CONS_DAT_REQ_CON_EXTER  
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    V_NU_NUME_MOVI NUMBER,
    CV_1 OUT SYS_REFCURSOR
)     
AS
BEGIN
    OPEN CV_1 FOR
        SELECT     
            NVL(med.NO_NOMB_MED,'') AS MEDICO_ORDENA_NOMBRE, 
            med.CD_CODI_MED AS MEDICO_ORDENA, 
            esp.CD_CODI_ESP AS ESPECIALIDAD_ORDENA, 
            NVL(esp.NO_NOMB_ESP,'') AS ESPECIALIDAD_ORDENA_NOMBRE,
            NVL(mca.CD_CODI_CECO_MOVI, '')  AS CD_CODI_CECO_MOVI, 
            NVL(cco.NO_NOMB_CECO, '') AS NO_NOMB_CECO,
            mca.NU_NUME_CONV_MOVI,
            con.CD_NIT_EPS_CONV,
            pac.NU_TIPD_PAC, 
            pac.NU_DOCU_PAC, 
            pac.DE_PRAP_PAC, 
            pac.DE_SGAP_PAC, 
            pac.NO_NOMB_PAC, 
            pac.NO_SGNO_PAC, 
            pac.FE_NACI_PAC
        FROM  MOVI_CARGOS mca 
            INNER JOIN  LABORATORIO lab
                ON lab.NU_NUME_MOVI_LABO = mca.NU_NUME_MOVI 
            INNER JOIN  PACIENTES pac 
                ON mca.NU_HIST_PAC_MOVI = pac.NU_HIST_PAC 
            INNER JOIN  ESPECIALIDADES esp 
                ON lab.CD_CODI_ESP_LABO = esp.CD_CODI_ESP
            LEFT JOIN CENTRO_COSTO cco 
                ON cco.CD_CODI_CECO = mca.CD_CODI_CECO_MOVI
            INNER JOIN CONVENIOS con 
                ON mca.NU_NUME_CONV_MOVI = con.NU_NUME_CONV
            INNER JOIN MEDICOS med
                ON lab.CD_CODI_MEDI_LABO = med.CD_CODI_MED
         WHERE 
            mca.NU_NUME_MOVI = V_NU_NUME_MOVI
            AND mca.NU_ESTA_MOVI <> 2 -- SE EXCLUYEN LOS ANULADOS
        GROUP BY
            NVL(med.NO_NOMB_MED,''), 
            med.CD_CODI_MED, 
            esp.CD_CODI_ESP,
            NVL(esp.NO_NOMB_ESP,''),
            NVL(mca.CD_CODI_CECO_MOVI, ''),
            NVL(cco.NO_NOMB_CECO, ''),
            mca.NU_NUME_CONV_MOVI,
            con.CD_NIT_EPS_CONV,
            pac.NU_TIPD_PAC, 
            pac.NU_DOCU_PAC, 
            pac.DE_PRAP_PAC, 
            pac.DE_SGAP_PAC, 
            pac.NO_NOMB_PAC, 
            pac.NO_SGNO_PAC, 
            pac.FE_NACI_PAC;     
EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;