CREATE OR REPLACE TRIGGER actualizaCodIps 
AFTER INSERT OR UPDATE OR DELETE 
ON ENTIDAD
FOR EACH ROW	
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
DECLARE

BEGIN
	UPDATE ENTIDAD
	SET cd_codi_pss_enti = '110010671007';
END;