CREATE OR REPLACE PROCEDURE H3i_SP_CAMBIARCLAVE /*PROCEDIMIENTO ALMACENADO QUE PERMITE REALIZAR EL CAMBIO DE CONTRASEÑA PARA UN USUARIO*/
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_LOGIN IN VARCHAR2,
  v_PASSW IN VARCHAR2
)
AS
   v_NUM_DIAS_CADUCIDAD NUMBER(10,0);
   v_FECHA_NUEVA DATE;

BEGIN

   	 SELECT TO_NUMBER(
        				   	 	TO_CHAR( 
            				   	 				TO_NUMBER(
                  								   	 	   (
                  									   	 	   	SELECT VL_VALO_CONT 
                  									            FROM CONTROL 
                  									            WHERE  CD_CONC_CONT = 'DIASVENPWD' 
                  									            AND ROWNUM <= 1
                  									        ) 
            								   	          ),
            						   	 		'10'
            						   	  ),
        		   	 			'10,0'
        		   	 		 )
     INTO v_NUM_DIAS_CADUCIDAD
     FROM DUAL ;
     --v_FECHA_NUEVA := utils.dateadd('DAY', v_NUM_DIAS_CADUCIDAD, SYSDATE) ;
   	 SELECT SYSDATE + v_NUM_DIAS_CADUCIDAD INTO v_FECHA_NUEVA FROM DUAL;
   UPDATE USUARIOS
      SET PS_PASS_USUA = v_PASSW,
          NU_CAMBCLAVE_USUA = 0,
          CA_PASSWORD = v_FECHA_NUEVA
    WHERE  ID_IDEN_USUA = v_LOGIN;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_CAMBIARCLAVE;