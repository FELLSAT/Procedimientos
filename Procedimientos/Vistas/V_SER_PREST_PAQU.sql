CREATE OR REPLACE VIEW V_SER_PREST_PAQU
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
AS 
        SELECT E.NU_NUME_PAQU, E.CD_CODI_SER_PAQU,
            H.NO_NOMB_SER NO_NOMB_SER_PAQU,
            C.FE_FECH_MOVI FE_FECH_PAQU,
            A.CD_NIT_EPS, A.NO_NOMB_EPS,
            B.NU_NUME_CONV, B.CD_CODI_CONV,
            D.NU_HIST_PAC, D.NO_NOMB_PAC,
            D.NO_SGNO_PAC, D.DE_PRAP_PAC,
            D.DE_SGAP_PAC, G.CD_CODI_SER,
            G.NO_NOMB_SER, K.FE_FECH_MOVI,
            CASE 
                WHEN NVL(K.CD_CODI_SER_LABO, 'S') = 'S' THEN 'N'
                ELSE 'S'
            END PRESTADO ,
            CASE 
                WHEN NU_OBLI_RPSE = 1 THEN 'S'
                ELSE 'N'
            END OBLIGATORIO  ,
            1 SERPARAM  
        FROM EPS A
        INNER JOIN CONVENIOS B   
            ON A.CD_NIT_EPS = B.CD_NIT_EPS_CONV
        INNER JOIN MOVI_CARGOS C   
            ON B.NU_NUME_CONV = C.NU_NUME_CONV_MOVI
        INNER JOIN PACIENTES D   
            ON C.NU_HIST_PAC_MOVI = D.NU_HIST_PAC
        INNER JOIN PAQUETES E   
            ON C.NU_NUME_MOVI = E.NU_NUME_MOVI_PAQU
        INNER JOIN R_PAQU_SER F   
            ON E.CD_CODI_SER_PAQU = F.CD_CODI_SER_PAQ_RPSE
        INNER JOIN SERVICIOS G   
            ON F.CD_CODI_SER_RPSE = G.CD_CODI_SER
        INNER JOIN SERVICIOS H   
            ON E.CD_CODI_SER_PAQU = H.CD_CODI_SER
        LEFT JOIN ( SELECT I.NU_HIST_PAC_MOVI,
                        I.NU_NUME_PAQU_MOVI,
                        I.FE_FECH_MOVI,
                        J.CD_CODI_SER_LABO 
                    FROM MOVI_CARGOS I
                    INNER JOIN LABORATORIO J   
                        ON I.NU_NUME_MOVI = J.NU_NUME_MOVI_LABO ) K   
                        ON D.NU_HIST_PAC = K.NU_HIST_PAC_MOVI
                        AND E.NU_NUME_MOVI_PAQU = K.NU_NUME_PAQU_MOVI
                        AND F.CD_CODI_SER_RPSE = K.CD_CODI_SER_LABO

    UNION 

        SELECT G.NU_NUME_PAQU, G.CD_CODI_SER_PAQU ,
            H.NO_NOMB_SER NO_NOMB_SER_PAQU,
            I.FE_FECH_MOVI FE_FECH_PAQU,
            A.CD_NIT_EPS, A.NO_NOMB_EPS ,
            B.NU_NUME_CONV, B.CD_CODI_CONV ,
            F.NU_HIST_PAC, F.NO_NOMB_PAC ,
            F.NO_SGNO_PAC, F.DE_PRAP_PAC ,
            F.DE_SGAP_PAC, E.CD_CODI_SER ,
            E.NO_NOMB_SER, C.FE_FECH_MOVI ,
            'S' PRESTADO, 'N' OBLIGATORIO  ,
            2 SERPARAM  
        FROM EPS A
        INNER JOIN CONVENIOS B   
            ON A.CD_NIT_EPS = B.CD_NIT_EPS_CONV
        INNER JOIN MOVI_CARGOS C   
            ON B.NU_NUME_CONV = C.NU_NUME_CONV_MOVI
        INNER JOIN LABORATORIO D   
            ON C.NU_NUME_MOVI = D.NU_NUME_MOVI_LABO
        INNER JOIN SERVICIOS E   
            ON D.CD_CODI_SER_LABO = E.CD_CODI_SER
        INNER JOIN PACIENTES F   
            ON C.NU_HIST_PAC_MOVI = F.NU_HIST_PAC
        INNER JOIN PAQUETES G   
            ON C.NU_NUME_PAQU_MOVI = G.NU_NUME_PAQU
        INNER JOIN SERVICIOS H   
            ON G.CD_CODI_SER_PAQU = H.CD_CODI_SER
        INNER JOIN MOVI_CARGOS I   
            ON G.NU_NUME_MOVI_PAQU = I.NU_NUME_MOVI

    UNION 

        SELECT E.NU_NUME_PAQU, E.CD_CODI_SER_PAQU ,
            H.NO_NOMB_SER NO_NOMB_SER_PAQU  ,
            C.FE_FECH_MOVI FE_FECH_PAQU  ,
            A.CD_NIT_EPS, A.NO_NOMB_EPS ,
            B.NU_NUME_CONV, B.CD_CODI_CONV,
            D.NU_HIST_PAC, D.NO_NOMB_PAC,
            D.NO_SGNO_PAC, D.DE_PRAP_PAC,
            D.DE_SGAP_PAC, G.CD_CODI_ARTI,
            G.NO_NOMB_ARTI,K.FE_FECH_MOVI,
            CASE 
                WHEN NVL(K.CD_CODI_ELE_FORM, 'S') = 'S' THEN 'N'
                  ELSE 'S'
            END PRESTADO,
            CASE 
                WHEN NU_OBLI_RPEL = 1 THEN 'S'
                ELSE 'N'
            END OBLIGATORIO,
            1 SERPARAM  
        FROM EPS A
        INNER JOIN CONVENIOS B   
            ON A.CD_NIT_EPS = B.CD_NIT_EPS_CONV
        INNER JOIN MOVI_CARGOS C   
            ON B.NU_NUME_CONV = C.NU_NUME_CONV_MOVI
        INNER JOIN PACIENTES D   
            ON C.NU_HIST_PAC_MOVI = D.NU_HIST_PAC
        INNER JOIN PAQUETES E   
            ON C.NU_NUME_MOVI = E.NU_NUME_MOVI_PAQU
        INNER JOIN R_PAQU_ELE F   
            ON E.CD_CODI_SER_PAQU = F.CD_CODI_SER_PAQ_RPEL
        INNER JOIN ARTICULO G   
            ON F.CD_CODI_ELE_RPEL = G.CD_CODI_ARTI
        INNER JOIN SERVICIOS H   
            ON E.CD_CODI_SER_PAQU = H.CD_CODI_SER
        LEFT JOIN ( SELECT I.NU_HIST_PAC_MOVI ,
                        I.NU_NUME_PAQU_MOVI ,
                        I.FE_FECH_MOVI ,
                        J.CD_CODI_ELE_FORM 
                    FROM MOVI_CARGOS I
                    INNER JOIN FORMULAS J   
                        ON I.NU_NUME_MOVI = J.NU_NUME_MOVI_FORM ) K   
            ON D.NU_HIST_PAC = K.NU_HIST_PAC_MOVI
            AND E.NU_NUME_MOVI_PAQU = K.NU_NUME_PAQU_MOVI
            AND F.CD_CODI_ELE_RPEL = K.CD_CODI_ELE_FORM

    UNION 

        SELECT G.NU_NUME_PAQU, G.CD_CODI_SER_PAQU ,
            H.NO_NOMB_SER NO_NOMB_SER_PAQU  ,
            I.FE_FECH_MOVI FE_FECH_PAQU  ,
            A.CD_NIT_EPS, A.NO_NOMB_EPS ,
            B.NU_NUME_CONV, B.CD_CODI_CONV ,
            F.NU_HIST_PAC, F.NO_NOMB_PAC,
            F.NO_SGNO_PAC, F.DE_PRAP_PAC,
            F.DE_SGAP_PAC, E.CD_CODI_ARTI,
            E.NO_NOMB_ARTI, C.FE_FECH_MOVI,
            'S' PRESTADO, 'N' OBLIGATORIO  ,
            2 SERPARAM  
        FROM EPS A
        INNER JOIN CONVENIOS B   
            ON A.CD_NIT_EPS = B.CD_NIT_EPS_CONV
        INNER JOIN MOVI_CARGOS C   
            ON B.NU_NUME_CONV = C.NU_NUME_CONV_MOVI
        INNER JOIN FORMULAS D   
            ON C.NU_NUME_MOVI = D.NU_NUME_MOVI_FORM
        INNER JOIN ARTICULO E   
            ON D.CD_CODI_ELE_FORM = E.CD_CODI_ARTI
        INNER JOIN PACIENTES F   
            ON C.NU_HIST_PAC_MOVI = F.NU_HIST_PAC
        INNER JOIN PAQUETES G   
            ON C.NU_NUME_PAQU_MOVI = G.NU_NUME_PAQU
        INNER JOIN SERVICIOS H   
            ON G.CD_CODI_SER_PAQU = H.CD_CODI_SER
        INNER JOIN MOVI_CARGOS I   
            ON G.NU_NUME_MOVI_PAQU = I.NU_NUME_MOVI;