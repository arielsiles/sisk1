--Khipus MRP PROD-84: Imlementar el registro de porcentaje graso
--Diego H. Loza Fernandez
--Fecha de creacion: 27/01/2014
ALTER TABLE PLANILLAACOPIO ADD PORCENTAJEGRASA NUMBER(16,2) default 0.0 NULL;
ALTER TABLE ORDENPRODUCCION ADD PORCENTAJEGRASA NUMBER(16,2) default 0.0 NULL;
--commit
--OPCION resumen kardex
INSERT  INTO FUNCIONALIDAD (IDFUNCIONALIDAD,CODIGO,DESCRIPCION,PERMISO,NOMBRERECURSO,IDMODULO)
  VALUES (363, 'KARDEXSUMMARYREPORT', NULL, 15, 'Reports.kardex.summary.menu.title', 1); 
INSERT  INTO DERECHOACCESO (IDFUNCIONALIDAD,IDROL,PERMISO,IDCOMPANIA,IDMODULO)
  VALUES (363, 50, 15, 1, 9);     
--select * from funcionalidad;  
--select * from modulo
INSERT  INTO FUNCIONALIDAD (IDFUNCIONALIDAD,CODIGO,DESCRIPCION,PERMISO,NOMBRERECURSO,IDMODULO)
  VALUES (364, 'SAVEGRAASEPERCENTAGE', NULL, 15, 'ProductionOrder.percentajeGrease', 6); 
INSERT  INTO DERECHOACCESO (IDFUNCIONALIDAD,IDROL,PERMISO,IDCOMPANIA,IDMODULO)
  VALUES (364, 50, 15, 1, 6);     