DROP DATABASE IF EXISTS agenda_contactos;
CREATE DATABASE agenda_contactos;
USE agenda_contactos;

-- ======================
-- TABLA ROL
-- ======================
CREATE TABLE tb_rol (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL UNIQUE
);

-- ======================
-- TABLA USUARIO
-- ======================
CREATE TABLE tb_usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(50) NOT NULL UNIQUE,
    contraseña VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE,
    id_rol INT NOT NULL,
    FOREIGN KEY (id_rol) REFERENCES tb_rol(id_rol)
);

-- ======================
-- TABLA GRUPO
-- ======================
CREATE TABLE tb_grupo (
    id_grupo INT AUTO_INCREMENT PRIMARY KEY,
    nombre_grupo VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(100)
);

-- ======================
-- TABLA CONTACTO
-- ======================
CREATE TABLE tb_contacto (
    id_contacto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE,
    direccion VARCHAR(150),
    id_grupo INT NOT NULL,
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_grupo) REFERENCES tb_grupo(id_grupo),
    FOREIGN KEY (id_usuario) REFERENCES tb_usuario(id_usuario)
);

-- ROLES
INSERT INTO tb_rol(nombre_rol) VALUES
('Administrador'),
('Usuario');

-- USUARIOS
INSERT INTO tb_usuario(nombre_usuario, contraseña, correo, id_rol) VALUES
('admin','1234','admin@email.com',1),
('user1','1234','user1@email.com',2),
('user2','1234','user2@email.com',2);

-- GRUPOS
INSERT INTO tb_grupo(nombre_grupo, descripcion) VALUES
('Familia','Contactos familiares'),
('Amigos','Contactos personales'),
('Trabajo','Contactos laborales'),
('Universidad','Compañeros'),
('Clientes','Contactos comerciales');

-- CONTACTOS
INSERT INTO tb_contacto(nombre, telefono, email, direccion, id_grupo, id_usuario) VALUES
('Carlos Perez','3012345678','carlos@email.com','Carrera 15',2,1),
('Maria Gomez','3023456789','maria@email.com','Calle 25',1,2),
('Luis Martinez','3034567890','luis@email.com','Avenida 30',3,1),
('Sofia Ramirez','3045678901','sofia@email.com','Calle 8',2,2),
('Jorge Castillo','3056789012','jorge@email.com','Carrera 7',1,3),
('Laura Torres','3067890123','laura@email.com','Avenida 68',3,2);