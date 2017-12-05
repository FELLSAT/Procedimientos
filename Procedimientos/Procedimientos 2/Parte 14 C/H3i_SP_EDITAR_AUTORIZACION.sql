CREATE OR REPLACE PROCEDURE H3i_SP_EDITAR_AUTORIZACION
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_CD_REGISTRO_AUTORIZACION IN NUMBER,
    v_NU_HIST_PAC_READ IN VARCHAR2,
    v_TX_NOM_COMPLE IN VARCHAR2,
    v_NU_TIPO_DOC IN VARCHAR2,
    v_NU_EDAD_PAC IN NUMBER,
    v_TXT_GENERO_PAC IN VARCHAR2,
    v_TXT_TIPO_USR IN VARCHAR2,
    v_FE_AUTO_READ IN DATE,
    v_FE_VENCI_READ IN DATE,
    v_TXT_COD_BARRA_READ IN VARCHAR2,
    v_TXT_AREA_DEPEN_READ IN VARCHAR2,
    v_TXT_ASEGURADORA_READ IN VARCHAR2,
    v_NO_CANT_AUTORI_READ IN NUMBER,
    v_NU_RECEPCIONADO IN NUMBER,
    v_NU_AUTORIZADO IN NUMBER,
    v_NU_PRE_REGISTRO IN NUMBER,
    v_COD_MED IN VARCHAR2,
    v_NOM_MED IN VARCHAR2,
    v_ESP_MED IN VARCHAR2,
    v_REG_MED IN VARCHAR2,
    v_NOM_ADSC IN VARCHAR2,
    v_TELF_ADSC IN VARCHAR2,
    v_DIREC_ADSC IN VARCHAR2,
    v_OBSERVACIONES IN VARCHAR2
)
AS

BEGIN

    UPDATE REGISTRO_ADSCRITO
    SET NU_HIST_PAC_READ = v_NU_HIST_PAC_READ,
        TX_NOM_COMPLE = v_TX_NOM_COMPLE,
        NU_TIPO_DOC = v_NU_TIPO_DOC,
        NU_EDAD_PAC = v_NU_EDAD_PAC,
        TXT_GENERO_PAC = v_TXT_GENERO_PAC,
        TXT_TIPO_USR = v_TXT_TIPO_USR,
        FE_AUTO_READ = v_FE_AUTO_READ,
        FE_VENCI_READ = v_FE_VENCI_READ,
        TXT_COD_BARRA_READ = v_TXT_COD_BARRA_READ,
        TXT_AREA_DEPEN_READ = v_TXT_AREA_DEPEN_READ,
        TXT_ASEGURADORA_READ = v_TXT_ASEGURADORA_READ,
        NO_CANT_AUTORI_READ = v_NO_CANT_AUTORI_READ,
        NU_RECEPCIONADO = v_NU_RECEPCIONADO,
        NU_AUTORIZADO = v_NU_AUTORIZADO,
        NU_PRE_REGISTRO = v_NU_PRE_REGISTRO,
        CD_MEDICO_READ = v_COD_MED,
        TX_NOM_MEDICO_READ = v_NOM_MED,
        TX_ESP_MEDICO_READ = v_ESP_MED,
        TX_REG_MEDICO_READ = v_REG_MED,
        TX_NOM_ADSCR_READ = v_NOM_ADSC,
        TX_TELF_ADSC_READ = v_TELF_ADSC,
        TX_DIREC_ADSCR_READ = v_DIREC_ADSC,
        TX_OBSERVACIONES_READ = v_OBSERVACIONES
    WHERE  CD_IDEN_READ = v_CD_REGISTRO_AUTORIZACION;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;