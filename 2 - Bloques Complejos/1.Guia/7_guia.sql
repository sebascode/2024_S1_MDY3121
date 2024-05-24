DECLARE

    CURSOR cur_persona IS (
    SELECT
        nombres || ' ' || apellidos as nombrecompleto,
        rut_vendedor as rut,
        g.nom_grupo as grupo,
        c.nom_categoria as categoria,
        v.sueldo,
        v.id_vendedor as id_persona,
        'Vendedor' as tipo
    FROM Vendedor v
    INNER JOIN Grupo g on v.id_grupo = g.id_grupo
    INNER JOIN Categoria c on v.id_categoria = c.id_categoria
    UNION
    SELECT
        nombre_cliente as nombrecompleto,
        '' as rut,
        '' as grupo,
        '' as categoria,
        0 as Sueldo,
        id_cliente as id_persona,
        'Cliente' as tipo
    FROM Cliente);
    
    TYPE r_persona IS RECORD(       
        nombrecompleto VARCHAR2(255),
        rut VARCHAR2(12),
        grupo VARCHAR2(50),
        categoria VARCHAR2(50),
        sueldo INT,
        id_persona INT,
        tipo VARCHAR2(50)
    );
    v_persona r_persona;
    
    v_msg VARCHAR(255);
    
    TYPE v_cliente is VARRAY(255) OF r_persona;
    TYPE v_vendedor is VARRAY(255) OF r_persona;
BEGIN
    dbms_output.put_line('------------------------------------');
    dbms_output.put_line('   LOG DE MOVIMIENTOS POR USUARIO');
    dbms_output.put_line('------------------------------------');

    OPEN cur_persona;
    LOOP
        FETCH cur_persona INTO v_persona;
        EXIT WHEN cur_persona%NOTFOUND;
        
        IF v_persona.tipo = 'Cliente'
        THEN 
            v_cliente.add(v_persona);
        ELSE
            v_vendedor.add(v_persona);
        END IF;
    END LOOP;
    
    FOR persona IN v_vendedor
    LOOP
        FOR venta IN (SELECT 
            v.id_venta as id_venta,
            a.nom_articulo as articulo,
            a.precio as precio,
            dv.cantidad as cantidad,
            (a.precio * dv.cantidad) total
        FROM venta v
        JOIN detalleventa dv ON dv.id_venta = v.id_venta
        JOIN articulo a ON a.id_articulo = dv.id_articulo
        WHERE v.id_vendedor = persona.id_persona)
        LOOP
            v_msg := '[VENTA] El Vendedor '|| persona.nombrecompleto || ' vendió en la boleta ' || venta.id_venta ||' el articulo '|| venta.articulo || ' por un total de ' || venta.total;
            dbms_output.put_line(v_msg);
        END LOOP;
    END LOOP;
END;
