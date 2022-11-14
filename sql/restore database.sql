
-- =============================================
--             script to drop Foreign Keys
-- =============================================
USE FERMEZA;
GO
SET NOCOUNT ON;
DECLARE @sql nvarchar(max) = N'';

SELECT @sql += N'BEGIN TRY
  ALTER TABLE ' + objectname + N'
    DROP CONSTRAINT ' + fkname + N';
END TRY
BEGIN CATCH
  SELECT N''FK ' + fkname + N' failed. Run the script again.'', 
    ERROR_MESSAGE();
END CATCH
' FROM 
(
  SELECT fkname = QUOTENAME(fk.[name]), 
    objectname = QUOTENAME(s.[name]) + N'.' + QUOTENAME(t.[name])
  FROM sys.foreign_keys AS fk
  INNER JOIN sys.objects AS t
  ON fk.parent_object_id = t.[object_id]
  INNER JOIN sys.schemas AS s
  ON t.[schema_id] = s.[schema_id]
) AS src;

SELECT @sql;
--EXEC sys.sp_executesql @sql;

-- =============================================
--             script to drop user tables
-- =============================================
USE FERMEZA;
GO
DECLARE @sql nvarchar(max) = N'';

SELECT @sql += N'BEGIN TRY
  EXEC sys.sp_executesql N''DROP TABLE ' + objectname + N';'';
END TRY
BEGIN CATCH
  SELECT N''Table ' + objectname + N' failed - run the script again.'',
    ERROR_MESSAGE();
END CATCH
' FROM
(
  SELECT QUOTENAME(s.[name]) + N'.' + QUOTENAME(o.[name])
  FROM sys.tables AS o
  INNER JOIN sys.schemas AS s 
  ON o.[schema_id] = s.[schema_id]
  WHERE o.is_ms_shipped = 0
) AS src(objectname);

SELECT @sql;
--EXEC sys.sp_executesql @sql;


-- =============================================
--             script to drop store procedures
-- =============================================
-- script to drop procedures
USE BD_PROYECTO        ;
GO
DECLARE @sql nvarchar(max) = N'';

SELECT @sql += N'BEGIN TRY
  EXEC sys.sp_executesql N''DROP PROCEDURE ' + objectname + N';'';
END TRY
BEGIN CATCH
  SELECT N''Procedure ' + objectname + N' failed - run the script again.'',
    ERROR_MESSAGE();
END CATCH
' FROM
(
  SELECT QUOTENAME(s.[name]) + N'.' + QUOTENAME(o.[name])
  FROM sys.objects AS o
  INNER JOIN sys.schemas AS s 
  ON o.[schema_id] = s.[schema_id]
  WHERE o.[type] = 'P'
  AND o.is_ms_shipped = 0
) AS src(objectname);

SELECT @sql;
--EXEC sys.sp_executesql @sql;

-- =============================================
--             script to drop all of data
-- =============================================
/*
EXEC sp_MSForEachTable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL' 
GO 

EXEC sp_MSForEachTable 'DELETE FROM ?' 
GO 

-- enable referential integrity again 
EXEC sp_MSForEachTable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL' 
GO
*/


-- =============================================
--             delete primary keys
-- =============================================
DECLARE @object_id int;
DECLARE @parent_object_id int;
DECLARE @TSQL NVARCHAR(4000);
DECLARE @COLUMN_NAME SYSNAME;
DECLARE @is_descending_key bit;
DECLARE @col1 BIT;
DECLARE @action CHAR(6);
 
--SET @action = 'DROP';
SET @action = 'CREATE';
 
DECLARE PKcursor CURSOR FOR
    select kc.object_id, kc.parent_object_id
    from sys.key_constraints kc
    inner join sys.objects o
    on kc.parent_object_id = o.object_id
    where kc.type = 'PK' and o.type = 'U'
    and o.name not in ('dtproperties','sysdiagrams')  -- not true user tables
    order by QUOTENAME(OBJECT_SCHEMA_NAME(kc.parent_object_id))
            ,QUOTENAME(OBJECT_NAME(kc.parent_object_id));
 
OPEN PKcursor;
FETCH NEXT FROM PKcursor INTO @object_id, @parent_object_id;
  
