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
--Que tipo de audits quiero vigilar, que metodo DML o DDL a nivel base de datos o nivel de servidor quiero guardar registros 
ADD(FAILED_LOGIN_GROUP),
ADD(SUCESSFULL_LOGIN_GROUP),
ADD(DATABASE_OPERATION_GROUP),
ADD(CREATE, DROP ON SCHEMA::dbo BY PUBLIC)
/*NOTA ME FALTA AGREGAR OTROS AUDITS, NO CREAR EL AUDIT SPECIFICATION, SI LO CREARON, LUEGO LO ELIMINAN Y VUELVEN A CREAR atte: edu:( */

-- Activar la auditoría a nivel base de datos
ALTER DATABASE AUDIT SPECIFICATION AuditoriaHospital 
WITH (STATE = ON);
