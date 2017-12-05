CREATE OR REPLACE PROCEDURE H3i_BUSCAR_CAT_PROF_SUMIN_AUDI
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_TX_NOMBRE_PROF_PS IN VARCHAR2,
  v_TX_CEDULA_PS IN VARCHAR2,
  v_POR_NOMBRE IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    IF v_POR_NOMBRE = 0 THEN

        BEGIN
            OPEN  cv_1 FOR
                SELECT COD_CATAL_PS ,
                    TX_RANGO_PS ,
                    TX_FUERZA_PS ,
                    TX_NOMBRE_PROF_PS ,
                    TX_CEDULA_PS ,
                    TX_ESM_PS ,
                    TX_TIPO_FUNCIONARIO_PS ,
                    TX_TELEFONO_PS ,
                    TX_CORREO_PS ,
                    NU_ESTADO_PS 
                FROM AUDITAR_CATALOGO_PROFE_SUMIN 
                WHERE  TX_CEDULA_PS LIKE '%' || v_TX_CEDULA_PS || '%'
                ORDER BY TX_NOMBRE_PROF_PS ASC ;
        END;

    ELSE
   
        BEGIN
            OPEN  cv_1 FOR
                SELECT COD_CATAL_PS ,
                    TX_RANGO_PS ,
                    TX_FUERZA_PS ,
                    TX_NOMBRE_PROF_PS ,
                    TX_CEDULA_PS ,
                    TX_ESM_PS ,
                    TX_TIPO_FUNCIONARIO_PS ,
                    TX_TELEFONO_PS ,
                    TX_CORREO_PS ,
                    NU_ESTADO_PS 
                FROM AUDITAR_CATALOGO_PROFE_SUMIN 
                WHERE  TX_NOMBRE_PROF_PS LIKE '%' || v_TX_NOMBRE_PROF_PS || '%'
                ORDER BY TX_NOMBRE_PROF_PS ASC ;
        END;
        
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;