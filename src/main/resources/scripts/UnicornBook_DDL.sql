/*
CREATE DATABASE UNICORNBOOK;
USE UNICORNBOOK;
*/
CREATE TABLE TIPO_ENTREGA
(
    ID           BIGINT(19) PRIMARY KEY AUTO_INCREMENT,
    TIPO_ENTREGA VARCHAR(25) NOT NULL
);

CREATE TABLE TIPO_OPERACION
(
    ID             BIGINT(19) PRIMARY KEY AUTO_INCREMENT,
    TIPO_OPERACION VARCHAR(25) NOT NULL
);

CREATE TABLE ESTADO
(
    ID     BIGINT(19) PRIMARY KEY AUTO_INCREMENT,
    ESTADO VARCHAR(25) NOT NULL
);

CREATE TABLE ROL
(
    ID         BIGINT(19) PRIMARY KEY AUTO_INCREMENT,
    NOMBRE_ROL VARCHAR(25) NOT NULL
);
CREATE SEQUENCE ROL_SEQ;

CREATE TABLE TEMATICA
(
    ID          BIGINT(19) PRIMARY KEY AUTO_INCREMENT,
    NOMBRE      VARCHAR(50) NOT NULL,
    DESCRIPCION VARCHAR(500)
);

CREATE TABLE EDITORIAL
(
    ID          BIGINT(19) PRIMARY KEY AUTO_INCREMENT,
    NOMBRE      VARCHAR(50) NOT NULL,
    DIRECCION   VARCHAR(100),
    PROVINCIA   VARCHAR(50),
    CCAA        VARCHAR(25),
    TELEFONO1   BIGINT(9),
    TELEFONO2   BIGINT(9),
    ENLACE_WEB  VARCHAR(100),
    DESCRIPCION VARCHAR(500)
);

CREATE TABLE COLECCION
(
    ID          BIGINT(19) PRIMARY KEY AUTO_INCREMENT,
    NOMBRE      VARCHAR(50) NOT NULL,
    DESCRIPCION VARCHAR(500)
);

