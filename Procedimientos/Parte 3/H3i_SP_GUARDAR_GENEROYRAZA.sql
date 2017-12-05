CREATE OR REPLACE PROCEDURE H3i_SP_GUARDAR_GENEROYRAZA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_HIST_PAC IN VARCHAR2,
  v_CD_CODI_RAZA IN CHAR,
  v_CD_CODI_GEN IN CHAR
)
AS
   v_temp NUMBER(1, 0) := 0;

BEGIN

   BEGIN
      SELECT 1 INTO v_temp
        FROM DUAL
       WHERE EXISTS ( SELECT * 
                      FROM R_PAC_RAZAYGENERO 
                       WHERE  NU_HIST_PAC = v_NU_HIST_PAC );
   EXCEPTION
      WHEN OTHERS THEN
         NULL;
   END;
      
   IF v_temp = 1 THEN
    
   BEGIN
      UPDATE R_PAC_RAZAYGENERO
         SET CD_RAZA_PAC = v_CD_CODI_RAZA,
             CD_GEN_PAC = v_CD_CODI_GEN
       WHERE  NU_HIST_PAC = v_NU_HIST_PAC;
   
   END;
   ELSE
   
   BEGIN
      INSERT INTO R_PAC_RAZAYGENERO
        VALUES ( v_NU_HIST_PAC, v_CD_CODI_RAZA, v_CD_CODI_GEN );
   
   END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_GUARDAR_GENEROYRAZA;