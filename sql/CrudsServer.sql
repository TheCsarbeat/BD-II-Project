
-- Creación de cruds

-- Sucursal
-- opcion 1: insertar, opcion 2: actualizar, opcion 3: consultar, opcion 4: borrar
go
create or alter procedure crudSucursal @opcion int, @idSucursal int, @nombre varchar(20), @idLugar int, @idMonedaXPais int, @idEmpleadoAdministrador int 
as
begin
	declare @error int, @errorMsg varchar(20)

	if @opcion = 1
		begin
		if (select count(*) from Sucursal where idSucursal = @idSucursal)=0
			begin
			if @nombre is not null
				begin
				if (select count(*) from Lugar where idLugar = @idLugar)!=0  
					begin
					if (select count(*) from MonedaXPais where idMonedaXPais = @idMonedaXPais)!=0 
						begin
						if (select count(*) from Empleado where idEmpleado= @idEmpleadoAdministrador)!=0
							begin 
							begin transaction

							insert into Sucursal(idSucursal, nombreSucursal, idLugar, idMonedaXpais, idEmpleadoAdministrador) 
							values(@idSucursal, @nombre, @idLugar, @idMonedaXpais, @idEmpleadoAdministrador)
					
							commit transaction

							end
						else
						begin
						set @error = 1
						set @errorMsg = 'El idEmpleado no existe'
						end

						end
					else
					begin
					set @error = 2
					set @errorMsg = 'La idMonedaXPais no existe'
					end

					end
				else
				begin
				set @error = 3
				set @errorMsg = 'El idLugar no existe'
				end

				end
			else
			begin
			set @error = 4
			set @errorMsg = 'nombre nulo'
			end
			end		
		else
		begin
		set @error = 5
		set @errorMsg = 'idSucursal ya existe'
		end
		end


	if @opcion = 2
		begin
		if (select count(*) from Sucursal where idSucursal = @idSucursal)!=0 
			begin
			begin transaction

			update Sucursal
			set nombreSucursal = ISNULL(@nombre, nombreSucursal), idLugar = ISNULL(@idLugar, idLugar), idMonedaXPais = ISNULL(@idMonedaXPais, idMonedaXPais),
			idEmpleadoAdministrador = ISNULL(@idEmpleadoAdministrador, idEmpleadoAdministrador) where idSucursal = @idSucursal
			
			commit transaction 

			end
			
		else
		begin 
		set @error = 1
		set @errorMsg = 'El idSucursal no existe'
		end
		
		end

	if @opcion = 3
		begin
		if (select count(*) from Sucursal where idSucursal = @idSucursal)!=0
			begin
			begin transaction

			select * from Sucursal where idSucursal = @idSucursal

			commit transaction

			end
		else
		begin
		set @error = 1
		set @errorMsg = 'El idSucursal no existe'
		end
		
		end

	if @opcion = 4
		begin
		if (select count(*) from Sucursal where idSucursal = @idSucursal)!=0
			begin
			begin transaction

			update Sucursal
			set estado = 0 where idSucursal = @idSucursal

			commit transaction

			end
			else
		begin
		set @error = 1
		set @errorMsg = 'El idSucursal no existe'
		
		end
		end
		select @error as error, @errorMsg as mensaje
	
	end

-- ****************************************************************************************************************

-- crudEmpleado

