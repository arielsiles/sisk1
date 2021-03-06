--
alter table REGISTROPAGOMATERIAPRIMA add TOTALPAGOACOPIO NUMBER(16,2) default 0.0;
alter table REGISTROPAGOMATERIAPRIMA add LIQUIDOPAGABLE NUMBER(16,2) default 0.0;
--
alter table PLANILLAPAGOMATERIAPRIMA add TOTALACOPIADOXGAB NUMBER(16,2) default 0.0;
alter table PLANILLAPAGOMATERIAPRIMA add TOTALMONTOACOPIOADOXGAB NUMBER(16,2) default 0.0;
alter table PLANILLAPAGOMATERIAPRIMA add TOTALRETENCIONESXGAB NUMBER(16,2) default 0.0;
alter table PLANILLAPAGOMATERIAPRIMA add TOTALCREDITOXGAB NUMBER(16,2) default 0.0;
alter table PLANILLAPAGOMATERIAPRIMA add TOTALVETERINARIOXGAB NUMBER(16,2) default 0.0;
alter table PLANILLAPAGOMATERIAPRIMA add TOTALYOGURDXGAB NUMBER(16,2) default 0.0;
alter table PLANILLAPAGOMATERIAPRIMA add TOTALTACHOSXGAB NUMBER(16,2) default 0.0;
alter table PLANILLAPAGOMATERIAPRIMA add TOTALOTROSDECUENTOSXGAB NUMBER(16,2) default 0.0;
alter table PLANILLAPAGOMATERIAPRIMA add TOTALAJUSTEXGAB NUMBER(16,2) default 0.0;
alter table PLANILLAPAGOMATERIAPRIMA add TOTALOTROSINGRESOSXGAB NUMBER(16,2) default 0.0;
alter table PLANILLAPAGOMATERIAPRIMA add TOTALIQUIDOXGAB NUMBER(16,2) default 0.0;
alter table PLANILLAPAGOMATERIAPRIMA add TOTADESCUENTOSXGAB NUMBER(16,2) default 0.0;
alter table PLANILLAPAGOMATERIAPRIMA add TOTALALCOHOLXGAB NUMBER(16,2) default 0.0;
alter table PLANILLAPAGOMATERIAPRIMA add TOTALCONCENTRADOSXGAB NUMBER(16,2) default 0.0;
--
alter table DESCUENTPRODUCTMATERIAPRIMA add ALCOHOL NUMBER(16,2) default 0.0;
alter table DESCUENTPRODUCTMATERIAPRIMA add CONCENTRADOS NUMBER(16,2) default 0.0;
ALTER TABLE DESCUENTPRODUCTMATERIAPRIMA MODIFY (
                                                YOGURT NUMBER(16,2) default 0.0,
                                                VETERINARIO NUMBER(16,2) default 0.0,
                                                CREDITO NUMBER(16,2) default 0.0,
                                                TACHOS NUMBER(16,2) default 0.0,
                                                RETENCION NUMBER(16,2) default 0.0,
                                                OTROSINGRESOS NUMBER(16,2) default 0.0,
                                                OTROSDESCUENTOS NUMBER(16,2) default 0.0,
                                                ALCOHOL NUMBER(16,2) default 0.0,
                                                CONCENTRADOS NUMBER(16,2) default 0.0
                                                );
ALTER TABLE NOTARECHAZOMATERIAPRIMA MODIFY (CANTIDADRECHAZADA NUMBER(16,2) default 0.0);
ALTER TABLE ACOPIOMATERIAPRIMA MODIFY (CANTIDAD NUMBER(16,2) default 0.0);
ALTER TABLE REGISTROPAGOMATERIAPRIMA MODIFY (
                                             TOTALGANADO NUMBER(16,2) default 0.0,
                                             CANTIDADTOTAL NUMBER(16,2) default 0.0,
                                             AJUSTEZONAPRODUCTIVA NUMBER(16,2) default 0.0,
                                             TOTALPAGOACOPIO NUMBER(16,2) default 0.0
                                             );
/*Pago productores -> reportes -> Resumen de Pago*/
INSERT  INTO FUNCIONALIDAD (IDFUNCIONALIDAD,CODIGO,DESCRIPCION,PERMISO,NOMBRERECURSO,IDMODULO)
  VALUES (350, 'REPORTPAYROLL', NULL, 15, 'menu.production.supplierPayments.reports.payRoll', 6);
