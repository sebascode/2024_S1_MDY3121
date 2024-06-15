create or replace NONEDITIONABLE PROCEDURE SP_CONTAR
( x_numero1 number )
AS
    v_resultado number;
    V_ID NUMBER;
BEGIN

    SELECT ID INTO V_ID FROM USUARIO;

    /*
    IF(x_numero1 = 0)
    THEN
        RAISE ZERO_DIVIDE;
    END IF;
    */
    dbms_output.put_line('ya pasó por el if');
    FOR contador IN 1..100
    LOOP
        v_resultado := contador / x_numero1;
        dbms_output.put_line('numero: '||contador);
        dbms_output.put_line('calculo: '||v_resultado);
    END LOOP;
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        dbms_output.put_line('NO SE PUEDE DIVIDIR POR 0');
    /*
    WHEN OTHERS THEN
        dbms_output.put_line('MELE CAI');
        */
END SP_CONTAR;
/

-- Ejecución Capturando la excepción de división por zero
BEGIN
      SP_CONTAR(2); -- divide por 2
      SP_CONTAR(0); -- produce error de división por 0.
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        dbms_output.put_line('TELE CAYÓ EN EL SP');
END;
