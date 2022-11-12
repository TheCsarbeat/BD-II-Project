DELIMITER  //
CREATE PROCEDURE crudImpuesto (IN opcion int, IN nombre varchar(20),IN porcentaje float,IN pais int,IN impId int)
BEGIN
    If opcion = 1 THEN

        if not EXISTS (SELECT 1 from Impuesto where nombreImpuesto = nombre) THEN

            if (porcentaje is not null and pais is not null) then
            
                if EXISTS(Select 1 from Pais where idPais = pais) THEN
                    Insert into Impuesto (nombreImpuesto,porcentajeImpuesto,idPais)
                    values (nombre,porcentaje,pais);
                ELSE      
					Select 'IdPais no existe';
                    
				end if;
            ELSE   
				select 'Datos incorrectos';
            end if;
        ELSE
			select 'Ya existe este impuesto';
        end if;
    ElseIf opcion = 2 THEN

        if EXISTS (SELECT 1 from Impuesto where idImpuesto = impId) THEN
            UPDATE Impuesto
            set nombreImpuesto = nombre,porcentajeImpuesto = porcentaje, idPais = pais
            where idImpuesto = impId;
        Else
			select'idImpuesto no existe';
        end if;

    Elseif opcion = 3 then

        if EXISTS (SELECT 1 from Impuesto where idImpuesto = impId) THEN
            select * from Impuesto where idImpuesto = impId;
        Else
			select 'idImpuesto no existe';
        end if;

    Elseif opcion = 4 THEN

        if EXISTS (SELECT 1 from Impuesto where idImpuesto = impId) THEN
            UPDATE Impuesto
            set estado = 'Inactivo'
            where idImpuesto = impId;
        Else
			select 'idImpuesto no existe';
        end if;

    End if;
END//

DELIMITER ;



Delimiter //
CREATE   PROCEDURE crudCategoriaProducto (IN opcion int, IN nombre varchar(20),IN describ varchar(40),IN idCat int)
BEGIN
    If opcion = 1 THEN

        if not EXISTS (SELECT 1 from CategoriaProducto where nombreCategoria = nombre) THEN

            if (nombre is not null and describ is not null) then
            
                    Insert into CategoriaProducto (nombreCategoria,descripcionCategoria)
                    values (nombre,describ);

            ELSE   
				select 'Datos incorrectos';
            end if;
        ELSE
			select 'Ya existe esta Categoria';
        end if;
    ElseIf opcion = 2 THEN

        if EXISTS (SELECT 1 from CategoriaProducto where idCategoria = idCat) THEN
            UPDATE CategoriaProducto
            set nombreCategoria = nombre,descripcionCategoria = describ
            where idCategoria = idCat;
        Else
			select'idImpuesto no existe';
        end if;

    Elseif opcion = 3 then

        if EXISTS (SELECT 1 from CategoriaProducto where idCategoria = idCat) THEN
            select * from CategoriaProducto where idCategoria = idCat;
        Else
			select 'idImpuesto no existe';
        end if;

    Elseif opcion = 4 THEN

        if EXISTS (SELECT 1 from CategoriaProducto where idCategoria = idCat) THEN
            UPDATE CategoriaProducto
            set estado = 'Inactivo'
            where idCategoria = idCat;
        Else
			select 'idImpuesto no existe';
        end if;

    End if;
END
//

Delimiter;



