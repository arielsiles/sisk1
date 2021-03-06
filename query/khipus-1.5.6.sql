--descripcion : Implementar descuento a productores para reservas
--
CREATE TABLE DESCUENTOPRODUCTOR(
   IDDESCUENTOPRODUCTOR NUMBER (24,0) NOT NULL
  ,PROMEDIOLECHE NUMBER(16,2) NOT NULL
  ,RESERVA NUMBER(8,5) NOT NULL
  ,RESERVAQUICENTA NUMBER(16,2) NOT NULL
  ,FECHAINI DATE NOT NULL
  ,FECHAFIN DATE NOT NULL
  ,MONTOTOTALMN NUMBER(16,2) NOT NULL
  ,MONTOTOTALME NUMBER(16,2) NOT NULL
  ,TC NUMBER (5,2) NOT NULL
  ,ESTADO VARCHAR(10) NOT NULL   
  ,CONSTRAINT PK_DESCUENTOPRODUCTOR PRIMARY KEY (IDDESCUENTOPRODUCTOR)
);
--DROP TABLE DESCUENTOPRODUCCION
CREATE TABLE DESCUENTORESERVA(
   IDDESCUENTORESERVA NUMBER(24,0) NOT NULL
  ,MONTO NUMBER(16,2) NOT NULL
  ,FECHAINI DATE NOT NULL
  ,FECHAFIN DATE NOT NULL
  ,IDPRODUCTORMATERIAPRIMA NUMBER(24,0) NOT NULL
  ,IDDESCUENTOPRODUCTOR NUMBER(24,0) NOT NULL
  ,CONSTRAINT PK_DESCUENTORESERVA PRIMARY KEY (IDDESCUENTORESERVA)
);
--DROP TABLE DESCUENTORESERVA
ALTER TABLE DESCUENTORESERVA
ADD CONSTRAINT FK_PRODCMATERIAPRIMA FOREIGN KEY (IDPRODUCTORMATERIAPRIMA) REFERENCES PRODUCTORMATERIAPRIMA(IDPRODUCTORMATERIAPRIMA);
ALTER TABLE DESCUENTORESERVA
ADD CONSTRAINT FK_DESCUENTOPRODUCTOR FOREIGN KEY (IDDESCUENTOPRODUCTOR) REFERENCES DESCUENTOPRODUCTOR(IDDESCUENTOPRODUCTOR);
--COMMIT
ALTER TABLE PLANILLAPAGOMATERIAPRIMA ADD TOTALDESCUENTORESERVA	NUMBER(16,2) DEFAULT 0.0;
--
Insert into DESCUENTOPRODUCTOR (IDDESCUENTOPRODUCTOR,PROMEDIOLECHE,RESERVA,FECHAINI,FECHAFIN,MONTOTOTALMN,MONTOTOTALME,TC,ESTADO,RESERVAQUICENTA) values ('1','168390','0,0069',to_date('01/05/14','DD/MM/RR'),to_date('31/12/14','DD/MM/RR'),'3485,67','3485,67','6,96','ENABLE','3485,67');

