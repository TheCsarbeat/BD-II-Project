
-- Creación de cruds

-- Sucursal
-- opcion 1: insertar, opcion 2: actualizar, opcion 3: consultar, opcion 4: borrar
go
create or alter procedure crudSucursal @opcion int, @idSucursal int =NULL, @nombre varchar(20), @idLugar int, @idMonedaXPais int
as
BEGIN
	declare @error int, @errorMsg varchar(20)

	if @opcion = 1
		BEGIN
		if (select count(*) from Sucursal where idSucursal = @idSucursal)=0	BEGIN
			if @nombre is not null	BEGIN
				if (select count(*) from Lugar where idLugar = @idLugar)!=0	BEGIN
					if (select count(*) from MonedaXPais where idMonedaXPais = @idMonedaXPais)!=0 BEGIN
						
						BEGIN TRY
							BEGIN transaction
								insert into Sucursal( nombreSucursal, idLugar, idMonedaXpais) 
								values(@nombre, @idLugar, @idMonedaXpais)
					
							commit transaction
						END TRY
						BEGIN CATCH
							set @error=1
							set @errorMsg = 'Error al actualizar a la base de datos'
						END CATCH
					END ELSE BEGIN 
						set @error = 1
						set @errorMsg = 'La idMonedaXPais no existe'
					END
				END ELSE BEGIN
					set @error = 3
					set @errorMsg = 'El idLugar no existe'
				END
			END ELSE BEGIN
				set @error = 4
				set @errorMsg = 'nombre nulo'
			END
		END ELSE BEGIN
			set @error = 5
			set @errorMsg = 'idSucursal ya existe'
		END
	END


	if @opcion = 2
		BEGIN
		if (select count(*) from Sucursal where idSucursal = @idSucursal)!=0 BEGIN
			BEGIN transaction
				update Sucursal
				set nombreSucursal = ISNULL(@nombre, nombreSucursal), idLugar = ISNULL(@idLugar, idLugar), idMonedaXPais = ISNULL(@idMonedaXPais, idMonedaXPais)
				where idSucursal = @idSucursal			
			commit transaction 

			END ELSE BEGIN 
				set @error = 1
				set @errorMsg = 'El idSucursal no existe'
			END
		
		END

	if @opcion = 3
		BEGIN
		if (select count(*) from Sucursal where idSucursal = @idSucursal)!=0	BEGIN
			BEGIN transaction

			select * from Sucursal where idSucursal = @idSucursal

			commit transaction

		END ELSE BEGIN 
			set @error = 1
			set @errorMsg = 'El idSucursal no existe'
		END
		
		END

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
			set @errorMsg = 'El idSucursal no existe'
		
		END
	END
		select @error as error, @errorMsg as mensaje
	
END

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
		select 1 as valueResult, 'Funcion hecha sin problema' as Mensaje
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
	ELSE 
		select 1 as valueResult, 'Funcion hecha sin problema' as Mensaje
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
			Select 1 as ValueResult, 'Invalid credentials' as MSG
		END
	END ELSE BEGIN
		select 1 as ValueResult, 'No pueden haber campos nulos' as Mensaje
		END  ---Final if validacion nulos
END


-- ***************************************************************************************************
--							INGRESAR PRODUCTOS AL INVENTARIO
-- ***************************************************************************************************
GO
CREATE OR ALTER PROCEDURE dbo.spGetPriceOfProduct
	
	@idLote int,	
	@idProducto int,	
	@idPaisImpuesto int
	
 	with encryption
as
BEGIN
declare @errorInt int = 0, @errorMsg varchar(60)


--INSERT OPERATION
	IF @idProducto is not null and @idLote is not null BEGIN
		declare @costoUnidad money;
		declare @procentajeVenta float;
		declare @procentajeImpuesto float;
		declare @precioVentaTotal money;

		set @costoUnidad = (SELECT costoUnidad from MYSQLSERVER...Lote where idLote = @idLote and idProducto = @idProducto)
		set @procentajeVenta = (SELECT porcentajeVenta from MYSQLSERVER...Lote where idLote = @idLote and idProducto = @idProducto)
		set @procentajeImpuesto = (SELECT porcentajeImpuesto from MYSQLSERVER...Impuesto as Impuesto
									INNER JOIN MYSQLSERVER...CategoriaXImpuesto as CategoriaXImpuesto ON CategoriaXImpuesto.idCategoriaXImpuesto = Impuesto.idImpuesto
									INNER JOIN MYSQLSERVER...CategoriaProducto as Categoria ON Categoria.idCategoria = CategoriaXImpuesto.idCategoriaXImpuesto
									WHERE Impuesto.idPais = @idPaisImpuesto)
		
		set @precioVentaTotal = (@costoUnidad *@procentajeVenta) +@costoUnidad
		set @precioVentaTotal = (@precioVentaTotal * @procentajeImpuesto) +@precioVentaTotal
		
		
	END ELSE BEGIN 			
		set @errorInt=1
		set @errorMsg = 'There are a null values'
		END  ---Final if validacion nulos
	if @errorInt !=0
		RETURN 0
	else
		RETURN @precioVentaTotal 