INSERT  INTO DERECHOACCESO (IDFUNCIONALIDAD,IDROL,PERMISO,IDCOMPANIA,IDMODULO)
  VALUES (350, 50, 15, 1, 6);
--COMMIT
alter table RHMARCADO add DESCRIPCION CLOB NULL;
--alter table RHMARCADO drop column DESCRIPCION;
--COMMIT
/* PROD-22 Ariel: Add column for state control. */
ALTER TABLE EOS.PLANILLAACOPIO ADD ESTADO VARCHAR2(3) NULL;
UPDATE EOS.PLANILLAACOPIO SET ESTADO = 'PEN' WHERE ESTADO IS NULL;
COMMIT;

/* PROD-22 Ariel: Add column CTATRANSALM1MN "MATERIA PRIMA PARA PRODUCCION". */
DELETE FROM WISE.CONFIGURACION;
ALTER TABLE WISE.CONFIGURACION ADD CTATRANSALM1MN VARCHAR2(20) NOT NULL; /* "insufficient privileges" to EOS schema */
INSERT INTO WISE.CONFIGURACION (NO_CIA,CTADIFTIPCAM,VERSION,CTAANTPROVME,CTAANTPROVMN,CTAALMME,CTAALMMN,CTAAITB,CTAPROVOBU,NO_USR_TESO,NO_USR_CONTA,NO_USR_SIS,PAGOCTABCOMN,PAGOCTABCOME,IDCARGODOC,CTAIVACREFIMN,CTAIVACREFIME,CTAAFET,IDDEFTIPODOC,IDDEFSALMUJ,IDDEFSALHOM,URLREDIREVALPROG,URLREDIREVALPROGEST,URLREDIREVALPROGDOC,URLREDIREVALPROGAE,URLREDIREVALPROGJC,OCCODIFACTIVA,ACTIVOAUTDOC_TESO,ACTIVOAUTDOC_CXP,IDCOMPANIA,RETENCIONPRESTAMOANTI,AUTOMODIFCONTRATO,HABILITAR_VENTA_ART,CTAIVACREFITRMN,CTATRANSALMME,CTATRANSALMMN,CODMODIFCONTRATO,AGUI_BASICO,TIPO_DOC_CAJA,HRSDIALABORAL,NO_USR_RPAGOS,ANIO_GEN_RPAGOS,IDCATEGORIAPUESTODLH,IDCATEGORIAPUESTODTH,IDTIPOSUELDODLH,IDTIPOSUELDODTH,COD_CC,NO_USR_PAGAR,CTADEPTRAMN,CTADEPTRAME,NO_USR_CONTARRHH, CTATRANSALM1MN) values ('01','40201001002001','6','10103003006001','10103003006001','10601003001004','10601003001004','5','4','ADM','ACC','ADM','1234','1234','1','10202001002001','10202001002001','1','101','31','30','HTTP://PORTAL.UDABOL.EDU.BO','HTTP://PORTAL.UDABOL.EDU.BO:7777/PLS/PORTAL/URL/PAGE/ISKAY_ESTUDIANTE/WSISS_EST_INICIO/WSISS_EVALUACION_EST','HTTP://PORTAL.UDABOL.EDU.BO:7777/PLS/PORTAL/URL/PAGE/ISKAY_AUTORIDAD/WSISS_AUTORIDADES_INICIO/WSISS_EVALUACION_DOC','HTTP://PORTAL.UDABOL.EDU.BO:7777/PLS/PORTAL/URL/PAGE/ISKAY_AUTORIDAD/WSISS_AUTORIDADES_INICIO/WSISS_EVALUACION_DOC','HTTP://PORTAL.UDABOL.EDU.BO:7777/PLS/PORTAL/URL/PAGE/ISKAY_AUTORIDAD/WSISS_AUTORIDADES_INICIO/WSISS_EVALUACION_DOC','1','SI','SI','1','0','0','SI','1','10201001001004','10601003001006','1','0','PE','8','ACC','2013','1','1','1','1','0101','ADM','2','2','ADM', '10601003001007');
COMMIT;

