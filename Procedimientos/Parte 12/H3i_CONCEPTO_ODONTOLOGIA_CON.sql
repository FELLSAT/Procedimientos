CREATE OR REPLACE PROCEDURE H3i_CONCEPTO_ODONTOLOGIA_CON
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NOHICL IN NUMBER,
  v_ORDEN IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT CO_CONDIGO_HIODO CODIGO  ,
            TX_DESCRIBE_HIODO DESCRIBE  ,
            NU_TIPO_CONV_HIODO TIPO_CONV  ,
            NU_TIPO_CONCEPTO_HIODO TIPO_CONCEPTO  ,
            ODR.NU_ESCARIES_ODRE ,
            ODR.NU_CARIESCAV_ODRE ,
            ODR.NU_CARNOCAV_ODRE ,
            ODR.NU_OPTURADOS_ODRE ,
            ODR.NU_PERDIDOS_ODRE ,
            ODR.NU_ENDODONCIA_ODRE ,
            ODR.NU_EXODONCIA_ODRE ,
            TO_NUMBER(NU_AUTO_RELA_HIOD) NU_AUTO_RELA,
            TO_NUMBER(CAT_ODO.NU_AUTO_CAOD) NU_AUTO_CAOD  ,
            CAT_ODO.TX_NOMBRE_CAOD ,
            NU_COLOR_HIODO COLOR  ,
            IMG_ICONO_HIODO ICONO  ,
            CD_COD_HIODO NO_APLICACION  ,
            NU_DIENTE_HIODO DIENTE  ,
            NU_SUPERFICIE_HIODO SUPERFICIE  
        FROM HIST_ODO 
        INNER JOIN ODONTO_RELA ODR   
            ON NU_AUTO_RELA_HIOD = NU_AUTO_RELA
        INNER JOIN CATEGORIA_ODONTO CAT_ODO   
            ON ODR.NU_AUTO_CAOD_ODRE = CAT_ODO.NU_AUTO_CAOD
        WHERE  NU_NUME_HICL_HIODO = v_NOHICL
            AND NU_NUME_ORDEN_HIODO = v_ORDEN ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;