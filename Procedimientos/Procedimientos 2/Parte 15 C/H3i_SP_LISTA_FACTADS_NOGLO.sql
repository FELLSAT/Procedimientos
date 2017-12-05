CREATE OR REPLACE PROCEDURE H3i_SP_LISTA_FACTADS_NOGLO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
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
            DE_NOMB_ADSC NOMBREADS , 
            DE_NOMB_COAD NOMCONVE,
            CD_CODI_ADSC NIT  ,
            CASE( SELECT COUNT(*)  
                  FROM RIPS_TRANSACCION 
                  WHERE  NU_FAC_AF = NU_NUME_FAAD)
                WHEN 0 THEN 'NO'
                ELSE 'SI'
            END TIENERIPS  
        FROM FACTURA_ADSCRITO F
        INNER JOIN ADSCRITOS A   
            ON A.NU_CONSE_ADSC = F.NU_CONSE_ADSC_FAAD
        INNER JOIN CONVENIO_ADSC C   
            ON C.NU_NUME_COAD = F.NU_NUME_COAD_FAAD
        WHERE  F.NU_NUME_FAAD NOT IN( SELECT NU_NUME_FACU_DEGL 
                                      FROM DETALLE_GLOSA3i  );

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;