go
create or alter procedure crudEmpleado @opcion int,@idEmpleado int, @nombre varchar(20), @apellido varchar(20), @fechaContratacion date,
@foto varchar(100), @idPuesto int, @idSucursal int
as
begin
	declare @error int, @errorMsg varchar(20)

	if @opcion = 1
		begin
		if (select count(*) from Empleado where idEmpleado = @idEmpleado)=0
			begin
			if @nombre is not null and @apellido is not null and @fechaContratacion is not null and @foto is not null
				begin
				if (select count(*) from Puesto where idPuesto = @idPuesto)!=0
					begin
					if (select count(*) from Sucursal where idSucursal = @idSucursal)!=0
						begin
						
						begin transaction

						insert into Empleado(idEmpleado,nombreEmpleado,apellidoEmpleado,fechaContratacion,fotoEmpleado,idPuesto,idSucursal) 
						values(@idEmpleado,@nombre,@apellido,@fechaContratacion,@foto,@idPuesto,@idSucursal)

						commit transaction

						end
								
					else
					begin
					set @error = 1
					set @errorMsg = 'idSucursal no existe'
					end

					end
				else
				begin
				set @error = 2
				set @errorMsg = 'idPuesto no existe'
				end

				end
			else
			begin
			set @error = 3
			set @errorMsg = 'No pueden ir valores nulos'
			end

			end
		else
		begin
		set @error = 4
		set @errorMsg = 'idEmpleado ya existe'
		end

		end
	

	if @opcion = 2
		begin
		if (select count(*) from Empleado where idEmpleado = @idEmpleado)!=0 
			begin
			begin transaction

			update Empleado
			set nombreEmpleado = ISNULL(@nombre, nombreEmpleado), apellidoEmpleado = ISNULL(@apellido, apellidoEmpleado), 
			fechaContratacion = ISNULL(@fechaContratacion, fechaContratacion), fotoEmpleado = ISNULL(@foto, fotoEmpleado), idPuesto = ISNULL(@idPuesto, idPuesto),
			idSucursal = ISNULL(@idSucursal, idSucursal) where idEmpleado = @idEmpleado

			commit transaction 

			end
			
		else
		begin 
		set @error = 1
		set @errorMsg = 'El idEmpleado no existe'
		end
		end

	if @opcion = 3
		begin
		if (select count(*) from Empleado where idEmpleado = @idEmpleado)!=0
			begin
			begin transaction

			select * from Empleado where idEmpleado = @idEmpleado

			commit transaction

			end
		else
		begin
		set @error = 1
		set @errorMsg = 'El idEmpleado no existe'
		end
		end

	if @opcion = 4
		begin
		if (select count(*) from Empleado where idEmpleado = @idEmpleado)!=0 
			begin
			begin transaction

			update Empleado
			set estado = 0 where idEmpleado = @idEmpleado

			commit transaction

			end
		else
		begin
		set @error = 1
		set @errorMsg = 'El idEmpleado no existe'
		end

		end

		select @error as error, @errorMsg as mensaje
		
	end

-- ****************************************************************************************************************

-- opcion 1: insertar, opcion 2: actualizar, opcion 3: consultar, opcion 4: borrar

go
create or alter procedure crudPerformance @opcion int,@idPerformance int, @calificacion int, @descripcion varchar(50), @fecha date, @idEmpleado int with encryption
as
begin
	declare @error int, @errorMsg varchar(20)

	if @opcion = 1
		begin
		if (select count(*) from Performance where idPerformance = @idPerformance)=0
			begin
			if @calificacion is not null and @descripcion is not null and @fecha is not null
				begin
				if (select count(*) from Empleado where idEmpleado = @idEmpleado)!=0 
					begin
					begin transaction

					insert into Performance(idPerformance,calificacion, descripcionPerformance, fecha, idEmpleado)
					values(@idPerformance,@calificacion, @descripcion, @fecha,@idEmpleado)

					commit transaction

					end
				else
				begin
				set @error = 1
				set @errorMsg = 'idEmpleado no existe'
				end

				end
			else
			begin
			set @error = 2
			set @errorMsg = 'No pueden ir nulos'
			end

			end
		else
		begin
		set @error = 3
		set @errorMsg = 'idPerformance ya existe'
		end

		end
	

	if @opcion = 2
		begin
		if (select count(*) from Performance where idPerformance = @idPerformance)!=0 
			begin
			begin transaction

			update Performance
			set calificacion = ISNULL(@calificacion, calificacion), descripcionPerformance = ISNULL(@descripcion, descripcionPerformance), 
			fecha = ISNULL(@fecha, fecha), idEmpleado = ISNULL(@idEmpleado, idEmpleado) where idPerformance = @idPerformance

			commit transaction 

			end
			
		else
		begin 
		set @error = 1
		set @errorMsg = 'El idPerformance no existe'
		end
		end
	if @opcion = 3
		begin
		if (select count(*) from Performance where idPerformance = @idPerformance)!=0 
			begin
			begin transaction

			select * from Performance where idPerformance = @idPerformance

			commit transaction

			end
		else
		begin
		set @error = 1
		set @errorMsg = 'El idPerformance no existe'
		end
		end

	if @opcion = 4
		begin
		if (select count(*) from Performance where idPerformance = @idPerformance)!=0 
			begin
			begin transaction

			update Performance
			set estado = 0 where idPerformance = @idPerformance

			commit transaction

			end
		else
		begin
		set @error = 1
		set @errorMsg = 'El idPerformance no existe'
		end

		end

		select @error as error, @errorMsg as mensaje
		
	end

