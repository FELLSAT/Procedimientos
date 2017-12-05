CREATE OR REPLACE VIEW VVALOPAQU
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
AS 
        SELECT A.NU_NUME_MOVI, A.NU_NUME_FACO_MOVI ,
            NO_NOMB_LUAT,
            -------------------------------------
            CASE NU_TIPD_PAC
                WHEN 0 THEN 'CC'
                WHEN 1 THEN 'TI'
                WHEN 2 THEN 'RC'
                WHEN 3 THEN 'CE'
                WHEN 4 THEN 'PA'
                WHEN 5 THEN 'AS'
                WHEN 6 THEN 'MS'
                WHEN 7 THEN 'NU'   
            END Tipo_Documento,
            -------------------------------------
            NU_DOCU_PAC, DE_PRAP_PAC ,
            DE_SGAP_PAC, NO_NOMB_PAC,
            NO_SGNO_PAC,
            -------------------------------------
            CASE 
                WHEN ((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD')) < 30) 
                    THEN TRUNC((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD')))
                WHEN ((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD')) >= 30) AND 
                  ((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD')) < 365) 
                    THEN TRUNC(((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD'))/ 30.4166))
                ELSE TRUNC((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD')) / 365.259)
            END EDAD ,
            -------------------------------------
            CASE 
                WHEN ((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD')) < 30) 
                    THEN 'Días'
                WHEN ((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD')) >= 30) AND 
                  ((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD')) < 365) 
                    THEN 'Meses'
                ELSE 'Años'
            END UNIDAD_MEDIDA_EDAD ,
            -------------------------------------
            CD_CODI_SER_PAQU ,
            NO_NOMB_SER ,
            VL_VALO_PAQU ,
            VL_COPA_PAQU ,
            SUM(CT_CANT_LABO * VL_UNID_LABO)  Suma_Detallado  ,
            SUM(VL_COPA_LABO)  Copago_Detallado  
        FROM MOVI_CARGOS A
        INNER JOIN PAQUETES    
            ON NU_NUME_MOVI = NU_NUME_MOVI_PAQU
        INNER JOIN SERVICIOS    
            ON CD_CODI_SER_PAQU = CD_CODI_SER
        INNER JOIN PACIENTES    
            ON NU_HIST_PAC_MOVI = NU_HIST_PAC
        INNER JOIN MOVI_CARGOS B   
            ON A.NU_NUME_MOVI = B.NU_NUME_PAQU_MOVI
        INNER JOIN LUGAR_ATENCION    
            ON A.CD_CODI_LUAT_MOVI = CD_CODI_LUAT
        INNER JOIN LABORATORIO    
            ON B.NU_NUME_MOVI = NU_NUME_MOVI_LABO
        WHERE  A.NU_NUME_FAC_MOVI = 216 -- Numero de factura a comparar
            AND A.NU_ESTA_MOVI <> 2
            AND B.NU_ESTA_MOVI <> 2

        --AND  B.NU_NUME_FAC_MOVI=216
        GROUP BY A.NU_NUME_MOVI,A.NU_NUME_FACO_MOVI,
            (CASE NU_TIPD_PAC
                WHEN 0 THEN 'CC'
                WHEN 1 THEN 'TI'
                WHEN 2 THEN 'RC'
                WHEN 3 THEN 'CE'
                WHEN 4 THEN 'PA'
                WHEN 5 THEN 'AS'
                WHEN 6 THEN 'MS'
                WHEN 7 THEN 'NU'   
            END),
            DE_PRAP_PAC, DE_SGAP_PAC,
            NO_NOMB_PAC, NO_NOMB_PAC,
            NO_SGNO_PAC,
            (CASE 
                WHEN ((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD')) < 30)
                    THEN TRUNC(TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD'))
                WHEN ((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD')) >= 30) AND 
                  ((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD')) < 365)
                    THEN TRUNC((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD'))/30.4166)
                ELSE TRUNC((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD'))/365.259)
            END),
            (CASE 
                WHEN ((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD')) < 30)
                    THEN 'Días'
                WHEN ((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD')) >= 30) AND 
                  ((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD')) < 365)
                    THEN 'Meses'
                ELSE 'Años'
        END),CD_CODI_SER_PAQU,NO_NOMB_SER,VL_VALO_PAQU,VL_COPA_PAQU,NO_NOMB_LUAT,NU_DOCU_PAC

   UNION ALL 

       --VALOR TOTAL PAQUETE
        SELECT A.NU_NUME_MOVI, A.NU_NUME_FACO_MOVI ,
            NO_NOMB_LUAT,    
            (CASE NU_TIPD_PAC
                WHEN 0 THEN 'CC'
                WHEN 1 THEN 'TI'
                WHEN 2 THEN 'RC'
                WHEN 3 THEN 'CE'
                WHEN 4 THEN 'PA'
                WHEN 5 THEN 'AS'
                WHEN 6 THEN 'MS'
                WHEN 7 THEN 'NU'   
            END) Tipo_Documento  ,
            NU_DOCU_PAC,  DE_PRAP_PAC ,
            DE_SGAP_PAC, NO_NOMB_PAC ,
            NO_SGNO_PAC,
            (CASE 
                WHEN ((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD')) < 30)
                    THEN TRUNC(TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD'))
                WHEN ((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD')) >= 30)
                  AND ((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD')) < 365)
                    THEN TRUNC((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD'))/30.4166)
                ELSE TRUNC((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD'))/365.259)
            END) EDAD,
            (CASE 
                WHEN ((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD')) < 30)
                    THEN 'Días'
                WHEN ((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD')) >= 30)
                  AND ((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD')) < 365)
                    THEN 'Meses'
                ELSE 'Años'
            END) UNIDAD_MEDIDA_EDAD  ,
            CD_CODI_SER_PAQU, NO_NOMB_SER,
            VL_VALO_PAQU, VL_COPA_PAQU,
            SUM(CT_CANT_FORM * VL_UNID_FORM)  Suma_Detallado  ,
            SUM(VL_COPA_FORM)  Copago_Detallado  
        FROM MOVI_CARGOS A
        INNER JOIN PAQUETES    
            ON NU_NUME_MOVI = NU_NUME_MOVI_PAQU
        INNER JOIN SERVICIOS    
            ON CD_CODI_SER_PAQU = CD_CODI_SER
        INNER JOIN PACIENTES    
            ON NU_HIST_PAC_MOVI = NU_HIST_PAC
        INNER JOIN MOVI_CARGOS B   
            ON A.NU_NUME_MOVI = B.NU_NUME_PAQU_MOVI
        INNER JOIN LUGAR_ATENCION    
            ON A.CD_CODI_LUAT_MOVI = CD_CODI_LUAT
        INNER JOIN FORMULAS    
            ON B.NU_NUME_MOVI = NU_NUME_MOVI_FORM
        WHERE  A.NU_NUME_FAC_MOVI = 216 -- Numero de factura a comparar
            AND A.NU_ESTA_MOVI <> 2
            AND B.NU_ESTA_MOVI <> 2
        GROUP BY A.NU_NUME_MOVI,A.NU_NUME_FACO_MOVI,
            (CASE NU_TIPD_PAC
                WHEN 0 THEN 'CC'
                WHEN 1 THEN 'TI'
                WHEN 2 THEN 'RC'
                WHEN 3 THEN 'CE'
                WHEN 4 THEN 'PA'
                WHEN 5 THEN 'AS'
                WHEN 6 THEN 'MS'
                WHEN 7 THEN 'NU'   
            END),
            DE_PRAP_PAC, DE_SGAP_PAC,
            NO_NOMB_PAC,NO_NOMB_PAC,
            NO_SGNO_PAC,
            (CASE 
                WHEN ((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD')) < 30)
                    THEN TRUNC(TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD'))
                WHEN ((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD')) >= 30)
                  AND ((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD')) < 365)
                    THEN TRUNC((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD'))/30.4166)
                ELSE TRUNC((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD'))/365.259)
            END),
            (CASE 
                WHEN ((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD')) < 30)
                    THEN 'Días'
                WHEN ((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD')) >= 30)
                  AND ((TO_CHAR(A.FE_FECH_MOVI,'DD') - TO_CHAR(FE_NACI_PAC,'DD')) < 365)
                    THEN 'Meses'
                ELSE 'Años'
            END),
            CD_CODI_SER_PAQU, NO_NOMB_SER,VL_VALO_PAQU,
            VL_COPA_PAQU, NO_NOMB_LUAT, NU_DOCU_PAC;