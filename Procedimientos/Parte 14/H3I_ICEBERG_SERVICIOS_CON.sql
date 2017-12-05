CREATE OR REPLACE PROCEDURE H3I_ICEBERG_SERVICIOS_CON
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_cd_codi_ser IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT ire.cd_codi_iceberg ,
             ire.no_nomb_iceberg ,
             ser.CD_CODI_SER ,
             ser.NO_NOMB_SER ,
             ise.cd_cecos_iceberg 
       FROM iceberg_servicios ise
      INNER JOIN iceberg_referencias ire   
          ON ise.cd_codi_iceberg = ire.cd_codi_iceberg
      INNER JOIN SERVICIOS ser   
          ON ise.cd_codi_ser = ser.CD_CODI_SER
      WHERE  ise.cd_codi_ser = v_cd_codi_ser ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;