-- ****************************************************************************************************************

go
create or alter procedure crudBono @opcion int,@idBono int, @fecha date, @cantidadBono money, @idTipoBono int, @idEmpleado int with encryption
as
begin
	declare @error int, @errorMsg varchar(20)

	if @opcion = 1
		begin
		if (select count(*) from Bono where idBono = @idBono)=0
			begin
			if @fecha is not null and @cantidadBono is not null
				begin
				if (select count(*) from TipoBono where idTipoBono = @idTipoBono)!=0 
					begin
					if (select count(*) from Empleado where idEmpleado = @idEmpleado)!=0
						begin
						begin transaction

						insert into Bono(idBono,fecha,cantidadBono, idTipoBono, idEmpleado)
						values(@idBono,@fecha,@cantidadBono, @idTipoBono, @idEmpleado)

						commit transaction

						end
					else
					begin
					set @error = 1
					set @errorMsg = 'idEmpleado no existe'
					end

				end
				else
				begin
				set @error = 1
				set @errorMsg = 'idTipoBono no existe'
				end

				end
			else
			begin
			set @error = 2
			set @errorMsg = 'No pueden ir nulos'
			end

			end
		else
		begin
		set @error = 3
		set @errorMsg = 'idBono ya existe'
		end

		end
	

	if @opcion = 2
		begin
		if (select count(*) from Bono where idBono = @idBono)!=0 
			begin
			begin transaction

			update Bono
			set fecha = ISNULL(@fecha, fecha), cantidadBono = ISNULL(@cantidadBono, cantidadBono), 
			idTipoBono = ISNULL(@idTipoBono, idTipoBono), idEmpleado = ISNULL(@idEmpleado, idEmpleado) where idBono = @idBono
			commit transaction 

			end
			
		else
		begin 
		set @error = 1
		set @errorMsg = 'El idBono no existe'
		end
		end
	if @opcion = 3
		begin
		if (select count(*) from Bono where idBono = @idBono)!=0 
			begin
			begin transaction

			select * from Bono where idBono = @idBono

			commit transaction

			end
		else
		begin
		set @error = 1
		set @errorMsg = 'El idBono no existe'
		end
		end

	if @opcion = 4
		begin
		if (select count(*) from Bono where idBono = @idBono)!=0 
			begin
			begin transaction

			update Bono
			set estado = 0 where  idBono = @idBono

			commit transaction

			end
		else
		begin
		set @error = 1
		set @errorMsg = 'El idBono no existe'
		end

		end

		select @error as error, @errorMsg as mensaje
		
	end

-- ****************************************************************************************************************

-- opcion 1: insertar, opcion 2: actualizar, opcion 3: consultar, opcion 4: borrar

go
create or alter procedure crudHorario @opcion int,@idHorario int, @horaInicial time, @horaFinal time, @dia varchar(15), @idSucursal int
as
begin
	declare @error int, @errorMsg varchar(20)

	if @opcion = 1
		begin
		if (select count(*) from Horario where idHorario = @idHorario)=0
			begin
			if @horaInicial is not null and @horaFinal is not null and @dia is not null
				begin
				if (select count(*) from Sucursal where idSucursal = @idSucursal)!=0 
					begin
					begin transaction

					insert into Horario(idHorario, horarioInicial, horarioFinal, dia, idSucursal) 
					values(@idHorario, @horaInicial, @horaFinal, @dia, @idSucursal)

					commit transaction

					end
				else
				begin
				set @error = 1
				set @errorMsg = 'idSucursal no existe'
				end

				end
			else
			begin
			set @error = 2
			set @errorMsg = 'No pueden ir valores nulos' 
			end

			end
		else
		begin
		set @error = 3
		set @errorMsg = 'idHorario ya existe'
		end

		end
	

	if @opcion = 2
		begin
		if (select count(*) from Horario where idHorario = @idHorario)!=0 
			begin
			begin transaction

			update Horario
			set horarioInicial = ISNULL(@horaInicial, horarioInicial),horarioFinal = ISNULL(@horaFinal, horarioFinal), dia = ISNULL(@dia, dia),
			idSucursal = ISNULL(@idSucursal, idSucursal) where idHorario = @idHorario

			commit transaction 

			end
			
		else
		begin 
		set @error = 1
		set @errorMsg = 'El idHorario no existe'
		end
		end
