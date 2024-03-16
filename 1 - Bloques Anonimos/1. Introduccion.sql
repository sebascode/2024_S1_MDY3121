/*
CREATE TABLE Persona(
    id_persona int,
    nombre varchar2(50),
    apellido varchar2(50),
    id_comuna int
);

INSERT INTO Persona(id_persona, nombre, apellido, id_comuna)
VALUES (1, 'Sebastian', 'Contreras', 1);
INSERT INTO Persona(id_persona, nombre, apellido, id_comuna)
VALUES (2, 'Cristian', 'Perez', 6);
*/

--
DECLARE
    v_id_persona int := 10;
    v_nombreCompleto varchar2(100);
    
BEGIN
    -- EJECUTAMOS CÓDIGO
    
    SELECT nombre || ' ' || apellido
    INTO v_nombreCompleto
    FROM persona
    WHERE id_persona = v_id_persona;
    
    dbms_output.put_line('ID seleccionado: '|| v_id_persona);
    DBMS_OUTPUT.put_line('Nombre: ' || v_nombreCompleto);
END;
