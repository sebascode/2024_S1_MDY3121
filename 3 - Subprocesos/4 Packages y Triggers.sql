/*
--DDL Tabla
CREATE TABLE Usuario (
    id_usuario NUMBER PRIMARY KEY,
    nombre VARCHAR2(50),
    correo VARCHAR2(100),
    contraseña VARCHAR2(50)
);
*/

-- Package
CREATE OR REPLACE PACKAGE Usuario_PKG IS
    PROCEDURE crear_usuario(
        p_id_usuario IN NUMBER,
        p_nombre IN VARCHAR2,
        p_correo IN VARCHAR2,
        p_contraseña IN VARCHAR2
    );

    PROCEDURE modificar_usuario(
        p_id_usuario IN NUMBER,
        p_nombre IN VARCHAR2,
        p_correo IN VARCHAR2
    );

    PROCEDURE actualizar_contraseña(
        p_id_usuario IN NUMBER,
        p_contraseña IN VARCHAR2
    );
END Usuario_PKG;
/

-- Crear el cuerpo del package
CREATE OR REPLACE PACKAGE BODY Usuario_PKG IS
    PROCEDURE crear_usuario(
        p_id_usuario IN NUMBER,
        p_nombre IN VARCHAR2,
        p_correo IN VARCHAR2,
        p_contraseña IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO Usuario (id_usuario, nombre, correo, contraseña)
        VALUES (p_id_usuario, p_nombre, p_correo, p_contraseña);
    END crear_usuario;

    PROCEDURE modificar_usuario(
        p_id_usuario IN NUMBER,
        p_nombre IN VARCHAR2,
        p_correo IN VARCHAR2
    ) IS
    BEGIN
        UPDATE Usuario
        SET nombre = p_nombre, correo = p_correo
        WHERE id_usuario = p_id_usuario;
    END modificar_usuario;

    PROCEDURE actualizar_contraseña(
        p_id_usuario IN NUMBER,
        p_contraseña IN VARCHAR2
    ) IS
    BEGIN
        UPDATE Usuario
        SET contraseña = p_contraseña
        WHERE id_usuario = p_id_usuario;
    END actualizar_contraseña;
END Usuario_PKG;
/

-- Trigger antes de insertar un nuevo usuario
CREATE OR REPLACE TRIGGER before_insert_usuario
BEFORE INSERT ON Usuario
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Antes de insertar un nuevo usuario: ' || :NEW.nombre);
END;
/

-- Trigger después de actualizar el campo contraseña
CREATE OR REPLACE TRIGGER after_update_contraseña
AFTER UPDATE OF contraseña ON Usuario
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Contraseña antigua: ' || :OLD.contraseña || ', Nueva contraseña: ' || :NEW.contraseña);
END;
/

-- Trigger antes de eliminar un usuario
CREATE OR REPLACE TRIGGER before_delete_usuario
BEFORE DELETE ON Usuario
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Antes de eliminar el usuario con ID: ' || :OLD.id_usuario);
END;
/
