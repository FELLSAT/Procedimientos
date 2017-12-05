CREATE OR REPLACE PROCEDURE H3i_SP_BUSCAR_REG_ADSC
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_CD_REG_ADSC IN NUMBER,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN
    
    OPEN  cv_1 FOR
        SELECT CD_IDEN_READ ID  ,
            MOSTRARTIPODOCUMENTO(PAC.NU_TIPD_PAC) + PAC.NU_DOCU_PAC NU_HIST_PAC_READ  ,
            PAC.NU_HIST_PAC NU_HIST_PAC_REAL  ,
            TX_NOM_COMPLE ,
            NU_TIPO_DOC ,
            NU_EDAD_PAC ,
            TXT_GENERO_PAC ,
            TXT_TIPO_USR ,
            FE_AUTO_READ ,
            FE_VENCI_READ ,
            TXT_COD_BARRA_READ ,
            TXT_ASEGURADORA_READ ,
            NO_CANT_AUTORI_READ ,
            NU_RECEPCIONADO ,
            NU_AUTORIZADO ,
            NU_PRE_REGISTRO ,
            LAB.CD_CODI_MEDI_LABO CD_MEDICO_READ  ,
            M.NO_NOMB_MED TX_NOM_MEDICO_READ  ,
            e.NO_NOMB_ESP TX_ESP_MEDICO_READ  ,
            TX_REG_MEDICO_READ ,
            TX_NOM_ADSCR_READ ,
            TX_TELF_ADSC_READ ,
            TX_DIREC_ADSCR_READ ,
            TX_OBSERVACIONES_READ ,
            PORC_CUBRIMIENTO_AUAD ,
            --agregando nuevos campos autorizador y datos area y diagnostico
            ( SELECT CD_CODI_MED 
              FROM MEDICOS 
              INNER JOIN USUARIOS    
                  ON NU_DOCU_MED = NU_DOCU_USUA
              INNER JOIN CONEXIONES CX   
                  ON CX.USUARIO = ID_IDEN_USUA
              WHERE  NU_NUME_CONE = ad.NU_NUME_CONE_AUAD ) CODI_MED_AUTORIZA  ,
            ( SELECT NO_NOMB_MED 
              FROM MEDICOS 
              INNER JOIN USUARIOS    
                  ON NU_DOCU_MED = NU_DOCU_USUA
              INNER JOIN CONEXIONES CX   
                  ON CX.USUARIO = ID_IDEN_USUA
              WHERE  NU_NUME_CONE = ad.NU_NUME_CONE_AUAD) NOMBRE_MED_AUTORIZA  ,
            NVL(( SELECT NO_NOMB_TLUAT 
                  FROM MOVI_CARGOS 
                  INNER JOIN LUGAR_ATENCION la   
                  ON CD_CODI_LUAT_MOVI = CD_CODI_LUAT
                  INNER JOIN TIPO_LUGAR_ATENCION tla   
                  ON la.CD_CODI_TLUAT = tla.CD_CODI_TLUAT
                  WHERE  NU_NUME_MOVI = LAB.NU_NUME_MOVI_LABO), cc.NO_NOMB_CECO) TXT_AREA_DEPEN_READ ,
            ( SELECT la.DE_TELE_LUAT 
              FROM MOVI_CARGOS 
              JOIN LUGAR_ATENCION la   ON CD_CODI_LUAT_MOVI = CD_CODI_LUAT
              WHERE  NU_NUME_MOVI = LAB.NU_NUME_MOVI_LABO) TELEFONO_AREA ,--Telefono Tipo_lugar_atencion
            ( SELECT la.DE_CORREO_LUAT 
              FROM MOVI_CARGOS 
              JOIN LUGAR_ATENCION la   ON CD_CODI_LUAT_MOVI = CD_CODI_LUAT
              WHERE  NU_NUME_MOVI = LAB.NU_NUME_MOVI_LABO ) CORREO_AREA ,--Correo Tipo_lugar_atencion
            ( SELECT RLD.CD_CODI_DIAG_RLAD 
              FROM R_LABO_DIAG RLD
              WHERE  RLD.NU_NUME_LABO_RLAD = LAB.NU_NUME_LABO
              AND RLD.ID_TIPO_DIAG_RLAD = 'PR') DIAGNOSTICO  
        FROM PACIENTES PAC
        LEFT JOIN REGISTRO_ADSCRITO    
            ON ( NU_HIST_PAC_READ = NU_HIST_PAC OR NU_HIST_PAC_READ = MOSTRARTIPODOCUMENTO(PAC.NU_TIPD_PAC) + PAC.NU_DOCU_PAC)
        LEFT JOIN AUTORIZACION_ADSCRITOS ad   
            ON txt_cod_barra_read = cd_codi_autoriza_auad
        LEFT JOIN R_LABO_AUTO RLA   
            ON RLA.NU_AUTO_AUAD_LAAU = NU_AUTO_AUAD
        LEFT JOIN LABORATORIO LAB   
            ON LAB.NU_NUME_LABO = NU_NUME_LABO_LAAU
        LEFT JOIN MEDICOS M   
            ON M.CD_CODI_MED = LAB.CD_CODI_MEDI_LABO
        LEFT JOIN ESPECIALIDADES e   
            ON LAB.CD_CODI_ESP_LABO = e.CD_CODI_ESP
        LEFT JOIN PACIENTES p   
            ON P.NU_HIST_PAC = NU_HIST_PAC_READ
        LEFT JOIN CENTRO_COSTO cc   
            ON cc.CD_CODI_CECO = TXT_AREA_DEPEN_READ
        WHERE  CD_IDEN_READ = v_CD_REG_ADSC
        AND NU_HIST_PAC_READ IS NOT NULL ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;