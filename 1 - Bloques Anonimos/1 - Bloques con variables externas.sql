
/*
imprimir el nombre completo de una
persona por el id.
*/

DECLARE 
    --VARIABLES ACÁ
    v_id_persona int := :x_id_persona; -- x_ es para una variable externa
    v_nombre_completo varchar2(100);
    v_porc_imp int;
BEGIN
    --variable regular
    v_porc_imp := 10000 * 0.19;
    
    -- variable sql
    SELECT nombre || ' ' || apellido
    INTO v_nombre_completo
    FROM persona
    WHERE id_persona = v_id_persona;
    

    dbms_output.put_line('holi');
    dbms_output.put_line('El nombre del usuario '|| v_id_persona);
    dbms_output.put_line('es: '|| v_nombre_completo);
END;

