
-- Creación de cruds

-- Sucursal
-- opcion 1: insertar, opcion 2: actualizar, opcion 3: consultar, opcion 4: borrar

-- ****************************************************************************************************************

-- crudEmpleado

go
create or alter procedure crudEmpleado @opcion int,@idEmpleado int, @nombre varchar(20), @apellido varchar(20), @fechaContratacion date,
@foto varchar(100), @idPuesto int, @idSucursal int
as
BEGIN
	declare @error int, @errorMsg varchar(20)

	if @opcion = 1
		BEGIN
		if (select count(*) from Empleado where idEmpleado = @idEmpleado)= 0 BEGIN
			if @nombre is not null and @apellido is not null and @fechaContratacion is not null and @foto is not null BEGIN
				if (select count(*) from Puesto where idPuesto = @idPuesto)!=0 BEGIN
					if (select count(*) from Sucursal where idSucursal = @idSucursal)!=0 BEGIN
						
						BEGIN transaction

							insert into Empleado(nombreEmpleado,apellidoEmpleado,fechaContratacion,fotoEmpleado,idPuesto,idSucursal) 
							values(@nombre,@apellido,@fechaContratacion,@foto,@idPuesto,@idSucursal)

						commit transaction

					END ELSE BEGIN 
						set @error = 1
						set @errorMsg = 'idSucursal no existe'
					END
				END ELSE BEGIN 
					set @error = 2
					set @errorMsg = 'idPuesto no existe'
				END
			END ELSE BEGIN 
				set @error = 3
				set @errorMsg = 'No pueden ir valores nulos'
			END
		END ELSE BEGIN 
			set @error = 4
			set @errorMsg = 'idEmpleado ya existe'
		END

	END
	

	if @opcion = 2 BEGIN
		if (select count(*) from Empleado where idEmpleado = @idEmpleado)!=0 BEGIN
			BEGIN transaction
				update Empleado
				set nombreEmpleado = ISNULL(@nombre, nombreEmpleado), apellidoEmpleado = ISNULL(@apellido, apellidoEmpleado), 
				fechaContratacion = ISNULL(@fechaContratacion, fechaContratacion), fotoEmpleado = ISNULL(@foto, fotoEmpleado), idPuesto = ISNULL(@idPuesto, idPuesto),
				idSucursal = ISNULL(@idSucursal, idSucursal) where idEmpleado = @idEmpleado
			commit transaction 

			END
		END ELSE BEGIN 
			set @error = 1
			set @errorMsg = 'El idEmpleado no existe'
		END
	END

	if @opcion = 3
		BEGIN
		if (select count(*) from Empleado where idEmpleado = @idEmpleado)!= 0 BEGIN
			BEGIN transaction

			select * from Empleado where idEmpleado = @idEmpleado

			commit transaction

		END ELSE BEGIN 
			set @error = 1
			set @errorMsg = 'El idEmpleado no existe'
		END
	END

	if @opcion = 4		BEGIN
		if (select count(*) from Empleado where idEmpleado = @idEmpleado)!=0 BEGIN
			BEGIN transaction
				update Empleado
				set estado = 0 where idEmpleado = @idEmpleado
			commit transaction
		END ELSE BEGIN 
			set @error = 1
			set @errorMsg = 'El idEmpleado no existe'
	END
	select @error as error, @errorMsg as mensaje
END

-- ****************************************************************************************************************

-- opcion 1: insertar, opcion 2: actualizar, opcion 3: consultar, opcion 4: borrar

go
create or alter procedure crudSucursalManager @opcion int,@idSucursalManger int, @idSucursal int , @idEmpleado int
as
BEGIN
	declare @error int, @errorMsg varchar(20)

	if @opcion = 1
		BEGIN
		if (select count(*) from SucursalManager where idSucursalManager = @idSucursalManger) = 0 BEGIN
			if @idSucursal is not null and @idEmpleado is not null BEGIN
				if (select count(*) from Empleado where idEmpleado = @idEmpleado)!=0 BEGIN
					if (select count(*) from Sucursal where idSucursal = @idSucursal)!=0 BEGIN
						
						BEGIN transaction
							insert into SucursalManager
							values(@idSucursal,@idEmpleado)
						commit transaction

					END ELSE BEGIN 
						set @error = 1
						set @errorMsg = 'idSucursal no existe'
					END
				END ELSE BEGIN 
					set @error = 2
					set @errorMsg = 'idEmpleado no existe'
				END
			END ELSE BEGIN 
				set @error = 3
				set @errorMsg = 'No pueden ir valores nulos'
			END
		END ELSE BEGIN 
			set @error = 4
			set @errorMsg = 'Ya existe esa relacion SucursalMaganer'
		END

	END

	if @opcion = 2 BEGIN
		if (select count(*) from SucursalManager where idSucursalManager = @idSucursalManger)!=0 BEGIN
			if (select count(*) from Empleado where idEmpleado = @idEmpleado)!=0 BEGIN
				if (select count(*) from Sucursal where idSucursal = @idSucursal)!=0 BEGIN
					BEGIN transaction
						update SucursalManager
						set idEmpleado = ISNULL(@idEmpleado, idEmpleado), idSucursal = ISNULL(@idSucursal, idSucursal)
						where idSucursalManager = @idSucursalManger
					commit transaction 
				END ELSE BEGIN 
						set @error = 1
						set @errorMsg = 'idSucursal no existe'
					END
			END ELSE BEGIN 
				set @error = 2
				set @errorMsg = 'idEmpleado no existe'
			END			
		END ELSE BEGIN 
			set @error = 1
			set @errorMsg = 'El idEmpleado no existe'
		END
	END

	if @opcion = 3
		BEGIN
		if (select count(*) from SucursalManager where idSucursalManager = @idSucursalManger)!= 0 BEGIN
			BEGIN transaction
			select * from SucursalManager where idSucursalManager = ISNULL(@idSucursalManger,idSucursalManager)
			commit transaction

		END ELSE BEGIN 
			set @error = 1
			set @errorMsg = 'El idEmpleado no existe'
		END
	END

	
	select @error as error, @errorMsg as mensaje
END



		
-- ****************************************************************************************************************

-- opcion 1: insertar, opcion 2: actualizar, opcion 3: consultar, opcion 4: borrar

