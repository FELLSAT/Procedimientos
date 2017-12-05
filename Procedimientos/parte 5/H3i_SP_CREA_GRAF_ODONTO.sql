CREATE OR REPLACE PROCEDURE H3i_SP_CREA_GRAF_ODONTO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NOMB_GRAF IN VARCHAR2,
  v_ICON_GRAF IN VARCHAR2,
  v_TIPO_GRAF IN VARCHAR2
)
AS
   v_CODIGO NUMBER(10,0);

BEGIN

   SELECT NVL(( SELECT * 
                  FROM ( SELECT TO_NUMBER(CD_CODI_GRAF,10.0) CD_CODI_GRAF  
                FROM GRAF_ODONTO 
                  ORDER BY CD_CODI_GRAF DESC )
                  WHERE ROWNUM <= 1 ), 0)

     INTO v_CODIGO
     FROM DUAL ;
   IF v_CODIGO IS NOT NULL THEN
    
   BEGIN
      v_CODIGO := v_CODIGO + 1 ;
      INSERT INTO GRAF_ODONTO
        ( CD_CODI_GRAF, NO_NOMB_GRAF, GR_ICON_GRAF, TI_TIPO_GRAF )
        VALUES ( TO_CHAR(v_CODIGO,4), v_NOMB_GRAF, v_ICON_GRAF, v_TIPO_GRAF );
   
   END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;