CREATE TABLE LIBRO
(
    ID                BIGINT(19) PRIMARY KEY AUTO_INCREMENT,
    ISBN              BIGINT(13) NOT NULL UNIQUE,
    TITULO            VARCHAR(100),
    SUBTITULO         VARCHAR(100),
    SINOPSIS          VARCHAR(500),
    PAGINAS           INT,
    FORMATO           VARCHAR(50),
    FECHA_PUBLICACION DATE,
    FECHA_EDICION     DATE,
    FECHA_DISPONIBLE  DATE,
    VISIBLE           BOOLEAN,
    IDIOMA            VARCHAR(50),
    NOTAS             VARCHAR(500),
    STOCK             INT,
    PRECIO            FLOAT(6, 2),
    LINK_PORTADA      VARCHAR(500),
    ID_EDITORIAL      BIGINT(19),
    FOREIGN KEY (ID_EDITORIAL) REFERENCES EDITORIAL (ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE AUTOR
(
    ID        BIGINT(19) PRIMARY KEY AUTO_INCREMENT,
    NOMBRE    VARCHAR(25) NOT NULL,
    APELLIDO1 VARCHAR(25),
    APELLIDO2 VARCHAR(25),
    BIOGRAFIA VARCHAR(500),
    LINK_FOTO VARCHAR(500)
);

CREATE TABLE LIBRO_AUTOR
(
    ID_LIBRO BIGINT(19) NOT NULL,
    ID_AUTOR BIGINT(19) NOT NULL,
    PRIMARY KEY (ID_LIBRO, ID_AUTOR),
    FOREIGN KEY (ID_LIBRO) REFERENCES LIBRO (ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (ID_AUTOR) REFERENCES AUTOR (ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE LIBRO_TEMATICA
(
    ID_LIBRO    BIGINT(19) NOT NULL,
    ID_TEMATICA BIGINT(19) NOT NULL,
    PRIMARY KEY (ID_LIBRO, ID_TEMATICA),
    FOREIGN KEY (ID_LIBRO) REFERENCES LIBRO (ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (ID_TEMATICA) REFERENCES TEMATICA (ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE LIBRO_COLECCION
(
    ID_LIBRO     BIGINT(19) NOT NULL,
    ID_COLECCION BIGINT(19) NOT NULL,
    PRIMARY KEY (ID_LIBRO, ID_COLECCION),
    FOREIGN KEY (ID_LIBRO) REFERENCES LIBRO (ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (ID_COLECCION) REFERENCES COLECCION (ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE USUARIO
(
    ID               BIGINT(19) PRIMARY KEY AUTO_INCREMENT,
    USUARIO          VARCHAR(25) UNIQUE NOT NULL,
    PASSWORD         VARCHAR(255)        NOT NULL,
    EMAIL            VARCHAR(50) UNIQUE NOT NULL,
    DNI              VARCHAR(9),
    NOMBRE           VARCHAR(25),
    APELLIDO1        VARCHAR(25),
    APELLIDO2        VARCHAR(25),
    TELEFONO1        BIGINT(9),
    TELEFONO2        BIGINT(9),
    FECHA_NACIMIENTO DATE
);

CREATE TABLE USUARIO_ROL
(
    ID_USUARIO BIGINT(19) NOT NULL,
    ID_ROL     BIGINT(19) NOT NULL,
    PRIMARY KEY (ID_USUARIO, ID_ROL),
    FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO (ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (ID_ROL) REFERENCES ROL (ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE DIRECCION
(
    ID                   BIGINT(19) PRIMARY KEY AUTO_INCREMENT,
    NOMBRE_PERSONALIZADO VARCHAR(50),
    NOMBRE_RECEPTOR      VARCHAR(25)  NOT NULL,
    APELLIDO1_RECEPTOR   VARCHAR(25),
    APELLIDO2_RECEPTOR   VARCHAR(25),
    DIRECCION            VARCHAR(100) NOT NULL,
    CODIGO_POSTAL        INT(5),
    POBLACION            VARCHAR(50),
    PROVINCIA            VARCHAR(25),
    PAIS                 VARCHAR(50),
    ID_USUARIO           BIGINT(19),
    FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO (ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE TARJETA
(
    ID                   BIGINT(19) PRIMARY KEY AUTO_INCREMENT,
    NOMBRE_PERSONALIZADO VARCHAR(50),
    NUMERO               BIGINT(16) NOT NULL,
    TIPO_TARJETA         VARCHAR(25),
    MES_CADUCIDAD        INT  NOT NULL,
    ANO_CADUCIDAD        INT NOT NULL,
    CVV                  INT  NOT NULL,
    ID_USUARIO           BIGINT(19),
    FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO (ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE COMENTARIO
(
    ID               BIGINT(19) PRIMARY KEY AUTO_INCREMENT,
    FECHA_COMENTARIO DATE NOT NULL,
    HORA_COMENTARIO  TIME,
    COMENTARIO       VARCHAR(500),
    ESTRELLAS        INT,
    ID_ESTADO        BIGINT(19),
    FOREIGN KEY (ID_ESTADO) REFERENCES ESTADO (ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE COMPRA
(
    ID              BIGINT(19) PRIMARY KEY AUTO_INCREMENT,
    FECHA_COMPRA    DATE       NOT NULL,
    HORA_COMPRA     TIME       NOT NULL,
    FECHA_ENTREGA   DATE,
    METODO_PAGO     FLOAT(6, 2),
    ID_ESTADO       BIGINT(19),
    ID_USUARIO      BIGINT(19) NOT NULL,
    ID_TIPO_ENTREGA BIGINT(19) NOT NULL,
    ID_DIRECCION    BIGINT(19),
    ID_TARJETA      BIGINT(19),
    FOREIGN KEY (ID_ESTADO) REFERENCES ESTADO (ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO (ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (ID_TIPO_ENTREGA) REFERENCES TIPO_ENTREGA (ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (ID_DIRECCION) REFERENCES DIRECCION (ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (ID_TARJETA) REFERENCES TARJETA (ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE DETALLE_COMPRA
(
    ID_COMPRA            BIGINT(19) NOT NULL,
    ID_LIBRO             BIGINT(19) NOT NULL,
    CANTIDAD             INT        NOT NULL,
    PORCENTAJE_DESCUENTO INT(2),
    ID_COMENTARIO        BIGINT(19),
    PRIMARY KEY (ID_COMPRA, ID_LIBRO),
    FOREIGN KEY (ID_COMENTARIO) REFERENCES COMENTARIO (ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (ID_COMPRA) REFERENCES COMPRA (ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (ID_LIBRO) REFERENCES LIBRO (ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE ENCARGO
(
    ID                BIGINT(19) PRIMARY KEY AUTO_INCREMENT,
    ISBN              BIGINT(13),
    TITULO            VARCHAR(100),
    CANTIDAD          INT,
    FECHA_ENCARGO     DATE,
    HORA_ENCARGO      TIME,
    FECHA_FIN         DATE,
    ID_ESTADO         BIGINT(19),
    ID_TIPO_ENTREGA   BIGINT(19),
    ID_LIBRO          BIGINT(19),
    ID_USUARIO        BIGINT(19) NOT NULL,
    ID_TIPO_OPERACION BIGINT(19) NOT NULL,
    FOREIGN KEY (ID_ESTADO) REFERENCES ESTADO (ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (ID_TIPO_ENTREGA) REFERENCES TIPO_ENTREGA (ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (ID_LIBRO) REFERENCES LIBRO (ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO (ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (ID_TIPO_OPERACION) REFERENCES TIPO_OPERACION (ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE CONSULTA
(
    ID                BIGINT(19) PRIMARY KEY AUTO_INCREMENT,
    NOMBRE            VARCHAR(25)   NOT NULL,
    APELLIDO1         VARCHAR(25)   NOT NULL,
    APELLIDO2         VARCHAR(25),
    EMAIL             VARCHAR(50),
    TELEFONO          BIGINT(9),
    FECHA_CONSULTA    DATE          NOT NULL,
    HORA_CONSULTA     TIME,
    FECHA_FIN         DATE,
    CONSULTA          VARCHAR(1000) NOT NULL,
    ID_USUARIO        BIGINT(19),
    ID_ESTADO         BIGINT(19),
    ID_TIPO_OPERACION BIGINT(19)    NOT NULL,
    FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO (ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (ID_ESTADO) REFERENCES ESTADO (ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (ID_TIPO_OPERACION) REFERENCES TIPO_OPERACION (ID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE CESTA(
    -- ID_SESSION       VARCHAR(50)    NOT NULL,
                      ID_USUARIO BIGINT(19),
                      ID_LIBRO   BIGINT(19) NOT NULL,
                      CANTIDAD   INT        NOT NULL,
                      PRIMARY KEY (ID_USUARIO, ID_LIBRO),
                      FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO (ID)
                          ON UPDATE CASCADE
                          ON DELETE CASCADE,
                      FOREIGN KEY (ID_LIBRO) REFERENCES LIBRO (ID)
                          ON UPDATE CASCADE
                          ON DELETE CASCADE
);

/*
--ES NECESARIO AÑADIR ALGUN CAMPO EN LA TABLA LIBRO? PARA PERMITIR RESERVAR?
CREATE TABLE RESERVA(
	ID_RESERVA NUMERIC(19 PRIMARY KEY AUTO_INCREMENT,
	FECHA_RESERVA DATE NOT NULL,
	HORA_RESERVA TIME NOT NULL,
	FECHA_FIN DATE,
	ID_TIPO_ENTREGA INT,
	ID_LIBRO INT NOT NULL,
	ID_USUARIO INT NOT NULL,
	ID_DIRECCION INT,
	ID_ESTADO INT,
	FOREIGN KEY (ID_TIPO_ENTREGA) REFERENCES TIPO_ENTREGA(ID_TIPO_ENTREGA)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (ID_LIBRO) REFERENCES LIBRO(ID_LIBRO)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO(ID_USUARIO)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (ID_DIRECCION) REFERENCES DIRECCION(ID_DIRECCION)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (ID_ESTADO) REFERENCES ESTADO(ID_ESTADO)
		ON UPDATE CASCADE
		ON DELETE CASCADE
);*/

