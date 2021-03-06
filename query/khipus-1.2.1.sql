-- INICIO
-- INSERTANDO GRUPOS
INSERT INTO WISE.INV_GRUPOS (NO_CIA, COD_GRU, DESCRI, CUENTA_INV, VERSION) VALUES('01', '7', 'UHT', '10103004001001', 0)
INSERT INTO WISE.INV_GRUPOS (NO_CIA, COD_GRU, DESCRI, CUENTA_INV, VERSION) VALUES('01', '8', 'YOGURT', '10103004001001', 0)
INSERT INTO WISE.INV_GRUPOS (NO_CIA, COD_GRU, DESCRI, CUENTA_INV, VERSION) VALUES('01', '9', 'QUESO', '10103004001001', 0)
--
-- INSERTANDO CONFIGURACION DE GRUPOS
-- DELETE EOS.CONFIGRUPO WHERE IDCONFIGRUPO = 1
INSERT INTO EOS.CONFIGRUPO (IDCONFIGRUPO, TIPO, NO_CIA, COD_GRU, VERSION, IDCOMPANIA) VALUES (1, 'AREA_PRODUCTOS', '01', '7', 0, 1)
INSERT INTO EOS.CONFIGRUPO (IDCONFIGRUPO, TIPO, NO_CIA, COD_GRU, VERSION, IDCOMPANIA) VALUES (2, 'AREA_PRODUCTOS', '01', '8', 0, 1)
INSERT INTO EOS.CONFIGRUPO (IDCONFIGRUPO, TIPO, NO_CIA, COD_GRU, VERSION, IDCOMPANIA) VALUES (3, 'AREA_PRODUCTOS', '01', '9', 0, 1)

--
-- -- INSERTANDO SUBGRUPOS
INSERT INTO WISE.INV_SUBGRUPOS (NO_CIA, COD_GRU, COD_SUB, DESCRI, ESTADO, VERSION) VALUES ('01', '7', '1', 'LECHE NATURAL', 'VIG', 0)
INSERT INTO WISE.INV_SUBGRUPOS (NO_CIA, COD_GRU, COD_SUB, DESCRI, ESTADO, VERSION) VALUES ('01', '7', '2', 'LECHE SABORIZADA', 'VIG', 0)

INSERT INTO WISE.INV_SUBGRUPOS (NO_CIA, COD_GRU, COD_SUB, DESCRI, ESTADO, VERSION) VALUES ('01', '8', '1', 'BIOYOGURT', 'VIG', 0)
INSERT INTO WISE.INV_SUBGRUPOS (NO_CIA, COD_GRU, COD_SUB, DESCRI, ESTADO, VERSION) VALUES ('01', '8', '2', 'FRUTADO', 'VIG', 0)
INSERT INTO WISE.INV_SUBGRUPOS (NO_CIA, COD_GRU, COD_SUB, DESCRI, ESTADO, VERSION) VALUES ('01', '8', '3', 'SACHET', 'VIG', 0)
INSERT INTO WISE.INV_SUBGRUPOS (NO_CIA, COD_GRU, COD_SUB, DESCRI, ESTADO, VERSION) VALUES ('01', '8', '4', 'JUGO LACTEO', 'VIG', 0)

INSERT INTO WISE.INV_SUBGRUPOS (NO_CIA, COD_GRU, COD_SUB, DESCRI, ESTADO, VERSION) VALUES ('01', '9', '1', 'EDAM', 'VIG', 0)

-- ACTUALIZANDO LECHE NATURAL
UPDATE WISE.INV_ARTICULOS A SET A.COD_GRU = '7', A.COD_SUB = '1'
WHERE A.COD_GRU = 6
AND   A.COD_SUB = 1
AND   A.COD_ART = 100

-- SOLO TEST
UPDATE WISE.INV_ARTICULOS A SET A.COD_GRU = '7', A.COD_SUB = '1'
WHERE A.COD_GRU = 6
AND   A.COD_SUB = 1
AND   A.COD_ART = 117

UPDATE WISE.INV_ARTICULOS A SET A.COD_GRU = '7', A.COD_SUB = '2'
WHERE A.COD_GRU = 6
AND   A.COD_SUB = 1

UPDATE WISE.INV_ARTICULOS A SET A.COD_GRU = '7', A.COD_SUB = '2'
WHERE A.COD_GRU = 6
AND   A.COD_SUB = 1

-- ASINGANDO TODO AL SUBGRUPO BIOYOGURT
UPDATE WISE.INV_ARTICULOS A SET A.COD_GRU = '8', A.COD_SUB = '1'
WHERE A.COD_GRU = 6
AND   A.COD_SUB = 2

-- ASIGNANDO AL SUBGRUPO QUESO
UPDATE WISE.INV_ARTICULOS A SET A.COD_GRU = '9', A.COD_SUB = '1'
WHERE A.COD_GRU = 6
AND   A.COD_SUB = 4

