CREATE OR REPLACE FUNCTION INICIA_SESION 
RETURN utl_smtp.connection 
IS
    conn      utl_smtp.connection;
    smtp_host VARCHAR2(64);  
    smtp_domain VARCHAR2(64);
    smtp_user VARCHAR2(64);
    smtp_pass VARCHAR2(64);
BEGIN
    -- toma las variables necesarias para abrir la conexion SMTP de la tabla parametros_nue
	smtp_host := '192.168.0.195';    
    
    -- abre la conexion smtp
    conn := utl_smtp.open_connection(smtp_host,'25'/*smtp_port*/);
    utl_smtp.helo(conn,  smtp_domain);

    
    RETURN conn;
END;