go
create or alter procedure crudPerformance @opcion int,@idPerformance int, @calificacion int, @descripcion varchar(50), @fecha date, @idEmpleado int with encryption
as
BEGIN
	declare @error int, @errorMsg varchar(20)

	if @opcion = 1
		BEGIN
		if (select count(*) from Performance where idPerformance = @idPerformance)= 0 BEGIN
			if @calificacion is not null and @descripcion is not null and @fecha is not null BEGIN
				if (select count(*) from Empleado where idEmpleado = @idEmpleado)!=0 BEGIN
					BEGIN transaction
						insert into Performance(idPerformance,calificacion, descripcionPerformance, fecha, idEmpleado)
						values(@idPerformance,@calificacion, @descripcion, @fecha,@idEmpleado)
					commit transaction

				END ELSE BEGIN 
					set @error = 1
					set @errorMsg = 'idEmpleado no existe'
				END
			END ELSE BEGIN 
				set @error = 2
				set @errorMsg = 'No pueden ir nulos'
			END
		END ELSE BEGIN 
			set @error = 3
			set @errorMsg = 'idPerformance ya existe'
		END
	END
	

	if @opcion = 2		BEGIN
		if (select count(*) from Performance where idPerformance = @idPerformance)!=0 			BEGIN
			BEGIN transaction
				update Performance
				set calificacion = ISNULL(@calificacion, calificacion), descripcionPerformance = ISNULL(@descripcion, descripcionPerformance), 
				fecha = ISNULL(@fecha, fecha), idEmpleado = ISNULL(@idEmpleado, idEmpleado) where idPerformance = @idPerformance
			commit transaction 

		END ELSE BEGIN 
			set @error = 1
			set @errorMsg = 'El idPerformance no existe'
		END
	END

	if @opcion = 3		BEGIN
		if (select count(*) from Performance where idPerformance = @idPerformance)!=0 			BEGIN
			BEGIN transaction
				select * from Performance where idPerformance = @idPerformance
			commit transaction
		END ELSE BEGIN 
			set @error = 1
			set @errorMsg = 'El idPerformance no existe'
		END
	END

	if @opcion = 4		BEGIN
		if (select count(*) from Performance where idPerformance = @idPerformance)!=0 	BEGIN
			BEGIN transaction
				update Performance
				set estado = 0 where idPerformance = @idPerformance
			commit transaction
		END ELSE BEGIN 
			set @error = 1
			set @errorMsg = 'El idPerformance no existe'
		END

	END

		select @error as error, @errorMsg as mensaje
		
END

-- ****************************************************************************************************************

go
create or alter procedure crudBono @opcion int,@idBono int, @fecha date, @cantidadBono money, @idTipoBono int, @idEmpleado int with encryption
as
BEGIN
	declare @error int, @errorMsg varchar(20)

	if @opcion = 1
		BEGIN
		if (select count(*) from Bono where idBono = @idBono)= 0 BEGIN
			if @fecha is not null and @cantidadBono is not null BEGIN
				if (select count(*) from TipoBono where idTipoBono = @idTipoBono)!=0 BEGIN
					if (select count(*) from Empleado where idEmpleado = @idEmpleado)!=0 BEGIN
						BEGIN transaction

						insert into Bono(idBono,fecha,cantidadBono, idTipoBono, idEmpleado)
						values(@idBono,@fecha,@cantidadBono, @idTipoBono, @idEmpleado)

						commit transaction
					END ELSE BEGIN 
						set @error = 1
						set @errorMsg = 'idEmpleado no existe'
					END
				END ELSE BEGIN 
					set @error = 1
					set @errorMsg = 'idTipoBono no existe'
				END
			END ELSE BEGIN 
				set @error = 2
				set @errorMsg = 'No pueden ir nulos'
			END
		END ELSE BEGIN 
			set @error = 3
			set @errorMsg = 'idBono ya existe'
		END
	END
	

	if @opcion = 2
		BEGIN
		if (select count(*) from Bono where idBono = @idBono)!=0 
			BEGIN
			BEGIN transaction
			update Bono
				set fecha = ISNULL(@fecha, fecha), cantidadBono = ISNULL(@cantidadBono, cantidadBono), 
				idTipoBono = ISNULL(@idTipoBono, idTipoBono), idEmpleado = ISNULL(@idEmpleado, idEmpleado) where idBono = @idBono
			commit transaction 
		END ELSE BEGIN 
			set @error = 1
			set @errorMsg = 'El idBono no existe'
		END
	END
	if @opcion = 3
		BEGIN
		if (select count(*) from Bono where idBono = @idBono)!=0 
			BEGIN
			BEGIN transaction
			select * from Bono where idBono = @idBono
			commit transaction

		END ELSE BEGIN 
		set @error = 1
		set @errorMsg = 'El idBono no existe'
		END
	END

	if @opcion = 4
		BEGIN
		if (select count(*) from Bono where idBono = @idBono)!=0 
			BEGIN
			BEGIN transaction
			update Bono
			set estado = 0 where  idBono = @idBono
			commit transaction

		END ELSE BEGIN 
		set @error = 1
		set @errorMsg = 'El idBono no existe'
		END

	END

		select @error as error, @errorMsg as mensaje
		
END

-- ****************************************************************************************************************

-- opcion 1: insertar, opcion 2: actualizar, opcion 3: consultar, opcion 4: borrar

go
create or alter procedure crudHorario @opcion int,@idHorario int, @horaInicial time, @horaFinal time, @dia varchar(15), @idSucursal int
as
BEGIN
	declare @error int, @errorMsg varchar(20)

	if @opcion = 1
		BEGIN
		if (select count(*) from Horario where idHorario = @idHorario)= 0 BEGIN
			if @horaInicial is not null and @horaFinal is not null and @dia is not null
				BEGIN
				if (select count(*) from Sucursal where idSucursal = @idSucursal)!=0 
					BEGIN
					BEGIN transaction
					insert into Horario(idHorario, horarioInicial, horarioFinal, dia, idSucursal) 
					values(@idHorario, @horaInicial, @horaFinal, @dia, @idSucursal)
					commit transaction

				END ELSE BEGIN 
				set @error = 1
				set @errorMsg = 'idSucursal no existe'
				END

			END ELSE BEGIN 
			set @error = 2
			set @errorMsg = 'No pueden ir valores nulos' 
			END

		END ELSE BEGIN 
		set @error = 3
		set @errorMsg = 'idHorario ya existe'
		END

	END
	

	if @opcion = 2
		BEGIN
		if (select count(*) from Horario where idHorario = @idHorario)!=0 			BEGIN
			BEGIN transaction
				update Horario
				set horarioInicial = ISNULL(@horaInicial, horarioInicial),horarioFinal = ISNULL(@horaFinal, horarioFinal), dia = ISNULL(@dia, dia),
				idSucursal = ISNULL(@idSucursal, idSucursal) where idHorario = @idHorario
			commit transaction 

		END ELSE BEGIN  
			set @error = 1
			set @errorMsg = 'El idHorario no existe'
		END
	END
	if @opcion = 3		BEGIN
		if (select count(*) from Horario where idHorario = @idHorario)!= 0 BEGIN
			BEGIN transaction
				select * from Horario where idHorario = @idHorario
			commit transaction
		END ELSE BEGIN 
		set @error = 1
		set @errorMsg = 'El idHorario no existe'
		END
	END

	if @opcion = 4
		BEGIN
		if (select count(*) from Horario where idHorario = @idHorario)!=0 			BEGIN
			BEGIN transaction
				delete from Horario where idHorario = @idHorario
			commit transaction

		END ELSE BEGIN 
			set @error = 1
			set @errorMsg = 'El idHorario no existe'
		END
	END
		select @error as error, @errorMsg as mensaje		
	END

-- ****************************************************************************************************************

-- opcion 1: insertar, opcion 2: actualizar, opcion 3: consultar, opcion 4: borrar

