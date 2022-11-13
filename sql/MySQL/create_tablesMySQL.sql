#    create database BD_PROYECTO;
#    drop database BD_PROYECTO;
use BD_PROYECTO;

CREATE TABLE Impuesto(
    idImpuesto int PRIMARY Key not null AUTO_INCREMENT,
    nombreImpuesto varchar(20),
    porcentajeImpuesto float,
    idPais int,
    estado int DEFAULT 1
);
CREATE TABLE CategoriaProducto(
    idCategoria int PRIMARY Key not null AUTO_INCREMENT,
    nombreCategoria varchar(20),
    descripcionCategoria varchar(40),
    estado int DEFAULT 1
);

CREATE TABLE Producto(
    idProducto int PRIMARY Key not null AUTO_INCREMENT,
    nombreProducto varchar(20),
    descripcionProducto varchar(40),
    idCategoria int,
	nombreImg varchar(250),
	imgPath varchar(2000),
    estado int DEFAULT 1,
    FOREIGN KEY (idCategoria) REFERENCES CategoriaProducto(idCategoria)
);

CREATE TABLE CategoriaXImpuesto(
    idCategoriaXImpuesto int PRIMARY Key not null AUTO_INCREMENT,
    idCategoria int, FOREIGN KEY(idCategoria) REFERENCES CategoriaProducto(idCategoria),
    idImpuesto int, FOREIGN KEY(idImpuesto) REFERENCES Impuesto(idImpuesto),
    estado int DEFAULT 1
);
CREATE TABLE Proveedor(
    idProveedor int PRIMARY Key not null AUTO_INCREMENT,
    nombreProveedor varchar(20),
    contacto varchar(20),
    idPais int, 
    estado int DEFAULT 1
);	


CREATE TABLE Lote(
    idLote int PRIMARY Key not null AUTO_INCREMENT,
    fechaProduccion DATE,
    fechaExpiracion Date,
    idProducto int, FOREIGN KEY(idProducto) REFERENCES Producto(idProducto),
    idProveedor int, FOREIGN KEY(idProveedor) REFERENCES Proveedor(idProveedor),
    cantidadExistencias int,
    costoUnidad float,
    porcentajeVenta float,
    estado int DEFAULT 1
);

CREATE TABLE Limite(
    idLimite int PRIMARY Key not null AUTO_INCREMENT,
    maxCant int,
    minCant int,
    idProducto int, FOREIGN KEY(idProducto) REFERENCES Producto(idProducto),
    estado int DEFAULT 1    
);