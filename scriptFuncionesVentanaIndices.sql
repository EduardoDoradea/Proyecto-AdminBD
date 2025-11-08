
/*CREACION DE FUNCIONES VENTANA E INDICES EN EL MISMO SCRIPT*/
--Activando los tiempos de ejecucion 
SET STATISTICS TIME ON 
SET STATISTICS IO ON

--REALIZADA
-- 1 pacientes con mas servicios han solicitado
SELECT pa.nombre, pa.apellido, ci.especialidad,
COUNT(ci.idCita) citasRealizadas,
DENSE_RANK() OVER(PARTITION BY ci.especialidad ORDER BY COUNT(ci.idCita)DESC) rankingPacienteServicios
FROM Clinica.Paciente AS pa
JOIN Clinica.Cita AS ci ON pa.idPaciente = ci.idPaciente
GROUP BY pa.nombre, pa.apellido, ci.especialidad

SET STATISTICS TIME OFF 
SET STATISTICS IO OFF

-- INDICES 
CREATE NONCLUSTERED INDEX IX_ClinicaPaciente_NonClustered
ON Clinica.Paciente (nombre, apellido);

CREATE NONCLUSTERED INDEX IX_ClinicaCitaPa_NonClustered
ON Clinica.Cita (especialidad, idCita, idPaciente);

SET STATISTICS TIME ON 
SET STATISTICS IO ON

--REALIZADA
-- 2 medicos que mas servicios han brindado
SELECT med.nombre, 
COUNT(ci.idCita) tratamientosMedico,
DENSE_RANK() OVER(ORDER BY COUNT(ci.idCita)DESC) rankingMedicoServicios
FROM Clinica.Cita AS ci
JOIN Clinica.Medico AS med ON ci.idMedico = med.idMedico
GROUP BY med.nombre

SET STATISTICS TIME OFF 
SET STATISTICS IO OFF

-- INDICES
CREATE NONCLUSTERED INDEX IX_ClinicaMedico_NonClustered
ON Clinica.Medico (nombre);

CREATE NONCLUSTERED INDEX IX_ClinicaCitaMed_NonClustered
ON Clinica.Cita (idCita, idMedico);

SET STATISTICS TIME ON 
SET STATISTICS IO ON

-- 3 cuales son los analgesicos mas solicitados
SELECT an.tipo, 
COUNT(tr.idTratamiento) tipoAnalgesicoSolicitado,
ROW_NUMBER() OVER(ORDER BY COUNT(tr.idTratamiento)DESC) ranking
FROM Clinica.Tratamiento AS tr
JOIN Inventario.Medicamento AS medi ON tr.idMedicamento = medi.idMedicamento
JOIN Inventario.Analgesico as an ON medi.idAnalgesico = an.idAnalgesico
GROUP BY an.tipo

SET STATISTICS TIME OFF 
SET STATISTICS IO OFF

-- INDICES
CREATE NONCLUSTERED INDEX IX_ClinicaTratamiento_NonClustered
ON Clinica.Tratamiento (idTratamiento, idMedicamento);

CREATE NONCLUSTERED INDEX IX_InventarioAnalgesico_NonClustered
ON Inventario.Analgesico (tipo);

CREATE NONCLUSTERED INDEX IX_InventarioMedicamento_NonClustered
ON Inventario.Medicamento (idAnalgesico);

SET STATISTICS TIME ON 
SET STATISTICS IO ON

--REALIZADA
-- 4 cual es el metodo de pago mas usado para pagar en cada especialidad
SELECT ci.especialidad, mp.tipo, 
COUNT(fac.idFactura) AS tiposDePago,
DENSE_RANK() OVER(PARTITION BY ci.especialidad ORDER BY COUNT(fac.idFactura) DESC) AS ranking 
FROM Contabilidad.Factura AS fac
JOIN Contabilidad.MetodoPago AS mp ON fac.idMetodoPago = mp.idMetodoPago
JOIN Clinica.Cita AS ci ON fac.idCita = ci.idCita
GROUP BY ci.especialidad, mp.tipo

SET STATISTICS TIME OFF 
SET STATISTICS IO OFF

-- INDICES
CREATE NONCLUSTERED INDEX IX_ContabilidadFactura_NonClustered
ON Contabilidad.Factura (idFactura, idMetodoPago, idCita);

CREATE NONCLUSTERED INDEX IX_ContabilidadMetodoPago_NonClustered
ON Contabilidad.MetodoPago (tipo);

CREATE NONCLUSTERED INDEX IX_CitaFactura_NonClustered
ON Clinica.Cita (especialidad);
