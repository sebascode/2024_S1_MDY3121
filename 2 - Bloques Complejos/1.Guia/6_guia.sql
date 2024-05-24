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
    
BEGIN
    dbms_output.put_line('------------------------------------');
    dbms_output.put_line('INFORME DE CLIENTES Y VENDEDORES');
    dbms_output.put_line('------------------------------------');

    dbms_output.put_line('TIPO'|| CHR(9) ||CHR(9)
    || 'ID ' || CHR(9)
    || 'NOMBRE COMPLETO' || CHR(9)
    || 'RUT' || CHR(9)
    || 'EQUIPO' || CHR(9)
    || 'CATEGORIA' || CHR(9) ||'SUELDO');
    dbms_output.put_line('------------------------------------');
    FOR v_persona IN cur_persona
    LOOP
        dbms_output.put_line(V_PERSONA.tipo
        || CHR(9) || V_PERSONA.id_persona
        || CHR(9) || V_PERSONA.nombrecompleto
        || CHR(9) || CHR(9) || V_PERSONA.rut
        || CHR(9) || V_PERSONA.grupo
        || CHR(9) || V_PERSONA.categoria
        || CHR(9) || V_PERSONA.sueldo);        
    END LOOP;
END;