go
create or alter procedure crudMonedaXPais @opcion int,@idMonedaXPais int, @idPais int, @cambioPorcentaje float,  @idMoneda int
as
BEGIN
	declare @error int, @errorMsg varchar(20)

	if @opcion = 1		BEGIN
		if (select count(*) from MonedaXPais where idMonedaXPais = @idMonedaXPais)= 0 BEGIN
			if (select count(*) from Pais where idPais = @idPais)!=0 BEGIN
				if @cambioPorcentaje is not null BEGIN
					if (select count(*) from Moneda where idMoneda = @idMoneda)!=0 BEGIN
						BEGIN transaction
							insert into MonedaXPais( idPais,cambioPorcentaje,idMoneda) 
							values(@idPais,@cambioPorcentaje,@idMoneda)
						commit transaction

					END ELSE BEGIN 
						set @error = 1
						set @errorMsg = 'idMoneda no existe'
					END
				END ELSE BEGIN 
					set @error = 2
					set @errorMsg = 'No pueden ir valores nulos' 
				END

			END ELSE BEGIN 
				set @error = 3
				set @errorMsg = 'idPais no existe' 
			END
		END ELSE BEGIN 
			set @error = 4
			set @errorMsg = 'idMonedaXPais ya existe'
		END

		END

	if @opcion = 2
		BEGIN
		if (select count(*) from MonedaXPais where idMonedaXPais = @idMonedaXPais)!=0 			BEGIN
			BEGIN transaction
				update MonedaXPais
				set idPais = ISNULL(@idPais, idPais), cambioPorcentaje = ISNULL(@cambioPorcentaje, cambioPorcentaje), idMoneda = ISNULL(@idMoneda, idMoneda)
				where idMonedaXPais = @idMonedaXPais
			commit transaction 

		END ELSE BEGIN 
			set @error = 1
			set @errorMsg = 'El idMonedaXPais no existe'
		END
		END

if @opcion = 3
		BEGIN
		if (select count(*) from MonedaXPais where idMonedaXPais = @idMonedaXPais)!= 0 BEGIN
			BEGIN transaction
				select * from MonedaXPais where idMonedaXPais = @idMonedaXPais
			commit transaction

		END ELSE BEGIN 
			set @error = 1
			set @errorMsg = 'El idMonedaXPais no existe'
		END
		END

	if @opcion = 4
		BEGIN
		if (select count(*) from MonedaXPais where idMonedaXPais = @idMonedaXPais)!=0 
			BEGIN
			BEGIN transaction
				delete from MonedaXPais where idMonedaXPais = @idMonedaXPais
			commit transaction
		END ELSE BEGIN 
			set @error = 1
			set @errorMsg = 'El idMonedaXPais no existe'
		END
	END
	select @error as error, @errorMsg as mensaje
		
END

go
CREATE OR ALTER PROCEDURE insertMoneda @nombre varchar(20)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 from Moneda where nombreMoneda = @nombre)
    BEGIN
        Insert into Moneda(nombreMoneda)
        VALUES (@nombre)
    END ELSE BEGIN 
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
    END ELSE BEGIN 
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
        END ELSE BEGIN 
            Select 0
        END
    END
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
    END ELSE BEGIN 
        Select 0
    END
END
GO

CREATE OR ALTER PROCEDURE insertPuesto @nombre VARCHAR(20), @salario money
AS
BEGIN
    If NOT EXISTS(SELECT 1 from Puesto where nombrePuesto = @nombre)
    BEGIN
        Insert into Puesto (nombrePuesto,salario)
        Values (@nombre,@salario)
    END ELSE BEGIN 
        Select 0
    END
END
Go

Create OR ALTER PROCEDURE insertEmpleado @nombre VARCHAR(20), @apellido varchar(20), @fecha date, @foto NVARCHAR(MAX), @idPuesto int
AS
BEGIN
    If EXISTS (SELECT 1 from Puesto where idPuesto = @idPuesto)
    BEGIN
        insert into Empleado(nombreEmpleado,apellidoEmpleado,fechaContratacion,fotoEmpleado,idPuesto)
        values (@nombre,@apellido,@fecha,@foto,@idPuesto)
    END ELSE BEGIN 
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
    END ELSE BEGIN 
        SELECT 0
    END
END
GO

--===========================================================
--============================CRUDS USUARIO==================
--===========================================================


GO
--====================================================
--						Tipo de SignUpCostumer
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
BEGIN
declare @errorInt int = 0, @errorMsg varchar(60)
declare @identityValue int = -1

--INSERT OPERATION
	IF @nombrUsuario is not null and @contrasena is not null  and @idCliente is not null and @nombre is not null and @apellidos is not null and 
	@xPosition is not null  and @yPosition is not null BEGIN
		IF (select count(*) from Usuario where nombreUsuario = @nombrUsuario ) = 0 BEGIN
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
					set @errorMsg = 'There is an error in de database'
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
END

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
BEGIN
declare @errorInt int = 0, @errorMsg varchar(60)
declare @identityValue int = -1

	if @operationFlag = 0 BEGIN
		IF @userName is not null  and @password is not null BEGIN			
			IF (select count(*) from Usuario where @UserName = nombreUsuario) = 0 BEGIN
							
				BEGIN TRY
					BEGIN TRANSACTION
						INSERT INTO Usuario
						VALUES( @userName, @password, 1)						
					COMMIT TRANSACTION
				END TRY
				BEGIN CATCH
					set @errorInt=1
					set @errorMsg = 'There is an error in de database'
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
		IF @userName is not null and @password is not null BEGIN			
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
		select 0 as valueResult , 'Funcion hecha sin problema' as Mensaje
END

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
BEGIN
declare @errorInt int = 0, @errorMsg varchar(60)

	if @operationFlag = 0 BEGIN
		if @nombre is not null  and @apellidos is not null and @xPosition is not null and @yPosition is not null BEGIN
			IF (select count(*) from Cliente where idCliente = @idCliente) = 0 BEGIN
						

					BEGIN TRY
						BEGIN TRANSACTION												
							INSERT INTO Cliente
							VALUES(@idCliente, @nombre, @apellidos,geometry::Point(@xPosition, @yPosition, 0),1)
						COMMIT TRANSACTION
					END TRY
					BEGIN CATCH
						set @errorInt=1
						set @errorMsg = 'There is an error in de database'
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
	if @idCliente is not null and @nombre is not null  and @apellidos is not null and @xPosition is not null and @yPosition is not null BEGIN
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
						set @errorMsg = 'There is an error in de database'
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
	BEGIN
		select * from Cliente
		where idCliente = ISNULL(@idCliente,idCliente) and estado = 1 ;
	END


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
	ELSE IF @errorInt = 0 
		select 0 as valueResult, 'Funcion hecha sin problema' as Mensaje
END


