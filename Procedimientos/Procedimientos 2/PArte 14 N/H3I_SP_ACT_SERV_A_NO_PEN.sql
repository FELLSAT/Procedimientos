CREATE OR REPLACE PROCEDURE H3I_SP_ACT_SERV_A_NO_PEN
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NU_NUME_HPRO IN NUMBER,
    v_NU_NUME_MOVI_HPRO IN NUMBER,
    v_CD_CODI_SER_LABO IN VARCHAR2,
    v_TIPO_SERVICIO IN NUMBER,
    v_HIS_PACIENTE IN VARCHAR2,
    v_NU_NUME_REG IN NUMBER
)
AS
    v_NU_NUME_LABO_HPRO NUMBER(10,0);

BEGIN

    -----------
    SELECT NU_NUME_LABO 
    INTO v_NU_NUME_LABO_HPRO
    FROM LABORATORIO 
    WHERE  NU_NUME_MOVI_LABO = v_NU_NUME_MOVI_HPRO
        AND CD_CODI_SER_LABO = v_CD_CODI_SER_LABO;

    -----------
    UPDATE HIST_PROC
    SET NU_ESTA_HPRO = 2,
        NU_NUME_MOVI_HPRO = v_NU_NUME_MOVI_HPRO,
        NU_NUME_LABO_HPRO = v_NU_NUME_LABO_HPRO
    WHERE  NU_NUME_HPRO = v_NU_NUME_HPRO;

    -----------
    --SI EL TIPO DE SERVICIO ES PROCEDIMIENTO QUIRURGICO
    IF ( v_TIPO_SERVICIO = 3 ) THEN
        DECLARE
            v_NU_ACTO NUMBER(10,0);
        BEGIN
            SELECT MAX(NVL(NU_NUME_ACQX, 1))  + 1
            INTO v_NU_ACTO
            FROM ACTO_QX ;

            --------
            INSERT INTO ACTO_QX( 
                NU_NUME_ACQX, NU_HIST_PAC_ACQX, 
                NU_NUME_REG_ACQX )
            VALUES(
                v_NU_ACTO , v_HIS_PACIENTE ,
                v_NU_NUME_REG);

            --------
            INSERT INTO R_ACQX_MOVI( 
                NU_NUME_ACQX_RAM, NU_NUME_MOVI_RAM )
            VALUES( 
                v_NU_ACTO,
                v_NU_NUME_MOVI_HPRO);
        END;
    END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;