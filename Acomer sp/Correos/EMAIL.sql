CREATE OR REPLACE PROCEDURE EMAIL 
(
	sender IN VARCHAR2,
    sender_name IN VARCHAR2,
    recipients IN VARCHAR2,
    subject IN VARCHAR2,
    message IN CLOB,
    repositorio IN VARCHAR2 DEFAULT NULL,
    archivo IN VARCHAR2 DEFAULT NULL
)
IS                    
    tamano_lob NUMBER(7) := 0;
    porcion_lob CLOB;
    tamano_buffer INTEGER := 2000;
    posicion INTEGER := 1;
    archivo_origen BFILE;
    archivo_destino BLOB := TO_BLOB('1');
    vble_raw RAW(2000);  
    conn utl_smtp.connection;
    boundary VARCHAR2(32) := sys_guid(); --CONSTANT VARCHAR2(256) := '-----7D81B75CCC90D2974F7A1CBD';   
BEGIN
    conn := INICIA_SESION;  
    utl_smtp.mail( conn, sender );
    utl_smtp.rcpt( conn, recipients );
    utl_smtp.open_data(conn);
    
    -- Encabezado
    utl_smtp.write_data( conn, 'From: ' ||sender_name||'<'||sender||'>' || utl_tcp.crlf );
    utl_smtp.write_data( conn, 'To: ' || recipients || utl_tcp.crlf );
    utl_smtp.write_data( conn, 'Subject: ' || subject || utl_tcp.crlf );
    utl_smtp.write_data( conn, 'MIME-Version: 1.0' || utl_tcp.crlf );
    utl_smtp.write_data( conn, 'Content-Type: multipart/mixed; ' || utl_tcp.crlf );
    utl_smtp.write_data( conn, ' boundary= "' || boundary || '"' || utl_tcp.crlf );
    utl_smtp.write_data( conn, utl_tcp.crlf );

    -- Cuerpo
    utl_smtp.write_data( conn, '--' || boundary || utl_tcp.crlf );
    utl_smtp.write_data( conn, 'Content-Type: text/html;' || utl_tcp.crlf );
    utl_smtp.write_data( conn, ' charset=US-ASCII' || utl_tcp.crlf );
    utl_smtp.write_data( conn, utl_tcp.crlf );
    -- Carga el cuerpo del mensaje por porciones debido a que el contenido puede ser grande 
    tamano_lob := dbms_lob.getlength(message);
    posicion := 1;
    while posicion < tamano_lob loop
        dbms_lob.read(message, tamano_buffer, posicion, porcion_lob);
        utl_smtp.write_data(conn, porcion_lob );
        posicion := posicion + tamano_buffer;
    end loop;
    utl_smtp.write_data(conn, utl_tcp.crlf);        

    -- Attachment
    IF (repositorio IS NOT NULL) AND (archivo IS NOT NULL) THEN  
         archivo_origen := BFILENAME(repositorio, archivo);             
        -- abre el archivo
        DBMS_LOB.FILEOPEN(archivo_origen, DBMS_LOB.FILE_READONLY);             
        -- carga el archivo a la variable archivo_destino de tipo blob
        DBMS_LOB.LOADFROMFILE(archivo_destino, archivo_origen, DBMS_LOB.GETLENGTH(archivo_origen));
        -- cierra el archivo
        DBMS_LOB.FILECLOSE(archivo_origen);
        utl_smtp.write_data( conn, '--' || boundary || utl_tcp.crlf );
        utl_smtp.write_data( conn, 'Content-Type: application/octet-stream' || utl_tcp.crlf );
        utl_smtp.write_data( conn, 'Content-Disposition: attachment; ' || utl_tcp.crlf );
        utl_smtp.write_data( conn, ' filename="' || archivo || '"' || utl_tcp.crlf );
        utl_smtp.write_data( conn, 'Content-Transfer-Encoding: base64' || utl_tcp.crlf );
        utl_smtp.write_data( conn, utl_tcp.crlf );

        -- Recorre el blob por partes de 2000 bytes y lo escribe en el buffer del mail
        tamano_lob := dbms_lob.getlength(archivo_destino);
        while posicion < tamano_lob loop
          dbms_lob.read(archivo_destino, tamano_buffer, posicion, vble_raw);
          utl_smtp.write_raw_data(conn, utl_encode.base64_encode(vble_raw) );
          utl_smtp.write_data(conn, utl_tcp.crlf);
          posicion := posicion + tamano_buffer;
        end loop;
        utl_smtp.write_data(conn, utl_tcp.crlf);
    END IF;    

    -- Close Email
    FIN_EMAIL(conn);

    exception
    --smtp errors, close connection and reraise
    when utl_smtp.transient_error or
       utl_smtp.permanent_error then
       utl_smtp.quit( conn );
    raise;
END;