GO
CREATE Or ALTER PROCEDURE spLoginCostumer 
@nombrUsuario varchar(20),
@contrasena varchar(20)
AS
BEGIN
	if @nombrUsuario is not null and @contrasena is not null BEGIN
		if EXISTS(Select * from Usuario where nombreUsuario = @nombrUsuario and contrasena = @contrasena)
		BEGIN
			Select 0 as ValueResult, 'Login Success' as MSG
		END
		ELSE
		BEGIN
			select 1 as valueResult , 'Invalid credentials' as MSG
		END
	END ELSE BEGIN
		select 1 as valueResult , 'No pueden haber campos nulos' as Mensaje
		END  ---Final if validacion nulos
END
GO

-- ***************************************************************************************************
--							INGRESAR PRODUCTOS AL INVENTARIO
-- ***************************************************************************************************
/*

declare @precioVentaTotal float
EXEC spGetPriceOfProduct 1,1,1 , precioVenta OUTPUT
select @precioVentaTotal



declare @Test money


exec prTest 1,1,1,@Test output
select @Test



";
      

*/

-- EXEC spGetPriceOfProduct 1,1,1
GO

create or alter procedure spGetPriceOfProduct 
	@idLote int,	
	@idProducto int,	
	@idPaisImpuesto int,
	@precioVentaTotal money OUTPUT
as BEGIN
declare @costo money;
declare @errorInt int = 0, @errorMsg varchar(60)
	IF @idProducto is not null and @idLote is not null BEGIN
		declare @costoUnidad float;
		declare @porcentajeVenta float;
		declare @porcentajeImpuesto float;		

		set @costo = (SELECT costoUnidad from MYSQLSERVER...Lote where idLote = @idLote and idProducto = @idProducto)
		set @porcentajeVenta = (SELECT porcentajeVenta from MYSQLSERVER...Lote where idLote = @idLote and idProducto = @idProducto)
		set @porcentajeImpuesto = (SELECT porcentajeImpuesto from MYSQLSERVER...Impuesto as Impuesto
									INNER JOIN MYSQLSERVER...CategoriaXImpuesto as CategoriaXImpuesto ON CategoriaXImpuesto.idCategoriaXImpuesto = Impuesto.idImpuesto
									INNER JOIN MYSQLSERVER...CategoriaProducto as Categoria ON Categoria.idCategoria = CategoriaXImpuesto.idCategoriaXImpuesto
									WHERE Impuesto.idPais = @idPaisImpuesto)
		
		set @costoUnidad = CAST(@costo AS float)
		
		set @precioVentaTotal = CONVERT(money, (CAST(@costoUnidad AS float) *@porcentajeVenta) + CAST(@costoUnidad AS float))
		set @precioVentaTotal = CONVERT(money, (CAST(@precioVentaTotal AS float) * @porcentajeImpuesto) +CAST(@precioVentaTotal AS float))

	END ELSE BEGIN 			
		set @errorInt=1
		set @errorMsg = 'There are a null values'
	END  ---Final if validacion nulos
END
go

GO
CREATE OR ALTER PROCEDURE dbo.spInsertProductToInventory
	@idInventario int,
	@cantidad int,
	@idSucursal int,
	@idLote int,
	@precioVenta money,
	@option int				--Insertar insertarProducto nuevo 0, agregarCantidad Pedido
 	with encryption
as
BEGIN
declare @errorInt int = 0, @errorMsg varchar(60)
declare @identityValue int = -1, @aux int

--INSERT OPERATION
	IF @cantidad is not null  and @idSucursal is not null and @idLote is not null BEGIN
		IF (select count(*) from Sucursal where  idSucursal = @idSucursal) = 1 BEGIN
			IF (select count(*) from MYSQLSERVER...Lote where idLote = @idLote) = 1 BEGIN	
				BEGIN TRY
					
						declare @idPais int;
						declare @idProducto int;
						
						set @idPais = (select idPais FROM Sucursal 
										INNER JOIN Lugar ON lugar.idLugar = Sucursal.idLugar
										where Sucursal.idSucursal = @idSucursal)
						set @idProducto = (select idProducto FROM MYSQLSERVER...Lote where idLote = @idLote)
						
						--idLote, idproducto, idPais
						EXEC @aux = spGetPriceOfProduct @idLote,@idProducto,@idPais, @precioVenta OUTPUT

						
						INSERT INTO Inventario (cantidadInventario, idLote, idSucursal, precioVenta)
						VALUES (@cantidad, @idLote,@idSucursal,@precioVenta)
						
						--Actualizar Cantidad lote
						UPDATE MYSQLSERVER...Lote 
						set cantidadExistencias = (cantidadExistencias-@cantidad)
						where idLote = @idLote

					set @errorInt=0
					set @errorMsg = 'The product has inserted in the inventory'
				END TRY
				BEGIN CATCH
					set @errorInt=1
					set @errorMsg = 'There is an error in de database'
				END CATCH
			END ELSE BEGIN --Final if idCliente			
				set @errorInt=1
				set @errorMsg = 'idLote no existe'
				END
		END ELSE BEGIN 			
			set @errorInt=1
			set @errorMsg = 'idSucarsasl no existe'
			END
				
	END ELSE BEGIN 			
		set @errorInt=1
		set @errorMsg = 'There are a null values'
		END  ---Final if validacion nulos
	if @errorInt = 1
		select @errorInt as Error, @ErrorMsg as MensajeError
	IF @errorInt = 0
		select 0 as correct, @errorMsg as REsult
END

-- idInventario, cantidad, @idSucursal, @idLote, @precioVenta
-- EXEC spInsertProductToInventory null, 30, 1, 1,null, 0

GO 

CREATE OR ALTER PROCEDURE dbo.spGetCantNeed
	@idSucursal int,
	@idProducto int
with encryption
as
BEGIN
    declare @errorInt int = 0, @errorMsg varchar(60)
    BEGIN TRY
		declare @pointSucursal geometry

		declare @current int
		declare @need int

		declare @max int

		set @current = (select sum(cantidadInventario) as cantidadInventario from Inventario
		INNER JOIN Sucursal as Sucursal ON  Sucursal.idSucursal = Inventario.idSucursal
		INNER JOIN MYSQLSERVER...Lote as Lote ON Inventario.idLote = Lote.idLote
		INNER JOIN MYSQLSERVER...Producto as Producto ON  Producto.idProducto = Lote.idProducto		
		where Lote.estado = 1 and Producto.estado = 1 and Producto.idProducto = @idProducto and Sucursal.idSucursal = @idSucursal)
		
		if @current is null
			set @current = 0

		set @max = (select Limite.maxCant from MYSQLSERVER...Producto
		INNER JOIN MYSQLSERVER...Limite as Limite ON  Limite.idProducto = Producto.idProducto	
		where Producto.estado = 1 and Producto.idProducto = @idProducto) 
		set @need = @max - @current
		select @need

    END TRY
    BEGIN CATCH
        set @errorInt=1
        set @errorMsg = 'There is an error in de database'
    END CATCH
    if @errorInt !=0
        select @errorInt as Error, @ErrorMsg as MensajeError
END
GO

--  EXEC spGetBestProvider 6, 1,10

GO
CREATE OR ALTER PROCEDURE dbo.spGetBestProvider
	@idSucursal int,
	@idProducto int,
	@idNeed int
