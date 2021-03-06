--Khipus MRP PROD-87: Implementar el cierre y aprovación de periodo(quincena) para produccion
--Diego H. Loza Fernandez
--Fecha de creacion: 10/04/2014
--ALTER TABLE PLANILLAACOPIO ADD (ESTATO VARCHAR(10) default 'PENDING'); ya cuenta con un estado
ALTER TABLE SESIONACOPIO ADD (ESTADO VARCHAR(10) default 'PENDING');
ALTER TABLE NOTARECHAZOMATERIAPRIMA ADD (ESTADO VARCHAR(10) DEFAULT 'PENDING');
ALTER TABLE MOVIMIENTOSALARIOPRODUCTOR ADD (ESTADO VARCHAR(10) default 'PENDING');
ALTER TABLE MOVIMIENTOSALARIOGAB ADD (ESTADO VARCHAR(10) default 'PENDING');
--ALTER TABLE PLANILLAPAGOMATERIAPRIMA ADD (ESTADO VARCHAR(10) default 'PENDING');
--CAMBIAR EL ESTADO DE LA TABLA POR PENDIENTE

--COMMIT
ALTER TABLE movimientosalarioproductor ADD (IDZONAPRODUCTIVA NUMBER(24,0) NULL);
--select * from movimientosalarioproductor;
--select * from PRODUCTORMATERIAPRIMA;
CREATE TABLE LOGZONAPRODUCTIVA(
   IDLOGZONAPRODUCTIVA NUMBER(24,0) NOT NULL
  ,FECHA DATE
  ,ESTADO VARCHAR(10)
  ,IDPRODUCTORMATERIAPRIMA NUMBER(24,0) NOT NULL
  ,IDZONAPRODUCTIVA NUMBER(24,0) NOT NULL
  ,IDCOMPANIA NUMBER(24,0) NOT NULL 
  ,CONSTRAINT PK_LOGZONAPRODUCTIVA PRIMARY KEY(IDLOGZONAPRODUCTIVA)
);
--DROP TABLE LOGZONAPRODUCTIVA
ALTER TABLE LOGZONAPRODUCTIVA ADD CONSTRAINT FK_LOGZONAPROD_PRODMATPRIM FOREIGN KEY (IDPRODUCTORMATERIAPRIMA)
REFERENCES PRODUCTORMATERIAPRIMA(IDPRODUCTORMATERIAPRIMA);
ALTER TABLE LOGZONAPRODUCTIVA ADD CONSTRAINT FK_LOGZONAPROD_ZONAPROD FOREIGN KEY (IDZONAPRODUCTIVA)
REFERENCES ZONAPRODUCTIVA(IDZONAPRODUCTIVA);

update MOVIMIENTOSALARIOPRODUCTOR 
set idzonaproductiva = (
                        select idzonaproductiva from productormateriaprima 
                        where movimientosalarioproductor.idproductormateriaprima = productormateriaprima.idproductormateriaprima
                       )
where exists (
              select idzonaproductiva from productormateriaprima 
                        where movimientosalarioproductor.idproductormateriaprima = productormateriaprima.idproductormateriaprima
          );
--COMMIT

--commit
--Khipus KHIPUS-54: Implementar la probación de asientos contables
--Diego H. Loza Fernandez
--Fecha de creacion: 25/04/2014
INSERT  INTO FUNCIONALIDAD (IDFUNCIONALIDAD,CODIGO,DESCRIPCION,PERMISO,NOMBRERECURSO,IDMODULO)
  VALUES (385, 'APPROVEDALLACCOUNTENTRIES', NULL, 15,'menu.warehouse.accountEntries', 5); 
INSERT  INTO DERECHOACCESO (IDFUNCIONALIDAD,IDROL,PERMISO,IDCOMPANIA,IDMODULO)
  VALUES (385, 50, 15, 1, 5);   

