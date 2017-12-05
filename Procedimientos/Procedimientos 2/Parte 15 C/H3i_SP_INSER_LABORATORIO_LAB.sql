CREATE OR REPLACE PROCEDURE H3i_SP_INSER_LABORATORIO_LAB
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CD_AUTO_LAB OUT NUMBER,
  v_NOMBRE_LAB IN NVARCHAR2,
  v_CANTIDAD_LAB IN NUMBER,
  v_HORA_INI_ATEN_LAB IN DATE,
  v_HORA_FIN_ATEN_LAB IN DATE
)
AS

BEGIN

   	INSERT INTO LABORATORIO_LAB( 
   		NOMBRE_LAB, CANTIDAD_LAB, 
   		HORA_INI_ATEN_LAN, 
   		HORA_FIN_ATEN_LAB )
    VALUES ( 
    	v_NOMBRE_LAB, v_CANTIDAD_LAB, 
    	TO_DATE(v_HORA_INI_ATEN_LAB,'dd/mm/yyyy'), 
    	TO_DATE(v_HORA_FIN_ATEN_LAB,'dd/mm/yyyy') );


    SELECT CD_AUTO_LAB 
	INTO v_CD_AUTO_LAB 
	FROM LABORATORIO_LAB
	WHERE CD_AUTO_LAB = (SELECT MAX(CD_AUTO_LAB) FROM LABORATORIO_LAB);

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;