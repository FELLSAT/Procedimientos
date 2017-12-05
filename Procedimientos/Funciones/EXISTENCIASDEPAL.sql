CREATE OR REPLACE FUNCTION EXISTENCIASDEPAL
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_pFecha IN VARCHAR2,
    v_pDependencia IN VARCHAR2,
    v_pArticulo IN VARCHAR2
)
RETURN NUMBER
AS
    v_Despachos NUMBER(19,0);
    v_DevoBajaDep NUMBER(19,0);
    v_TrasEntran NUMBER(19,0);
    v_Salidas NUMBER(19,0);
    v_DevoAlma NUMBER(19,0);
    v_TrasSalen NUMBER(19,0);

BEGIN
    IF v_pDependencia = 'TODAS' THEN
        SELECT NVL(SUM(CT_CANT_DEAR) , 0) 
        INTO v_Despachos
        FROM DESPACHO 
        INNER JOIN R_DESPA_ARTI    
            ON CD_CODI_DESP = CD_DESP_DEAR
        WHERE  CD_ARTI_DEAR = v_pArticulo
            AND ID_ESTA_DESP <> 2
            AND FE_FECH_DESP <= TO_DATE(TO_CHAR(v_pFecha,'DD/MM/YYYY'),'DD/MM/YYYY');
    END IF;

    ------------------------------------------
    IF v_pDependencia <> 'TODAS' THEN
        SELECT NVL(SUM(CT_CANT_DEAR) , 0) 
            INTO v_Despachos
        FROM DESPACHO 
        INNER JOIN R_DESPA_ARTI    
            ON CD_CODI_DESP = CD_DESP_DEAR
        WHERE  CD_ARTI_DEAR = v_pArticulo
            AND ID_ESTA_DESP <> 2
            AND CD_DEPE_DESP = v_pDependencia
            AND FE_FECH_DESP <= TO_DATE(TO_CHAR(v_pFecha,'DD/MM/YYYY'),'DD/MM/YYYY');
    END IF;

    ------------------------------------------
    IF v_pDependencia = 'TODAS' THEN
        SELECT NVL(SUM(CT_CANT_DVAR) , 0) 
        INTO v_DevoBajaDep
        FROM DEVOLVER 
        INNER JOIN R_DEVOL_ARTI    
            ON CD_CODI_DEVD = CD_BAJD_DVAR
        WHERE  CD_ARTI_DVAR = v_pArticulo
            AND ID_ESTA_DEVD <> 2
            AND FE_FECH_DEVD <= TO_DATE(TO_CHAR(v_pFecha,'DD/MM/YYYY'),'DD/MM/YYYY');
    END IF;

    --------------------------------------------
    IF v_pDependencia <> 'TODAS' THEN
        SELECT NVL(SUM(CT_CANT_DVAR) , 0) 
        INTO v_DevoBajaDep
        FROM DEVOLVER 
        INNER JOIN R_DEVOL_ARTI    
            ON CD_CODI_DEVD = CD_BAJD_DVAR
        WHERE  CD_ARTI_DVAR = v_pArticulo
            AND ID_ESTA_DEVD <> 2
            AND CD_DEPE_DEVD = v_pDependencia
            AND FE_FECH_DEVD <= TO_DATE(TO_CHAR(v_pFecha,'DD/MM/YYYY'),'DD/MM/YYYY');
    END IF;

   --------------------------------------------
    IF v_pDependencia = 'TODAS' THEN
        SELECT NVL(SUM(CT_CANT_TRAR) , 0) 
        INTO v_TrasEntran
        FROM TRASDEPE 
        INNER JOIN R_TRASD_ARTI    
            ON CD_CODI_TRAD = CD_TRAD_TRAR
        WHERE  CD_ARTI_TRAR = v_pArticulo
        AND ID_ESTA_TRAD <> 2
        AND FE_FECH_TRAD <= TO_DATE(TO_CHAR(v_pFecha,'DD/MM/YYYY'),'DD/MM/YYYY');
    END IF;

    -------------------------------------------
    IF v_pDependencia <> 'TODAS' THEN
        SELECT NVL(SUM(CT_CANT_TRAR) , 0)
        INTO v_TrasEntran
        FROM TRASDEPE 
        INNER JOIN R_TRASD_ARTI    
            ON CD_CODI_TRAD = CD_TRAD_TRAR
        WHERE  CD_ARTI_TRAR = v_pArticulo
          AND ID_ESTA_TRAD <> 2
          AND CD_DEEN_TRAD = v_pDependencia
          AND FE_FECH_TRAD <= TO_DATE(TO_CHAR(v_pFecha,'DD/MM/YYYY'),'DD/MM/YYYY');
    END IF;

    ------------------------------------------
    IF v_pDependencia = 'TODAS' THEN
        SELECT NVL(SUM(CT_CANT_BDAR) , 0) 
        INTO v_Salidas
        FROM BAJA_DEPE 
        INNER JOIN R_BAJAD_ARTI    
            ON CD_CODI_BAJD = CD_BAJD_BDAR
        WHERE  CD_ARTI_BDAR = v_pArticulo
            AND ID_ESTA_BAJD <> 2
            AND FE_FECH_BAJD <= TO_DATE(TO_CHAR(v_pFecha,'DD/MM/YYYY'),'DD/MM/YYYY');
    END IF;

    -----------------------------------------
    IF v_pDependencia <> 'TODAS' THEN
        SELECT NVL(SUM(CT_CANT_BDAR) , 0) 
        INTO v_Salidas
        FROM BAJA_DEPE 
        INNER JOIN R_BAJAD_ARTI    
            ON CD_CODI_BAJD = CD_BAJD_BDAR
        WHERE  CD_ARTI_BDAR = v_pArticulo
            AND CD_DEPE_BAJD = v_pDependencia
            AND ID_ESTA_BAJD <> 2
            AND FE_FECH_BAJD <= TO_DATE(TO_CHAR(v_pFecha,'DD/MM/YYYY'),'DD/MM/YYYY');
    END IF;

    ------------------------------------------
    IF v_pDependencia = 'TODAS' THEN
        SELECT NVL(SUM(CT_CANT_DVAR) , 0) 
        INTO v_DevoAlma
        FROM DEVODEP 
        INNER JOIN R_DEVOD_ARTI    
            ON CD_CODI_DEVD = CD_DEVD_DVAR
        LEFT JOIN CENTRO_COSTO    
            ON CD_DEPE_DEVD = CD_CODI_CECO
        WHERE  CD_ARTI_DVAR = v_pArticulo
            AND ID_ESTA_DEVD <> 2
            AND FE_FECH_DEVD <= TO_DATE(TO_CHAR(v_pFecha,'DD/MM/YYYY'),'DD/MM/YYYY');
    END IF;

    ------------------------------------------
    IF v_pDependencia <> 'TODAS' THEN
        SELECT NVL(SUM(CT_CANT_DVAR) , 0) 
        INTO v_DevoAlma
        FROM DEVODEP 
        INNER JOIN R_DEVOD_ARTI    
            ON CD_CODI_DEVD = CD_DEVD_DVAR
        LEFT JOIN CENTRO_COSTO    
            ON CD_DEPE_DEVD = CD_CODI_CECO
        WHERE  CD_ARTI_DVAR = v_pArticulo
            AND ID_ESTA_DEVD <> 2
            AND CD_DEPE_DEVD = v_pDependencia
            AND FE_FECH_DEVD <= TO_DATE(TO_CHAR(v_pFecha,'DD/MM/YYYY'),'DD/MM/YYYY');
    END IF;

    ----------------------------------------
    IF v_pDependencia = 'TODAS' THEN
        SELECT NVL(SUM(CT_CANT_TRAR) , 0) 
        INTO v_TrasSalen
        FROM TRASDEPE 
        INNER JOIN R_TRASD_ARTI    
            ON CD_CODI_TRAD = CD_TRAD_TRAR
        WHERE  CD_ARTI_TRAR = v_pArticulo
        AND ID_ESTA_TRAD <> 2
        AND FE_FECH_TRAD <= TO_DATE(TO_CHAR(v_pFecha,'DD/MM/YYYY'),'DD/MM/YYYY');
    END IF;

    -------------------------------------
    IF v_pDependencia <> 'TODAS' THEN
        SELECT NVL(SUM(CT_CANT_TRAR) , 0) 
        INTO v_TrasSalen
        FROM TRASDEPE 
        INNER JOIN R_TRASD_ARTI    
            ON CD_CODI_TRAD = CD_TRAD_TRAR
        WHERE  CD_ARTI_TRAR = v_pArticulo
            AND ID_ESTA_TRAD <> 2
            AND CD_DESA_TRAD = v_pDependencia
            AND FE_FECH_TRAD <= TO_DATE(TO_CHAR(v_pFecha,'DD/MM/YYYY'),'DD/MM/YYYY');
    END IF;

    RETURN ((v_Despachos + v_DevoBajaDep + v_TrasEntran) - (v_Salidas + v_DevoAlma + v_TrasSalen));
  
EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;