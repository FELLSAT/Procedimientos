CREATE OR REPLACE PROCEDURE H3i_SP_LISTAR_FACTURA_M_GEST
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_FECHA_INI IN DATE,
  v_FECHA_FIN IN DATE,
  v_IDCONVENIO IN NUMBER,
  v_IDADSCRITO IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    IF v_IDADSCRITO > 0
      AND v_IDCONVENIO > 0 THEN
    
        BEGIN
            OPEN  cv_1 FOR
                SELECT gl.nu_auto_glos idglosa  ,
                    gl.fe_genera_glos fecha  ,
                    dl.nu_nume_facu_degl factura  ,
                    fa.nu_conse_adsc_faad adscrito  ,
                    fa.nu_nume_coad_faad convenio  ,
                    DE_NOMB_ADSC descadscrito  ,
                    DE_NOMB_COAD descconvenio  ,
                    fa.vl_total_faad valorfactura  ,
                    SUM(dl.NU_VALOR_DEGL)  valorglosar  ,
                    gl.nu_auto_esgl_glos idestado  ,
                    ( SELECT TX_NOMBRE_ESGLO 
                      FROM ESTADO_GLOSA3i 
                      WHERE  NU_AUTO_ESGLO = gl.nu_auto_esgl_glos ) AuxEstado  
                FROM GLOSA3i gl
                INNER JOIN DETALLE_GLOSA3i dl   
                    ON dl.nu_auto_glos_degl = gl.nu_auto_glos
                INNER JOIN FACTURA_ADSCRITO fa   
                    ON fa.nu_nume_faad = dl.nu_nume_facu_degl
                INNER JOIN ADSCRITOS A   
                    ON A.NU_CONSE_ADSC = fa.NU_CONSE_ADSC_FAAD
                INNER JOIN CONVENIO_ADSC C   
                    ON C.NU_NUME_COAD = fa.NU_NUME_COAD_FAAD
                WHERE  nu_conse_adsc_faad = v_IDADSCRITO
                    AND fa.nu_nume_coad_faad = v_IDCONVENIO
                    AND gl.fe_genera_glos >= v_FECHA_INI
                    AND gl.fe_genera_glos <= v_FECHA_FIN
                GROUP BY gl.fe_genera_glos,gl.nu_auto_glos,
                    dl.nu_nume_facu_degl,fa.nu_conse_adsc_faad,
                    fa.nu_nume_coad_faad,DE_NOMB_ADSC,DE_NOMB_COAD,
                    fa.vl_total_faad,gl.nu_auto_esgl_glos ;   
        END;

    ELSE

        IF v_IDCONVENIO > 0 THEN
       
            BEGIN
                OPEN  cv_1 FOR
                    SELECT gl.nu_auto_glos idglosa  ,
                        gl.fe_genera_glos fecha  ,
                        dl.nu_nume_facu_degl factura  ,
                        fa.nu_conse_adsc_faad adscrito  ,
                        fa.nu_nume_coad_faad convenio  ,
                        DE_NOMB_ADSC descadscrito  ,
                        DE_NOMB_COAD descconvenio  ,
                        fa.vl_total_faad valorfactura  ,
                        SUM(dl.NU_VALOR_DEGL)  valorglosar  ,
                        gl.nu_auto_esgl_glos idestado  ,
                        ( SELECT TX_NOMBRE_ESGLO 
                          FROM ESTADO_GLOSA3i 
                          WHERE  NU_AUTO_ESGLO = gl.nu_auto_esgl_glos ) AuxEstado  
                    FROM GLOSA3i gl
                    INNER JOIN DETALLE_GLOSA3i dl   
                        ON dl.nu_auto_glos_degl = gl.nu_auto_glos
                    INNER JOIN FACTURA_ADSCRITO fa   
                        ON fa.nu_nume_faad = dl.nu_nume_facu_degl
                    INNER JOIN ADSCRITOS A   
                        ON A.NU_CONSE_ADSC = fa.NU_CONSE_ADSC_FAAD
                    INNER JOIN CONVENIO_ADSC C   
                        ON C.NU_NUME_COAD = fa.NU_NUME_COAD_FAAD
                    WHERE  fa.nu_nume_coad_faad = v_IDCONVENIO
                        AND gl.fe_genera_glos >= v_FECHA_INI
                        AND gl.fe_genera_glos <= v_FECHA_FIN
                    GROUP BY gl.fe_genera_glos,gl.nu_auto_glos,
                        dl.nu_nume_facu_degl,fa.nu_conse_adsc_faad,
                        fa.nu_nume_coad_faad,DE_NOMB_ADSC,DE_NOMB_COAD,
                        fa.vl_total_faad,gl.nu_auto_esgl_glos ;
            END;
        ELSE

            IF v_IDADSCRITO > 0 THEN
          
                BEGIN
                    OPEN  cv_1 FOR
                        SELECT gl.nu_auto_glos idglosa  ,
                            gl.fe_genera_glos fecha  ,
                            dl.nu_nume_facu_degl factura  ,
                            fa.nu_conse_adsc_faad adscrito  ,
                            fa.nu_nume_coad_faad convenio  ,
                            DE_NOMB_ADSC descadscrito  ,
                            DE_NOMB_COAD descconvenio  ,
                            fa.vl_total_faad valorfactura  ,
                            SUM(dl.NU_VALOR_DEGL)  valorglosar  ,
                            gl.nu_auto_esgl_glos idestado  ,
                            ( SELECT TX_NOMBRE_ESGLO 
                              FROM ESTADO_GLOSA3i 
                              WHERE  NU_AUTO_ESGLO = gl.nu_auto_esgl_glos ) AuxEstado  
                        FROM GLOSA3i gl
                        INNER JOIN DETALLE_GLOSA3i dl   
                            ON dl.nu_auto_glos_degl = gl.nu_auto_glos
                        INNER JOIN FACTURA_ADSCRITO fa   
                            ON fa.nu_nume_faad = dl.nu_nume_facu_degl
                        INNER JOIN ADSCRITOS A   
                            ON A.NU_CONSE_ADSC = fa.NU_CONSE_ADSC_FAAD
                        INNER JOIN CONVENIO_ADSC C   
                            ON C.NU_NUME_COAD = fa.NU_NUME_COAD_FAAD
                        WHERE  gl.fe_genera_glos >= v_FECHA_INI
                            AND gl.fe_genera_glos <= v_FECHA_FIN
                            AND nu_conse_adsc_faad = v_IDADSCRITO
                        GROUP BY gl.fe_genera_glos,gl.nu_auto_glos,
                            dl.nu_nume_facu_degl,fa.nu_conse_adsc_faad,
                            fa.nu_nume_coad_faad,DE_NOMB_ADSC,DE_NOMB_COAD,
                            fa.vl_total_faad,gl.nu_auto_esgl_glos ;
                END;

            ELSE
         
                BEGIN
                    OPEN  cv_1 FOR
                        SELECT gl.nu_auto_glos idglosa  ,
                            gl.fe_genera_glos fecha  ,
                            dl.nu_nume_facu_degl factura  ,
                            fa.nu_conse_adsc_faad adscrito  ,
                            fa.nu_nume_coad_faad convenio  ,
                            DE_NOMB_ADSC descadscrito  ,
                            DE_NOMB_COAD descconvenio  ,
                            fa.vl_total_faad valorfactura  ,
                            SUM(dl.NU_VALOR_DEGL)  valorglosar  ,
                            gl.nu_auto_esgl_glos idestado  ,
                            ( SELECT TX_NOMBRE_ESGLO 
                            FROM ESTADO_GLOSA3i 
                            WHERE  NU_AUTO_ESGLO = gl.nu_auto_esgl_glos ) AuxEstado  
                        FROM GLOSA3i gl
                        INNER JOIN DETALLE_GLOSA3i dl   
                            ON dl.nu_auto_glos_degl = gl.nu_auto_glos
                        INNER JOIN FACTURA_ADSCRITO fa   
                            ON fa.nu_nume_faad = dl.nu_nume_facu_degl
                        INNER JOIN ADSCRITOS A   
                            ON A.NU_CONSE_ADSC = fa.NU_CONSE_ADSC_FAAD
                        INNER JOIN CONVENIO_ADSC C   
                            ON C.NU_NUME_COAD = fa.NU_NUME_COAD_FAAD
                        WHERE  gl.fe_genera_glos >= v_FECHA_INI
                            AND gl.fe_genera_glos <= v_FECHA_FIN
                        GROUP BY gl.fe_genera_glos,gl.nu_auto_glos,
                            dl.nu_nume_facu_degl,fa.nu_conse_adsc_faad,
                            fa.nu_nume_coad_faad,DE_NOMB_ADSC,DE_NOMB_COAD,
                            fa.vl_total_faad,gl.nu_auto_esgl_glos ;         
                END;
            END IF;
        END IF;
    END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;