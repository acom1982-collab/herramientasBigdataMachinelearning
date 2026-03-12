-- =============================================
-- FASE 1: Preparación (Estructura inicial del Lake)
-- Nota: La importación del CSV se hace mediante el asistente de DBeaver,
-- pero esta es la tabla que se crea internamente.
-- =============================================

-- (Opcional) Si necesitas borrar para reintentar:
-- DROP TABLE IF EXISTS Datalake.dbo.Db_Departamentos;

-- =============================================
-- FASE 2: Análisis de Longitudes (Optimización)
-- Ejecutamos esto para saber el tamaño real de los datos antes de crear el House.
-- =============================================

-- Consultar la longitud máxima del nombre del departamento
SELECT MAX(LEN(Nom_DPTO)) AS Max_Longitud_Nombre 
FROM Datalake.dbo.Db_Departamentos;

-- Consultar la longitud máxima del código del departamento
SELECT MAX(LEN(Cod_DPTO)) AS Max_Longitud_Codigo 
FROM Datalake.dbo.Db_Departamentos;


-- =============================================
-- FASE 3: Transformación al Data House (Carga Final)
-- Aquí creamos la tabla optimizada y movemos los datos.
-- =============================================

-- 1. Crear la tabla en el Datahouse con tipos de datos optimizados
CREATE TABLE Datahouse.dbo.DIM_Departamentos (
    Cod_DPTO TINYINT,          -- Optimizado: El código es un número pequeño
    Nom_DPTO VARCHAR(50)       -- Optimizado: Ajustado según el análisis de la Fase 2
);

-- 2. Proceso ETL (Carga de datos del Lake al House)
INSERT INTO Datahouse.dbo.DIM_Departamentos (Cod_DPTO, Nom_DPTO)
SELECT Cod_DPTO, Nom_DPTO 
FROM Datalake.dbo.Db_Departamentos;

-- 3. Verificación de la carga
SELECT * FROM Datahouse.dbo.DIM_Departamentos;

-- =============================================
-- LIMPIEZA (Opcional)
-- Usar solo si se necesita reiniciar el proceso de carga
-- =============================================
-- DELETE FROM Datahouse.dbo.DIM_Departamentos;