CREATE OR REPLACE PROCEDURE H3i_SP_LISTA_FACTADS_TODAS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_FECH_INI IN DATE,
  v_FECH_FIN IN DATE,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT ID_IDEN_FAAD ,
            NU_NUME_FAAD ,
            NU_CONSE_ADSC_FAAD ,
            NU_NUME_COAD_FAAD ,
            FE_RECEP_FAAD ,
            FE_EXPED_FAAD ,
            VL_TOTAL_FAAD ,
            DE_NOMB_ADSC NOMBREADS  ,
            DE_DESC_COAD NOMCONVE  ,
            CD_CODI_ADSC NIT  ,
            CASE( SELECT COUNT(*)  
                  FROM RIPS_TRANSACCION 
                  WHERE  NU_FAC_AF = NU_NUME_FAAD )
                WHEN 0 THEN 'NO'
                ELSE 'SI'
            END TIENERIPS  
        FROM FACTURA_ADSCRITO F
        INNER JOIN ADSCRITOS A   
            ON A.NU_CONSE_ADSC = F.NU_CONSE_ADSC_FAAD
        INNER JOIN CONVENIO_ADSC C   
            ON C.NU_NUME_COAD = F.NU_NUME_COAD_FAAD
        WHERE  FE_RECEP_FAAD <= v_FECH_FIN
            AND FE_RECEP_FAAD >= v_FECH_INI ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;