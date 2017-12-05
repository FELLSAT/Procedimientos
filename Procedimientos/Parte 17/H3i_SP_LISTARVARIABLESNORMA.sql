CREATE OR REPLACE PROCEDURE H3i_SP_LISTARVARIABLESNORMA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_CODIGO IN VARCHAR2 DEFAULT NULL ,
    v_CRITERIO IN NUMBER DEFAULT NULL ,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    IF ( v_CRITERIO IS NULL ) THEN
    
        BEGIN
            OPEN  cv_1 FOR
                SELECT CD_CODI_VN ,
                    DE_DESC_VN ,
                    CD_CODI_NORMA_VN ,
                    ES_ESTA_VN 
                FROM VARIABLES_NORMA;  
        END;

    ELSE

        IF ( v_CRITERIO = 1 ) THEN
       
            BEGIN
                OPEN  cv_1 FOR
                    SELECT CD_CODI_VN ,
                        DE_DESC_VN ,
                        CD_CODI_NORMA_VN ,
                        ES_ESTA_VN 
                    FROM VARIABLES_NORMA 
                    WHERE  DE_DESC_VN LIKE '%' || v_CODIGO || '%' ;
            END;

        ELSE

            IF ( v_CRITERIO = 0 ) THEN
          
                BEGIN
                    OPEN  cv_1 FOR
                    SELECT CD_CODI_VN ,
                        DE_DESC_VN ,
                        CD_CODI_NORMA_VN ,
                        ES_ESTA_VN 
                    FROM VARIABLES_NORMA 
                    WHERE  CD_CODI_VN LIKE '%' || v_CODIGO || '%' ;
                END;
                
            END IF;
        END IF;
    END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;