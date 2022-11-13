
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
USE FERMEZA    ;
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
USE FERMEZA    ;
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
GO*/


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



BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[crudSucursal];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[crudSucursal] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[crudEmpleado];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[crudEmpleado] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[crudPerformance];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[crudPerformance] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[crudBono];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[crudBono] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[crudHorario];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[crudHorario] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[crudMonedaXPais];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[crudMonedaXPais] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[insertMoneda];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[insertMoneda] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[insertPais];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[insertPais] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[insertMonedaXPais];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[insertMonedaXPais] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[insertLugar];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[insertLugar] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[insertPuesto];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[insertPuesto] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[insertEmpleado];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[insertEmpleado] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[insertInventario];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[insertInventario] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[insertHorario];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[insertHorario] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[insertSucursal];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[insertSucursal] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spSignUpCostumer];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spSignUpCostumer] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spUser];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spUser] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spCliente];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spCliente] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spLoginCostumer];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spLoginCostumer] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spCrudCategoriaProducto];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spCrudCategoriaProducto] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  BEGIN TRY    EXEC sys.sp_executesql N'DROP PROCEDURE [dbo].[spCrudProducto];';  END TRY  BEGIN CATCH    SELECT N'Procedure [dbo].[spCrudProducto] failed - run the script again.',      ERROR_MESSAGE();  END CATCH  