CREATE OR REPLACE PROCEDURE H3i_SP_OBTENER_EVENTO_ADVERSO /*PROCEDIMIENTO PARA BUSCAR EVENTOS ADVERSOS*/
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_HIST_PAC IN VARCHAR2,
  v_EPS IN VARCHAR2,
  v_FECH_INICIAL IN DATE,
  v_FECH_FINAL IN DATE,
  v_INTERVALO IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS
   v_PACIENTE NUMBER(1,0) := 0;
   v_FECHA NUMBER(1,0) := 0;
   v_EP NUMBER(1,0) := 0;

BEGIN

    IF v_NU_HIST_PAC <> ' ' THEN    
        BEGIN
            v_PACIENTE := 1;    
        END;
    END IF;


    IF v_EPS <> ' ' THEN    
        BEGIN
            v_EP := 1 ;
        END;
    END IF;


    IF v_INTERVALO <> 0 THEN    
      BEGIN
          v_FECHA := 1;   
      END;
    END IF;


    OPEN  cv_1 FOR
        SELECT EA.CD_EVENTO_ADVERSO, EA.NU_HIST_PAC,
               EA.TIPO_DOC_PAC, EA.NUM_DOC_PAC,
               EA.USUARIO, EA.ANIO,
               EA.MES AS MES_LITERAL, EA.DIA, TO_CHAR(EA.FECHA_COMPLETA,'MM') AS MES,
               EA.FECHA_COMPLETA, EA.TIPO_EVENTO,
               TE1.NUM_SECUENCIA AS EVENTO_SECUENCIA, TE1.NOM_EVENTO EVENTO,
               EA.CAUSA_EVENTO, TE2.NUM_SECUENCIA AS CAUSA_SECUENCIA,
               TE2.NUM_SECUENCIA_PADRE AS CAUSA_SECUENCIA_PADRE, TE2.NOM_EVENTO AS CAUSA,
               EA.EPS, EA.OBSERVACION,
               EA.TX_NOMBRE_EVAD, EA.TX_DESCRIBE_EVAD,
               EA.TX_EVIDENCIA_EVAD, EA.NU_NUME_CONE_EVAD,
               EA.FE_REGISTRO_EVAD 
        FROM EVENTO_ADVERSO EA
               INNER JOIN TIPO_EVENTO_ADVERSO TE1   
               ON EA.TIPO_EVENTO = TE1.CD_TIPO_EVENTO
               INNER JOIN TIPO_EVENTO_ADVERSO TE2   
               ON EA.CAUSA_EVENTO = TE2.CD_TIPO_EVENTO
        WHERE ( 
                (v_PACIENTE = 0 OR ( 
                                    v_PACIENTE = 1 AND 
                                    RECUPERARNUMEROSVARCHAR(EA.NU_HIST_PAC) = RECUPERARNUMEROSVARCHAR(v_NU_HIST_PAC) 
                                   ) 
                )
                AND 
                ( 
                  ( v_EP = 0 AND v_FECHA = 0 ) OR 
                  ( v_EP = 0 AND v_FECHA = 1 AND v_INTERVALO = 1 AND EA.FECHA_COMPLETA >= v_FECH_INICIAL) OR 
                  ( v_EP = 0 AND v_FECHA = 1 AND v_INTERVALO = 2 AND EA.FECHA_COMPLETA <= v_FECH_FINAL) OR 
                  ( v_EP = 0 AND v_FECHA = 1 AND v_INTERVALO = 3 AND EA.FECHA_COMPLETA BETWEEN v_FECH_INICIAL AND v_FECH_FINAL) OR 
                  ( v_EP = 1 AND v_FECHA = 0 AND EA.EPS = v_EPS) OR 
                  ( v_EP = 1 AND v_FECHA = 1 AND EA.EPS = v_EPS AND v_INTERVALO = 1 AND EA.FECHA_COMPLETA >= v_FECH_INICIAL) OR 
                  ( v_EP = 1 AND v_FECHA = 1 AND EA.EPS = v_EPS AND v_INTERVALO = 2 AND EA.FECHA_COMPLETA <= v_FECH_FINAL ) OR 
                  ( v_EP = 1 AND v_FECHA = 1 AND EA.EPS = v_EPS AND v_INTERVALO = 3 AND EA.FECHA_COMPLETA BETWEEN v_FECH_INICIAL AND v_FECH_FINAL) 
                ) 
              )
        ORDER BY EA.FECHA_COMPLETA DESC;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;