if @opcion = 3
		begin
		if (select count(*) from Horario where idHorario = @idHorario)!=0
			begin
			begin transaction

			select * from Horario where idHorario = @idHorario

			commit transaction

			end
		else
		begin
		set @error = 1
		set @errorMsg = 'El idHorario no existe'
		end
		end

	if @opcion = 4
		begin
		if (select count(*) from Horario where idHorario = @idHorario)!=0 
			begin
			begin transaction

			delete from Horario where idHorario = @idHorario

			commit transaction

			end
		else
		begin
		set @error = 1
		set @errorMsg = 'El idHorario no existe'
		end

		end

		select @error as error, @errorMsg as mensaje
		
	end

-- ****************************************************************************************************************

-- opcion 1: insertar, opcion 2: actualizar, opcion 3: consultar, opcion 4: borrar

go
create or alter procedure crudMonedaXPais @opcion int,@idMonedaXPais int, @idPais int, @cambioPorcentaje float,  @idMoneda int
as
begin
	declare @error int, @errorMsg varchar(20)

	if @opcion = 1
		begin
		if (select count(*) from MonedaXPais where idMonedaXPais = @idMonedaXPais)=0
			begin
			if (select count(*) from Pais where idPais = @idPais)!=0  
				begin
				if @cambioPorcentaje is not null
					begin
					if (select count(*) from Moneda where idMoneda = @idMoneda)!=0 
						begin
						begin transaction

						insert into MonedaXPais(idMonedaXPais, idPais,cambioPorcentaje,idMoneda) 
						values(@idMonedaXPais, @idPais,@cambioPorcentaje,@idMoneda)

						commit transaction

						end
					else
					begin
					set @error = 1
					set @errorMsg = 'idMoneda no existe'
					end

					end
				else
				begin
				set @error = 2
				set @errorMsg = 'No pueden ir valores nulos' 
				end

				end
			else
			begin
			set @error = 3
			set @errorMsg = 'idPais no existe' 
			end

			end
		else
		begin
		set @error = 4
		set @errorMsg = 'idMonedaXPais ya existe'
		end

		end
	

	if @opcion = 2
		begin
		if (select count(*) from MonedaXPais where idMonedaXPais = @idMonedaXPais)!=0 
			begin
			begin transaction

			update MonedaXPais
			set idPais = ISNULL(@idPais, idPais), cambioPorcentaje = ISNULL(@cambioPorcentaje, cambioPorcentaje), idMoneda = ISNULL(@idMoneda, idMoneda)
			where idMonedaXPais = @idMonedaXPais

			commit transaction 

			end
			
		else
		begin 
		set @error = 1
		set @errorMsg = 'El idMonedaXPais no existe'
		end
		end

if @opcion = 3
		begin
		if (select count(*) from MonedaXPais where idMonedaXPais = @idMonedaXPais)!=0
			begin
			begin transaction

			select * from MonedaXPais where idMonedaXPais = @idMonedaXPais

			commit transaction

			end
		else
		begin
		set @error = 1
		set @errorMsg = 'El idMonedaXPais no existe'
		end
		end

	if @opcion = 4
		begin
		if (select count(*) from MonedaXPais where idMonedaXPais = @idMonedaXPais)!=0 
			begin
			begin transaction

			delete from MonedaXPais where idMonedaXPais = @idMonedaXPais

			commit transaction

			end
		else
		begin
		set @error = 1
		set @errorMsg = 'El idMonedaXPais no existe'
		end

		end

		select @error as error, @errorMsg as mensaje
		
	end

go
CREATE OR ALTER PROCEDURE insertMoneda @nombre varchar(20)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 from Moneda where nombreMoneda = @nombre)
    BEGIN
        Insert into Moneda(nombreMoneda)
        VALUES (@nombre)
    End
    ELSE
    BEGIN
        Select 0
    END
