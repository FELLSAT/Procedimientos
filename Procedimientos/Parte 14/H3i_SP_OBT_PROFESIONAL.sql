CREATE OR REPLACE PROCEDURE H3i_SP_OBT_PROFESIONAL
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NU_DOCU_MED IN VARCHAR2,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT CD_CODI_MED ,
            --,[NU_DOCU_MED]
            NO_NOMB_MED ,
            DE_CARG_MED ,
            DE_REGI_MED 
        FROM MEDICOS 
        WHERE  CD_CODI_MED = v_NU_DOCU_MED ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;