Delimiter //
CREATE   PROCEDURE crudProducto (IN opcion int, IN nombre varchar(20),IN describ varchar(40),IN idCat int,IN foto LONGBLOB, IN idP int)
BEGIN
    If opcion = 1 THEN
        if (nombre is not null and describ is not null and idCat is not null and foto is not null) then
        
                Insert into Producto (nombreProducto,descripcionProducto,idCategoria,fotoPedido)
                values (nombre,describ,idCat,foto);

        ELSE   
            select 'Datos incorrectos';
        end if;
    ElseIf opcion = 2 THEN

        if EXISTS (SELECT 1 from Producto where idProducto = idP) THEN
            UPDATE Producto
            set nombreProducto = nombre,descripcionProducto = describ, idCategoria = idCat,fotoPedido=foto
            where idProducto = idP;
        Else
			select'idImpuesto no existe';
        end if;

    Elseif opcion = 3 then

        if EXISTS (SELECT 1 from Producto where idProducto = idP) THEN
            select * from Producto where idProducto = idP;
        Else
			select 'idImpuesto no existe';
        end if;

    Elseif opcion = 4 THEN

        if EXISTS (SELECT 1 from Producto where idProducto = idP) THEN
            UPDATE Producto
            set estado = 'Inactivo'
            where idProducto = idP;
        Else
			select 'idImpuesto no existe';
        end if;

    End if;
END//

Delimiter;


Delimiter //
CREATE   PROCEDURE crudCategoriaXImpuesto (IN opcion int, IN idI int,IN idCat int,IN idCXI int)
BEGIN
    If opcion = 1 THEN
        if (idI is not null and idCat is not null) then
        
                Insert into CategoriaXImpuesto (idCategoria,idImpuesto)
                values (idI,idCat);

        ELSE   
            select 'Datos incorrectos';
        end if;
    ElseIf opcion = 2 THEN

        if EXISTS (SELECT 1 from CategoriaXImpuesto where idCategoriaXImpuesto = idCXI) THEN
            UPDATE CategoriaXImpuesto
            set idCategoria = idCat,idImpuesto = idI
            where idCategoriaXImpuesto = idCXI;
        Else
			select'idImpuesto no existe';
        end if;

    Elseif opcion = 3 then

        if EXISTS (SELECT 1 from CategoriaXImpuesto where idCategoriaXImpuesto = idCXI) THEN
            select * from CategoriaXImpuesto where idCategoriaXImpuesto = idCXI;
        Else
			select 'idImpuesto no existe';
        end if;

    Elseif opcion = 4 THEN

        if EXISTS (SELECT 1 from CategoriaXImpuesto where idCategoriaXImpuesto = idCXI) THEN
            UPDATE CategoriaXImpuesto
            set estado = 'Inactivo'
            where idCategoriaXImpuesto = idCXI;
        Else
			select 'idImpuesto no existe';
        end if;

    End if;
END//

Delimiter;





Delimiter //
CREATE   PROCEDURE crudLote (IN opcion int, IN fechaP date,IN fechaE date,IN idP int, IN idL int)
BEGIN
    If opcion = 1 THEN
        if (fechaP is not null and fechaE is not null and idProducto is not null) then
        
                Insert into Lote (fechaProduccion,fechaExpiracion,idProducto)
                values (fechaP,fechaE,idP);

        ELSE   
            select 'Datos incorrectos';
        end if;
    ElseIf opcion = 2 THEN

        if EXISTS (SELECT 1 from Lote where idLote = idL) THEN
            UPDATE Lote
            set fechaProduccion = fechaP,fechaExpiracion = fechaE,idProducto = idP
            where idLote = idL;
        Else
			select'idImpuesto no existe';
        end if;

    Elseif opcion = 3 then

        if EXISTS (SELECT 1 from Lote where idLote = idL) THEN
            select * from Lote where idLote = idL;
        Else
			select 'idImpuesto no existe';
        end if;

    Elseif opcion = 4 THEN

        if EXISTS (SELECT 1 from Lote where idLote = idL) THEN
            UPDATE crudLote
            set estado = 'Inactivo'
            where idLote = idL;
        Else
			select 'idImpuesto no existe';
        end if;

    End if;
END//

Delimiter;



