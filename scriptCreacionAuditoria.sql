USE master

CREATE SERVER AUDIT AuditoriaHospital
TO FILE(FILEPATH = 'C:\SQLAudit\AuditoriaHospital', MAXSIZE = 512 MB, MAX_FILES = 10)
WITH (ON_FAILURE = CONTINUE);

--Activando auditoria
ALTER SERVER AUDIT AuditoriaHospital WITH(STATE=ON);

--Auditoria a nivel de base de datos
USE DB_Hospital

CREATE DATABASE AUDIT SPECIFICATION AuditoriaHospital
FOR SERVER AUDIT AuditoriaHospital
ADD(DATABASE_OPERATION_GROUP),
--REGISTROS DE LO QUE HA REALIZADO EL ROL DE MEDICO
ADD(SELECT ON OBJECT::Inventario.Medicamento BY R_Medico),
ADD(SELECT ON OBJECT::Inventario.Analgesico BY R_Medico),
ADD(SELECT, INSERT, UPDATE, DELETE ON OBJECT::Clinica.Tratamiento BY R_Medico),
ADD(SELECT ON OBJECT::Clinica.Paciente BY R_Medico),
ADD(SELECT ON OBJECT::Administracion.Departamento BY R_Medico),
--Aqui se le dice registra los metodos dml del rol medico sobre el esquema completo de clinica 
--(se podria hacer tambien para los demas esquemas)
ADD(SELECT, INSERT, UPDATE, DELETE ON OBJECT::Clinica BY R_Medico), 
--REGISTROS DE LO QUE HA REALIZADO EL ROL DE SECRETARIA
ADD(SELECT ON OBJECT::Clinica.Tratamiento BY R_Secretaria),
ADD(SELECT, INSERT, UPDATE, DELETE ON OBJECT::Clinica.Cita BY R_Secretaria),
ADD(SELECT, INSERT, UPDATE, DELETE ON OBJECT::Contabilidad.Factura BY R_Secretaria),
ADD(SELECT, INSERT, UPDATE, DELETE ON OBJECT::Contabilidad.MetodoPago BY R_Secretaria),
ADD(SELECT ON OBJECT::Clinica.Medico BY R_Secretaria),
ADD(SELECT, INSERT, UPDATE, DELETE ON OBJECT::Clinica.Paciente BY R_Secretaria),
ADD(SELECT ON OBJECT::Administracion.Departamento BY R_Secretaria),
--REGISTROS DE LO QUE REALIZA EL ROL DE FARMACEUTICO
ADD(SELECT ON OBJECT::Inventario.InstrumentoMedico BY R_Farmaceutico),
ADD(SELECT ON OBJECT::Inventario.Bodega BY R_Farmaceutico),
ADD(SELECT, INSERT, UPDATE, DELETE ON OBJECT::Inventario.Analgesico BY R_Farmaceutico),
ADD(SELECT, INSERT, UPDATE, DELETE ON OBJECT::Inventario.Medicamento BY R_Farmaceutico),
--REGISTROS DE LO QUE REALIZA EL ROL DE AUXILIAR_BODEGA
ADD(SELECT, INSERT, UPDATE, DELETE ON OBJECT::Inventario.InstrumentoMedico BY R_Auxiliar_Bodega),
ADD(SELECT, INSERT, UPDATE, DELETE ON OBJECT::Inventario.Bodega BY R_Auxiliar_Bodega),
ADD(SELECT ON OBJECT::Inventario.Medicamento BY R_Auxiliar_Bodega),
ADD(SELECT ON OBJECT::Inventario.Analgesico BY R_Auxiliar_Bodega);


-- Activar la auditoría a nivel base de datos
ALTER DATABASE AUDIT SPECIFICATION AuditoriaHospital 
WITH (STATE = ON);

SELECT event_time, server_principal_name, database_name, database_principal_name, schema_name, object_name, statement
FROM sys.fn_get_audit_file('C:\SQLAudit\AuditoriaHospital\*.sqlaudit', DEFAULT, DEFAULT);


