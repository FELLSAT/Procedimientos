CREATE OR REPLACE FUNCTION fnSplit
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	V_sInputList IN VARCHAR2,
 	V_sDelimiter IN VARCHAR2 DEFAULT ','
)
RETURN TYPE_TAB_SPLIT
AS 
	V_TABLA  TYPE_TAB_SPLIT := TYPE_TAB_SPLIT();
	--
	V_sItem VARCHAR2(4000);
	VV_sInputList VARCHAR2(4000) := V_sInputList;
BEGIN
	--
	WHILE (INSTR(VV_sInputList,V_sDelimiter) <> 0)
	LOOP
		BEGIN
			V_sItem := TRIM(SUBSTR(VV_sInputList,1,(INSTR(VV_sInputList,V_sDelimiter)-1)));
			VV_sInputList := TRIM(SUBSTR(VV_sInputList,INSTR(VV_sInputList,V_sDelimiter) + LENGTH(V_sDelimiter),LENGTH(VV_sInputList)));
			--
			IF(LENGTH(V_sItem) > 0) THEN
				BEGIN
					V_TABLA.EXTEND;
					V_TABLA(V_TABLA.LAST) := TYPE_FN_SPLIT(V_sItem);
				END;
			END IF;
		END;
	END LOOP;
	--
	IF(LENGTH(VV_sInputList) > 0) THEN
		BEGIN
			V_TABLA.EXTEND;
			V_TABLA(V_TABLA.LAST) := TYPE_FN_SPLIT(VV_sInputList);			
		END;
	END IF;

	RETURN V_TABLA;

END;


--CREACION DEL TYPO COMO OBJECTO QUE SERA LA TABLA
CREATE TYPE TYPE_FN_SPLIT AS OBJECT (
    ITEM VARCHAR2(8000)
);

--CREACION DEL TYPE COMO UNA TBLA DE ESE TIPOP
CREATE TYPE TYPE_TAB_SPLIT IS TABLE OF TYPE_FN_SPLIT;
