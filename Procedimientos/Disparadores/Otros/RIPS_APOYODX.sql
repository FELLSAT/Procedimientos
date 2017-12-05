CREATE OR REPLACE TRIGGER RIPS_APOYODX 
AFTER INSERT
ON LABORATORIO
FOR EACH ROW
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================  
DECLARE
	V_CODSERV VARCHAR2(50);
	V_TIPO NUMBER;
	V_NUMLABO NUMBER;
BEGIN
	SELECT :NEW.CD_CODI_SER_LABO 
	INTO V_CODSERV
	FROM DUAL;
	------------------------------------------------------
	SELECT NU_OPCI_SER 
	INTO V_TIPO
	FROM SERVICIOS 
	WHERE CD_CODI_SER = V_CODSERV;
	------------------------------------------------------
	SELECT :NEW.NU_NUME_LABO 
	INTO V_NUMLABO
	FROM DUAL;
	------------------------------------------------------
	IF (V_TIPO = 2) THEN
		BEGIN
			UPDATE LABORATORIO
			SET TX_CODI_RPP_LABO='12'
			WHERE NU_NUME_LABO = V_NUMLABO;
		END;
	END IF;
END;