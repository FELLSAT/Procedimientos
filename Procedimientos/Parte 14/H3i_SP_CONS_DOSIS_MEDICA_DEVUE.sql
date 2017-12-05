CREATE OR REPLACE PROCEDURE H3i_SP_CONS_DOSIS_MEDICA_DEVUE
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    V_NU_NUME_MOVI IN NUMBER,
    V_CD_CODI_ELE_FORM IN VARCHAR2
)
     
AS

BEGIN

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;
    CREATE TABLE #RESULTADO(
        DOSIS [nvarchar](2500) NULL,
        PRESENTACION [varchar](30),
        FRECUENCIA [varchar](500),
        UNIDAD_FRECUENCIA [int],
        VIA_ADMINISTRACION [nvarchar](400),
        DURACION_TRATAMIENTO [smallint],
        OBSERVACIONES [nvarchar](255)
    )

    INSERT INTO [#RESULTADO] ([DOSIS], [PRESENTACION], [FRECUENCIA], [UNIDAD_FRECUENCIA], [VIA_ADMINISTRACION], 
        [DURACION_TRATAMIENTO], [OBSERVACIONES])
    SELECT     
        CONVERT([nvarchar](2500), ISNULL([sme].[DE_DOSIS_SMED],'')) AS DOSIS,
        ISNULL([sme].[DE_UNME_SMED], '') AS PRESENTACION,
        ISNULL([hme].[DE_FREC_ADMIN_HMED],'') AS FRECUENCIA,
        ISNULL([hme].[NU_UNFRE_HMED],0) AS UNIDAD_FRECUENCIA,
        ISNULL([hme].[DE_VIA_ADMIN_HMED],'') AS VIA_ADMINISTRACION,
       ISNULL([hme].[NU_NUME_DUR_TRAT_HMED],0) AS DURACION_TRATAMIENTO,
        ISNULL([hme].[TX_OBSERV_HED],'') AS OBSERVACIONES
    FROM
        [dbo].[SOLICITUD_MED] sme with(NOLOCK)
        INNER JOIN HIST_MEDI hme with(NOLOCK)
            ON [sme].[NU_NUME_HMED_SMED] = [hme].[NU_NUME_HMED]
   WHERE
        [sme].[NU_NUME_MOVI_SMED] = @NU_NUME_MOVI
        AND [sme].[CD_CODI_ARTI_SMED] = @CD_CODI_ELE_FORM
   GROUP BY
        CONVERT([nvarchar](2500), ISNULL([sme].[DE_DOSIS_SMED],'')),
        ISNULL([sme].[DE_UNME_SMED], ''),
        ISNULL([hme].[DE_FREC_ADMIN_HMED],''),
        ISNULL([hme].[NU_UNFRE_HMED],0),
        ISNULL([hme].[DE_VIA_ADMIN_HMED],''),
        ISNULL([hme].[NU_NUME_DUR_TRAT_HMED],0),
        ISNULL([hme].[TX_OBSERV_HED],'')

    SELECT * FROM #RESULTADO

GO