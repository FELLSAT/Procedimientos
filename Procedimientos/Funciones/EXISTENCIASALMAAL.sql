CREATE OR REPLACE FUNCTION EXISTENCIASALMAAL
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_pFecha IN VARCHAR2,
    v_pArticulo IN VARCHAR2
)
RETURN NUMBER
AS
    v_Entradas NUMBER(19,0);
    v_DevoVentas NUMBER(19,0);
    v_DevoDep NUMBER(19,0);
    v_AjustesIN NUMBER(19,0);
    v_Salidas NUMBER(19,0);
    v_Ventas NUMBER(19,0);
    v_Despachos NUMBER(19,0);
    v_AjustesOUT NUMBER(19,0);
    v_DevolProveedor NUMBER(19,0);

BEGIN
    SELECT NVL(SUM(CT_CANT_ENAR) , 0) 
    INTO v_Entradas
    FROM ENTRADA_ALMACEN 
    INNER JOIN R_ENTRA_ARTI    
        ON CD_CODI_ENTR = CD_ENTR_ENAR
    WHERE  CD_ARTI_ENAR = v_pArticulo
        AND ID_ESTA_ENTR <> 2
        AND FE_FECH_ENTR <= TO_DATE(TO_CHAR(v_pFecha,'DD/MM/YYYY'),'DD/MM/YYYY');

    SELECT NVL(SUM(CT_CANT_DEAR) , 0) 
    INTO v_DevoVentas
    FROM DEVOCLI 
    INNER JOIN R_DEVO_ARTI    
        ON CD_CODI_DEVO = CD_DEVO_DEAR
    WHERE  CD_ARTI_DEAR = v_pArticulo
        AND ID_ESTA_DEVO <> 2
        AND FE_FECH_DEVO <= TO_DATE(TO_CHAR(v_pFecha,'DD/MM/YYYY'),'DD/MM/YYYY');

    SELECT NVL(SUM(CT_CANT_DVAR) , 0) 
    INTO v_DevoDep
    FROM DEVODEP 
    INNER JOIN R_DEVOD_ARTI    
        ON CD_CODI_DEVD = CD_DEVD_DVAR
    WHERE  CD_ARTI_DVAR = v_pArticulo
        AND ID_ESTA_DEVD <> 2
        AND FE_FECH_DEVD <= TO_DATE(TO_CHAR(v_pFecha,'DD/MM/YYYY'),'DD/MM/YYYY');

    SELECT NVL(SUM(CT_CANT_AJAR) , 0) 
    INTO v_AjustesIN
    FROM AJUSTE 
    INNER JOIN R_AJUS_ARTI    
        ON CD_CODI_AJUS = CD_AJUS_AJAR
    WHERE  CD_ARTI_AJAR = v_pArticulo
        AND ID_ESTA_AJUS <> 2
        AND CT_CANT_AJAR > 0
        AND FE_FECH_AJUS <= TO_DATE(TO_CHAR(v_pFecha,'DD/MM/YYYY'),'DD/MM/YYYY');

    SELECT NVL(SUM(CT_CANT_SAAR) , 0) 
    INTO v_Salidas
    FROM SALI_ALMA 
    INNER JOIN R_SALIA_ARTI    
        ON CD_CODI_SAAL = CD_SAAL_SAAR
    WHERE  CD_ARTI_SAAR = v_pArticulo
        AND ID_ESTA_SAAL <> 2
        AND FE_FECH_SAAL <= TO_DATE(TO_CHAR(v_pFecha,'DD/MM/YYYY'),'DD/MM/YYYY');

    SELECT NVL(SUM(CT_CANT_VEAR) , 0) 
    INTO v_Ventas
    FROM VENTA 
    INNER JOIN R_VENT_ARTI    
        ON CD_CODI_VENT = CD_VENT_VEAR
    WHERE  CD_ARTI_VEAR = v_pArticulo
        AND ID_ESTA_VENT <> 2
        AND FE_FECH_VENT <= TO_DATE(TO_CHAR(v_pFecha,'DD/MM/YYYY'),'DD/MM/YYYY');

    SELECT NVL(SUM(CT_CANT_DEAR) , 0) 
    INTO v_Despachos
    FROM DESPACHO 
    INNER JOIN R_DESPA_ARTI    
        ON CD_CODI_DESP = CD_DESP_DEAR
    WHERE  CD_ARTI_DEAR = v_pArticulo
        AND ID_ESTA_DESP <> 2
        AND FE_FECH_DESP <= TO_DATE(TO_CHAR(v_pFecha,'DD/MM/YYYY'),'DD/MM/YYYY');

    SELECT NVL(SUM(CT_CANT_AJAR) , 0) 
    INTO v_AjustesOUT
    FROM AJUSTE 
    INNER JOIN R_AJUS_ARTI    
        ON CD_CODI_AJUS = CD_AJUS_AJAR
    WHERE  CD_ARTI_AJAR = v_pArticulo
        AND ID_ESTA_AJUS <> 2
        AND CT_CANT_AJAR < 0
        AND FE_FECH_AJUS <= TO_DATE(TO_CHAR(v_pFecha,'DD/MM/YYYY'),'DD/MM/YYYY');

    SELECT NVL(SUM(CT_CANT_DEAR) , 0) 
    INTO v_DevolProveedor
    FROM DEVOL_PROVEEDOR 
    INNER JOIN R_DEVPROV_ARTI    
        ON CD_CODI_DEVO = CD_ENTR_DEAR
    WHERE  CD_ARTI_DEAR = v_pArticulo
        AND ID_ESTA_DEVO <> 2
        AND FE_FECH_DEVO <= TO_DATE(TO_CHAR(v_pFecha,'DD/MM/YYYY'),'DD/MM/YYYY');

   RETURN ((v_Entradas + v_DevoVentas + v_DevoDep + v_AjustesIN) - (v_Salidas + v_Ventas + v_Despachos + v_AjustesOUT + v_DevolProveedor));

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;