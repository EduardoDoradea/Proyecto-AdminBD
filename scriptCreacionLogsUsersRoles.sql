
-- SCRIPT DE CREACION DE LOGINS - USUARIOS - ROLES

--CREACION DE LOGINS (Estos se crean a nivel de servidor es decir globalmente)
--CREACION DE TODOS LOS LOGINS 
USE master

CREATE LOGIN L_Medico
WITH PASSWORD = 'D!@gn0s1s101!',
CHECK_POLICY = ON,
CHECK_EXPIRATION = OFF;

CREATE LOGIN L_Secretaria
WITH PASSWORD = 'Ag3nd@$F@ctura%',
CHECK_POLICY = ON,
CHECK_EXPIRATION = OFF;

CREATE LOGIN L_Farmaceutico
WITH PASSWORD = 'D0s1s#M3d1c@l7',
CHECK_POLICY = ON,
CHECK_EXPIRATION = OFF;

CREATE LOGIN L_Auxiliar_Bodega
WITH PASSWORD = '!nv3nt@r1oC4ja$',
CHECK_POLICY = ON,
CHECK_EXPIRATION = OFF;

CREATE LOGIN L_Ingeniero
WITH PASSWORD = 'S!st3m@s&DBK3y',
CHECK_POLICY = ON,
CHECK_EXPIRATION = OFF;

CREATE LOGIN L_Operador
WITH PASSWORD = 'Aud!tAcc3s0#44',
CHECK_POLICY = ON,
CHECK_EXPIRATION = OFF;

CREATE LOGIN L_Administrador
WITH PASSWORD = 'C0ntr0lT0t@l$24',
CHECK_POLICY = ON,
CHECK_EXPIRATION = OFF;

--CREACION DE USUARIOS EN BASE DE DATOS (Los usuarios se crean en la base de datos que se utilizara)
USE DB_Hospital

CREATE USER U_Medico FOR LOGIN L_Medico;
CREATE USER U_Secretaria FOR LOGIN L_Secretaria;
CREATE USER U_Farmaceutico FOR LOGIN L_Farmaceutico;
CREATE USER U_Auxiliar_Bodega FOR LOGIN L_Auxiliar_Bodega;
CREATE USER U_Ingeniero FOR LOGIN L_Ingeniero;
CREATE USER U_Administrador FOR LOGIN L_Administrador;
CREATE USER U_Operador FOR LOGIN L_Operador;

--CREACION DE ROLES
CREATE ROLE R_Medico;
CREATE ROLE R_Secretaria;
CREATE ROLE R_Farmaceutico;
CREATE ROLE R_Auxiliar_Bodega;
CREATE ROLE R_Ingeniero;
CREATE ROLE R_Operador;

--LE ASIGNAMOS QUE PRIVILEGIOS PUEDE REALIZAR EN QUE TABLAS AL ROLE CREADO ANTERIORMENTE
USE DB_Hospital

--PRIVILEGIOS PARA EL ROL DE MEDICO
GRANT SELECT ON Inventario.Medicamento TO R_Medico;
GRANT SELECT ON Inventario.Analgesico TO R_Medico;
GRANT SELECT ON Clinica.Cita TO R_Medico;
GRANT SELECT ON Clinica.Paciente TO R_Medico;
GRANT SELECT ON Administracion.Departamento TO R_Medico;
GRANT SELECT, INSERT, UPDATE, DELETE ON Clinica.Tratamiento TO R_Medico;

--PROBANDOLOS
EXECUTE AS USER = 'U_Medico';

--SIN ERROR
select * from Inventario.Medicamento
select * from Inventario.Analgesico
select * from Clinica.Cita
select * from Clinica.Paciente
select * from Administracion.Departamento
select * from Clinica.Tratamiento

--CON ERROR
select * from Inventario.Bodega

REVERT

--PRIVILEGIOS PARA EL ROL DE FARMACEUTICO
GRANT SELECT ON Inventario.InstrumentoMedico TO R_Farmaceutico;
GRANT SELECT ON Inventario.Bodega TO R_Farmaceutico;
GRANT SELECT, INSERT, UPDATE, DELETE ON Inventario.Medicamento TO R_Farmaceutico;
GRANT SELECT, INSERT, UPDATE, DELETE ON Inventario.Analgesico TO R_Farmaceutico;

--PROBANDOLOS
--SIN ERROR
EXECUTE AS USER = 'U_Farmaceutico';
select * from Inventario.InstrumentoMedico
select * from Inventario.Bodega
select * from Inventario.Medicamento
select * from Inventario.Analgesico

--CON ERROR
select * from Clinica.Tratamiento

REVERT

--PRIVILEGIOS PARA EL ROL DE SECRETARIA
GRANT SELECT, INSERT, UPDATE, DELETE ON Clinica.Cita TO R_Secretaria;
GRANT SELECT, INSERT, UPDATE, DELETE ON Contabilidad.MetodoPago TO R_Secretaria;
GRANT SELECT, INSERT, UPDATE, DELETE ON Contabilidad.Factura TO R_Secretaria;
GRANT SELECT, INSERT, UPDATE, DELETE ON Clinica.Paciente TO R_Secretaria;
GRANT SELECT ON Clinica.Tratamiento TO R_Secretaria;
GRANT SELECT ON Clinica.Medico TO R_Secretaria;
GRANT SELECT ON Administracion.Departamento TO R_Secretaria;

--FALTA PROBARLOS
EXECUTE AS USER = 'U_Secretaria';


REVERT

--PRIVILEGIOS PARA EL ROL DE AUXILIAR_BODEGA
GRANT SELECT ON Inventario.Medicamento TO R_Auxiliar_Bodega;
GRANT SELECT ON Inventario.Analgesico TO R_Auxiliar_Bodega;
GRANT SELECT, INSERT, UPDATE, DELETE ON Inventario.InstrumentoMedico TO R_Auxiliar_Bodega;
GRANT SELECT, INSERT, UPDATE, DELETE ON Inventario.Bodega TO R_Auxiliar_Bodega;

--FALTA PROBARLOS 
EXECUTE AS USER = 'U_Auxiliar_Bodega';


REVERT

--AGREGAMOS MIEMBROS A ESE ROL CREADO
--EXEC sp_addrolemember 'rol', 'usuario'; Si quieren colocarlo con el procedimiento almacenado de caso contrario con alter role add member
EXEC sp_addrolemember 'R_Medico', 'U_Medico'
EXEC sp_addrolemember 'R_Secretaria', 'U_Secretaria'
EXEC sp_addrolemember 'R_Farmaceutico', 'U_Farmaceutico'
EXEC sp_addrolemember 'R_Auxiliar_Bodega', 'U_Auxiliar_Bodega'
EXEC sp_addrolemember 'R_Ingeniero', 'U_Ingeniero'
EXEC sp_addrolemember 'R_Administrador', 'U_Administrador'
EXEC sp_addrolemember 'R_Operador', 'U_Operador'