UPDATE WISE.INV_ARTICULOS A SET A.COD_SUB = '3'
WHERE A.COD_GRU = 8
AND A.COD_ART IN (111, 112, 115, 116, 120)

UPDATE WISE.INV_ARTICULOS A SET A.COD_SUB = '2'
WHERE A.COD_GRU = 8
AND A.COD_ART IN (110, 113, 128)

UPDATE WISE.INV_ARTICULOS A SET A.COD_SUB = '4'
WHERE A.COD_GRU = 8
AND A.COD_ART IN (124, 125, 126)

-- TIPO DE TAREA PRODUCCION
DELETE FROM EOS.TIPOTAREAPROD

INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (1, 'PREPARACION', 0, 1, '01', '7')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (2, 'ELABORACION', 0, 1, '01', '7')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (3, 'ENVASADO', 0, 1, '01', '7')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (4, 'ETIQUETADO', 0, 1, '01', '7')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (5, 'FECHADO', 0, 1, '01', '7')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (6, 'CONTEO DE PRODUCTO', 0, 1, '01', '7')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (7, 'LIMPIEZA', 0, 1, '01', '7')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (8, 'ALMUERZO', 0, 1, '01', '7')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (9, 'CENA', 0, 1, '01', '7')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (10, 'OTROS', 0, 1, '01', '7')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (11, 'SIN ACTIVIDAD', 0, 1, '01', '7')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (12, 'FIN DE JORNADA', 0, 1, '01', '7')

INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (13, 'PREPARACION', 0, 1, '01', '8')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (14, 'ELABORACION', 0, 1, '01', '8')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (15, 'ENVASADO', 0, 1, '01', '8')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (16, 'ETIQUETADO', 0, 1, '01', '8')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (17, 'FECHADO', 0, 1, '01', '8')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (18, 'CONTEO DE PRODUCTO', 0, 1, '01', '8')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (19, 'LIMPIEZA', 0, 1, '01', '8')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (20, 'ALMUERZO', 0, 1, '01', '8')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (21, 'CENA', 0, 1, '01', '8')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (22, 'OTROS', 0, 1, '01', '8')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (23, 'SIN ACTIVIDAD', 0, 1, '01', '8')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (24, 'FIN DE JORNADA', 0, 1, '01', '8')

INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (25, 'PREPARACION', 0, 1, '01', '9')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (26, 'ELABORACION', 0, 1, '01', '9')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (27, 'SELLADO', 0, 1, '01', '9')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (28, 'FECHADO', 0, 1, '01', '9')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (29, 'CONTEO DE PRODUCTO', 0, 1, '01', '9')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (30, 'LIMPIEZA', 0, 1, '01', '9')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (31, 'ALMUERZO', 0, 1, '01', '9')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (32, 'CENA', 0, 1, '01', '9')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (33, 'OTROS', 0, 1, '01', '9')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (34, 'SIN ACTIVIDAD', 0, 1, '01', '9')
INSERT INTO EOS.TIPOTAREAPROD (IDTIPOTAREAPROD, NOMBRE, VERSION, IDCOMPANIA, NO_CIA, COD_GRU) VALUES (35, 'FIN DE JORNADA', 0, 1, '01', '9')

-- FIN
--Khipus MRP PROD-75: Imlementar costos indirectos
--Diego H. Loza Fernandez
--Fecha de creacion: 05/12/2013

CREATE TABLE COSTOSINDIRECTOS (
   IDCOSTOSINDIRECTOS NUMBER (24,0) NOT NULL
  ,NOMBRE VARCHAR(512) NOT NULL
  ,MES NUMBER(2) NOT NULL
  ,ANIO	NUMBER(4) NOT NULL
  ,MONTOBS NUMBER(16,2) NOT NULL
  ,TIPO VARCHAR(512) NULL
  ,NO_CIA	VARCHAR2(2 BYTE) NULL
  ,COD_GRU	VARCHAR2(3 BYTE) NULL
  ,VERSION   NUMBER(24) NOT NULL
  ,IDCOMPANIA NUMBER(24) NOT  NULL
  ,CONSTRAINT pk_COSTOSINDIRECTOS PRIMARY KEY (IDCOSTOSINDIRECTOS)
);
--drop table COSTOSINDIRECTOS
ALTER TABLE COSTOSINDIRECTOS
ADD CONSTRAINT fk_INV_GRUPOS_COSTOSINDIRECTOS FOREIGN KEY (NO_CIA,COD_GRU) REFERENCES WISE.INV_GRUPOS(NO_CIA,COD_GRU);
--commit
ALTER TABLE ORDENPRODUCCION ADD (TOTALCOSTOINDIRECTO	NUMBER(16,2) null);
--
ALTER TABLE PRODUCTOPROCESADO ADD (UNIDADMEDIDATE VARCHAR(4) NULL);
ALTER TABLE PRODUCTOPROCESADO ADD (CANTIDAD NUMBER(7,2) NULL);

