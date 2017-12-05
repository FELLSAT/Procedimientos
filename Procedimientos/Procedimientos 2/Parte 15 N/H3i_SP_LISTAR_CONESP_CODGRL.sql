CREATE OR REPLACE PROCEDURE H3i_SP_LISTAR_CONESP_CODGRL
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_COD_CONC_GRL IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT TX_CODIGO_ESGL ,
            TX_NOMBRE_ESGL ,
            NU_ESTADO_ESGL 
        FROM ESPECIFICO_GLOSA3i es
        INNER JOIN R_ESG_GEG r   
            ON r.TX_CODIGO_ESGL_REG = es.TX_CODIGO_ESGL
        INNER JOIN GENERAL_GLOSA3i g   
            ON g.TX_CODIGO_GEGL = r.TX_CODIGO_GEGL_REG
        WHERE  r.TX_CODIGO_GEGL_REG = v_COD_CONC_GRL ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;