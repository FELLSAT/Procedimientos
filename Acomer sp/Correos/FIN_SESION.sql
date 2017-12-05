CREATE OR REPLACE PROCEDURE FIN_SESION
(
	conn IN OUT NOCOPY utl_smtp.connection
) 
IS
BEGIN
	utl_smtp.quit(conn);
END;