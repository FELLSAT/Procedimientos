CREATE OR REPLACE PROCEDURE H3i_SP_CON_MEDICAMENTO_REG
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_NUME_REG_MOVI IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS
BEGIN

    OPEN  cv_1 FOR
        SELECT DISTINCT NU_NUME_HMED ,
            CD_CODI_ARTI_HMED AS ORDENADO ,
            NO_NOMB_ARTI_HMED AS NOMBRE_ARTICULO ,
            ( 
              SELECT TX_NOMB_PRES 
              FROM PRESENTACION 
              WHERE NU_AUTO_PRES = REPLACE(DE_UNME_HMED, '|', ' ') 
              AND ROWNUM <= 1 ) 
            UNIDAD_MEDIDA,
            DE_CTRA_HMED AS CONCENTRACION  ,
            DE_DOSIS_HMED AS DOSIS  ,
            TO_NUMBER(SM.NU_CANT_SMED - (NVL(DEV.TDEV, 0)) - (NVL(T.TOTAL, 0)),10.0) AS CANTIDAD,
            FE_FECH_FORM_HMED AS FECHA_FORMULADO  ,
            DE_VIA_ADMIN_HMED,
            NU_CANT_SMED AS ORDENADO_MED  ,
            NU_CANT_PEND_SMED AS PENDIENTE  ,
            DE_FREC_ADMIN_HMED,
            NVL(T.TOTAL, 0) ADMINISTRADO,
            TO_NUMBER(NVL(DEV.TDEV, 0),10.0) AS DEVUELTO ,
            'Tomar/Suministrar' || ' ' || TO_CHAR(TO_NUMBER(DE_DOSIS_HMED),5) || ' ' || DE_UNME_HMED || '(S) Cada ' || DE_FREC_ADMIN_HMED || 
                    (
                      CASE NU_UNFRE_HMED                                                                                                                                         WHEN 1 THEN ' Minutos'
                          ELSE ' Días'
                      END) 
                    || ' vía ' || DE_VIA_ADMIN_HMED AS FRECUENCIA,
            NU_ORDE_HMED ,
            1 subtipo,
            NU_UNFRE_HMED ,
            NU_NUME_DUR_TRAT_HMED 
        FROM MOVI_CARGOS 
        INNER JOIN LABORATORIO    
            ON NU_NUME_MOVI = NU_NUME_MOVI_LABO
        INNER JOIN HISTORIACLINICA    
            ON NU_NUME_LABO_HICL = NU_NUME_LABO
        INNER JOIN HIST_MEDI HM   
            ON NU_NUME_HICL = NU_NUME_HICL_HMED
        INNER JOIN SOLICITUD_MED SM  
            ON SM.NU_NUME_HMED_SMED = HM.NU_NUME_HMED
        LEFT JOIN ( 
                    SELECT SUM(DA.CT_CANT_DVAR) AS TDEV,
                        DA.NU_NUME_SOLI_SMED_DVAR SOL_MED  
                    FROM R_DEVOL_ARTI DA
                    INNER JOIN SOLICITUD_MED SM   
                        ON DA.NU_NUME_SOLI_SMED_DVAR = SM.NU_NUME_SOLI_SMED
                    WHERE  DA.NU_NUME_SOLI_SMED_DVAR = SM.NU_NUME_SOLI_SMED
                    GROUP BY DA.NU_NUME_SOLI_SMED_DVAR ) DEV   
                        ON DEV.SOL_MED = SM.NU_NUME_SOLI_SMED
                    LEFT JOIN ( 
                                SELECT SUM(DA.NU_CANTIDAD_DADMI) AS TOTAL  ,
                                    DA.NU_NUME_HMED NUME_HMED  
                                FROM DOSIS_ADMINISTRADAS DA
                                GROUP BY DA.NU_NUME_HMED ) T   
            ON T.NUME_HMED = NU_NUME_HMED
       WHERE  NU_NUME_REG_MOVI = v_NU_NUME_REG_MOVI
          AND NVL(T.TOTAL, 0) < NU_CANT_HMED
          AND SM.NU_ESTA_SMED = 1
          AND ( 
                NU_CANT_PEND_SMED > 0 -- CANTIDAD PENDIENTE MAYOR A CERO
                OR TO_NUMBER(SM.NU_CANT_SMED - (NVL(DEV.TDEV, 0)) - (NVL(T.TOTAL, 0)),10.0) > 0 -- CANTIDAD DISPONIBLE MAYOR A CERO
              )
      UNION ALL 
      -- MEDICAMENTOS CON PENDIENTES POR ENTREGA

      SELECT DISTINCT NU_NUME_HMED ,
          CD_CODI_ARTI_HMED AS ORDENADO  ,
          NO_NOMB_ARTI_HMED AS NOMBRE_ARTICULO  ,
          ( 
            SELECT TX_NOMB_PRES 
            FROM PRESENTACION 
            WHERE  NU_AUTO_PRES = REPLACE(DE_UNME_HMED, '|', ' ') 
            AND ROWNUM <= 1 ) AS UNIDAD_MEDIDA,
          DE_CTRA_HMED CONSENTRACION  ,
          DE_DOSIS_HMED DOSIS  ,
          NVL(TO_NUMBER((SM.NU_CANT_SMED - SM.NU_CANT_PEND_SMED) - (NVL(DEV.TDEV, 0)),10.0) - (NVL(T.TOTAL, 0)), 0) AS CANTIDAD,
          FE_FECH_FORM_HMED FECHA_FORMULADO  ,
          DE_VIA_ADMIN_HMED ,
          NU_CANT_SMED AS ORDENADO_MED  ,
          NU_CANT_PEND_SMED AS PENDIENTE  ,
          DE_FREC_ADMIN_HMED ,
          NVL(T.TOTAL, 0) AS ADMINISTRADO  ,
          NVL(DEV.TDEV, 0) AS DEVUELTO  ,
          'Tomar/Suministrar' || ' ' || TO_CHAR(TO_NUMBER(DE_DOSIS_HMED),5) || ' ' || DE_UNME_HMED || '(S) Cada ' || 
            DE_FREC_ADMIN_HMED || (
                                  CASE NU_UNFRE_HMED
                                      WHEN 1 THEN
                                          ' Día'
                                      ELSE ' Días'
                                  END) || ' vía ' || DE_VIA_ADMIN_HMED FRECUENCIA,
          NU_ORDE_HMED ,
          2 subtipo  ,
          NU_UNFRE_HMED ,
          NU_NUME_DUR_TRAT_HMED 
      FROM MOVI_CARGOS 
      INNER JOIN LABORATORIO    
          ON NU_NUME_MOVI = NU_NUME_MOVI_LABO
      INNER JOIN HISTORIACLINICA    
          ON NU_NUME_LABO_HICL = NU_NUME_LABO
      INNER JOIN HIST_MEDI HM   
          ON NU_NUME_HICL = NU_NUME_HICL_HMED
      INNER JOIN SOLICITUD_MED SM   
          ON SM.NU_NUME_HMED_SMED = HM.NU_NUME_HMED
      LEFT JOIN ( 
                  SELECT SUM(DA.CT_CANT_DVAR)  AS TDEV  ,
                      DA.NU_NUME_SOLI_SMED_DVAR SOL_MED  
                   -- FROM R_DEVOL_ARTI DA,SOLICITUD_MED SM 
                  FROM R_DEVOL_ARTI DA
                  JOIN SOLICITUD_MED SM   
                      ON DA.NU_NUME_SOLI_SMED_DVAR = SM.NU_NUME_SOLI_SMED
                                              
                  -- Linea comentada y modificada con join por Héctor Gaviria 2011/12/19 02:09pm
                  WHERE  DA.NU_NUME_SOLI_SMED_DVAR = SM.NU_NUME_SOLI_SMED
                  GROUP BY DA.NU_NUME_SOLI_SMED_DVAR ) DEV   
                      ON DEV.SOL_MED = SM.NU_NUME_SOLI_SMED
                  LEFT JOIN ( SELECT SUM(DA.NU_CANTIDAD_DADMI) AS TOTAL,
                                  DA.NU_NUME_HMED NUME_HMED  
                              FROM DOSIS_ADMINISTRADAS DA
                              GROUP BY DA.NU_NUME_HMED ) T   
                      ON T.NUME_HMED = NU_NUME_HMED
                  WHERE  NU_NUME_REG_MOVI = v_NU_NUME_REG_MOVI
                  AND NVL(T.TOTAL, 0) < NU_CANT_HMED
                  AND (SM.NU_CANT_SMED - SM.NU_CANT_PEND_SMED) > 0
                  AND SM.NU_ESTA_SMED <> 1
                  AND ( NU_CANT_PEND_SMED > 0 -- CANTIDAD PENDIENTE MAYOR A CERO
                  OR NVL(TO_NUMBER((SM.NU_CANT_SMED - SM.NU_CANT_PEND_SMED) - (NVL(DEV.TDEV, 0)),10.0) - (NVL(T.TOTAL, 0)), 0) > 0 -- CANTIDAD DISPONIBLE MAYOR A CERO
                )
      UNION ALL
        -- MEDICAMENTOS APLICADOS

        --ORDER BY NU_ORDE_HMED
      SELECT DISTINCT HM.NU_NUME_HMED ,
          CD_CODI_ARTI_HMED AS ORDENADO  ,
          NO_NOMB_ARTI_HMED AS NOMBRE_ARTICULO,
          (
            SELECT TX_NOMB_PRES 
            FROM PRESENTACION 
            WHERE  NU_AUTO_PRES = REPLACE(DE_UNME_HMED, '|', ' ') 
            AND ROWNUM <= 1 ) ASUNIDAD_MEDIDA,
          DE_CTRA_HMED AS CONSENTRACION  ,
          DE_DOSIS_HMED AS DOSIS  ,
          NVL(TO_NUMBER((SM.NU_CANT_SMED - SM.NU_CANT_PEND_SMED) - (NVL(DEV.TDEV, 0)),10.0) - (NVL(T.TOTAL, 0)), 0) CANTIDAD  ,
          FE_FECH_FORM_HMED AS FECHA_FORMULADO  ,
          DE_VIA_ADMIN_HMED ,
          NU_CANT_SMED AS ORDENADO_MED  ,
          NU_CANT_PEND_SMED AS PENDIENTE  ,
          DE_FREC_ADMIN_HMED ,
          NVL(T.TOTAL, 0) AS ADMINISTRADO  ,
          NVL(DEV.TDEV, 0) AS DEVUELTO  ,
          'Tomar/Suministrar' || ' ' || TO_CHAR(TO_NUMBER(DE_DOSIS_HMED),5) || ' ' || DE_UNME_HMED || '(S) Cada ' || 
            DE_FREC_ADMIN_HMED || (
                                    CASE NU_UNFRE_HMED
                                        WHEN 0 THEN ' Horas'
                                        WHEN 1 THEN ' Minutos'
                                    ELSE ' Días'
                                    END
                                  ) || ' vía ' || DE_VIA_ADMIN_HMED FRECUENCIA ,
          NU_ORDE_HMED ,
          2 subtipo  ,
          NU_UNFRE_HMED ,
          NU_NUME_DUR_TRAT_HMED 
      FROM MOVI_CARGOS 
      INNER JOIN LABORATORIO    
          ON NU_NUME_MOVI = NU_NUME_MOVI_LABO
      INNER JOIN HISTORIACLINICA    
          ON NU_NUME_LABO_HICL = NU_NUME_LABO
      INNER JOIN HIST_MEDI HM   
          ON NU_NUME_HICL = NU_NUME_HICL_HMED
      INNER JOIN SOLICITUD_MED SM   
          ON SM.NU_NUME_HMED_SMED = HM.NU_NUME_HMED
      LEFT JOIN ( 
                  SELECT SUM(DA.CT_CANT_DVAR) AS TDEV  ,
                      DA.NU_NUME_SOLI_SMED_DVAR AS SOL_MED  
                   --       FROM R_DEVOL_ARTI DA,SOLICITUD_MED SM 
                    FROM R_DEVOL_ARTI DA
                    INNER JOIN SOLICITUD_MED SM   
                        ON DA.NU_NUME_SOLI_SMED_DVAR = SM.NU_NUME_SOLI_SMED
                    
                    -- Linea comentada y modificada con join por Héctor Gaviria 2011/12/19 02:09pm
                    WHERE  DA.NU_NUME_SOLI_SMED_DVAR = SM.NU_NUME_SOLI_SMED
                    GROUP BY DA.NU_NUME_SOLI_SMED_DVAR ) DEV   
            ON DEV.SOL_MED = SM.NU_NUME_SOLI_SMED
        LEFT JOIN ( 
                    SELECT SUM(DA.NU_CANTIDAD_DADMI) AS TOTAL  ,
                        DA.NU_NUME_HMED AS NUME_HMED  
                    FROM DOSIS_ADMINISTRADAS DA
                    GROUP BY DA.NU_NUME_HMED ) T 
            ON T.NUME_HMED = NU_NUME_HMED
        LEFT JOIN ( 
                    SELECT NU_NUME_HMED ,
                        MED_CERRADO 
                    FROM DOSIS_ADMINISTRADAS SS
                    WHERE  SS.NU_NUME_REG = v_NU_NUME_REG_MOVI ) DA  
        ON DA.NU_NUME_HMED = HM.NU_NUME_HMED
        WHERE  NU_NUME_REG_MOVI = v_NU_NUME_REG_MOVI
        AND NVL(TO_NUMBER((SM.NU_CANT_SMED - SM.NU_CANT_PEND_SMED) - (NVL(DEV.TDEV, 0)),10.0) - (NVL(T.TOTAL, 0)), 0) = 0
        AND MED_CERRADO = 0
                    --AND   ISNULL(T.TOTAL, 0) < NU_CANT_HMED    
                     --AND    (SM.NU_CANT_SMED - SM.NU_CANT_PEND_SMED) > 0
                     --AND    SM.NU_ESTA_SMED <> 1
                     --AND    (NU_CANT_PEND_SMED > 0 -- CANTIDAD PENDIENTE MAYOR A CERO
                     --OR   ISNULL(CONVERT(INT,(SM.NU_CANT_SMED - SM.NU_CANT_PEND_SMED) - (ISNULL(DEV.TDEV,0))) - (ISNULL(T.TOTAL, 0)),0)  >  0) -- CANTIDAD DISPONIBLE MAYOR A CERO

        ORDER BY NU_ORDE_HMED ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;