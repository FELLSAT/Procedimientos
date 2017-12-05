CREATE OR REPLACE PROCEDURE H3i_PRETRIAGE_CREAR
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_nu_auto_ptri IN NUMBER,
    v_nu_hist_pac_ptri IN VARCHAR2,
    v_nu_tipdoc_ptri IN NUMBER,
    v_tx_ape1_ptri IN VARCHAR2,
    v_tx_ape2_ptri IN VARCHAR2,
    v_tx_nomb1_ptri IN VARCHAR2,
    v_tx_nomb2_ptri IN VARCHAR2,
    v_fe_nacepac_ptri IN DATE,
    v_fe_ingre_ptri IN DATE DEFAULT NULL ,
    v_fe_iniat_ptri IN DATE DEFAULT NULL ,
    v_fe_regis_ptri IN DATE DEFAULT NULL ,
    v_nu_nume_tria_ptri IN NUMBER DEFAULT NULL ,
    v_nu_nume_cone_ptri IN NUMBER DEFAULT NULL ,
    v_nu_estado_ptri IN NUMBER,
    v_nu_nume_conanu_ptri IN NUMBER DEFAULT NULL ,
    v_nu_nume_reg_ptri IN NUMBER DEFAULT NULL ,
    v_fe_borra_ptri IN DATE DEFAULT NULL ,
    v_tx_borra_ptri IN VARCHAR2 DEFAULT NULL ,
    v_nu_gest_pac IN NUMBER DEFAULT 0 ,
    v_cd_codi_luat IN VARCHAR2
)
AS

BEGIN

    INSERT INTO PRETRIAGE( 
        nu_hist_pac_ptri, nu_tipdoc_ptri, 
        tx_ape1_ptri, tx_ape2_ptri, 
        tx_nomb1_ptri, tx_nomb2_ptri, 
        fe_nacepac_ptri, fe_ingre_ptri, 
        fe_iniat_ptri, fe_regis_ptri, 
        nu_nume_tria_ptri, nu_nume_cone_ptri, 
        nu_estado_ptri, nu_nume_conanu_ptri, 
        nu_nume_reg_ptri, fe_borra_ptri, 
        tx_borra_ptri, nu_gest_pac, 
        cd_codi_luat_pret )
    VALUES ( 
        v_nu_hist_pac_ptri, v_nu_tipdoc_ptri, 
        v_tx_ape1_ptri, v_tx_ape2_ptri, 
        v_tx_nomb1_ptri, v_tx_nomb2_ptri, 
        TO_DATE(v_fe_nacepac_ptri,'dd/mm/yyyy'), TO_DATE(v_fe_ingre_ptri,'dd/mm/yyyy'), 
        TO_DATE(v_fe_iniat_ptri,'dd/mm/yyyy'), TO_DATE(v_fe_regis_ptri,'dd/mm/yyyy'), 
        v_nu_nume_tria_ptri, v_nu_nume_cone_ptri, 
        v_nu_estado_ptri, v_nu_nume_conanu_ptri, 
        v_nu_nume_reg_ptri, TO_DATE(v_fe_borra_ptri,'dd/mm/yyyy'), 
        v_tx_borra_ptri, v_nu_gest_pac, 
        v_cd_codi_luat );

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;