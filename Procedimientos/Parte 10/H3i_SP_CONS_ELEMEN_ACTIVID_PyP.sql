CREATE OR REPLACE PROCEDURE H3i_SP_CONS_ELEMEN_ACTIVID_PyP
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	V_CD_ACTIVIDAD_PYP IN VARCHAR2,
	CV_1 OUT SYS_REFCURSOR
)				
AS

BEGIN
	OPEN CV_1 FOR
		SELECT CD_CODI_ARTI,
	       NO_NOMB_ARTI
		FROM ARTICULO A 
		INNER JOIN R_ARTI_ACTI RARA ON A.CD_CODI_ARTI = RARA.CD_CODI_ARTI_RARA
		INNER JOIN ACTIVIDAD_PYP APYP ON RARA.CD_CODI_ACTI_RARA = APYP.CD_CODI_ACTI
		WHERE APYP.CD_CODI_ACTI = V_CD_ACTIVIDAD_PYP;
END;