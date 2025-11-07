
--CREACION DE ESQUEMAS PARA LA BASE DE DATOS

CREATE SCHEMA Inventario AUTHORIZATION db_owner;

ALTER SCHEMA Inventario TRANSFER InstrumentoMedico;
ALTER SCHEMA Inventario TRANSFER Bodega;
ALTER SCHEMA Inventario TRANSFER Medicamento;
ALTER SCHEMA Inventario TRANSFER Analgesico;

CREATE SCHEMA Contabilidad AUTHORIZATION db_owner;

ALTER SCHEMA Contabilidad TRANSFER MetodoPago;
ALTER SCHEMA Contabilidad TRANSFER Factura;

CREATE SCHEMA Clinica AUTHORIZATION db_owner;

ALTER SCHEMA Clinica TRANSFER Tratamiento;
ALTER SCHEMA Clinica TRANSFER Cita;
ALTER SCHEMA Clinica TRANSFER Medico;
ALTER SCHEMA Clinica TRANSFER DepaXMed;
ALTER SCHEMA Clinica TRANSFER Paciente;

CREATE SCHEMA Administracion AUTHORIZATION db_owner;

ALTER SCHEMA Administracion TRANSFER Departamento;

SELECT name
FROM sys.schemas


SELECT s.name AS Esquema, 
o.name AS Objeto, 
o.type_desc AS Tipo
FROM sys.objects o
JOIN sys.schemas s ON o.schema_id= s.schema_id
WHERE s.name LIKE 'Inventario' AND o.type_desc LIKE 'USER_TABLE'
ORDER BY s.name

SELECT s.name AS Esquema, 
o.name AS Objeto, 
o.type_desc AS Tipo
FROM sys.objects o
JOIN sys.schemas s ON o.schema_id= s.schema_id
WHERE s.name LIKE 'Contabilidad' AND o.type_desc LIKE 'USER_TABLE'
ORDER BY s.name

SELECT s.name AS Esquema, 
o.name AS Objeto, 
o.type_desc AS Tipo
FROM sys.objects o
JOIN sys.schemas s ON o.schema_id= s.schema_id
WHERE s.name LIKE 'Clinica' AND o.type_desc LIKE 'USER_TABLE'
ORDER BY s.name

SELECT s.name AS Esquema, 
o.name AS Objeto, 
o.type_desc AS Tipo
FROM sys.objects o
JOIN sys.schemas s ON o.schema_id= s.schema_id
WHERE s.name LIKE 'Administracion' AND o.type_desc LIKE 'USER_TABLE'
ORDER BY s.name