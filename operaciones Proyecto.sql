use agenda_contactos;
drop procedure if exists sp_registrar_contacto;
drop procedure if exists sp_actualizar_contacto;
drop procedure if exists sp_eliminar_contacto;
drop procedure if exists sp_buscar_nombre;
drop procedure if exists sp_contactos_grupo;
drop function if exists fn_contar_contactos;
drop function if exists fn_existe_telefono;
drop function if exists fn_total_usuario;
drop function if exists fn_nombre_grupo;
drop function if exists fn_rol_usuario;


INSERT INTO tb_usuario(nombre_usuario, contraseña, correo, id_rol)
VALUES('nuevo','1234','nuevo@email.com',2);

SELECT * FROM tb_usuario;

UPDATE tb_usuario SET nombre_usuario='actualizado' WHERE id_usuario=1;

-- DELETE FROM tb_usuario WHERE id_usuario=3;

INSERT INTO tb_grupo(nombre_grupo, descripcion)
VALUES('Deportes','Contactos deportivos');

SELECT * FROM tb_grupo;

UPDATE tb_grupo SET descripcion='Grupo deportivo' WHERE id_grupo=1;

DELETE FROM tb_grupo WHERE id_grupo=5;

INSERT INTO tb_contacto(nombre,telefono,email,direccion,id_grupo,id_usuario)
VALUES('Ana','3001234567','ana@email.com','Calle 10',1,1);

SELECT * FROM tb_contacto;

UPDATE tb_contacto SET telefono='3009999999' WHERE id_contacto=1;

DELETE FROM tb_contacto WHERE id_contacto=2;

DELIMITER //
CREATE PROCEDURE sp_registrar_contacto(
IN p_nombre VARCHAR(100),
IN p_telefono VARCHAR(15),
IN p_email VARCHAR(100),
IN p_direccion VARCHAR(150),
IN p_id_grupo INT,
IN p_id_usuario INT
)
BEGIN
DECLARE existe INT;

SELECT COUNT(*) INTO existe FROM tb_contacto WHERE telefono = p_telefono;

IF existe = 0 THEN
INSERT INTO tb_contacto(nombre,telefono,email,direccion,id_grupo,id_usuario)
VALUES(p_nombre,p_telefono,p_email,p_direccion,p_id_grupo,p_id_usuario);
END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_actualizar_contacto(
IN p_id INT,
IN p_telefono VARCHAR(15)
)
BEGIN
UPDATE tb_contacto
SET telefono = p_telefono
WHERE id_contacto = p_id;
END //
DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_eliminar_usuario(IN p_id INT)
BEGIN
DECLARE total INT;

-- Verificar si tiene contactos
SELECT COUNT(*) INTO total
FROM tb_contacto
WHERE id_usuario = p_id;

IF total = 0 THEN
    DELETE FROM tb_usuario WHERE id_usuario = p_id;
ELSE
    SELECT 'No se puede eliminar, tiene contactos asociados' AS mensaje;
END IF;

END //

DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_buscar_nombre(IN p_nombre VARCHAR(100))
BEGIN
SELECT * FROM tb_contacto
WHERE nombre LIKE CONCAT('%',p_nombre,'%');
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_contactos_grupo(IN p_id INT)
BEGIN
SELECT * FROM tb_contacto WHERE id_grupo = p_id;
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION fn_contar_contactos(p_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE total INT;
SELECT COUNT(*) INTO total FROM tb_contacto WHERE id_grupo = p_id;
RETURN total;
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION fn_existe_telefono(p_tel VARCHAR(15))
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE total INT;
SELECT COUNT(*) INTO total FROM tb_contacto WHERE telefono = p_tel;
RETURN total;
END //
DELIMITER ;

CREATE FUNCTION fn_total_usuario(p_id INT)
RETURNS INT
DETERMINISTIC
RETURN (SELECT COUNT(*) FROM tb_contacto WHERE id_usuario = p_id);

CREATE FUNCTION fn_nombre_grupo(p_id INT)
RETURNS VARCHAR(50)
DETERMINISTIC
RETURN (SELECT nombre_grupo FROM tb_grupo WHERE id_grupo = p_id);

CREATE FUNCTION fn_rol_usuario(p_id INT)
RETURNS VARCHAR(50)
DETERMINISTIC
RETURN (
SELECT r.nombre_rol
FROM tb_usuario u
JOIN tb_rol r ON u.id_rol = r.id_rol
WHERE u.id_usuario = p_id
);