END

GO

CREATE OR ALTER PROCEDURE insertPais @nombre varchar(20)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 from Pais where nombrePais = @nombre)
    BEGIN
        Insert into Pais(nombrePais)
        VALUES (@nombre)
    End
    ELSE
    BEGIN
        Select 0
    END
END
GO

CREATE OR ALTER PROCEDURE insertMonedaXPais @idP int, @idM int, @cambio FLOAT
AS
BEGIN
    IF EXISTS (SELECT 1 from Pais where idPais = @idP)
    BEGIN
        IF EXISTS (SELECT 1 from Moneda where idMoneda = @idM)
        BEGIN
            insert into MonedaXPais(idPais,cambioPorcentaje,idMoneda)
            Values (@idP,@cambio,@idM)  
        END
        else
        BEGIN
            Select 0
        ENd
    End
    ELSE
    BEGIN
        Select 0
    END
END
GO

CREATE OR ALTER PROCEDURE insertLugar @nombre varchar(20), @idP int, @ubi Geometry
AS
BEGIN
    If EXISTS(Select 1 from Pais where idPais = @idP)
    BEGIN
        Insert into Lugar(nombreLugar,idPais,ubicacion)
        Values (@nombre,@idP,@ubi)
    End
    Else
    BEGIN
        Select 0
    End
End
GO

CREATE OR ALTER PROCEDURE insertPuesto @nombre VARCHAR(20), @salario money
AS
BEGIN
    If NOT EXISTS(SELECT 1 from Puesto where nombrePuesto = @nombre)
    BEGIN
        Insert into Puesto (nombrePuesto,salario)
        Values (@nombre,@salario)
    END
    Else
    BEGIN
        Select 0
    END
End
Go

Create OR ALTER PROCEDURE insertEmpleado @nombre VARCHAR(20), @apellido varchar(20), @fecha date, @foto NVARCHAR(MAX), @idPuesto int
AS
BEGIN
    If EXISTS (SELECT 1 from Puesto where idPuesto = @idPuesto)
    BEGIN
        insert into Empleado(nombreEmpleado,apellidoEmpleado,fechaContratacion,fotoEmpleado,idPuesto)
        values (@nombre,@apellido,@fecha,@foto,@idPuesto)
    ENd
    ELSE
    BEGIN
        Select 0
    End
ENd
Go

CREATE OR ALTER PROCEDURE insertInventario @max int,@min int,@cantidad int, @idProd INT
AS
BEGIN
    If EXISTS (SELECT 1 from Producto where idProducto = @idProd)
    BEGIN
        Insert into Inventario(minimo,maximo,cantidadInventario,idProducto)
        VALUES (@max,@min,@cantidad,@idProd)
    END
    ELSE
    BEGIN
        Select 0
    END
END
GO

CREATE OR ALTER PROCEDURE insertHorario @inicial time,@final time,@dia date,@idSuc INT
AS
BEGIN
    If EXISTS(Select 1 from Sucursal where idSucursal = @idSuc)
    BEGIN
        insert into Horario(horarioInicial,horarioFinal,dia,idSucursal)
        Values (@inicial,@final,@dia,@idSuc)
    End
    Else
    BEGIN
        SELECT 0
    End
End
GO

CREATE OR ALTER PROCEDURE insertSucursal @nombre VARCHAR(20),@idL int,@idMXP int, @idEmp int,@idI INT
AS
BEGIN
    IF EXISTS(SELECT 1 from Lugar WHERE idLugar = @idL) and EXISTS(Select 1 From MonedaXPais where idMonedaXPais = @idMXP) AND EXISTS(SELECT 1 from Empleado where idEmpleado = @idEmp)
    AND EXISTS(SELECT 1 from Inventario where idInventario = @idI)
    BEGIN
        Insert into Sucursal(nombreSucursal,idLugar,idMonedaXPais,idEmpleadoAdministrador)
        Values (@nombre,@idL,@idMXP,@idEmp)
    END
    Else
    BEGIN
        Select 0
    END
End

GO

--===========================================================
--============================CRUDS USUARIO==================
--===========================================================


