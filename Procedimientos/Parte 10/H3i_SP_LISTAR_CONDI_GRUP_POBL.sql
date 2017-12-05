CREATE OR REPLACE PROCEDURE H3i_SP_LISTAR_CONDI_GRUP_POBL
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_COD_GRUP_POBLA IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT CP.CD_CODI_GP_CP CODIGO  ,
             NVL(TO_NUMBER(CP.NU_SEXO_CP), 0) GENERO  ,
             NVL(CP.NU_EDAD_INI_CP, 0) EDAD_INI  ,
             NVL(CP.NU_EDAD_FIN_CP, 0) EDAD_FIN  ,
             NVL(CP.NU_MED_EDAD_CP, 0) MED_EDAD  ,
             CP.NU_GEST_CP GESTANTE  
        FROM CONDICION_POBLA CP
               JOIN GRUPO_POBLA GP   ON CP.CD_CODI_GP_CP = GP.CD_CODI_GP
       WHERE  GP.CD_CODI_GP = v_COD_GRUP_POBLA
                AND CD_CODI_GP_CP IS NOT NULL ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;