CREATE TABLE Moneda (
    idMoneda int PRIMARY Key not null IDENTITY(1,1),
    nombreMoneda nvarchar(200),
    estado int DEFAULT 1
);
CREATE TABLE Pais(
    idPais INT PRIMARY Key not null IDENTITY(1,1),
    nombrePais nvarchar(200),
    estado int DEFAULT 1
);

CREATE TABLE MonedaXPais(
    idMonedaXPais INT PRIMARY Key not null IDENTITY(1,1),
    idPais int FOREIGN KEY REFERENCES Pais(idPais),
    cambioPorcentaje FLOAT,
    idMoneda int FOREIGN KEY REFERENCES Moneda(idMoneda),
    estado int DEFAULT 1
);


CREATE TABLE Lugar(
    idLugar INT PRIMARY Key not null IDENTITY(1,1),
    nombreLugar nvarchar(200),
    idPais int FOREIGN KEY REFERENCES Pais(idPais),
    ubicacion Geometry,
    estado int DEFAULT 1                         
);

CREATE TABLE Puesto(
    idPuesto INT PRIMARY Key not null IDENTITY(1,1),
    nombrePuesto nvarchar(200),
    salario money,
    estado int DEFAULT 1
);

CREATE TABLE Sucursal(
    idSucursal INT PRIMARY Key not null IDENTITY(1,1),
    nombreSucursal nvarchar(200),
    idLugar int FOREIGN KEY REFERENCES Lugar(idLugar),
    idMonedaXPais int FOREIGN KEY REFERENCES MonedaXPais(idMonedaXPais),
    estado int DEFAULT 1
);

CREATE TABLE Empleado(
    idEmpleado INT PRIMARY Key not null IDENTITY(1,1),
    nombreEmpleado nvarchar(200),
    apellidoEmpleado nvarchar(200),
    fechaContratacion date,
    fotoEmpleado nvarchar(MAX),
    idPuesto int FOREIGN KEY REFERENCES Puesto(idPuesto),
    idSucursal int FOREIGN KEY REFERENCES Sucursal(idSucursal),
    estado int DEFAULT 1
);

CREATE TABLE SucursalManager(
    idSucursalManager INT PRIMARY Key not null IDENTITY(1,1),
    idSucursal int FOREIGN KEY REFERENCES Sucursal(idSucursal),
    idEmpleado int FOREIGN KEY REFERENCES Empleado(idEmpleado)
);

CREATE TABLE Inventario(
    idInventario INT PRIMARY Key not null IDENTITY(1,1),
    cantidadInventario int,
    idLote int,
    idSucursal int FOREIGN KEY REFERENCES Sucursal(idSucursal),
	precioVenta money,
    estado int DEFAULT 1
);


CREATE TABLE Horario(
    idHorario INT PRIMARY Key not null IDENTITY(1,1),
    horarioInicial time,
    horarioFinal time,
    dia date,
    idSucursal int,
    estado int DEFAULT 1
);

-- TABLAS DEL BD_PROYECTO (Servidor)


CREATE TABLE Usuario(
    nombreUsuario varchar(200) PRIMARY Key not null,
    contrasena varchar(200),
    estado int DEFAULT 1
);

CREATE TABLE Cliente(
    idCliente varchar(200) PRIMARY Key ,
    nombreCliente varchar(200),
    apellidoCliente varchar(200),
    ubicacion Geometry,
    estado int DEFAULT 1
);

CREATE TABLE UsuarioXCliente(
    idUsuarioXCliente INT PRIMARY Key not null IDENTITY(1,1),
    idCliente varchar(200) FOREIGN KEY REFERENCES Cliente(idCliente),
    nombreUsuario varchar(200) FOREIGN KEY REFERENCES Usuario(nombreUsuario),
    estado int DEFAULT 1
);

CREATE TABLE UsuarioXEmpleado(
    idUsuarioXEmpleado INT PRIMARY Key not null IDENTITY(1,1),
    nombreUsuario varchar(200)  FOREIGN KEY REFERENCES Usuario(nombreUsuario),
    idEmpleado int, --FOREIGN KEY REFERENCES Empleado(idEmpleado),
    estado int DEFAULT 1        
);


CREATE TABLE MetodoPago(
    idMetodoPago INT PRIMARY Key not null IDENTITY(1,1),
    nombreMetodo varchar(200),
    otrosDetalles varchar(200),
    estado int DEFAULT 1        
);


CREATE TABLE Factura(
    idFactura INT PRIMARY Key not null IDENTITY(1,1),
    fechaFactura Date,
    hora time,
    idSucursal int FOREIGN KEY REFERENCES Sucursal(idSucursal),    
    montoTotal money,
    idCliente varchar(200) FOREIGN KEY REFERENCES Cliente(idCliente),
    idMetodoPago int FOREIGN KEY REFERENCES MetodoPago(idMetodoPago),
    estado int DEFAULT 1        
);

CREATE TABLE FacturaxEmpleado(
idFacturaxEmpleado INT PRIMARY Key not null IDENTITY(1,1),
	idFactura int FOREIGN KEY REFERENCES Factura(idFactura),
	idEmpleado int FOREIGN KEY REFERENCES Empleado(idEmpleado)
);

CREATE TABLE DetalleFactura(
    idDetalleFactura INT PRIMARY Key not null IDENTITY(1,1),
    idProducto int,
    cantidad int,
    idFactura int FOREIGN KEY REFERENCES Factura(idFactura),
    estado int DEFAULT 1
);

CREATE TABLE Pedido(
    idPedido INT PRIMARY Key not null IDENTITY(1,1),
	idLugar int,
    idFactura int FOREIGN KEY REFERENCES Factura(idFactura),
	porcentajeCosto float,
	otrosDetalles varchar(200),
	idCliente varchar(200) FOREIGN KEY REFERENCES Cliente(idCliente),
    estado int DEFAULT 1        
);

CREATE TABLE Performance(
    idPerformance INT PRIMARY Key not null IDENTITY(1,1),
    calificacion int,
    descripcionPerformance nvarchar(200),
    fecha date,
    idEmpleado int FOREIGN KEY REFERENCES Empleado(idEmpleado),
    estado int DEFAULT 1
);

CREATE TABLE TipoBono(
    idTipoBono INT PRIMARY Key not null IDENTITY(1,1),
    nombreTipoBono nvarchar(200),
    descripcionTipoBono nvarchar(200),
    estado int DEFAULT 1
);


--Tablas Rosadas
CREATE TABLE Bono(
    idBono INT PRIMARY Key not null IDENTITY(1,1),
    fecha DATE,
    cantidadBono money,
    idTipoBono int FOREIGN KEY REFERENCES TipoBono(idTipoBono),
    idEmpleado int FOREIGN KEY REFERENCES Empleado(idEmpleado),
	performance varchar(200),
    estado int DEFAULT 1
	
);

CREATE TABLE Descuento(
    idDescuento INT PRIMARY Key not null IDENTITY(1,1),
    nombre nvarchar(100),
	descuentoPorcent float,
    estado int DEFAULT 1
);

CREATE TABLE DescuentoXInventario(
    idDescuentoXInventario INT PRIMARY Key not null IDENTITY(1,1),
    idInventario int FOREIGN KEY REFERENCES Inventario(idInventario),
	idDescuento int FOREIGN KEY REFERENCES Descuento(idDescuento),
);