with encryption
as
BEGIN
    declare @errorInt int = 0, @errorMsg varchar(60)
    BEGIN TRY
		declare @pointSucursal geometry

		set @pointSucursal = (select Lugar.ubicacion from Sucursal
								INNER JOIN Lugar ON Lugar.idLugar = Sucursal.idLugar
								where Sucursal.idSucursal = @idSucursal);

		declare @idProvider int
		declare @idLote int
		set @idLote = (select top 1 Lote.idLote from MYSQLSERVER...Proveedor as Proveedor
		INNER JOIN MYSQLSERVER...Lote as Lote ON Lote.idProveedor = Proveedor.idProveedor
		INNER JOIN MYSQLSERVER...Producto as Producto ON Producto.idProducto = Lote.idProducto
		where Producto.idProducto = @idProducto and Lote.cantidadExistencias >= @idNeed
		ORDER BY Lote.costoUnidad ASC)

		IF @idLote is not null 
			select Proveedor.idProveedor, Proveedor.nombreProveedor, idLote from  MYSQLSERVER...Proveedor as Proveedor
			INNER JOIN MYSQLSERVER...Lote as Lote ON Lote.idProveedor = Proveedor.idProveedor			
			where Lote.idLote = @idLote 
		else
			select -1,'No exist a provider with products'

		/*SELECT TOP 1 Sucursal.idSucursal, Sucursal.nombreSucursal FROM Sucursal 
		inner join Lugar on Lugar.idLugar = Sucursal.idLugar
		ORDER BY @pointCliente.STDistance(Lugar.ubicacion) ASC;*/
    END TRY
    BEGIN CATCH
        set @errorInt=1
        set @errorMsg = 'There is an error in de database'
    END CATCH
    if @errorInt !=0
        select @errorInt as Error, @ErrorMsg as MensajeError
END

GO






GO
CREATE OR ALTER PROCEDURE dbo.spGetCortumerIdByUserName
	@nombreUsuario varchar(200)
with encryption
as
BEGIN
    declare @errorInt int = 0, @errorMsg varchar(60)
    BEGIN TRY
        SELECT Cliente.idCliente FROM Cliente
		INNER JOIN UsuarioXCliente ON UsuarioxCliente.idCliente = Cliente.idCliente
		INNER JOIN Usuario ON Usuario.nombreUsuario = UsuarioXCliente.nombreUsuario
		WHERE  UsuarioXCliente.nombreUsuario = @nombreUsuario
    END TRY
    BEGIN CATCH
        set @errorInt=1
        set @errorMsg = 'There is an error in de database'
    END CATCH
    if @errorInt !=0
        select @errorInt as Error, @ErrorMsg as MensajeError
END

GO
CREATE OR ALTER PROCEDURE dbo.spGetOtherBranches
	@idSucursal int
	with encryption
as
BEGIN
	declare @errorInt int = 0, @errorMsg varchar(60)
	BEGIN TRY
		select * from Sucursal where idSucursal != @idSucursal
	END TRY
	BEGIN CATCH
		set @errorInt=1
		set @errorMsg = 'There is an error in de database'
	END CATCH
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
END

GO
CREATE OR ALTER PROCEDURE dbo.spGetIdCustomerFromUser
	@nombreUsuario varchar(20)
	with encryption
as
BEGIN
	declare @errorInt int = 0, @errorMsg varchar(60)
	BEGIN TRY
		select Cliente.idCliente, ubicacion.STX as X, ubicacion.STY from Cliente inner join UsuarioXCliente on
		UsuarioXCliente.idCliente = Cliente.idCliente inner join Usuario on
		UsuarioXCliente.nombreUsuario = Usuario.nombreUsuario
		where Usuario.nombreUsuario = @nombreUsuario
	END TRY
	BEGIN CATCH
		set @errorInt=1
		set @errorMsg = 'There is an error in de database'
	END CATCH
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
END

GO
CREATE OR ALTER PROCEDURE dbo.spClosestPoint
	@idCliente nvarchar(20)
	with encryption
as
begin
declare @errorInt int = 0, @errorMsg varchar(20)
declare @pointCliente geometry
	
	BEGIN TRY
		set @pointCliente = (select ubicacion from Cliente where idCliente = @idCliente);

		SELECT TOP 1 Sucursal.idSucursal, Sucursal.nombreSucursal FROM Sucursal 
		inner join Lugar on Lugar.idLugar = Sucursal.idLugar
		ORDER BY @pointCliente.STDistance(Lugar.ubicacion) ASC;
	END TRY
	BEGIN CATCH
		set @errorInt=1
		set @errorMsg = 'There is an error in de database'
	END CATCH
	if @errorInt != 0
		select @errorInt as error, @errorMsg as mensaje
end

GO
CREATE OR ALTER PROCEDURE dbo.spGetProductsByBranch
    @idSucursal int
    with encryption
as
begin
declare @errorInt int = 0, @errorMsg varchar(20)

    BEGIN TRY
        select Sucursal.idSucursal, Producto.idProducto, Producto.nombreProducto, Producto.imgPath, Lote.idLote, 
		Inventario.idInventario, Inventario.precioVenta, Producto.descripcionProducto from Sucursal 
        inner join Inventario on Sucursal.idSucursal = Inventario.idSucursal inner join MYSQLSERVER...Lote on
        Lote.idLote = Inventario.idLote inner join MYSQLSERVER...Producto on Producto.idProducto = Lote.idProducto
        where Sucursal.idSucursal = @idSucursal and Inventario.cantidadInventario > 0 and Producto.estado != 0
    END TRY
    BEGIN CATCH
        set @errorInt=1
        set @errorMsg = 'There is an error in de database'
    END CATCH

    if @errorInt != 0
        select @errorInt as error, @errorMsg as mensaje
end

GO
-- PROCEDURE PARA VALIDAR QUE EXISTA EL EMPLEADO
Create or ALTER PROCEDURE spValidarEmpleado @idEmpleado int
AS
BEGIN
    If @idEmpleado is not NULL
    BEGIN
        If EXISTS (SELECT * from Empleado where idEmpleado = @idEmpleado)
        BEGIN
            Select 0 as ValueResult, 'Employee updated' as MSG
        END
        Else
        BEGIN
            select 1 as ValueResult, 'Invalid ID' as MSG
        END
    ENd
    Else
    BEGIN
        select 1 as ValueResult, 'No pueden haber campos nulos' as MSG
    ENd
END
Go

--PROCEDURE PARA ACTUALIZAR EMPLEADO
CREATE OR ALTER PROCEDURE dbo.spActualizarEmpleado
	@idEmpleado int ,
	@nombreEmpleado varchar(20),
	@apellido varchar(20),
	@foto nvarchar(Max),
	@fecha date,
	@idSucursal int,
	@idPuesto int
	with encryption
as
begin
declare @errorInt int = 0, @errorMsg varchar(60)
declare @identityValue int = -1

