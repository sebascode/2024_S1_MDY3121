DECLARE
 /* MIS VARIABLES ACÁ */
    v_nombre_tabla VARCHAR2(300);
    v_id_tabla int := :x_id;
    v_resultado BOOLEAN := false;
BEGIN
    SELECT nombre
    INTO v_nombre_tabla
    FROM MITABLA
    WHERE id_tabla=v_id_tabla;
    
    IF v_nombre_tabla = 'Holi'
    THEN
        v_resultado := true;
    END IF;
    
    dbms_output.put_line('Nombre del campo '|| v_id_tabla ||' es '|| v_nombre_tabla);
END;

/

VAR x_mivariable INTEGER;
EXEC x_mivariable := 5;
--ITERADORES
DECLARE
    v_nombre mitabla.nombre%TYPE;
    v_indice number := 0;
    v_maximo number:= :x_mivariable;
    
    CURSOR c_micursor IS (SELECT * FROM mitabla);
    TYPE r_miregistro IS RECORD(
        id_tabla mitabla.id_tabla%type,
        nombre mitabla.nombre%type
    );
    v_miregistro r_miregistro;
    
    
BEGIN
    --SELECT * FROM mitabla;
    
    -- LOOP Manual
    /*
    LOOP
        EXIT WHEN v_indice = v_maximo;
        dbms_output.put_line(v_indice+1);
        v_indice := v_indice +1;
    END LOOP;
    */
    -- WHILE
    /*WHILE v_indice < v_maximo
    LOOP
        dbms_output.put_line(v_indice+1);
        v_indice := v_indice +1;
    END LOOP;
    */
    -- FOR & FOREACH
    /*FOR mi_contador IN 1..v_maximo
    LOOP
        dbms_output.put_line(mi_contador);
    END LOOP;
    */
    /*
    FOR mi_fila IN (c_micursor)
    LOOP
        dbms_output.put_line(mi_fila.nombre);
    END LOOP;
    */
    
    -- CURSOR MANUAL
    OPEN c_micursor;
    LOOP
        FETCH c_micursor INTO v_miregistro;
        EXIT WHEN c_micursor%NOTFOUND;
        dbms_output.put_line(v_miregistro.nombre);
    END LOOP;
    CLOSE c_micursor;
END;
