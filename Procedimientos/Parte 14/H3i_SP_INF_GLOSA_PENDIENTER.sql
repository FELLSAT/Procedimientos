CREATE OR REPLACE PROCEDURE H3i_SP_INF_GLOSA_PENDIENTER
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_FECH_INI IN DATE,
  v_FECH_FIN IN DATE,
  v_IDADSCRITO IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    IF v_IDADSCRITO > 0 THEN
    
        BEGIN
            OPEN  cv_1 FOR
                SELECT GLOSA3i.NU_AUTO_GLOS NOGLOSA  ,
                    GLOSA3i.FE_RADICACION_GLOS FECHAGLOSA  ,
                    FACTURA_ADSCRITO.NU_NUME_FAAD FACTURA  ,
                    ADSCRITOS.DE_NOMB_ADSC NOMBREADS  ,
                    DETALLE_GLOSA3i.NU_TIPOFACU_DEGL TIPOFAC  ,
                    CASE NU_TIPOFACU_DEGL
                        WHEN 1 THEN 'TOTAL'
                        WHEN 2 THEN 'PARCIAL'   
                    END AUX_TIPO  ,
                    --SUM(DETALLE_GLOSA3i.NU_VALOR_DEGL) TOTALGLOSADO, se cambia para que ya no sume para que el reporte aparezca individual.
                    DETALLE_GLOSA3i.NU_VALOR_DEGL TOTALGLOSADO  ,
                    SUM(GLOSA3i.NU_AUTO_ESGL_GLOS)  TOTALACEPTADO  
                FROM (( DETALLE_GLOSA3i DETALLE_GLOSA3i
                INNER JOIN GLOSA3i GLOSA3i   
                    ON ( DETALLE_GLOSA3i.NU_AUTO_GLOS_DEGL = GLOSA3i.NU_AUTO_GLOS )) 
                INNER JOIN FACTURA_ADSCRITO FACTURA_ADSCRITO   
                    ON ( FACTURA_ADSCRITO.NU_NUME_FAAD = DETALLE_GLOSA3i.NU_NUME_FACU_DEGL )) 
                INNER JOIN ADSCRITOS ADSCRITOS   
                    ON ( FACTURA_ADSCRITO.NU_CONSE_ADSC_FAAD = ADSCRITOS.NU_CONSE_ADSC )
                INNER JOIN GESTION_GLOSA GESTION_GLOSA   
                    ON GESTION_GLOSA.NU_NUME_CONE_GEGL = GLOSA3i.NU_AUTO_GLOS
                WHERE  GLOSA3i.FE_GENERA_GLOS >= v_FECH_INI
                  AND GLOSA3i.FE_GENERA_GLOS <= v_FECH_FIN
                  AND nu_conse_adsc_faad = v_IDADSCRITO
                  AND GLOSA3i.NU_AUTO_ESGL_GLOS IN( SELECT NU_AUTO_ESGLO 
                                                    FROM ESTADO_GLOSA3i 
                                                    WHERE  LTRIM(TX_NOMBRE_ESGLO) = 'EN PROCESO'
                                                    OR LTRIM(TX_NOMBRE_ESGLO) = 'INGRESADO')
                GROUP BY GLOSA3i.NU_AUTO_GLOS,GLOSA3i.FE_RADICACION_GLOS,
                    FACTURA_ADSCRITO.NU_NUME_FAAD,ADSCRITOS.DE_NOMB_ADSC,
                    DETALLE_GLOSA3i.NU_TIPOFACU_DEGL,GLOSA3i.NU_AUTO_ESGL_GLOS,
                    DETALLE_GLOSA3i.NU_VALOR_DEGL ;   
        END;

    ELSE
   
        BEGIN
            OPEN  cv_1 FOR
                SELECT GLOSA3i.NU_AUTO_GLOS NOGLOSA  ,
                    GLOSA3i.FE_RADICACION_GLOS FECHAGLOSA  ,
                    FACTURA_ADSCRITO.NU_NUME_FAAD FACTURA  ,
                    ADSCRITOS.DE_NOMB_ADSC NOMBREADS  ,
                    DETALLE_GLOSA3i.NU_TIPOFACU_DEGL TIPOFAC  ,
                    CASE NU_TIPOFACU_DEGL
                        WHEN 1 THEN 'TOTAL'
                        WHEN 2 THEN 'PARCIAL'   
                    END AUX_TIPO  ,
                    --SUM(DETALLE_GLOSA3i.NU_VALOR_DEGL) TOTALGLOSADO, se cambia para que ya no sume para que el reporte aparezca individual.
                    DETALLE_GLOSA3i.NU_VALOR_DEGL TOTALGLOSADO  ,
                    SUM(GLOSA3i.NU_AUTO_ESGL_GLOS)  TOTALACEPTADO  
                FROM ((DETALLE_GLOSA3i DETALLE_GLOSA3i
                INNER JOIN GLOSA3i GLOSA3i   
                    ON ( DETALLE_GLOSA3i.NU_AUTO_GLOS_DEGL = GLOSA3i.NU_AUTO_GLOS )) 
                INNER JOIN FACTURA_ADSCRITO FACTURA_ADSCRITO   
                    ON ( FACTURA_ADSCRITO.NU_NUME_FAAD = DETALLE_GLOSA3i.NU_NUME_FACU_DEGL)) 
                INNER JOIN ADSCRITOS ADSCRITOS   
                    ON ( FACTURA_ADSCRITO.NU_CONSE_ADSC_FAAD = ADSCRITOS.NU_CONSE_ADSC )
                INNER JOIN GESTION_GLOSA GESTION_GLOSA   
                    ON GESTION_GLOSA.NU_NUME_CONE_GEGL = GLOSA3i.NU_AUTO_GLOS
                WHERE  GLOSA3i.FE_GENERA_GLOS >= v_FECH_INI
                    AND GLOSA3i.FE_GENERA_GLOS <= v_FECH_FIN
                    AND GLOSA3i.NU_AUTO_ESGL_GLOS IN( SELECT NU_AUTO_ESGLO 
                                                      FROM ESTADO_GLOSA3i 
                                                      WHERE  LTRIM(TX_NOMBRE_ESGLO) = 'EN PROCESO'
                    OR LTRIM(TX_NOMBRE_ESGLO) = 'INGRESADO' )
                GROUP BY GLOSA3i.NU_AUTO_GLOS,GLOSA3i.FE_RADICACION_GLOS,
                    FACTURA_ADSCRITO.NU_NUME_FAAD,ADSCRITOS.DE_NOMB_ADSC,
                    DETALLE_GLOSA3i.NU_TIPOFACU_DEGL,GLOSA3i.NU_AUTO_ESGL_GLOS,
                    DETALLE_GLOSA3i.NU_VALOR_DEGL ;   
        END;
    END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;