--INSERT OPERATION
	IF @idEmpleado is not null and @nombreEmpleado is not null  and @apellido is not null and @fecha is not null and 
	@idSucursal is not null  and @idPuesto is not null BEGIN
		BEGIN TRY

				UPDATE Empleado
				set nombreEmpleado = @nombreEmpleado , apellidoEmpleado = @apellido,fechaContratacion = @fecha
				,idPuesto = @idPuesto, fotoEmpleado = @foto,
				idSucursal = @idSucursal , estado = 1
				where idEmpleado = @idEmpleado

		END TRY
		BEGIN CATCH
			set @errorInt=1
			set @errorMsg = 'Error al agregar a la base de datos'
		END CATCH
				
	END ELSE BEGIN 			
		set @errorInt=1
		set @errorMsg = 'There are a null values'
		END  ---Final if validacion nulos
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
	else
		select 0 as correct, 'Employee Updated!' as REsult
end
GO

--PROCEDURE QUE VALIDA QUE EXISTAN LAS SUCURSALES Y PUESTOS
CREATE OR ALTER PROCEDURE dbo.spValidPuestoSucursal
	@idSucursal int,
	@idPuesto int
	with encryption
as
begin
declare @errorInt int = 0, @errorMsg varchar(60)
declare @identityValue int = -1

--INSERT OPERATION
	IF @idSucursal is not null  and @idPuesto is not null BEGIN
		BEGIN TRY

				If EXISTS(Select * from Sucursal where idSucursal = @idSucursal)
				BEGIN
					If EXISTS(Select * from Puesto where idPuesto = @idPuesto)
					begin
						set @errorInt=0
						set @errorMsg = 'Success'
					End
					Else
					BEGIN
						set @errorInt=1
						set @errorMsg = 'Invalid Puesto ID!'
					End
				END
				ELSE
				BEGIN
					set @errorInt=1
					set @errorMsg = 'Invalid Sucursal ID!'
				End

		END TRY
		BEGIN CATCH
			set @errorInt=1
			set @errorMsg = 'Error al agregar a la base de datos'
		END CATCH
				
	END ELSE BEGIN 			
		set @errorInt=1
		set @errorMsg = 'There are a null values'
		END  ---Final if validacion nulos
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
	else
		select 0 as correct, 'Sucursal and Puesto Works' as REsult
end
go

--PROCEDURE PARA INSERTAR EMPLEADO
CREATE OR ALTER PROCEDURE dbo.spInsertarEmpleado
	@nombreEmpleado varchar(20),
	@apellido varchar(20),
	@foto nvarchar(Max),
	@fecha date,
	@idSucursal int,
	@idPuesto int
	with encryption
as
begin
declare @errorInt int = 0, @errorMsg varchar(60)
declare @identityValue int = -1

--INSERT OPERATION
	IF  @nombreEmpleado is not null  and @apellido is not null and @fecha is not null and 
	@idSucursal is not null  and @idPuesto is not null and @foto is not null BEGIN
		BEGIN TRY

				insert into Empleado (nombreEmpleado,apellidoEmpleado,fotoEmpleado,fechaContratacion,idSucursal,idPuesto)
				VALUES (@nombreEmpleado,@apellido,@foto,@fecha,@idSucursal,@idPuesto)

		END TRY
		BEGIN CATCH
			set @errorInt=1
			set @errorMsg = 'Error al agregar a la base de datos'
		END CATCH
				
	END ELSE BEGIN 			
		set @errorInt=1
		set @errorMsg = 'There are a null values'
		END  ---Final if validacion nulos
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
	else
		select 0 as correct, 'Employee Inserted!' as REsult
end
GO

--PROCEDURE PARA ELIMINAR EMPLEADO
CREATE OR ALTER PROCEDURE dbo.spEliminarEmpleado
	@idEmpleado varchar(20)
	with encryption
as
begin
declare @errorInt int = 0, @errorMsg varchar(60)
declare @identityValue int = -1

--INSERT OPERATION
	IF @idEmpleado is not NULL
	BEGIN
		BEGIN TRY

				update Empleado
				set estado = 2 where idEmpleado = @idEmpleado

		END TRY
		BEGIN CATCH
			set @errorInt=1
			set @errorMsg = 'Error al eliminar de la base de datos'
		END CATCH
				
	END ELSE BEGIN 			
		set @errorInt=1
		set @errorMsg = 'There are a null values'
		END  ---Final if validacion nulos
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
	else
		select 0 as correct, 'Employee Suspended!' as REsult
end
GO

CREATE Or ALTER PROCEDURE verEmpleados
AS
BEGIN
	Select idEmpleado as idEmpleado, nombreEmpleado as Nombre, apellidoEmpleado as Apellido, fechaContratacion as FechaContratacion,Puesto.nombrePuesto as Puesto,
	Sucursal.nombreSucursal as Sucursal, fotoEmpleado as Foto from Empleado JOIN Puesto on Empleado.idPuesto = Puesto.idPuesto JOIN Sucursal on Empleado.idSucursal = Sucursal.idSucursal
	where Empleado.estado = 1;
End
GO

GO
CREATE or ALTER PROCEDURE dbo.spSelectSucursalesToView    
as
begin
declare @errorInt int = 0, @errorMsg varchar(60)
declare @identityValue int = -1

    select Sucursal.idSucursal, Sucursal.nombreSucursal as Nombre, Lugar.nombreLugar as Lugar, Sucursal.idMonedaXPais as Moneda from Sucursal as Sucursal    
    INNER JOIN Lugar as Lugar ON  Lugar.idLugar = Sucursal.idLugar

    where Sucursal.estado = 1;
end

go
create or alter procedure crudSucursal @opcion int, @idSucursal int = null, @nombre varchar(20) = null, @idLugar int =null, @idMonedaXPais int= null, @estado int = null
as
BEGIN
  declare @error int, @errorMsg varchar(20)

  if @opcion = 1
    BEGIN
    if (select count(*) from Sucursal where idSucursal = @idSucursal)=0  BEGIN
      if @nombre is not null  BEGIN
        if (select count(*) from Lugar where idLugar = @idLugar)!=0  BEGIN
          if (select count(*) from MonedaXPais where idMonedaXPais = @idMonedaXPais)!=0 BEGIN
            
            BEGIN TRY
              BEGIN transaction
                insert into Sucursal( nombreSucursal, idLugar, idMonedaXpais) 
                values(@nombre, @idLugar, @idMonedaXpais)
          
              commit transaction
            END TRY
            BEGIN CATCH
              set @error=1
              set @errorMsg = 'Error updating data base'
            END CATCH
          END ELSE BEGIN 
            set @error = 1
            set @errorMsg = 'idMonedaXPais does no exist'
          END
        END ELSE BEGIN
          set @error = 3
          set @errorMsg = 'idLugar does no exist'
        END
      END ELSE BEGIN
        set @error = 4
        set @errorMsg = 'name null'
      END
    END ELSE BEGIN
      set @error = 5
      set @errorMsg = 'idSucursal already exist'
    END
  END


  if @opcion = 2
    BEGIN
    if (select count(*) from Sucursal where idSucursal = @idSucursal)!=0 BEGIN
      BEGIN transaction
        update Sucursal
        set nombreSucursal = ISNULL(@nombre, nombreSucursal), idLugar = ISNULL(@idLugar, idLugar), idMonedaXPais = ISNULL(@idMonedaXPais, idMonedaXPais),
        estado = ISNULL(@estado, estado)where idSucursal = @idSucursal      
      commit transaction 

      END ELSE BEGIN 
        set @error = 1
        set @errorMsg = 'El idSucursal does no exist'
      END    
    END

  if @opcion = 3
    BEGIN
    if (select count(*) from Sucursal where idSucursal = @idSucursal)!=0  BEGIN
      BEGIN transaction

      select * from Sucursal where idSucursal = @idSucursal

      commit transaction

    END ELSE BEGIN 
      set @error = 1
      set @errorMsg = 'El idSucursal does no exist'
    END    
    end

  if @opcion = 4
    BEGIN
    if (select count(*) from Sucursal where idSucursal = @idSucursal)!=0 BEGIN
      BEGIN transaction
      update Sucursal
      set estado = 0 where idSucursal = @idSucursal

      commit transaction
      END
      else
    BEGIN
      set @error = 1
      set @errorMsg = 'El idSucursal does no exist' 
    end
    end
    if @error !=0
      select @error as Error, @ErrorMsg as MensajeError
    else
      select 0 as correct, 'Action completed correctly!' as Result
  
