CREATE OR REPLACE PROCEDURE H3i_SP_RPT_PAI_NOPAI_P
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_PAI IN NUMBER,
  v_MES IN NUMBER,
  v_ANIO IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   DELETE FROM tt_Temp_5;
   INSERT INTO tt_Temp_5
     ( SELECT SERVICIOS.NO_NOMB_SER VACUNA  ,
              VACUNACION.NU_DOSIS_VACU DOSIS  ,
              TIPOUSUARIO.DE_DESC_TIUS REGIMEN  ,
              'R' TIPO_R  ,
              PACIENTES.FE_NACI_PAC ,
              VACUNACION.FE_FECH_VACU ,
              CalcularEdad(PACIENTES.FE_NACI_PAC, VACUNACION.FE_FECH_VACU, 0) EDAD  ,
              CalcularEdad(PACIENTES.FE_NACI_PAC, VACUNACION.FE_FECH_VACU, 1) UME  ,
              CASE 
                   WHEN ( PACIENTES.NU_ISDESPLAZADO_PAC IS NULL )
                     OR ( PACIENTES.NU_ISDESPLAZADO_PAC = 0 ) THEN 'N'
              ELSE 'S'
                 END DESPLAZADO  
       FROM PACIENTES PACIENTES
              JOIN VACUNACION    ON PACIENTES.NU_HIST_PAC = VACUNACION.NU_HIST_PAC_VACU
              JOIN SERVICIOS    ON VACUNACION.CD_CODI_SERV_VACU = SERVICIOS.CD_CODI_SER
              JOIN MOVI_CARGOS    ON VACUNACION.NU_NUME_MOVI_VACU = MOVI_CARGOS.NU_NUME_MOVI
              JOIN TIPOUSUARIO    ON MOVI_CARGOS.CD_REGIMEN_MOVI = HIMS2.TIPOUSUARIO.ID_CODI_TIUS
        WHERE  ( VACUNACION.TX_PAI = v_PAI )
                 AND ( TX_TIPO_VACU = 'APLICACION' )
                 AND utils.month_(VACUNACION.FE_FECH_VACU) = v_MES
                 AND utils.year_(VACUNACION.FE_FECH_VACU) = v_ANIO
       UNION 
       SELECT SERVICIOS.NO_NOMB_SER VACUNA  ,
              VACUNACION.NU_DOSIS_VACU DOSIS  ,
              ETNIA.TX_NOMBRE_ETNI ETNIA  ,
              'E' TIPO_E  ,
              PACIENTES.FE_NACI_PAC ,
              VACUNACION.FE_FECH_VACU ,
              CalcularEdad(PACIENTES.FE_NACI_PAC, VACUNACION.FE_FECH_VACU, 0) EDAD  ,
              CalcularEdad(PACIENTES.FE_NACI_PAC, VACUNACION.FE_FECH_VACU, 1) UME  ,
              CASE 
                   WHEN ( PACIENTES.NU_ISDESPLAZADO_PAC IS NULL )
                     OR ( PACIENTES.NU_ISDESPLAZADO_PAC = 0 ) THEN 'N'
              ELSE 'S'
                 END DESPLAZADO  
       FROM PACIENTES PACIENTES
              JOIN VACUNACION    ON PACIENTES.NU_HIST_PAC = VACUNACION.NU_HIST_PAC_VACU
              JOIN SERVICIOS    ON VACUNACION.CD_CODI_SERV_VACU = SERVICIOS.CD_CODI_SER
              JOIN ETNIA    ON PACIENTES.TX_CODIGO_ETNI_PACI = ETNIA.TX_CODIGO_ETNI
        WHERE  ( VACUNACION.TX_PAI = v_PAI )
                 AND ( TX_TIPO_VACU = 'APLICACION' )
                 AND utils.month_(VACUNACION.FE_FECH_VACU) = v_MES
                 AND utils.year_(VACUNACION.FE_FECH_VACU) = v_ANIO , LTRIM ( REGIMEN ) REGIMEN , Tipo , "1" AS Dosis1 , "2" AS Dosis2 , "3" AS Dosis3 , "4" AS Dosis4 , "5" AS Dosis5 , "6" AS Dosis6 , FechaNacimiento , FechaVacunacion , EDAD , UME , "S" AS DESPLAZADO FROM ( SELECT VACUNA , REGIMEN , tipo , DOSIS , FechaNacimiento , FechaVacunacion , EDAD , UME , DESPLAZADO FROM tt_Temp_5 ) AS SouceTable PIVOT ( COUNT ( DOSIS ) FOR DOSIS IN ( "1" , "2" , "3" , "4" , "5" , "6" ) ) AS PivotTableDosis PIVOT (  --SQLDEV: NOT RECOGNIZED );
   LTRIM(REGIMEN) ;
   OPEN  cv_1 FOR
      SELECT VACUNA ,
             REGIMEN ,
             tipo ,
             DOSIS ,
             FechaNacimiento ,
             FechaVacunacion ,
             EDAD ,
             UME ,
             DESPLAZADO 
        FROM tt_Temp_5  ; --SQLDEV: NOT RECOGNIZED

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;