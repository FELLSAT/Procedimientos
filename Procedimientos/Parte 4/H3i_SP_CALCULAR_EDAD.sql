CREATE OR REPLACE PROCEDURE H3i_SP_CALCULAR_EDAD /*PROCEDIMIENTO ALMACENADO QUE LLAMA LA FUNCION DBO.CALCULAREDAD*/
/*ESTE PROCEDIMIENTO SE CREO PARA PODER USAR CONEXION.ObtenerDatos() CON UN PROCEDIMIENTO ALMACENADO*/
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_FECHA_NACIMIENTO IN DATE DEFAULT NULL ,
  v_FECHA_COMPARA IN DATE DEFAULT NULL ,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT CalcularEdad(v_FECHA_NACIMIENTO, v_FECHA_COMPARA, 0) ,
             CalcularEdad(v_FECHA_NACIMIENTO, v_FECHA_COMPARA, 1) 
        FROM DUAL ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;