/* PROD-22 Ariel: Inserting for payroll approval collection */
insert into FUNCIONALIDAD (IDFUNCIONALIDAD,CODIGO,PERMISO,NOMBRERECURSO,IDMODULO) values ((select max(idfuncionalidad+1) from funcionalidad),'COLLECTIONFORMAPPROVAL','1','menu.production.collectionForm.approval','6');
COMMIT;

/* Ariel */
-- Paso 1.
-- GUARDAR EL ID DEL INSUMO "LECHE CRUDA"  - dev ID=190, prod ID=30

DELETE FROM INSUMOPRODUCCION;
DELETE FROM PRODUCTOPROCESADO;
DELETE FROM METAPRODUCTOPRODUCCION;
COMMIT;
-- Agregando columnas COD_ART, NO_CIA para relacionamiento con Articulos (INV_ARTICULOS)
ALTER TABLE EOS.METAPRODUCTOPRODUCCION ADD COD_ART VARCHAR2(6) NOT NULL;
ALTER TABLE EOS.METAPRODUCTOPRODUCCION ADD NO_CIA VARCHAR2(2) NOT NULL;

-- Asignando referencias de integridad: PRODUCTOPROCESADO, INSUMOPRODUCCION, METAPRODUCTOPRODUCCION
ALTER TABLE PRODUCTOPROCESADO ADD CONSTRAINT FK_PRODUCTOP_METAPRODUCTOP
FOREIGN KEY (IDPRODUCTOPROCESADO) REFERENCES METAPRODUCTOPRODUCCION (IDMETAPRODUCTOPRODUCCION);

ALTER TABLE INSUMOPRODUCCION ADD CONSTRAINT FK_INSUMOP_METAPRODUCTOP
FOREIGN KEY (IDINSUMOPRODUCCION) REFERENCES METAPRODUCTOPRODUCCION (IDMETAPRODUCTOPRODUCCION);

-- drop sequence seq_idmetaproducto;
create sequence seq_idmetaproducto
start with 1
increment by 1;

-- UPDATE EOS.METAPRODUCTOPRODUCCION M SET M.COD_ART = M.CODIGO;
-- UPDATE EOS.METAPRODUCTOPRODUCCION M SET M.NO_CIA = '01';
-- ALTER TABLE EOS.METAPRODUCTOPRODUCCION MODIFY COD_ART NOT NULL;
-- ALTER TABLE EOS.METAPRODUCTOPRODUCCION MODIFY NO_CIA NOT NULL;

-- Paso 2. Insertando INSUMOS de ARTICULOS
insert into metaproductoproduccion
(idmetaproductoproduccion, idunidadmedidaproduccion, codigo, nombre, descripcion, esacopiable, idcompania, version, cod_art, no_cia)
SELECT seq_idmetaproducto.NextVal, null, a.cod_art, a.descri, a.descri, '0', '1', '0', a.cod_art, '01'
FROM WISE.inv_articulos a, WISE.inv_grupos g
where a.cod_gru = g.cod_gru
and g.cuenta_inv = '10303001001001'
;

-- Paso 3.

insert into insumoproduccion (idinsumoproduccion, idcompania)
select idmetaproductoproduccion, 1
from metaproductoproduccion


-- ASIGNAR EL MISMO ID DEL INSUMO "LECHE CRUDA"  A:
-- SESIONACOPIO, PLANILLAACOPIO, PLANILLAPAGOMATERIAPRIMA,

UPDATE SESIONACOPIO SET IDMETAPRODUCTOPRODUCCION = (
SELECT IDMETAPRODUCTOPRODUCCION
FROM METAPRODUCTOPRODUCCION
WHERE NOMBRE = 'LECHE CRUDA');

UPDATE PLANILLAACOPIO SET IDMETAPRODUCTOPRODUCCION = (
SELECT IDMETAPRODUCTOPRODUCCION
FROM METAPRODUCTOPRODUCCION
WHERE NOMBRE = 'LECHE CRUDA');

UPDATE PLANILLAPAGOMATERIAPRIMA SET IDMETAPRODUCTOPRODUCCION = (
SELECT IDMETAPRODUCTOPRODUCCION
FROM METAPRODUCTOPRODUCCION
WHERE NOMBRE = 'LECHE CRUDA');

UPDATE METAPRODUCTOPRODUCCION M SET M.ESACOPIABLE = 1
WHERE NOMBRE = 'LECHE CRUDA';