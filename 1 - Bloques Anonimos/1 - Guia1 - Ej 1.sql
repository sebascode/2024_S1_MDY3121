/*
prueba 1: 11846972-5
prueba 2: 18560875-5

Algoritmo:
1. Preguntar parametros
2. Creabamos las variables
3. Ejecutamos un SQL para buscar el empleado y traer el sueldo
4. calculamos el sueldo
5. imprimimos los datos
6. ????
7. profit
*/
DECLARE
    v_porc_bono int := :x_bono;
    v_rut_emp int := :x_rut_emp;
    v_dvrut_emp varchar2(1) := :x_dv_emp;
    v_nombrecompleto varchar2(200);
    v_sueldo int := 0;
    v_bonificacion int := 0;
BEGIN
    SELECT
        nombre_emp ||' ' || appaterno_emp ||' ' ||apmaterno_emp as nombreCompleto,
        sueldo_emp
    INTO
        v_nombrecompleto,
        v_sueldo
    FROM empleado
    WHERE
        numrut_emp = v_rut_emp
        AND dvrut_emp = v_dvrut_emp;
    
    v_bonificacion := v_sueldo * (v_porc_bono / 100);
    
    dbms_output.put_line('DATO CALCULO BONIFICACIÓN EXTRA DEL '|| v_porc_bono || '% DEL SUELDO.');
    dbms_output.put_line('Nombre Empleado: '|| v_nombrecompleto);
    dbms_output.put_line('RUN: '|| v_rut_emp || '-' || v_dvrut_emp);
    dbms_output.put_line('Sueldo: '|| v_sueldo);
    dbms_output.put_line('Bonificacion extra: '|| v_bonificacion);
END;
