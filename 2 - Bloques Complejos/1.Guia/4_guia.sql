/*
4. Cursor Desarrollar un bloque anónimo que usando cursor explícito de lista de vendedores (id,
nombres, apellidos, fecha nacimiento y sueldo) muestre quien tiene un sueldo menor o igual $ 354,000.
Mostrar el resultado por cada registro.
P.S.: Usar variables ESCALAR (%TYPE)
OUTPUT:
--------------------------------------------------
INFORME DE EMPLEADOS
--------------------------------------------------
[1] Empleado N° 5 - María Rivera tiene un sueldo de $350,000
[2] Empleado N° 10 - Jeremías Lorca tiene un sueldo de $345,000
*/

DECLARE
    CURSOR cur_vendedores IS (        
        SELECT id_vendedor, nombres, apellidos, fecnac, sueldo
        FROM Vendedor
        WHERE sueldo <= 354000
    );
    
    v_id_vendedor Vendedor.id_vendedor%type;
    v_nombres Vendedor.nombres%type;
    v_apellidos Vendedor.nombres%type;
    v_fecnac Vendedor.fecnac%type;
    v_sueldo Vendedor.sueldo%type;
    
    v_contador int := 0;
BEGIN
    OPEN cur_vendedores;
    dbms_output.put_line('-------------------------------');
    dbms_output.put_line('INFORME VENDEDORES');
    dbms_output.put_line('-------------------------------');
    
    LOOP
        FETCH cur_vendedores INTO v_id_vendedor, v_nombres,v_apellidos, v_fecnac, v_sueldo;
        v_contador := v_contador+1;
        EXIT WHEN cur_vendedores%NOTFOUND;
    
        dbms_output.put_line('['||v_contador || '] Empleado N° '|| v_id_vendedor || ' - '
        || v_nombres ||' ' ||v_apellidos|| ' tiene un sueldo de '|| TO_CHAR(v_sueldo, '$999g999'));
    END LOOP;
END;