CREATE OR REPLACE PROCEDURE H3i_SP_ELIM_FREC_ELEM
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_COD_ELEMENTO_REL IN NUMBER,
  v_CD_CODI_GP_RAG IN VARCHAR2
)
AS
   v_temp NUMBER(1, 0) := 0;

BEGIN

   DELETE R_ARTI_GRPOB

    WHERE  NU_AUTO_RARA_RAG = v_COD_ELEMENTO_REL
             AND CD_CODI_GP_RAG = v_CD_CODI_GP_RAG;
   BEGIN
      SELECT 1 INTO v_temp
        FROM DUAL
       WHERE ( ( SELECT COUNT(NU_AUTO_RARA)  
                 FROM R_ARTI_ACTI 
                  WHERE  NU_AUTO_RARA = v_COD_ELEMENTO_REL ) = 0 );
   EXCEPTION
      WHEN OTHERS THEN
         NULL;
   END;
      
   IF v_temp = 1 THEN
    
   BEGIN
      DELETE R_ARTI_ACTI

       WHERE  NU_AUTO_RARA = v_COD_ELEMENTO_REL;
   
   END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;