GO
--====================================================
--						Tipo de Artista
--===================================================
CREATE OR ALTER PROCEDURE dbo.spSignUpCostumer
	@nombrUsuario varchar(20) ,
	@contrasena varchar(20),
	@idCliente varchar(20),
	@nombre varchar (15),
	@apellidos varchar (15),
	@xPosition float,
	@yPosition float
	with encryption
as
begin
declare @errorInt int = 0, @errorMsg varchar(60)
declare @identityValue int = -1

--INSERT OPERATION
	IF @nombrUsuario is not null and @contrasena is not null  and @idCliente is not null and @nombre is not null and @apellidos is not null and 
	@xPosition is not null  and @yPosition is not null BEGIN
		IF (select count(*) from Usuario where @nombrUsuario = nombreUsuario) = 0 BEGIN
			IF (select count(*) from Cliente where idCliente = @idCliente) = 0 BEGIN	
				BEGIN TRY
					BEGIN TRANSACTION
						INSERT INTO Usuario
						VALUES( @nombrUsuario, @contrasena, 1)	

						INSERT INTO Cliente
							VALUES(@idCliente, @nombre, @apellidos,geometry::Point(@xPosition, @yPosition, 0),1)

						INSERT INTO UsuarioXCliente
						VALUES (@idCliente, @nombrUsuario, 1)
					COMMIT TRANSACTION
				END TRY
				BEGIN CATCH
					set @errorInt=1
					set @errorMsg = 'Error al agregar a la base de datos'
				END CATCH
			END ELSE BEGIN --Final if idCliente			
				set @errorInt=1
				set @errorMsg = 'There already exits this Costumer'
				END
		END ELSE BEGIN 			
			set @errorInt=1
			set @errorMsg = 'The already exits this username'
			END
				
	END ELSE BEGIN 			
		set @errorInt=1
		set @errorMsg = 'There are a null values'
		END  ---Final if validacion nulos
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
	else
		select 0 as correct, 'The user has sign up succesfuly' as REsult
end

--====================================================
--						USUARIO
--===================================================

GO
CREATE OR ALTER PROCEDURE dbo.spUser
	@userName varchar(50) null, 
	@password varchar(20),
	@operationFlag int	-- Insert 0, update 1, select 2, select-ALL 3, delete 4
	with encryption
as
begin
declare @errorInt int = 0, @errorMsg varchar(60)
declare @identityValue int = -1

	if @operationFlag = 0 BEGIN
		IF @userName is not null  and @password is not null begin			
			IF (select count(*) from Usuario where @UserName = nombreUsuario) = 0 BEGIN
							
				BEGIN TRY
					BEGIN TRANSACTION
						INSERT INTO Usuario
						VALUES( @userName, @password, 1)						
					COMMIT TRANSACTION
				END TRY
				BEGIN CATCH
					set @errorInt=1
					set @errorMsg = 'Error al agregar a la base de datos'
				END CATCH
				
			END ELSE BEGIN 			
				set @errorInt=1
				set @errorMsg = 'The already exits this username'
				END
		END ELSE BEGIN 			
			set @errorInt=1
			set @errorMsg = 'There are a null values'
			END  ---Final if validacion nulos

	END
	
	if @operationFlag = 1 BEGIN
		IF @userName is not null and @password is not null begin			
			IF (select count(*) from Usuario where @UserName = nombreUsuario) = 0BEGIN				
					BEGIN TRY
						BEGIN TRANSACTION
						update Usuario 
						set contrasena = ISNULL(@password, contrasena)
						where nombreUsuario = @userName
					COMMIT TRANSACTION
					END TRY
					BEGIN CATCH
						set @errorInt=1
						set @errorMsg = 'Error al actualizar a la base de datos'
					END CATCH
		
			END ELSE BEGIN 			
				set @errorInt=1
				set @errorMsg = 'No exits a this username'
				END
		END ELSE BEGIN 			
			set @errorInt=1
			set @errorMsg = 'There are a null values'
			END  ---Final if validacion nulos
	END

	if @operationFlag = 2 BEGIN
		select * from Usuario
		where nombreUsuario = ISNULL(@userName, nombreUsuario) and estado = 1;
	END

	IF @operationFlag = 3 BEGIN
		IF @userName is not null BEGIN
			update Usuario 
			set estado = ISNULL(0, estado)
			where nombreUsuario = @userName
		END ELSE BEGIN
			set @errorInt=1
			set @errorMsg = 'EL ID no puede ser nulo'
			END  ---Final if validacion nulos
	END
	
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
	ELSE
		select 1 as valueResult, 'Funcion hecha sin problema' as Mensaje
