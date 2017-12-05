CREATE OR REPLACE PROCEDURE H3i_SP_CONS_PENDIENTES_MED_PAC
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NumHistoria IN VARCHAR2 DEFAULT NULL ,
  v_NumAdmision IN NUMBER DEFAULT NULL ,
  cv_1 OUT SYS_REFCURSOR
)
AS
   --Actualizar el centro de costo cuando esta el blanco
   v_COD_CCO VARCHAR2(11);
   v_NOM_CCO VARCHAR2(100);

BEGIN

   DELETE FROM tt_resultado;
   --DROP TABLE tt_resultado
   -------------
   INSERT INTO tt_resultado_2
     ( NU_HIST_PAC, NU_NUME_HMED, NU_NUME_MOVI, NU_NUME_LABO, NU_TIPD_PAC, NU_DOCU_PAC, DE_PRAP_PAC, DE_SGAP_PAC, NO_NOMB_PAC, NO_SGNO_PAC, FE_NACI_PAC, NU_NUME_HICL, NU_NUME_HEVO_HMED, NU_ORDE_HMED, FECHA_ORDEN, CD_CODI_ARTI, NO_NOMB_ARTI, NU_CANT_HMED, MEDICO_ORDENA, MEDICO_ORDENA_NOMBRE, ESPECIALIDAD_ORDENA, ESPECIALIDAD_ORDENA_NOMBRE, VALOR_UNITARIO, DOSIS, PRESENTACION, FRECUENCIA, UNIDAD_FRECUENCIA, VIA_ADMINISTRACION, DURACION_TRATAMIENTO, OBSERVACIONES, TIPO_ATENCION, CONCENTRACION, CD_CODI_CECO_MOVI, NO_NOMB_CECO, NU_NUME_CONV_MOVI, CD_NIT_EPS_CONV, COD_PRESENTACION, NU_ESTA_HMED )
     SELECT pac.NU_HIST_PAC ,
            hme.NU_NUME_HMED ,
            mca.NU_NUME_MOVI ,
            lab.NU_NUME_LABO ,
            pac.NU_TIPD_PAC ,
            pac.NU_DOCU_PAC ,
            pac.DE_PRAP_PAC ,
            pac.DE_SGAP_PAC ,
            pac.NO_NOMB_PAC ,
            pac.NO_SGNO_PAC ,
            pac.FE_NACI_PAC ,
            hcl.NU_NUME_HICL ,
            hme.NU_NUME_HEVO_HMED ,
            NVL(hme.NU_ORDE_HMED, 0) NU_ORDE_HMED  ,
            hme.FE_FECH_FORM_HMED FECHA_ORDEN  ,
            art.CD_CODI_ARTI ,
            art.NO_NOMB_ARTI ,
            NVL(hme.NU_CANT_HMED, 0) NU_CANT_HMED  ,
            med.CD_CODI_MED MEDICO_ORDENA  ,
            NVL(med.NO_NOMB_MED, ' ') MEDICO_ORDENA_NOMBRE  ,
            esp.CD_CODI_ESP ESPECIALIDAD_ORDENA  ,
            NVL(esp.NO_NOMB_ESP, ' ') ESPECIALIDAD_ORDENA_NOMBRE  ,
            MAX(rta.VL_PREC_TAAR)  VALOR_UNITARIO  ,
            UTILS.CONVERT_TO_NVARCHAR2(NVL(hme.DE_DOSIS_HMED, ' '),2500) DOSIS  ,
            NVL(SUBSTR(DE_UNME_HMED, 0, INSTR(DE_UNME_HMED, '|')), ' ') PRESENTACION  ,
            NVL(hme.DE_FREC_ADMIN_HMED, ' ') FRECUENCIA  ,
            NVL(hme.NU_UNFRE_HMED, 0) UNIDAD_FRECUENCIA  ,
            NVL(hme.DE_VIA_ADMIN_HMED, ' ') VIA_ADMINISTRACION  ,
            NVL(hme.NU_NUME_DUR_TRAT_HMED, 0) DURACION_TRATAMIENTO  ,
            NVL(hme.TX_OBSERV_HED, ' ') OBSERVACIONES  ,
            NVL(REG.NU_TIAT_REG, 1) TIPO_ATENCION ,--WHEN 2 THEN 'HOSPITALIZACION' WHEN 3 THEN 'URGENCIAS' ELSE 'AMBULATORIO' END 

            NVL(art.DE_CTRA_ARTI, ' ') CONCENTRACION  ,
            NVL(mca.CD_CODI_CECO_MOVI, ' ') CD_CODI_CECO_MOVI  ,
            NVL(cco.NO_NOMB_CECO, ' ') NO_NOMB_CECO  ,
            mca.NU_NUME_CONV_MOVI ,
            con.CD_NIT_EPS_CONV ,
            CASE 
                 WHEN hme.DE_UNME_HMED IS NULL THEN 0
            ELSE UTILS.CONVERT_TO_NUMBER(REPLACE((SUBSTR(hme.DE_UNME_HMED, 1, INSTR(hme.DE_UNME_HMED, '|'))), '|', ' '),10,0)
               END col  ,
            hme.NU_ESTA_HMED 
       FROM HIST_MEDI hme
              JOIN HISTORIACLINICA hcl   ON hme.NU_NUME_HICL_HMED = hcl.NU_NUME_HICL
              JOIN ARTICULO art   ON hme.CD_CODI_ARTI_HMED = art.CD_CODI_ARTI
              JOIN MEDICOS med   ON med.CD_CODI_MED = (CASE NU_NUME_HEVO_HMED
                                                                             WHEN 0 THEN CD_MED_REAL_HICL
            ELSE ( SELECT CD_CODI_MED_HEVO 
                   FROM HIST_EVOLUCION 
                    WHERE  NU_NUME_HEVO_HMED = NU_NUME_HEVO )
               END)
              JOIN LABORATORIO lab   ON hcl.NU_NUME_LABO_HICL = lab.NU_NUME_LABO
              JOIN MOVI_CARGOS mca   ON lab.NU_NUME_MOVI_LABO = mca.NU_NUME_MOVI
              JOIN PACIENTES pac   ON mca.NU_HIST_PAC_MOVI = pac.NU_HIST_PAC
              JOIN ESPECIALIDADES esp   ON lab.CD_CODI_ESP_LABO = esp.CD_CODI_ESP
              LEFT JOIN HIMS2.R_TARI_ARTI rta   ON RTA.CD_ARTI_TAAR = ART.CD_CODI_ARTI
              LEFT JOIN HIMS2.CENTRO_COSTO cco   ON cco.CD_CODI_CECO = mca.CD_CODI_CECO_MOVI
              LEFT JOIN REGISTRO REG   ON PAC.NU_HIST_PAC = REG.NU_HIST_PAC_REG
              AND REG.ID_ESTA_ASIS_REG <> '1'
              JOIN HIMS2.CONVENIOS con   ON mca.NU_NUME_CONV_MOVI = con.NU_NUME_CONV
      WHERE  pac.NU_HIST_PAC LIKE (CASE 
                                        WHEN ( v_NumHistoria IS NULL ) THEN '%%'
             ELSE v_NumHistoria
                END)
               AND ( hme.NU_NUME_FORM_HMED IS NULL
               OR hme.NU_NUME_FORM_HMED = 0 )
               AND ( v_NumAdmision IS NULL
               OR mca.NU_NUME_REG_MOVI = v_NumAdmision )
               AND mca.NU_ESTA_MOVI <> 2 -- SE EXCLUYEN LOS ANULADOS

       GROUP BY pac.NU_HIST_PAC,hme.NU_NUME_HMED,hme.NU_ESTA_HMED,mca.NU_NUME_MOVI,lab.NU_NUME_LABO,pac.NU_TIPD_PAC,pac.NU_DOCU_PAC,pac.DE_PRAP_PAC,pac.DE_SGAP_PAC,pac.NO_NOMB_PAC,pac.NO_SGNO_PAC,pac.FE_NACI_PAC,hcl.NU_NUME_HICL,hme.NU_NUME_HEVO_HMED,NVL(hme.NU_ORDE_HMED, 0),hme.FE_FECH_FORM_HMED,art.CD_CODI_ARTI,art.NO_NOMB_ARTI,NVL(hme.NU_CANT_HMED, 0),med.CD_CODI_MED,NVL(med.NO_NOMB_MED, ' '),esp.CD_CODI_ESP,NVL(esp.NO_NOMB_ESP, ' '
                                                                                                                                                                                                                                                                                                                                                                                                                                   --[rta].[VL_PREC_TAAR],
                ),UTILS.CONVERT_TO_NVARCHAR2(NVL(hme.DE_DOSIS_HMED, ' '),2500),NVL(SUBSTR(DE_UNME_HMED, 0, INSTR(DE_UNME_HMED, '|')), ' '),NVL(hme.DE_FREC_ADMIN_HMED, ' '),NVL(hme.NU_UNFRE_HMED, 0),NVL(hme.DE_VIA_ADMIN_HMED, ' '),NVL(hme.NU_NUME_DUR_TRAT_HMED, 0),NVL(hme.TX_OBSERV_HED, ' '),NVL(REG.NU_TIAT_REG, 1),NVL(art.DE_CTRA_ARTI, ' '),NVL(mca.CD_CODI_CECO_MOVI, ' '),NVL(cco.NO_NOMB_CECO, ' '),mca.NU_NUME_CONV_MOVI,con.CD_NIT_EPS_CONV,CASE 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                 WHEN hme.DE_UNME_HMED IS NULL THEN 0
                ELSE UTILS.CONVERT_TO_NUMBER(REPLACE((SUBSTR(hme.DE_UNME_HMED, 1, INSTR(hme.DE_UNME_HMED, '|'))), '|', ' '),10,0)
                   END
       ORDER BY hme.FE_FECH_FORM_HMED;
   -------------
   --actualizar la cantidad despachada anteriormente, a los medicamentos que ya hayan sido solicitados y despachados
   MERGE INTO tt_resultado t
   USING (SELECT t.ROWID row_id, x.cantidad, CASE 
   WHEN x.cantidad = t.NU_CANT_HMED THEN 1
   ELSE 0
      END AS pos_3
   FROM tt_resultado t
          JOIN ( SELECT SUM(FOM.CT_CANT_FORM)  cantidad  ,
                        T.ID ID  ,
                        SME.CD_CODI_ARTI_SMED 
                 FROM tt_resultado T
                        JOIN HIMS2.SOLICITUD_MED SME   ON T.NU_NUME_HICL = SME.NU_NUME_HICL_SMED
                        AND T.CD_CODI_ARTI = SME.CD_CODI_ARTI_SMED
                        JOIN HIMS2.MOVI_CARGOS MCA   ON SME.NU_NUME_MOVI_SMED = MCA.NU_NUME_MOVI
                        JOIN HIMS2.FORMULAS FOM   ON FOM.NU_NUME_MOVI_FORM = MCA.NU_NUME_MOVI
                        AND SME.CD_CODI_ARTI_SMED = FOM.CD_CODI_ELE_FORM
                   GROUP BY T.ID,SME.CD_CODI_ARTI_SMED ) x   ON x.ID = t.ID ) src
   ON ( t.ROWID = src.row_id )
   WHEN MATCHED THEN UPDATE SET t.CANTIDAD_DESPACHADA = src.cantidad,
                                t.BORRAR = pos_3;
   -----
   --eliminar los registros donde ya el medicamento solicitado por el medico se haya despachado y generado cargo anteriormente
   DELETE tt_resultado

    WHERE  BORRAR = 1;
   --
   --Actualizar la presentacion de los medicamentos
   MERGE INTO tt_resultado RES
   USING (SELECT RES.ROWID row_id, PRE.TX_NOMB_PRES
   FROM tt_resultado RES
          JOIN HIMS2.PRESENTACION PRE   ON RES.COD_PRESENTACION = PRE.NU_AUTO_PRES 
    WHERE RES.COD_PRESENTACION <> 0) src
   ON ( RES.ROWID = src.row_id )
   WHEN MATCHED THEN UPDATE SET RES.PRESENTACION = src.TX_NOMB_PRES;
   ----
   SELECT CD_CODI_CECO ,
          NO_NOMB_CECO 

     INTO v_COD_CCO,
          v_NOM_CCO
     FROM HIMS2.CENTRO_COSTO 
    WHERE  NO_NOMB_CECO LIKE '%HOSPITALIZACION%' AND ROWNUM <= 1;
   UPDATE tt_resultado
      SET CD_CODI_CECO_MOVI = v_COD_CCO,
          NO_NOMB_CECO = v_NOM_CCO
    WHERE  TIPO_ATENCION = 2 --hopitalizacion

     AND ( CD_CODI_ARTI = ' '
     OR NO_NOMB_CECO = ' ' );
   ------
   SELECT CD_CODI_CECO ,
          NO_NOMB_CECO 

     INTO v_COD_CCO,
          v_NOM_CCO
     FROM HIMS2.CENTRO_COSTO 
    WHERE  NO_NOMB_CECO LIKE '%URGENCIAS%' AND ROWNUM <= 1;
   UPDATE tt_resultado
      SET CD_CODI_CECO_MOVI = v_COD_CCO,
          NO_NOMB_CECO = v_NOM_CCO
    WHERE  TIPO_ATENCION = 3 --urgencias

     AND ( CD_CODI_ARTI = ' '
     OR NO_NOMB_CECO = ' ' );
   ------
   SELECT CD_CODI_CECO ,
          NO_NOMB_CECO 

     INTO v_COD_CCO,
          v_NOM_CCO
     FROM HIMS2.CENTRO_COSTO 
    WHERE  NO_NOMB_CECO LIKE '%CONSULTA EXTERNA%' AND ROWNUM <= 1;
   UPDATE tt_resultado
      SET CD_CODI_CECO_MOVI = v_COD_CCO,
          NO_NOMB_CECO = v_NOM_CCO
    WHERE  TIPO_ATENCION = 1 --consulta externa

     AND ( CD_CODI_ARTI = ' '
     OR NO_NOMB_CECO = ' ' );
   -------
   OPEN  cv_1 FOR
      SELECT * 
        FROM tt_resultado  ;

EXCEPTION WHEN OTHERS THEN utils.handleerror(SQLCODE,SQLERRM);
END;