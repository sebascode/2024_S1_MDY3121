CREATE OR REPLACE TRIGGER TRG_REGISTRO_EMPLEADO
BEFORE -- OR AFTER
INSERT OR UPDATE OR DELETE
ON EJ_EMPLEADO -- TABLA
FOR EACH ROW 
    
BEGIN
    IF INSERTING THEN
        dbms_output.put_line('INSERTANDO '|| :new.nombres|| ' ' || :new.apellidos);
    ELSIF UPDATING(sueldo) THEN
        dbms_output.put_line('ACTUALIZANDING '|| :old.nombres|| ' ' || :old.apellidos);
        dbms_output.put_line('POR '|| :new.nombres|| ' ' || :new.apellidos);
    ELSIF DELETING THEN
        dbms_output.put_line('BORRANDING '|| :old.nombres|| ' ' || :old.apellidos);
    END IF;
END TRG_REGISTRO_EMPLEADO;