end

--====================================================
--						CLIENTE
--===================================================
--Creacion de procedimientoCliente
GO
CREATE OR ALTER PROCEDURE spCliente
	@idCliente varchar (20),
	@nombre varchar (15),
	@apellidos varchar (15),
	@xPosition float,
	@yPosition float,	
	@operationFlag int	-- Insert 0, update 1, select 2
	with encryption
as
begin
declare @errorInt int = 0, @errorMsg varchar(60)

	if @operationFlag = 0 BEGIN
		if @nombre is not null  and @apellidos is not null and @xPosition is not null and @yPosition is not null begin
			IF (select count(*) from Cliente where idCliente = @idCliente) = 0 BEGIN
						

					BEGIN TRY
						BEGIN TRANSACTION												
							INSERT INTO Cliente
							VALUES(@idCliente, @nombre, @apellidos,geometry::Point(@xPosition, @yPosition, 0),1)
						COMMIT TRANSACTION
					END TRY
					BEGIN CATCH
						set @errorInt=1
						set @errorMsg = 'Error al agregar a la base de datos'
						END CATCH
								

			END ELSE BEGIN --Final if idCliente			
				set @errorInt=1
				set @errorMsg = 'There already exits this Costumer'
				END
		END ELSE BEGIN --Final if idCliente			
			set @errorInt=1
			set @errorMsg = 'There are a null values'
			END  ---Final if validacion nulos
	
	END
	
	if @operationFlag = 1 BEGIN
	if @idCliente is not null and @nombre is not null  and @apellidos is not null and @xPosition is not null and @yPosition is not null begin
			IF (select count(*) from Cliente where idCliente = @idCliente) = 1 BEGIN

					BEGIN TRY
						BEGIN TRANSACTION
						update Cliente 
						set   nombreCliente = ISNULL(@nombre, nombreCliente), apellidoCliente= ISNULL(@apellidos, apellidoCliente),ubicacion = ISNULL(geometry::Point(@xPosition, @yPosition, 0), ubicacion)
						where idCliente = @idCliente;
					COMMIT TRANSACTION
					END TRY
					BEGIN CATCH
						set @errorInt=1
						set @errorMsg = 'Error al agregar a la base de datos'
					END CATCH

			END ELSE BEGIN --Final if idCliente			
				set @errorInt=1
				set @errorMsg = 'NO existe un Cliente con este ID'
				END
		END ELSE BEGIN --Final if idCliente			
			set @errorInt=1
			set @errorMsg = 'Hay algun valor nulo'
			END  ---Final if validacion nulos
		
	END

	if @operationFlag = 2
	begin
		select * from Cliente
		where idCliente = ISNULL(@idCliente,idCliente) and estado = 1 ;
	end


	if @operationFlag = 3
	BEGIN
		IF @idCliente is not null BEGIN
			update Cliente 
			set estado = ISNULL(0, estado)
			where idCliente = ISNULL(@idCliente,idCliente)
		END ELSE BEGIN
			set @errorInt=1
			set @errorMsg = 'EL ID no puede ser nulo'
			END  ---Final if validacion nulos
	END

	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
	ELSE 
		select 1 as valueResult, 'Funcion hecha sin problema' as Mensaje
END


GO
CREATE Or ALTER PROCEDURE spLoginCostumer 
@nombrUsuario varchar(20),
@contrasena varchar(20)
AS
BEGIN
	if @nombrUsuario is not null and @contrasena is not null begin
		if EXISTS(Select * from Usuario where nombreUsuario = @nombrUsuario and contrasena = @contrasena)
		BEGIN
			Select 0 as ValueResult, 'Login Success' as MSG
		end
		ELSE
		BEGIN
			Select 1 as ValueResult, 'Invalid credentials' as MSG
		End
	END ELSE BEGIN
		select 1 as ValueResult, 'No pueden haber campos nulos' as Mensaje
		END  ---Final if validacion nulos
END



