CREATE OR REPLACE PROCEDURE H3i_SP_ACTUALIZA_FRECUENCIA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_HIST_PAC IN VARCHAR2,
  v_CD_CODI_SER IN VARCHAR2,
  v_CD_CODI_FREC IN NUMBER
)
AS
   v_CANTIDAD NUMBER(10,0);
   v_temp NUMBER(1, 0) := 0;

BEGIN

   BEGIN
      SELECT 1 INTO v_temp
        FROM DUAL
       WHERE NOT EXISTS ( SELECT NU_CANT_FREC 
                          FROM R_FREC_PAC 
                           WHERE  NU_HIST_PAC = v_NU_HIST_PAC
                                    AND CD_CODI_SER = v_CD_CODI_SER );
   EXCEPTION
      WHEN OTHERS THEN
         NULL;
   END;
      
   IF v_temp = 1 THEN
    
   BEGIN
      SELECT NU_VALOR_FREC 

        INTO v_CANTIDAD
        FROM FREC_SER_POBLA 
       WHERE  NU_CONS_RSA_FREC = v_CD_CODI_FREC;
      v_CANTIDAD := v_CANTIDAD - 1 ;
      INSERT INTO R_FREC_PAC
        VALUES ( v_NU_HIST_PAC, v_CD_CODI_SER, v_CANTIDAD );
   
   END;
   ELSE
   
   BEGIN
      SELECT NU_CANT_FREC 

        INTO v_CANTIDAD
        FROM R_FREC_PAC 
       WHERE  NU_HIST_PAC = v_NU_HIST_PAC;
      v_CANTIDAD := v_CANTIDAD - 1 ;
      UPDATE R_FREC_PAC
         SET NU_CANT_FREC = v_CANTIDAD
       WHERE  NU_HIST_PAC = v_NU_HIST_PAC
        AND CD_CODI_SER = v_CD_CODI_SER;
   
   END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;