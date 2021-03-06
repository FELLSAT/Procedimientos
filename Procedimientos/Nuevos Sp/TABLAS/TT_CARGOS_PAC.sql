CREATE GLOBAL TEMPORARY TABLE TT_CARGOS_PAC(    
    NU_NUME_MOVI NUMBER(22),
    NU_TIPO_MOVI NUMBER(22),
    FE_FECH_MOVI DATE,                              
    CD_CODI_ESP VARCHAR2(3),
    NO_NOMB_MED VARCHAR2(70),
    VL_UNID_MOVI FLOAT(22),
    VL_COPA_MOVI FLOAT(22),
    NO_NOMB_EPS VARCHAR2(100),
    CD_NIT_EPS VARCHAR2(11),
    CD_CODI_CONV VARCHAR2(20),
    CD_NOMB_CONV NVARCHAR2(100),
    NU_NUME_REG_MOVI NUMBER(22),
    NU_NUME_CONV_MOVI NUMBER(22),
    CD_CODI_LUAT_MOVI VARCHAR2(2),
    CD_CODI_CECO_MOVI VARCHAR2(11),
    CD_CODI_CECO_INV VARCHAR2(11),
    NU_HIST_PAC_MOVI varchar2(20),
    NU_ADSCR_LIQUI NUMBER(22),
    AUTORIZADO VARCHAR2(2),
    ID_AUTORIZACION NUMBER(22)
) ON COMMIT DELETE ROWS;