Delimiter //
CREATE   PROCEDURE crudProveedor (IN opcion int, IN nombre varchar(20),IN contact varchar(20),IN idP int, IN idProv int)
BEGIN
    If opcion = 1 THEN
        if (nombreProveedor is not null and contacto is not null and idP is not null) then
            if not EXISTS(Select 1 from Proveedor where nombreProveedor = nombreProveedor) THEN

                Insert into Proveedor (nombreProveedor,contacto,idPais)
                values (nombreProveedor,contact,idP);

            ELSE
                select 'Ya existe el proveedor';
            end if;

        ELSE   
            select 'Datos incorrectos';
        end if;
    ElseIf opcion = 2 THEN

        if EXISTS (SELECT 1 from Proveedor where idProveedor = idProv) THEN
            UPDATE Proveedor
            set nombreProveedor = nombre,contacto = contact,idPais = idP
            where idProveedor = idProv;
        Else
			select'idImpuesto no existe';
        end if;

    Elseif opcion = 3 then

        if EXISTS (SELECT 1 from Proveedor where idProveedor = idProv) THEN
            select * from Proveedor where idProveedor = idProv;
        Else
			select 'idImpuesto no existe';
        end if;

    Elseif opcion = 4 THEN

        if EXISTS (SELECT 1 from Proveedor where idProveedor = idProv) THEN
            UPDATE Proveedor
            set estado = 'Inactivo'
            where idProveedor = idProv;
        Else
			select 'idImpuesto no existe';
        end if;

    End if;
END//

Delimiter;




Delimiter //
CREATE   PROCEDURE crudProductoXProveedor (IN opcion int, IN porcentaje float,IN costo float,IN idL int, IN idProv int, IN idPXP int)
BEGIN
    If opcion = 1 THEN
        if (porcentaje is not null and costo is not null and idL is not null and idProv is not null) THEN
         
                Insert into ProductoXProveedor (porcentajeVenta,costoUnidad,idLote,idProveedor)
                values (porcentaje,costo,idL,idProv);

        ELSE   
            select 'Datos incorrectos';
        end if;
    ElseIf opcion = 2 THEN

        if EXISTS (SELECT 1 from ProductoXProveedor where idProductoXProveedor = idPXP) THEN
            UPDATE ProductoXProveedor
            set porcentajeVenta = nombre,costoUnidad = costo,idLote = idL,idProveedor = idProv
            where idProductoXProveedor = idPXP;
        Else
			select'idImpuesto no existe';
        end if;

    Elseif opcion = 3 then

        if EXISTS (SELECT 1 from ProductoXProveedor where idProductoXProveedor = idPXP) THEN
            select * from ProductoXProveedor where idProductoXProveedor = idPXP;
        Else
			select 'idImpuesto no existe';
        end if;

    Elseif opcion = 4 THEN

        if EXISTS (SELECT 1 from ProductoXProveedor where idProductoXProveedor = idPXP) THEN
            UPDATE ProductoXProveedor
            set estado = 'Inactivo'
            where idProductoXProveedor = idPXP;
        Else
			select 'idImpuesto no existe';
        end if;

    End if;
END//



Delimiter //
CREATE   PROCEDURE crudPedido (IN opcion int, IN cantidad int,IN idPXP int,in fecha date,in idPedi int)
BEGIN
    If opcion = 1 THEN
        if (cantidad is not null and idPXP is not null and fecha is not null) THEN
         
                Insert into Pedido (cantidadPedido,idProductoXProveedor,fechaPedido)
                values (cantidad,idPXP,fecha);

        ELSE   
            select 'Datos incorrectos';
        end if;
    ElseIf opcion = 2 THEN

        if EXISTS (SELECT 1 from Pedido where idPedido = idPedi) THEN
            UPDATE Pedido
            set cantidadPedido = cantidad,idProductoXProveedor = idPXP,fechaPedido = fecha
            where idPedido = idPedi;
        Else
			select'idImpuesto no existe';
        end if;

    Elseif opcion = 3 then

        if EXISTS (SELECT 1 from Pedido where idPedido = idPedi) THEN
            select * from Pedido where idPedido = idPedi;
        Else
			select 'idImpuesto no existe';
        end if;

    Elseif opcion = 4 THEN

        if EXISTS (SELECT 1 from Pedido where idPedido = idPedi) THEN
            UPDATE Pedido
            set estado = 'Inactivo'
            where idPedido = idPedi;
        Else
			select 'idImpuesto no existe';
        end if;

    End if;
END//