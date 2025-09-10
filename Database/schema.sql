-- ===============================
-- Base de datos
-- ===============================
CREATE DATABASE IF NOT EXISTS gmap1 CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE gmap1;

-- ===============================
-- Tablas principales
-- ===============================

-- Tabla de usuarios
CREATE TABLE IF NOT EXISTS usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(150) NOT NULL,
  email VARCHAR(200) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  rol_id INT NOT NULL,
  creado_en DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de aeronaves
CREATE TABLE IF NOT EXISTS aeronaves (
  id INT AUTO_INCREMENT PRIMARY KEY,
  matricula VARCHAR(60) UNIQUE,
  fabricante VARCHAR(120),
  marca VARCHAR(120),
  modelo VARCHAR(120),
  anio_fabricacion INT,
  serie_numero VARCHAR(120),
  total_horas_vuelo INT DEFAULT 0,
  foto VARCHAR(255),
  estado VARCHAR(60) DEFAULT 'disponible',
  ultimo_mantenimiento DATETIME
);

-- Tabla de historial de horas
CREATE TABLE IF NOT EXISTS horas_historial (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_aeronave INT,
  horas_sumadas INT,
  fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_aeronave) REFERENCES aeronaves(id) ON DELETE SET NULL
);

-- ⚠️ Me quedo con esta versión de mantenimientos (la extendida)
CREATE TABLE IF NOT EXISTS mantenimientos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_aeronave INT NOT NULL,
    ciclo ENUM('50','100','200') NOT NULL,
    fecha_programada DATE NOT NULL,
    realizado BOOLEAN DEFAULT FALSE,
    fecha_realizado DATE NULL,
    FOREIGN KEY (id_aeronave) REFERENCES aeronaves(id) ON DELETE CASCADE
);

-- Tabla de órdenes de trabajo
CREATE TABLE IF NOT EXISTS ordenes_trabajo (
  id INT AUTO_INCREMENT PRIMARY KEY,
  aeronave_id INT,
  mantenimiento_id INT NULL,
  tipo_mantenimiento VARCHAR(50) NULL,
  estado VARCHAR(60) DEFAULT 'en_proceso',
  porcentaje_avance INT DEFAULT 0,
  fecha_inicio DATETIME DEFAULT CURRENT_TIMESTAMP,
  fecha_fin DATETIME,
  FOREIGN KEY (aeronave_id) REFERENCES aeronaves(id) ON DELETE SET NULL
);

-- Tabla de tareas de orden
CREATE TABLE IF NOT EXISTS tareas_orden (
  id INT AUTO_INCREMENT PRIMARY KEY,
  orden_id INT,
  descripcion TEXT,
  tipo_responsable VARCHAR(60) NULL,
  tecnico_id INT NULL,
  certificador_id INT NULL,
  estado VARCHAR(60) DEFAULT 'pendiente',
  firma_tecnico VARCHAR(255) NULL,
  fecha_firma_tecnico DATETIME NULL,
  firma_certificador VARCHAR(255) NULL,
  fecha_firma_certificador DATETIME NULL,
  FOREIGN KEY (orden_id) REFERENCES ordenes_trabajo(id) ON DELETE CASCADE
);

-- Tabla de notificaciones
CREATE TABLE IF NOT EXISTS notificaciones (
  id INT AUTO_INCREMENT PRIMARY KEY,
  usuario_id INT,
  mensaje TEXT,
  leido BOOLEAN DEFAULT FALSE,
  creado_en DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de reportes de piloto
CREATE TABLE IF NOT EXISTS reportes_piloto (
  id INT AUTO_INCREMENT PRIMARY KEY,
  aeronave_id INT,
  matricula VARCHAR(60),
  horas_vuelo INT,
  salida VARCHAR(255),
  llegada VARCHAR(255),
  fecha DATE,
  reporte TEXT,
  accion_correctiva TEXT,
  firma_piloto VARCHAR(255),
  creado_en DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de órdenes
CREATE TABLE IF NOT EXISTS ordenes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_aeronave INT NOT NULL,
    descripcion TEXT,
    estado ENUM('abierta', 'finalizada') DEFAULT 'abierta',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_finalizacion TIMESTAMP NULL,
    FOREIGN KEY (id_aeronave) REFERENCES aeronaves(id) ON DELETE CASCADE
);

-- Tabla de items de orden
CREATE TABLE IF NOT EXISTS orden_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_orden INT NOT NULL,
    descripcion TEXT NOT NULL,
    firmado_por INT NULL,
    fecha_firma TIMESTAMP NULL,
    FOREIGN KEY (id_orden) REFERENCES ordenes(id) ON DELETE CASCADE,
    FOREIGN KEY (firmado_por) REFERENCES usuarios(id) ON DELETE SET NULL
);

