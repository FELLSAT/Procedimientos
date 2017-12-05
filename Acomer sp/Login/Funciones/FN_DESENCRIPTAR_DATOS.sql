CREATE OR REPLACE FUNCTION FN_DESENCRIPTAR_DATOS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	V_IN_DATOS RAW -- DATOS QUE SE VAN A DESENCRIPTAR
)
RETURN VARCHAR2
IS
	V_OUT_DATOS VARCHAR2(20);
BEGIN
	V_OUT_DATOS := UTL_RAW.cast_to_varchar2(
						DBMS_CRYPTO.DECRYPT(
							TRIM(V_IN_DATOS),
							typ => 4353,
							key => UTL_I18N.STRING_TO_RAW ('3NCR1PTS4T44C0M3R', 'AL32UTF8')));

	RETURN V_OUT_DATOS;
END;