END


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
declare @identityValue int = -1

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
						EXEC @precioVenta = spGetPriceOfProduct @idLote,@idProducto,@idPais
					
						INSERT INTO Inventario (cantidadInventario, idLote, idSucursal, precioVenta)
						VALUES (@cantidad, @idLote,@idSucursal,@precioVenta)
					
				END TRY
				BEGIN CATCH
					set @errorInt=1
					set @errorMsg = 'Error al agregar a la base de datos'
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
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
	else
		select 0 as correct, 'The user has sign up succesfuly' as REsult
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
        set @errorMsg = 'Error al agregar a la base de datos'
    END CATCH
    if @errorInt !=0
        select @errorInt as Error, @ErrorMsg as MensajeError
END

GO 
CREATE OR ALTER PROCEDURE dbo.spGetProfits
	@fechaInicial date,
	@fechaFinal date,
	@idPais int,
	@idSucursal int,
	@idCategoriaProducto int
with encryption
as
BEGIN
    declare @errorInt int = 0, @errorMsg varchar(60)
    BEGIN TRY
        SELECT Producto.nombreProducto, Factura.fechaFactura, Pais.nombrePais, Sucursal.nombreSucursal, Categoria.nombreCategoria from Factura
		INNER JOIN DetalleFactura ON DetalleFactura.idFactura = Factura.idFactura
		INNER JOIN MYSQLSERVER...Producto as Producto ON  Producto.idProducto = DetalleFactura.idProducto
		INNER JOIN MYSQLSERVER...CategoriaProducto as Categoria ON Categoria.idCategoria = Producto.idCategoria
		INNER JOIN Sucursal ON Sucursal.idSucursal = Factura.idSucursal
		INNER JOIN Lugar ON Lugar.idLugar = Sucursal.idLugar
		INNER JOIN Pais ON Pais.idPais = Lugar.idPais
		WHERE Factura.fechaFactura >= ISNULL (@fechaInicial,Factura.fechaFactura) and Factura.fechaFactura <=ISNULL (@fechaFinal,Factura.fechaFactura) AND
		Pais.idPais = ISNULL(@idPais, PAis.idPais) and Sucursal.idSucursal = ISNULL(@idSucursal, Sucursal.idSucursal) and 
		Categoria.idCategoria = ISNULL(@idCategoriaProducto, Categoria.idCategoria)
    END TRY
    BEGIN CATCH
        set @errorInt=1
        set @errorMsg = 'Error al agregar a la base de datos'
    END CATCH
    if @errorInt !=0
        select @errorInt as Error, @ErrorMsg as MensajeError
END

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
        set @errorMsg = 'Error al agregar a la base de datos'
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
		set @errorMsg = 'Error al agregar a la base de datos'
	END CATCH
	if @errorInt !=0
		select @errorInt as Error, @ErrorMsg as MensajeError
END

GO
CREATE OR ALTER PROCEDURE dbo.spGetIdCustomerFromUser
	@nombreUsuario varchar(50)
	with encryption
as
BEGIN
	declare @errorInt int = 0, @errorMsg varchar(60)
	BEGIN TRY
		select Cliente.idCliente from Cliente inner join UsuarioXCliente on
		UsuarioXCliente.idCliente = Cliente.idCliente inner join Usuario on
		UsuarioXCliente.nombreUsuario = Usuario.nombreUsuario where Usuario.nombreUsuario = @nombreUsuario
	END TRY
	BEGIN CATCH
		set @errorInt=1
		set @errorMsg = 'Error al agregar a la base de datos'
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
		set @errorMsg = 'Error al agregar a la base de datos'
	END CATCH
	if @errorInt != 0
		select @errorInt as error, @errorMsg as mensaje
end

/*
GO
CREATE OR ALTER PROCEDURE dbo.spGetProductsByBranch
	@idSucursal int
	with encryption
as
begin
declare @errorInt int = 0, @errorMsg varchar(20)
	
	BEGIN TRY
		select Producto.nombreProducto, Producto.imgPath, Lote.idLote, Inventario.idInventario from Sucursal 
		inner join Inventario on Sucursal.idSucursal = Inventario.idSucursal inner join MYSQLSERVER...Lote on
		Lote.idLote = Inventario.idLote inner join MYSQLSERVER...Producto on Producto.idProducto = Lote.idProducto
		where Sucursal.idSucursal = @idSucursal
	END TRY
	BEGIN CATCH
		set @errorInt=1
		set @errorMsg = 'Error al agregar a la base de datos'
	END CATCH

	if @errorInt != 0
		select @errorInt as error, @errorMsg as mensaje
end
*/
-- idInventario, cantidad, @idSucursal, @idLote, @precioVenta
-- EXEC spInsertProductToInventory null, 30, 1, 1,null, 0


SELECT * FROM MYSQLSERVER...Producto
WHERE idProducto