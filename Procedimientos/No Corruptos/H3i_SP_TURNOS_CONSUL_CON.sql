CREATE OR REPLACE PROCEDURE HIMS.H3i_SP_TURNOS_CONSUL_CON
-- =============================================      
-- Author:  Carlos Castro Agudelo
-- ============================================= 
(v_codConsultorio IN VARCHAR2, v_FInicio IN DATE, v_FFinal IN DATE, cv_1 OUT SYS_REFCURSOR)
IS
BEGIN 
    BEGIN
        OPEN  cv_1 FOR
        SELECT FE_FECH_TUME, FE_HOIN_TUME, 
            FE_HOFI_TUME, NU_TIEMCIT_TUME, 
            ID_DISP_TUME, CD_CODI_CONS_TUME, 
            NU_NUME_TUME, TX_MOTINHA_TUME, 
            TX_CODI_EQUI_TUME, 
            NU_AUTO_TIPO_TUME_TUME,
            CD_MED_TUME, TX_DESC_TIPO_TUME, 
            NU_AUTO_HOGR_TUME 
        FROM TURNOS_MEDICOS 
        LEFT JOIN TIPO_TURNO_MED ON ( NU_AUTO_TIPO_TUME_TUME = NU_AUTO_TIPO_TUME )
        WHERE  (v_codConsultorio IS NULL OR CD_CODI_CONS_TUME = v_codConsultorio) AND (FE_FECH_TUME >= v_FInicio) AND (FE_FECH_TUME <= v_FFinal)
        UNION ALL 
        SELECT FE_FECH_TUME, FE_HOIN_TUME, 
        FE_HOFI_TUME, NU_TIEMCIT_TUME, 
        ID_DISP_TUME, TO_CHAR(CD_CODI_CONS_RTE), 
        NU_NUME_TUME, TX_MOTINHA_TUME, 
        TX_CODI_EQUI_TUME, NU_AUTO_TIPO_TUME_TUME,
        CD_MED_TUME, TX_DESC_TIPO_TUME, 
        NU_AUTO_HOGR_TUME 
        FROM TURNOS_MEDICOS 
        JOIN R_TUR_ESC ON NU_NUME_TUME = NU_NUME_TUME_RTE
        LEFT JOIN TIPO_TURNO_MED ON ( NU_AUTO_TIPO_TUME_TUME = NU_AUTO_TIPO_TUME )
        WHERE  (v_codConsultorio IS NULL OR CD_CODI_CONS_RTE = v_codConsultorio) AND (FE_FECH_TUME >= v_FInicio) AND (FE_FECH_TUME <= v_FFinal);
    END;
Exception
    When Others Then
    RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;
/