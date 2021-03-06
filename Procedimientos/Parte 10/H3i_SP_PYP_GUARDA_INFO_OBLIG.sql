CREATE OR REPLACE PROCEDURE H3i_SP_PYP_GUARDA_INFO_OBLIG
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CODIGO IN NUMBER,
  v_CODIGO_ACTPARAM IN NUMBER,
  v_NOMBRE IN VARCHAR2,
  v_DESCRIPCION IN VARCHAR2,
  v_TIPO IN NUMBER
)
AS

BEGIN

   IF ( v_CODIGO <> 0 ) THEN
    
   BEGIN
      UPDATE PYP_INFO_OBLIG
         SET CD_CODI_ACTI_PYPINFOBLI = v_CODIGO_ACTPARAM,
             TX_NOMBRE_PYPINFOBLI = v_NOMBRE,
             TX_DESCRIP_PYPINFOBLI = v_DESCRIPCION,
             NU_TIPO_PYPINFOBLI = v_TIPO
       WHERE  NU_AUTO_PYPINFOBLI = v_CODIGO;
   
   END;
   ELSE
   
   BEGIN
      INSERT INTO PYP_INFO_OBLIG
        ( CD_CODI_ACTI_PYPINFOBLI, TX_NOMBRE_PYPINFOBLI, TX_DESCRIP_PYPINFOBLI, NU_TIPO_PYPINFOBLI )
        VALUES ( v_CODIGO_ACTPARAM, v_NOMBRE, v_DESCRIPCION, v_TIPO );
   
   END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;