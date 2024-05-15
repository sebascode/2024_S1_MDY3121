-- 1
DECLARE
    v_iteraciones NUMBER := FLOOR(DBMS_RANDOM.value(2, 20));
    v_numRandom NUMBER := 0;
    v_total NUMBER := 0;
BEGIN
    FOR i IN 1..v_iteraciones
    LOOP
        v_numRandom := FLOOR(DBMS_RANDOM.value(20,200));
        dbms_output.put_line('Número random: '||v_numRandom);
        v_total := v_numRandom + v_total;
    END LOOP;
    dbms_output.put_line('TOTAL: '||v_numRandom);
END;

-- 2
BEGIN
    FOR i IN 1..200
    LOOP
        IF MOD(i,3) = 0 THEN
            dbms_output.put_line(i||' es múltiplo de 3');
        END IF;
    END LOOP;
END;

-- 3
BEGIN
    FOR i IN 1..10
    LOOP
        FOR c IN 1..10
        LOOP
            dbms_output.put_line(i||'x'||c||'='||(i*c));
        END LOOP;
    END LOOP;
END;
