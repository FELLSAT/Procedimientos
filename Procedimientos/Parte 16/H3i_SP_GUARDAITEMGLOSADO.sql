CREATE OR REPLACE PROCEDURE H3i_SP_GUARDAITEMGLOSADO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_AUTO_REG_GLOSA_AGSI IN NUMBER,
  v_CD_CODI_ATDI_AGSI IN NUMBER,
  v_CAUSA IN VARCHAR2,
  v_ESTADO IN NUMBER,
  v_AUTO_REG_HIST IN NUMBER
)
AS

BEGIN

    -- Si es mayor a cero es porque se creo un historico al que actualizar el seguimiento de items antes de actualizar
    IF ( v_AUTO_REG_HIST > 0 ) THEN
        DECLARE
            v_TX_SEGUIMIENTO NVARCHAR2(2000);
            v_TX_SEGUIMIENTO_COMPLETO NVARCHAR2(2000);
            v_BOOL_ESTADO NUMBER(1,0);
            v_CAUSA_H VARCHAR2(20);
            v_CD_ATDI NUMBER(10,0);
   
        BEGIN
            SELECT BT_ESTADO_AGSI ,
                NVL(COD_CAUSA_TIPO_AGSI, ' ') ,
                CD_CODI_ATDI_AGSI 
                INTO v_BOOL_ESTADO,
                v_CAUSA_H,
                v_CD_ATDI
            FROM AUDITAR_GLOSADO_SEGUIM_ITEMS 
            WHERE  AUTO_REG_GLOSA_AGSI = v_AUTO_REG_GLOSA_AGSI
            AND CD_CODI_ATDI_AGSI = v_CD_CODI_ATDI_AGSI;
            -----------
            SELECT NVL(TX_SEGUIM_ITEMS_ARH, ' ') 
            INTO v_TX_SEGUIMIENTO
            FROM AUDITAR_REGISTRO_HISTORY 
            WHERE  AUTO_REG_HISTO = v_AUTO_REG_HIST;

            v_TX_SEGUIMIENTO_COMPLETO := v_TX_SEGUIMIENTO || ',' || TO_CHAR(v_CD_ATDI) || '-' || TO_CHAR(v_CAUSA_H) 
                        || '-' || TO_CHAR(v_BOOL_ESTADO) ;
            ----------
            UPDATE AUDITAR_REGISTRO_HISTORY
            SET TX_SEGUIM_ITEMS_ARH = v_TX_SEGUIMIENTO_COMPLETO
            WHERE  AUTO_REG_HISTO = v_AUTO_REG_HIST;
            ---------
            UPDATE AUDITAR_GLOSADO_SEGUIM_ITEMS
            SET COD_CAUSA_TIPO_AGSI = v_CAUSA,
                BT_ESTADO_AGSI = v_ESTADO
            WHERE  AUTO_REG_GLOSA_AGSI = v_AUTO_REG_GLOSA_AGSI
            AND CD_CODI_ATDI_AGSI = v_CD_CODI_ATDI_AGSI;   
        END;

    ELSE
   
        BEGIN
            INSERT INTO AUDITAR_GLOSADO_SEGUIM_ITEMS( 
                AUTO_REG_GLOSA_AGSI, CD_CODI_ATDI_AGSI, 
                COD_CAUSA_TIPO_AGSI, BT_ESTADO_AGSI )
            VALUES( 
                v_AUTO_REG_GLOSA_AGSI, v_CD_CODI_ATDI_AGSI, 
                v_CAUSA, v_ESTADO );
        END;

    END IF;

    
EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;