CREATE OR REPLACE PROCEDURE H3i_SP_REC_LABORATORIO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_MOVIMIENTO IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT NU_NUME_MOVI_LABO, CD_CODI_ESP_LABO ,
            CD_CODI_SER_LABO , CT_CANT_LABO ,
            VL_UNID_LABO , VL_COPA_LABO ,
            CD_CODI_MEDI_LABO , NU_NIVE_LABO ,
            ID_CODI_TIPR_LABO , ID_CODI_PRAT_LABO ,
            ID_CODI_EMBA_LABO , NU_ESTA_LABO ,
            NU_AUTO_LABO , DE_COND_LABO ,
            ID_CODI_TIDI_LABO , ID_CODI_CAEX_LABO ,
            NU_DIIN_LABO , DE_PRES_LABO ,
            NU_NUME_LABO , CD_CODI_VIAC_LABO ,
            CD_CODI_SALA_LABO , CD_CODI_TIAN_LABO ,
            NU_ESHI_LABO , NU_EDAD_LABO ,
            CD_CODI_FICO_LABO , ID_ACTO_QUIR_LABO ,
            ID_ESTA_ASIS_LABO , TX_CODI_RRTT_LABO ,
            TX_CODI_RPP_LABO , TX_CODI_RFF_LABO ,
            NU_CONE_ANUL_LABO , FE_ANUL_LABO ,
            VL_IMAD_LABO , VL_IMPA_LABO 
        FROM LABORATORIO 
        WHERE  NU_NUME_MOVI_LABO = v_MOVIMIENTO ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;