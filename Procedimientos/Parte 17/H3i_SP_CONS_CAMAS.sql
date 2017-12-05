CREATE OR REPLACE PROCEDURE H3i_SP_CONS_CAMAS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CodHabitacion IN VARCHAR2 DEFAULT NULL ,
  v_EstadoCama IN VARCHAR2 DEFAULT NULL ,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT CD_CODI_CAMA ,
             DE_DESC_CAMA ,
             CD_CODI_HABI_CAMA ,
             TO_NUMBER(NU_ESTA_CAMA) NU_ESTA_CAMA  ,
             CD_CODI_ESP_CAMA 
        FROM CAMAS 
       WHERE  CD_CODI_HABI_CAMA = NVL(v_CodHabitacion, CD_CODI_HABI_CAMA)
                AND NU_ESTA_CAMA = NVL(TO_NUMBER(v_EstadoCama), NU_ESTA_CAMA) ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;