WHILE @@FETCH_STATUS = 0
BEGIN
    IF @action = 'DROP'
        SET @TSQL = 'ALTER TABLE '
                  + QUOTENAME(OBJECT_SCHEMA_NAME(@parent_object_id))
                  + '.' + QUOTENAME(OBJECT_NAME(@parent_object_id))
                  + ' DROP CONSTRAINT ' + QUOTENAME(OBJECT_NAME(@object_id))
    ELSE
        BEGIN
        SET @TSQL = 'ALTER TABLE '
                  + QUOTENAME(OBJECT_SCHEMA_NAME(@parent_object_id))
                  + '.' + QUOTENAME(OBJECT_NAME(@parent_object_id))
                  + ' ADD CONSTRAINT ' + QUOTENAME(OBJECT_NAME(@object_id))
                  + ' PRIMARY KEY'
                  + CASE INDEXPROPERTY(@parent_object_id
                                      ,OBJECT_NAME(@object_id),'IsClustered')
                        WHEN 1 THEN ' CLUSTERED'
                        ELSE ' NONCLUSTERED'
                    END
                  + ' (';
 
        DECLARE ColumnCursor CURSOR FOR
            select COL_NAME(@parent_object_id,ic.column_id), ic.is_descending_key
            from sys.indexes i
            inner join sys.index_columns ic
            on i.object_id = ic.object_id and i.index_id = ic.index_id
            where i.object_id = @parent_object_id
            and i.name = OBJECT_NAME(@object_id)
            order by ic.key_ordinal;
 
        OPEN ColumnCursor;
 
        SET @col1 = 1;
 
        FETCH NEXT FROM ColumnCursor INTO @COLUMN_NAME, @is_descending_key;
        WHILE @@FETCH_STATUS = 0
        BEGIN
            IF (@col1 = 1)
                SET @col1 = 0
            ELSE
                SET @TSQL = @TSQL + ',';
 
            SET @TSQL = @TSQL + QUOTENAME(@COLUMN_NAME)
                      + ' '
                      + CASE @is_descending_key
                            WHEN 0 THEN 'ASC'
                            ELSE 'DESC'
                        END;
 
            FETCH NEXT FROM ColumnCursor INTO @COLUMN_NAME, @is_descending_key;
        END;
 
        CLOSE ColumnCursor;
        DEALLOCATE ColumnCursor;
 
        SET @TSQL = @TSQL + ');';
 
        END;
 
    PRINT @TSQL;
 
    FETCH NEXT FROM PKcursor INTO @object_id, @parent_object_id;
END;
 
CLOSE PKcursor;
DEALLOCATE PKcursor;

BEGIN TRY    ALTER TABLE [dbo].[MonedaXPais]      DROP CONSTRAINT [FK__MonedaXPa__idPai__1B7E091A];  END TRY  BEGIN CATCH    SELECT N'FK [FK__MonedaXPa__idPai__1B7E091A] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[MonedaXPais]      DROP CONSTRAINT [FK__MonedaXPa__idMon__1C722D53];  END TRY  BEGIN CATCH    SELECT N'FK [FK__MonedaXPa__idMon__1C722D53] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[Lugar]      DROP CONSTRAINT [FK__Lugar__idPais__2042BE37];  END TRY  BEGIN CATCH    SELECT N'FK [FK__Lugar__idPais__2042BE37] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[Sucursal]      DROP CONSTRAINT [FK__Sucursal__idLuga__26EFBBC6];  END TRY  BEGIN CATCH    SELECT N'FK [FK__Sucursal__idLuga__26EFBBC6] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[Sucursal]      DROP CONSTRAINT [FK__Sucursal__idMone__27E3DFFF];  END TRY  BEGIN CATCH    SELECT N'FK [FK__Sucursal__idMone__27E3DFFF] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[Empleado]      DROP CONSTRAINT [FK__Empleado__idPues__2BB470E3];  END TRY  BEGIN CATCH    SELECT N'FK [FK__Empleado__idPues__2BB470E3] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[Empleado]      DROP CONSTRAINT [FK__Empleado__idSucu__2CA8951C];  END TRY  BEGIN CATCH    SELECT N'FK [FK__Empleado__idSucu__2CA8951C] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[Factura]      DROP CONSTRAINT [FK__Factura__idSucur__4C214075];  END TRY  BEGIN CATCH    SELECT N'FK [FK__Factura__idSucur__4C214075] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[Factura]      DROP CONSTRAINT [FK__Factura__idEmple__4D1564AE];  END TRY  BEGIN CATCH    SELECT N'FK [FK__Factura__idEmple__4D1564AE] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[Factura]      DROP CONSTRAINT [FK__Factura__idClien__4E0988E7];  END TRY  BEGIN CATCH    SELECT N'FK [FK__Factura__idClien__4E0988E7] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  BEGIN TRY    ALTER TABLE [dbo].[Factura]      DROP CONSTRAINT [FK__Factura__idMetod__4EFDAD20];  END TRY  BEGIN CATCH    SELECT N'FK [FK__Factura__idMetod__4EFDAD20] failed. Run the script again.',       ERROR_MESSAGE();  END CATCH  

BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[Moneda];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[Moneda] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[Pais];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[Pais] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[MonedaXPais];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[MonedaXPais] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[Lugar];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[Lugar] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[Puesto];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[Puesto] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[Sucursal];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[Sucursal] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[Empleado];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[Empleado] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[Usuario];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[Usuario] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[Cliente];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[Cliente] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[MetodoPago];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[MetodoPago] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[Factura];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[Factura] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP TABLE [dbo].[TipoBono];';  END TRY  BEGIN CATCH    SELECT N'Table [dbo].[TipoBono] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  