END

GO
CREATE or ALTER PROCEDURE dbo.spSelectProviderToView

as
begin
declare @errorInt int = 0, @errorMsg varchar(60)
declare @identityValue int = -1
    select Proveedor.idProveedor, nombreProveedor as Nombre, Proveedor.contacto as Contacto, Pais.nombrePais as Pais from MYSQLSERVER...Proveedor  as Proveedor
    INNER JOIN Pais as Pais ON  Pais.idPais = Proveedor.idPais
    where Proveedor.estado = 1;
end

GO
CREATE Or ALTER PROCEDURE verClientes
AS
BEGIN
    Select idCliente as idCliente, nombreCliente as Nombre, apellidoCliente as Apellido
    from Cliente
    where Cliente.estado = 1;
End
GO

go



CREATE OR ALTER PROCEDURE dbo.spBonoPerformance
    @idEmpleado varchar(20),
    @fecha date,
    @cantidad money,
    @perform varchar(60)
    with encryption
as
begin
declare @errorInt int = 0, @errorMsg varchar(60)
declare @identityValue int = -1

--INSERT OPERATION
    IF @idEmpleado is not NULL and @fecha is not null and @cantidad is not null and @perform is not null
    BEGIN
        BEGIN TRY

                insert into Bono(idEmpleado,fecha,cantidadBono,idTipoBono,performance)
                Values (@idEmpleado,@fecha,@cantidad,1,@perform)

        END TRY
        BEGIN CATCH
            set @errorInt=1
            set @errorMsg = 'Error al insertar bono en la base de datos'
        END CATCH

    END ELSE BEGIN
        set @errorInt=1
        set @errorMsg = 'There are a null values'
        END  ---Final if validacion nulos
    if @errorInt !=0
        select @errorInt as Error, @ErrorMsg as MensajeError
    else
        select 0 as correct, 'Bonus Awarded!' as REsult
end
GO

CREATE Or ALTER PROCEDURE reporteBonos
AS
BEGIN
    Select idBono as ID, nombreEmpleado as Nombre,  nombreTipoBono as NombreBono, descripcionTipoBono as TipoBono, cantidadBono as Monto, performance as Descripcion
    from Bono JOIN Empleado on Empleado.idEmpleado = Bono.idEmpleado JOIN TipoBono on TipoBono.idTipoBono = Bono.idTipoBono
End

GO
CREATE Or ALTER PROCEDURE spGetCountries
AS
BEGIN
    Select * from Pais
End
GO

GO
CREATE Or ALTER PROCEDURE spGetImpuestoxCategory
AS
BEGIN
    Select idCategoriaxImpuesto, Impuesto.nombreImpuesto as taxName, porcentajeImpuesto, nombreCategoria, descripcionCategoria,  nombrePais  from MYSQLSERVER...Impuesto as Impuesto
	INNER JOIN MYSQLSERVER...CategoriaXImpuesto as CategoriaXImpuesto ON CategoriaXImpuesto.idImpuesto = Impuesto.idImpuesto
	INNER JOIN MYSQLSERVER...CategoriaProducto as CategoriaProducto ON CategoriaProducto.idCategoria = CategoriaXImpuesto.idCategoria
	INNER JOIN Pais on Pais.idPais = Impuesto.idPais
End
GO





/*

select * from DetalleFactura

select * from Factura

INSER INTO DetalleFactura (idProducto, cantidad, idFactura)
VALUES ()


	  DECLARE @SQLString NVARCHAR(500);  
DECLARE @ParmDefinition NVARCHAR(500);  
declare @id int
set @id = 1;
SET @SQLString = 'insert into MetodoPago (nombreMetodo, otrosDetalles, estado) VALUES(''Tarjeta'', ''VISA'', '+CAST(@id as varchar)+')'
EXECUTE sp_executesql @SQLString

select * from MetodoPago

select * from DetalleFactura
select * from Factura

*/



-- EXEC spCostumerPurcharse null, 1,50000,'2021052792',4,0
-- EXEC spCostumerPurcharse null, 6,738, '2021052792',9, 0

GO
CREATE Or ALTER PROCEDURE dbo.spProductByPucharse
	@idProducto int,
	@idFactura int,
	@cant int,
	@operationFlag int
    with encryption
AS
BEGIN
    INSERT INTO DetalleFactura (idProducto, cantidad, idFactura)
	VALUES (@idProducto,@cant,@idFactura)
End
GO


GO
CREATE Or ALTER PROCEDURE spCostumerPurcharse
    @idFactura int,
    @idSucursal int,
	@montoTotal money,
	@idCliente varchar(20),
    @idMetodoPago int,
	@operationFlag int
    with encryption
