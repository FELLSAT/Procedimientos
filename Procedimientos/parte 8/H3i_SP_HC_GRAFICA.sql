CREATE OR REPLACE PROCEDURE H3i_SP_HC_GRAFICA /*PROCEDIMIENTO ALMACENADO QUE PERMITE RECUPERAR LA GRAFICA*/
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_NUME_HICL_GRA IN NUMBER,
  v_NU_INDICE_H IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT NU_NUME_HICL_GRA ,
             NU_RECTA_XY ,
             NU_TEXTO_XY ,
             NU_CIRCULO_XY ,
             NU_INDICE_H ,
             NU_COLOR_XY ,
             NU_LINE_XY ,
             NU_ESTA_XY ,
             TX_HEXCOLOR_HIGRA ,
             NU_GROSORPUNTO_HIGR 
        FROM HIST_GRA 
       WHERE  NU_NUME_HICL_GRA = v_NU_NUME_HICL_GRA
                AND NU_INDICE_H = v_NU_INDICE_H ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;