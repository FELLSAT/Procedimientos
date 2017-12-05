CREATE OR REPLACE PROCEDURE H3i_SP_GUARDA_ORDEN_SALIDA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_NUME_REG_ORSA IN NUMBER,
  v_FE_FECH_ORSA IN DATE,
  v_CD_CODI_MED_ORSA IN VARCHAR2,
  v_NU_ESTA_ORSA IN NUMBER
)
AS
   v_temp NUMBER(1, 0) := 0;

BEGIN

   BEGIN
      SELECT 1 INTO v_temp
        FROM DUAL
       WHERE ( SELECT COUNT(NU_AUTO_ORSA)  
               FROM ORDENSALIDA 
                WHERE  NU_NUME_REG_ORSA = v_NU_NUME_REG_ORSA ) = 0;
   EXCEPTION
      WHEN OTHERS THEN
         NULL;
   END;
      
   IF v_temp = 1 THEN
    
   BEGIN
      INSERT INTO ORDENSALIDA
        ( NU_NUME_REG_ORSA, FE_FECH_ORSA, CD_CODI_MED_ORSA, NU_ESTA_ORSA )
        VALUES ( v_NU_NUME_REG_ORSA, v_FE_FECH_ORSA, v_CD_CODI_MED_ORSA, v_NU_ESTA_ORSA );
   
   END;
   ELSE
   
   BEGIN
      UPDATE ORDENSALIDA
         SET FE_FECH_ORSA = v_FE_FECH_ORSA,
             CD_CODI_MED_ORSA = v_CD_CODI_MED_ORSA,
             NU_ESTA_ORSA = v_NU_ESTA_ORSA
       WHERE  NU_NUME_REG_ORSA = v_NU_NUME_REG_ORSA;
   
   END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;