-- Tabla de PDFs de orden
CREATE TABLE IF NOT EXISTS orden_pdfs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_orden INT NOT NULL,
    ruta_pdf VARCHAR(255) NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_orden) REFERENCES ordenes(id) ON DELETE CASCADE
);

-- ===============================
-- Inserts demo
-- ===============================

-- Usuarios
INSERT IGNORE INTO usuarios (id, nombre, email, password, rol_id) VALUES
(1, 'Admin', 'admin@example.com', 'adminpass', 1),
(2, 'Tecnico', 'tecnico@example.com', 'tecpass', 2),
(3, 'Certificador', 'cert@example.com', 'certpass', 3),
(4, 'Piloto', 'piloto@example.com', 'pilotopass', 4),
(5, 'piloto2', 'nea@hola.com', '123456', 5);

-- Aeronaves
INSERT INTO aeronaves (matricula, fabricante, marca, modelo, anio_fabricacion, serie_numero, total_horas_vuelo, foto, estado, ultimo_mantenimiento)
VALUES
('HK-4501', 'Airbus', 'Airbus', 'A320-200', 2015, 'SN-A320-001', 12500, 'a320.jpg', 'disponible', '2025-07-20 10:30:00'),
('HK-3982', 'Boeing', 'Boeing', '737-800', 2012, 'SN-B737-045', 18900, 'b737.jpg', 'mantenimiento', '2025-06-10 08:15:00'),
('HK-5023', 'Embraer', 'Embraer', 'E190', 2018, 'SN-E190-077', 8500, 'e190.jpg', 'disponible', '2025-08-05 14:00:00'),
('HK-2760', 'Cessna', 'Cessna', 'Citation XLS+', 2017, 'SN-CIT-088', 4200, 'citation.jpg', 'proximo_mantenimiento', '2025-08-25 09:00:00'),
('HK-3345', 'ATR', 'ATR', '72-600', 2016, 'SN-ATR72-099', 10300, 'atr72.jpg', 'disponible', '2025-07-30 11:45:00'),
('HK-4811', 'Beechcraft', 'Beechcraft', 'King Air 350', 2014, 'SN-KA350-122', 7650, 'kingair.jpg', 'mantenimiento', '2025-06-28 15:10:00'),
('HK-5599', 'Bombardier', 'Bombardier', 'CRJ900', 2019, 'SN-CRJ900-210', 6100, 'crj900.jpg', 'disponible', '2025-08-15 16:30:00'),
('HK-6210', 'Airbus', 'Airbus', 'A330-300', 2013, 'SN-A330-333', 20050, 'a330.jpg', 'proximo_mantenimiento', '2025-07-18 13:20:00'),
('HK-7077', 'Boeing', 'Boeing', '787-9 Dreamliner', 2020, 'SN-B787-099', 4300, 'b787.jpg', 'disponible', '2025-08-28 17:00:00'),
('HK-8890', 'Cessna', 'Cessna', '172 Skyhawk', 2011, 'SN-C172-555', 2800, 'c172.jpg', 'disponible', '2025-08-10 07:40:00');

-- Ordenes de trabajo (necesarias antes de tareas_orden)
INSERT INTO ordenes_trabajo (aeronave_id, mantenimiento_id, tipo_mantenimiento, estado, porcentaje_avance)
VALUES (1, NULL, 'preventivo', 'en_proceso', 20);

-- Tareas de orden (ahora sí válido porque existe orden_id = 1)
INSERT INTO tareas_orden (
  orden_id, descripcion, tipo_responsable, tecnico_id, certificador_id, estado, 
  firma_tecnico, fecha_firma_tecnico, firma_certificador, fecha_firma_certificador
)
VALUES
(1, 'Inspección visual del fuselaje y alas', 'tecnico', 2, NULL, 'completada',
 'firma_tec_2.png', '2025-08-15 09:30:00', NULL, NULL),
(1, 'Verificación de sistemas hidráulicos', 'tecnico', 3, NULL, 'pendiente',
 NULL, NULL, NULL, NULL);
