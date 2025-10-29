
--CREACION DE ESQUEMAS PARA LA BASE DE DATOS 

CREATE SCHEMA Inventario;
	
ALTER SCHEMA Inventario TRANSFER InstrumentoMedico;
ALTER SCHEMA Inventario TRANSFER InstrumentoMedico;
ALTER SCHEMA Inventario TRANSFER InstrumentoMedico;
ALTER SCHEMA Inventario TRANSFER InstrumentoMedico;

CREATE SCHEMA Contabilidad;

ALTER SCHEMA Contabilidad TRANSFER MetodoPago;
ALTER SCHEMA Contabilidad TRANSFER Factura;

CREATE SCHEMA Clinica;

ALTER SCHEMA Clinica TRANSFER Tratamiento;
ALTER SCHEMA Clinica TRANSFER Cita;
ALTER SCHEMA Clinica TRANSFER Medico;
ALTER SCHEMA Clinica TRANSFER DepaXMed;
ALTER SCHEMA Clinica TRANSFER Paciente;

CREATE SCHEMA Administracion;

ALTER SCHEMA Administracion TRANSFER Departamento;




SELECT name
FROM sys.sysusers
WHERE name LIKE 'R_'