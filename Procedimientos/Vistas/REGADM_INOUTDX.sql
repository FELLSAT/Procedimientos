CREATE OR REPLACE VIEW REGADM_INOUTDX
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
AS 
        SELECT NU_TIAT_REG, NU_NUME_REG ,
            NU_ESCU_REG , NU_HIST_PAC ,
            FE_INGR_REG , FE_HOIN_REG ,
            FE_SALI_REG , FE_HOSA_REG ,
            NU_TIPD_PAC , NU_DOCU_PAC ,
            DE_PRAP_PAC || '  ' || DE_SGAP_PAC || ' ' || NO_NOMB_PAC || ' ' || NO_SGNO_PAC NOMBRE_PAC  ,
            ID_TIPO_DIAG_RLAD ,  CD_CODI_DIAG_RLAD ,
            DE_DESC_DIAG , NU_NUME_CONV ,
            CD_CODI_CONV , CD_NIT_EPS ,
            NO_NOMB_EPS ,
            FE_INGR_REG + ((TO_CHAR(FE_HOIN_REG,'HH') * 60) + TO_CHAR(FE_HOIN_REG,'MI')) / 1440 FECH_HORA_INGRESO  ,
            FE_SALI_REG + ((TO_CHAR(FE_HOSA_REG,'HH') * 60) + TO_CHAR(FE_HOSA_REG,'MI')) / 1440 FECH_HORA_EGRESO  
        FROM PACIENTES, REGISTRO ,
            R_LABO_DIAG, DIAGNOSTICO ,
            R_REGISTRO_CONV, CONVENIOS ,
            EPS 
        WHERE  NU_HIST_PAC_REG = NU_HIST_PAC
            AND NU_NUME_REG = NU_NUME_REG_RECO
            AND NU_NUME_CONV_RECO = NU_NUME_CONV
            AND CD_NIT_EPS_CONV = CD_NIT_EPS
            AND CD_CODI_DIAG_RLAD = CD_CODI_DIAG
            AND NU_NUME_LABO_RLAD = NU_NUME_REG
            AND ( NU_TIAT_REG = 1
                OR NU_TIAT_REG = 2 )
            AND ID_TIPO_RLAD = 2
            AND ID_TIPO_DIAG_RLAD = 'EN'
    UNION 
        SELECT B.NU_TIAT_REG, B.NU_NUME_REG ,
            B.NU_ESCU_REG, A.NU_HIST_PAC ,
            B.FE_INGR_REG, B.FE_HOIN_REG ,
            B.FE_SALI_REG, B.FE_HOSA_REG ,
            A.NU_TIPD_PAC, A.NU_DOCU_PAC ,
            A.DE_PRAP_PAC || '  ' || 
              A.DE_SGAP_PAC || ' ' ||
              A.NO_NOMB_PAC || ' ' || 
              A.NO_SGNO_PAC NOMBRE_PAC  ,
            G.ID_TIPO_DIAG_RLAD, G.CD_CODI_DIAG_RLAD ,
            C.DE_DESC_DIAG, E.NU_NUME_CONV ,
            E.CD_CODI_CONV, F.CD_NIT_EPS ,
            F.NO_NOMB_EPS, 
            B.FE_INGR_REG + ((TO_CHAR(B.FE_HOIN_REG,'HH') * 60) + TO_CHAR(B.FE_HOIN_REG,'MI')) / 1440 FECH_HORA_INGRESO  ,
            B.FE_SALI_REG + ((TO_CHAR(B.FE_HOSA_REG,'HH') * 60) + TO_CHAR(B.FE_HOSA_REG,'MI')) / 1440 FECH_HORA_EGRESO  
        FROM PACIENTES A
        INNER JOIN REGISTRO B   
            ON (B.NU_HIST_PAC_REG = A.NU_HIST_PAC )
        INNER JOIN R_REGISTRO_CONV D   
            ON (B.NU_NUME_REG = D.NU_NUME_REG_RECO )
        INNER JOIN CONVENIOS E   
            ON (D.NU_NUME_CONV_RECO = E.NU_NUME_CONV )
        INNER JOIN EPS F   
            ON (E.CD_NIT_EPS_CONV = F.CD_NIT_EPS )
        LEFT JOIN ( SELECT NU_NUME_REG_MOVI, NU_NUME_LABO ,
                        CD_CODI_DIAG_RLAD, ID_TIPO_DIAG_RLAD 
                    FROM MOVI_CARGOS, LABORATORIO ,
                        R_LABO_DIAG 
                    WHERE  NU_NUME_MOVI = NU_NUME_MOVI_LABO
                        AND NU_NUME_LABO = NU_NUME_LABO_RLAD
                        AND ID_TIPO_RLAD = 1
                        AND ID_TIPO_DIAG_RLAD = 'PR' ) G   
            ON ( G.NU_NUME_REG_MOVI = B.NU_NUME_REG )
        LEFT JOIN DIAGNOSTICO C   
            ON ( G.CD_CODI_DIAG_RLAD = C.CD_CODI_DIAG )
        WHERE  NU_TIAT_REG = 3;