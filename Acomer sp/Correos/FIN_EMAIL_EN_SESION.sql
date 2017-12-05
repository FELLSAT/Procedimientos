CREATE OR REPLACE PROCEDURE FIN_EMAIL_EN_SESION 
(
	conn IN OUT NOCOPY utl_smtp.connection
) 
IS
BEGIN
    utl_smtp.close_data(conn);
END;