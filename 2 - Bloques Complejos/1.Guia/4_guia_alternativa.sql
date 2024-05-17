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
    
    TYPE r_vendedor IS RECORD (    
        id_vendedor Vendedor.id_vendedor%type,
        nombres Vendedor.nombres%type,
        apellidos Vendedor.nombres%type,
        fecnac Vendedor.fecnac%type,
        sueldo Vendedor.sueldo%type
    );
    
    --v_vendedor varchar2(255);
    v_vendedor r_vendedor;
    v_vendedor_planta r_vendedor;
    v_vendedor_aux r_vendedor;
    
    v_contador int := 0;
BEGIN
    OPEN cur_vendedores;
    dbms_output.put_line('-------------------------------');
    dbms_output.put_line('INFORME VENDEDORES');
    dbms_output.put_line('-------------------------------');
    
    LOOP
        FETCH cur_vendedores INTO v_vendedor;
        v_contador := v_contador+1;
        EXIT WHEN cur_vendedores%NOTFOUND;
    
        dbms_output.put_line('['||v_contador || '] Empleado N° '|| v_vendedor.id_vendedor || ' - '
        || v_vendedor.nombres ||' ' ||v_vendedor.apellidos|| ' tiene un sueldo de '|| TO_CHAR(v_vendedor.sueldo, '$999g999'));
    END LOOP;
    
    CLOSE cur_vendedores;
END;