/*
5. Elaborar un bloque anónimo PL/SQL que devuelva un reporte de los vendedores que tienen un salario
menor e igual a $ 400,000. El reporte debe mostrarse agrupado por Categoría. Los valores de la
columna deben ser por ancho fijo

--------------------------------------------------
INFORME DE EMPLEADOS POR DEPARTAMENTO
--------------------------------------------------
CATEGORÍA A:
35 HUMBERTO ORREGO $354,000
55 ELIZABETH MIRANDA $348,232
50 DOMITILA PAREDES $338,432
(...)
*/

DECLARE
    CURSOR cur_departamentos IS (        
        SELECT id_categoria, nom_categoria
        FROM categoria
    );
    CURSOR cur_vendedores(categoria varchar2) IS (        
        SELECT id_vendedor, nombres, apellidos, fecnac, sueldo
        FROM Vendedor
        WHERE sueldo <= 400000
        AND id_categoria = categoria
    );
    
    TYPE r_vendedor IS RECORD (    
        id_vendedor Vendedor.id_vendedor%type,
        nombres Vendedor.nombres%type,
        apellidos Vendedor.nombres%type,
        fecnac Vendedor.fecnac%type,
        sueldo Vendedor.sueldo%type
    );
    v_vendedor r_vendedor;
    
    v_id_categoria Categoria.id_categoria%type;
    v_nombre_categoria Categoria.nom_categoria%type;
BEGIN
    dbms_output.put_line('-------------------------------');
    dbms_output.put_line('INFORME VENDEDORES');
    dbms_output.put_line('-------------------------------');
    OPEN cur_departamentos;

    LOOP
        FETCH cur_departamentos INTO v_id_categoria, v_nombre_categoria;
        EXIT WHEN cur_departamentos%NOTFOUND;
        
        dbms_output.put_line(UPPER(v_nombre_categoria));
    
        OPEN cur_vendedores(v_id_categoria);
        
        LOOP
            FETCH cur_vendedores INTO v_vendedor;
            EXIT WHEN cur_vendedores%NOTFOUND;
        
            dbms_output.put_line(v_vendedor.id_vendedor || '  '
            || v_vendedor.nombres ||' ' ||v_vendedor.apellidos|| ' '|| TO_CHAR(v_vendedor.sueldo, '$999g999'));
        END LOOP;
        dbms_output.put_line('');
        CLOSE cur_vendedores;
    END LOOP;
    
    CLOSE cur_departamentos;
END;