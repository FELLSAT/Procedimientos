CREATE OR REPLACE PROCEDURE INSER_ACTU_CAT_PROF_SUMIN_AUDI
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_COD_CATAL_PS IN NUMBER,
  v_TX_RANGO_PS IN VARCHAR2,
  v_TX_FUERZA_PS IN VARCHAR2,
  v_TX_NOMBRE_PROF_PS IN VARCHAR2,
  v_TX_CEDULA_PS IN VARCHAR2,
  v_TX_ESM_PS IN VARCHAR2,
  v_TX_TIPO_FUNCIONARIO_PS IN VARCHAR2,
  v_TX_TELEFONO_PS IN VARCHAR2,
  v_TX_CORREO_PS IN VARCHAR2,
  v_NU_ESTADO_PS IN NUMBER,
  v_ES_NUEVO IN NUMBER
)
AS

BEGIN

    IF v_ES_NUEVO = 0 THEN
    
        BEGIN
            UPDATE AUDITAR_CATALOGO_PROFE_SUMIN
            SET TX_RANGO_PS = v_TX_RANGO_PS,
                TX_FUERZA_PS = v_TX_FUERZA_PS,
                TX_NOMBRE_PROF_PS = v_TX_NOMBRE_PROF_PS,
                TX_CEDULA_PS = v_TX_CEDULA_PS,
                TX_ESM_PS = v_TX_ESM_PS,
                TX_TIPO_FUNCIONARIO_PS = v_TX_TIPO_FUNCIONARIO_PS,
                TX_TELEFONO_PS = v_TX_TELEFONO_PS,
                TX_CORREO_PS = v_TX_CORREO_PS,
                NU_ESTADO_PS = v_NU_ESTADO_PS
            WHERE  COD_CATAL_PS = v_COD_CATAL_PS;
        END;

    ELSE
   
        BEGIN
            INSERT INTO AUDITAR_CATALOGO_PROFE_SUMIN( 
                TX_RANGO_PS, TX_FUERZA_PS, 
                TX_NOMBRE_PROF_PS, TX_CEDULA_PS, 
                TX_ESM_PS, TX_TIPO_FUNCIONARIO_PS, 
                TX_TELEFONO_PS, TX_CORREO_PS, 
                NU_ESTADO_PS )
            VALUES ( 
                v_TX_RANGO_PS, v_TX_FUERZA_PS, 
                v_TX_NOMBRE_PROF_PS, v_TX_CEDULA_PS, 
                v_TX_ESM_PS, v_TX_TIPO_FUNCIONARIO_PS, 
                v_TX_TELEFONO_PS, v_TX_CORREO_PS, 
                v_NU_ESTADO_PS );  
        END;

    END IF;


EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;