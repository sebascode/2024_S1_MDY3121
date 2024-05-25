DROP TABLE types CASCADE CONSTRAINTS;
DROP TABLE pokemon CASCADE CONSTRAINTS;
DROP TABLE trainers CASCADE CONSTRAINTS;
DROP TABLE pokemon_trainers CASCADE CONSTRAINTS;
DROP TABLE moves CASCADE CONSTRAINTS;
DROP TABLE battles CASCADE CONSTRAINTS;

CREATE TABLE types (
    id NUMBER PRIMARY KEY,
    type_name VARCHAR2(50) UNIQUE
);

CREATE TABLE pokemon (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    type_id NUMBER,
    hp NUMBER,
    speed NUMBER,
    FOREIGN KEY (type_id) REFERENCES types(id)
);

CREATE TABLE trainers (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    age NUMBER,
    city VARCHAR2(50)
);

CREATE TABLE pokemon_trainers (
    trainer_id NUMBER,
    pokemon_id NUMBER,
    PRIMARY KEY (trainer_id, pokemon_id),
    FOREIGN KEY (trainer_id) REFERENCES trainers(id),
    FOREIGN KEY (pokemon_id) REFERENCES pokemon(id)
);

CREATE TABLE moves (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    type_id NUMBER,
    power NUMBER,
    FOREIGN KEY (type_id) REFERENCES types(id)
);

CREATE TABLE battles (
    id NUMBER PRIMARY KEY,
    pokemon1_id NUMBER,
    pokemon2_id NUMBER,
    winner_id NUMBER,
    battle_date DATE,
    FOREIGN KEY (pokemon1_id) REFERENCES pokemon(id),
    FOREIGN KEY (pokemon2_id) REFERENCES pokemon(id),
    FOREIGN KEY (winner_id) REFERENCES pokemon(id)
);

-- Insertar datos en las tablas
INSERT INTO types (id, type_name) VALUES (1, 'Electric');
INSERT INTO types (id, type_name) VALUES (2, 'Water');
INSERT INTO types (id, type_name) VALUES (3, 'Fire');
INSERT INTO types (id, type_name) VALUES (4, 'Grass');
INSERT INTO types (id, type_name) VALUES (5, 'Normal');
/
DECLARE
    v_pokemon_id NUMBER := 1;
    v_name VARCHAR2(50);
    v_type_id NUMBER;
    v_hp NUMBER;
    v_speed NUMBER;
    v_names VARCHAR2(1500) := 'Pikachu,Bulbasaur,Charmander,Squirtle,Pidgey,Rattata,Ekans,Sandshrew,Nidoran,Nidoran,Vulpix,Jigglypuff,Zubat,Oddish,Paras,Venonat,Diglett,Meowth,Psyduck,Mankey,Growlithe,Poliwag,Abra,Machop,Bellsprout,Geodude,Ponyta,Slowpoke,Magnemite,Farfetchd,Doduo,Seel,Grimer,Shellder,Gastly,Onix,Drowzee,Krabby,Voltorb,Exeggcute,Cubone,Hitmonlee,Hitmonchan,Lickitung,Koffing,Rhyhorn,Chansey,Tangela,Kangaskhan,Horsea,Goldeen,Staryu,Mr. Mime,Scyther,Jynx,Electabuzz,Magmar,Pinsir,Tauros,Magikarp,Lapras,Ditto,Eevee,Porygon,Omanyte,Kabuto,Aerodactyl,Snorlax,Articuno,Zapdos,Moltres,Dratini,Dragonair,Dragonite,Mewtwo,Mew,Chikorita,Cyndaquil,Totodile,Sentret,Hoothoot,Ledyba,Spinarak,Chinchou,Pichu,Cleffa,Igglybuff,Togepi,Natu,Mareep,Bellossom,Marill,Sudowoodo,Politoed,Hoppip,Aipom,Sunkern,Yanma,Wooper,Murkrow,Misdreavus,Wobbuffet,Girafarig,Pineco,Dunsparce,Gligar,Steelix,Snubbull,Qwilfish,Scizor,Shuckle,Heracross,Sneasel,Teddiursa,Slugma,Swinub,Corsola,Remoraid,Octillery,Delibird,Mantine,Skarmory,Houndour,Phanpy,Donphan,Porygon2,Stantler,Smeargle,Tyrogue,Hitmontop,Smoochum,Elekid,Magby,Miltank,Blissey,Raikou,Entei,Suicune,Larvitar,Pupitar,Tyranitar,Lugia,HoOh,Celebi,Treecko,Torchic,Mudkip,Zigzagoon,Wurmple,Lotad';
    v_name_list DBMS_UTILITY.LNAME_ARRAY;
    r_limit INTEGER;
BEGIN
    dbms_utility.COMMA_TO_TABLE(
        v_names,
        r_limit,
        v_name_list
    );
    
    FOR i IN 1..v_name_list.COUNT LOOP
        v_name := v_name_list(i);
        v_type_id := MOD(i-1, 5) + 1;
        v_hp := 40 + MOD(i, 60);
        v_speed := 30 + MOD(i, 70);
        
        dbms_output.put_line('INSERTED: '||v_pokemon_id || ' ' ||  v_name);
        INSERT INTO pokemon (id, name, type_id, hp, speed) 
        VALUES (v_pokemon_id, v_name, v_type_id, v_hp, v_speed);
        
        v_pokemon_id := v_pokemon_id + 1;
    END LOOP;
END;
/
INSERT INTO trainers (id, name, age, city) VALUES (1, 'Ash', 10, 'Pallet Town');
INSERT INTO trainers (id, name, age, city) VALUES (2, 'Misty', 12, 'Cerulean City');
INSERT INTO trainers (id, name, age, city) VALUES (3, 'Brock', 15, 'Pewter City');

/
DECLARE
    v_trainer_id NUMBER;
    v_pokemon_id NUMBER := 1;
BEGIN
    FOR i IN 1..50 LOOP
        v_trainer_id := MOD(i, 3) + 1;
        
        FOR j IN 1..3 LOOP
            INSERT INTO pokemon_trainers (trainer_id, pokemon_id) 
            VALUES (v_trainer_id, v_pokemon_id);
            
            v_pokemon_id := v_pokemon_id + 1;
        END LOOP;
    END LOOP;
END;
/

INSERT INTO moves (id, name, type_id, power) VALUES (1, 'Thunder Shock', 1, 40);
INSERT INTO moves (id, name, type_id, power) VALUES (2, 'Water Gun', 2, 40);
INSERT INTO moves (id, name, type_id, power) VALUES (3, 'Flamethrower', 3, 90);
INSERT INTO moves (id, name, type_id, power) VALUES (4, 'Vine Whip', 4, 45);
INSERT INTO moves (id, name, type_id, power) VALUES (5, 'Quick Attack', 5, 40);

INSERT INTO battles (id, pokemon1_id, pokemon2_id, winner_id, battle_date) VALUES (1, 1, 2, 1, TO_DATE('2024-05-16', 'YYYY-MM-DD'));
INSERT INTO battles (id, pokemon1_id, pokemon2_id, winner_id, battle_date) VALUES (2, 3, 4, 4, TO_DATE('2024-05-17', 'YYYY-MM-DD'));

