CREATE OR REPLACE PROCEDURE H3i_SP_RECUPERAR_GRUPO_HIST -- SCRIPT QUE RECUPERAR TODOS LOS GRUPOS EXISTENTES EN HISTORIA CLINICA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_POR_NOMBRE IN NUMBER,
  v_DATO IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS
   v_CONT NUMBER(10,0);

BEGIN

   SELECT TO_NUMBER(
                    TO_CHAR(( 
                              SELECT VL_VALO_CONT 
                              FROM CONTROL 
                              WHERE  CD_CONC_CONT = 'CANT_VIS_CONT_DIS' )))

     INTO v_CONT
     FROM DUAL ;
   IF v_POR_NOMBRE = 0 THEN
    
   BEGIN
      OPEN  cv_1 FOR
         SELECT * 
           FROM ( SELECT CD_CODI_GRHI ,
                         NU_NUME_GRHI ,
                         TX_TITULO_GRHI ,
                         9e99 DE_TMAX_VAHI2  ,
                         -9e99 DE_TMIN_VAHI2  ,
                         0 DE_TEMIN_VAHI1  ,
                         150 DE_TEMAX_VAHI1  
           FROM GRUPO_HIST 
          WHERE  TX_TITULO_GRHI LIKE '%' || v_DATO || '%'
           ORDER BY CD_CODI_GRHI )
           WHERE ROWNUM <= v_CONT ;
   
   END;
   ELSE
   
   BEGIN
      OPEN  cv_1 FOR
         SELECT * 
           FROM ( SELECT CD_CODI_GRHI ,
                         NU_NUME_GRHI ,
                         TX_TITULO_GRHI ,
                         9e99 DE_TMAX_VAHI2  ,
                         -9e99 DE_TMIN_VAHI2  ,
                         0 DE_TEMIN_VAHI1  ,
                         150 DE_TEMAX_VAHI1  
           FROM GRUPO_HIST 
          WHERE  CD_CODI_GRHI LIKE '%' || v_DATO || '%'
           ORDER BY CD_CODI_GRHI )
           WHERE ROWNUM <= v_CONT ;
   
   END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;