AS
BEGIN
declare @errorInt int = 0, @errorMsg varchar(60)

    IF @operationFlag = 0 BEGIN
		if @idSucursal is not null and @idCliente is not null  and @idMetodoPago is not null and @montoTotal is not null BEGIN
			IF (select count(*) from Sucursal where idSucursal = @idSucursal) = 1 BEGIN
				IF (select count(*) from Cliente where idCliente = @idCliente) = 1 BEGIN
					IF (select count(*) from MetodoPago where idMetodoPago = @idMetodoPago) = 1 BEGIN
					
						BEGIN TRY
							BEGIN TRANSACTION;
								INSERT INTO Factura (fechaFactura,hora,idSucursal,montoTotal,idCliente,idMetodoPago)
								values (GETDATE(),CONVERT (TIME, GETDATE()),@idSucursal,@montoTotal,@idCliente,@idMetodoPago);
								set @idFactura = @@identity;

								set @errorInt=0
								set @errorMsg = 'The purchase was inserted correcty'
							COMMIT TRANSACTION;
	
						END TRY
						BEGIN CATCH
							set @errorInt=-1
							set @errorMsg = 'An error has ocurred try to insert into the data base'
						END CATCH		
				END ELSE BEGIN 				
					set @errorInt =-1
					set @errorMsg = 'No exits this paymentMethod'
					END						
				END ELSE BEGIN 				
					set @errorInt =1
					set @errorMsg = 'No exits this user'
					END				
			END ELSE BEGIN 			
				set @errorInt=-1
				set @errorMsg = 'No exits this branch'
				END
		END ELSE BEGIN 			
			set @errorInt=-1
			set @errorMsg = 'There are null values'
			END  ---Final if validaci�n nuloss

	END
	/*
	if @operationFlag = 1 BEGIN
		if  @idImpuesto is not null and @nombre is not null and @porcentaje is not null and @idPais is not null BEGIN
			IF (select count(*) from MYSQLSERVER...Impuesto where idImpuesto = @idImpuesto) = 1 BEGIN
				IF (select count(*) from pais where idPais = @idPais) = 1 BEGIN
							BEGIN TRY
								BEGIN TRANSACTION
								update MYSQLSERVER...Impuesto 
								set nombreImpuesto= ISNULL(@nombre, nombreImpuesto), porcentajeImpuesto = ISNULL(@porcentaje, porcentajeImpuesto),
								idPais = ISNULL(@idPais, idPais)
								where idImpuesto = @idImpuesto
							COMMIT TRANSACTION
							END TRY
							BEGIN CATCH
								set @errorInt=1
								set @errorMsg = 'Error al actualizar a la base de datos'
							END CATCH
	
				END ELSE BEGIN 				
					set @errorInt =1
					set @errorMsg = 'No existe un pais válido'
					END				
			END ELSE BEGIN 			
				set @errorInt=1
				set @errorMsg = 'NO existe un producto con este ID'
				END
		END ELSE BEGIN 			
			set @errorInt=1
			set @errorMsg = 'Hay algún valor nulo'
			END  ---Final if validaci�n nulos
	END

	if @operationFlag = 2
	begin
		select * from MYSQLSERVER...Impuesto
		where idImpuesto= @idImpuesto and estado =1;
	end

	IF @operationFlag = 3	BEGIN
		select * from MYSQLSERVER...Impuesto as Impuesto
		INNER JOIN Pais ON Pais.idPais =Impuesto.idPais
		
	END

	IF @operationFlag = 4	BEGIN
		update MYSQLSERVER...Impuesto  
		set estado = ISNULL(0, estado)
		where idImpuesto = @idImpuesto
	END
	IF @operationFlag = 5
	BEGIN
		update MYSQLSERVER...Impuesto	 
		set estado = ISNULL(1, estado)
		where idImpuesto= @idImpuesto
	END
	*/
	if @errorInt =-1
		select @errorInt as Error, @ErrorMsg as MensajeError
	if @errorInt =0
		select @idFactura as Id
End
GO

GO
CREATE Or ALTER PROCEDURE spGetPaymentMethod
AS
BEGIN
    Select * from MetodoPago
End
GO


GO
CREATE OR ALTER PROCEDURE dbo.spGetBranchesLocation
	with encryption
as
BEGIN
	declare @errorInt int = 0, @errorMsg varchar(60)
	BEGIN TRY
		select Sucursal.idSucursal, Sucursal.nombreSucursal, Lugar.ubicacion.STX as X, Lugar.ubicacion.STY as Y
		from Sucursal inner join Lugar on Sucursal.idLugar = Lugar.idLugar
	END TRY
	BEGIN CATCH
		set @errorInt=1
		set @errorMsg = 'There is an error in de database'
	END CATCH
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
END


GO
CREATE OR ALTER PROCEDURE dbo.spRemoveExpiredProducts
	with encryption
as
BEGIN
	declare @errorInt int = 0, @errorMsg varchar(60)
	declare @today date
	set @today = GETDATE()
	BEGIN TRY
		update Inventario
		set Inventario.cantidadInventario = 0
		from Inventario inner join MYSQLSERVER...Lote on Inventario.idLote = Lote.idLote
		where Lote.fechaExpiracion < @today
	END TRY
	BEGIN CATCH
		set @errorInt=1
		set @errorMsg = 'There is an error in de database'
	END CATCH
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
END


GO
CREATE OR ALTER PROCEDURE dbo.spChangeDiscount
	@descuentoPorcent float
	with encryption
as
BEGIN
	declare @errorInt int = 0, @errorMsg varchar(60)
	BEGIN TRY
		IF (select count(*) from Descuento) != 0 BEGIN
			update Descuento
			set descuentoPorcent = @descuentoPorcent
			where idDescuento = 1
		END
		ELSE BEGIN
			insert into Descuento(descuentoPorcent,nombre)
			values(@descuentoPorcent,'Descuento por expirar')
		END
	END TRY
	BEGIN CATCH
		set @errorInt=1
		set @errorMsg = 'There is an error in de database'
	END CATCH
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
END

--primero se obtienen los inventarios que estan para descuento
GO
CREATE OR ALTER PROCEDURE dbo.spGetProductsForDiscount
	with encryption
as
BEGIN
	declare @errorInt int = 0, @errorMsg varchar(60)
	declare @today date
	set @today = GETDATE()
	BEGIN TRY
		select Inventario.idInventario from Inventario 
		inner join MYSQLSERVER...Lote on Inventario.idLote = Lote.idLote 
		where Lote.fechaExpiracion > @today and DATEDIFF(DAY,@today,Lote.fechaExpiracion) < 7
	END TRY
	BEGIN CATCH
		set @errorInt=1
		set @errorMsg = 'There is an error in de database'
	END CATCH
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
END
/*
declare @today date
	set @today = GETDATE()

select ,Inventario.idInventario from Inventario 
		inner join MYSQLSERVER...Lote on Inventario.idLote = Lote.idLote 
		where DATEDIFF(DAY,Lote.fechaExpiracion,@today) < 7
*/


--
GO
CREATE OR ALTER PROCEDURE dbo.spApplyDiscount
	@idInventario int
	with encryption
as
BEGIN
	declare @errorInt int = 0, @errorMsg varchar(60)
	declare @descuentoPorcent float
	BEGIN TRY
		IF (select count(*) from DescuentoXInventario where idInventario = @idInventario) = 0 BEGIN
			set @descuentoPorcent = (select descuentoPorcent from Descuento where idDescuento = 1)
			insert into DescuentoXInventario
			values(@idInventario,1)
			update Inventario
			set precioVenta = precioVenta - (precioVenta*@descuentoPorcent)
			where idInventario = @idInventario
		end
	END TRY
	BEGIN CATCH
		set @errorInt=1
		set @errorMsg = 'There is an error in de database'
	END CATCH
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
END



GO
CREATE OR ALTER PROCEDURE dbo.spGetSucursalDropList
	with encryption
as
BEGIN
	declare @errorInt int = 0, @errorMsg varchar(60)
	declare @descuentoPorcent float
	BEGIN TRY
		SELECT idSucursal, nombreSucursal from Sucursal
	END TRY
	BEGIN CATCH
		set @errorInt=1
		set @errorMsg = 'There is an error in de database'
	END CATCH
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
END





--    EXEC spBonoPerformance 1, '2022-11-13', 5000, 'Buen trabajo'