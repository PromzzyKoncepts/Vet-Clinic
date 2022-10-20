INSERT into animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Agumon', '2020-03-02', 0, true, 10.23);

INSERT into animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Pikachu', '2021-01-07', 1, false, 15.04);

INSERT into animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Gabumon', '2018-11-15', 2, true, 8);

INSERT into animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Devimon', '2017-05-12', 5, true, 11);

INSERT into animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', '2021-11-15', 2, true, -5.7);
INSERT into animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', '1993-04-02', 3, false, -12.13);
INSERT into animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', '1998-10-13', 3, true, 17);
INSERT into animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', '2005-06-12', 1, true, -45);
INSERT into animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', '2005-06-07', 7, true, 24.5
INSERT into animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Ditto', '2022-05-14', 4, true, 22);

-- Day 2 project
select * from animals;
alter table animals add column species varchar;
INSERT into animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', '2021-11-15', 2, true, -5.7);
INSERT into animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', '1993-04-02', 3, false, -12.13);
INSERT into animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', '1998-10-13', 3, true, 17);
INSERT into animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', '2005-06-12', 1, true, -45);
INSERT into animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', '2005-06-07', 7, true, 24.5
INSERT into animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Ditto', '2022-05-14', 4, true, 22);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', '2020/2/8', '0', 'false', '-11.0');


DAY 3

/*Insert the following data into the owners table:
Sam Smith 34 years old.
Jennifer Orwell 19 years old.
Bob OW 45 years old.
Melody Pond 77 years old.
Dean Winchester 14 years old.
Jodie Whittaker 38 years old.
*/
INSERT INTO owners (full_name, age) VALUES
   ('Sam Smith', 34),
   ('Jennifer Orwell', 19),
   ('Bob', 45),
   ('Melody Pond', 77),
   ('Dean Winchester', 14),
   ('Jodie Whittaker', 38);

/*
Insert the following data into the species table:
Pokemon
Digimon
*/
INSERT INTO species (name) VALUES
   ('Pokemon'),
   ('Digimon');

/*
Modify your inserted animals so it includes the species_id value:
If the name ends in "mon" it will be Digimon
All other animals are Pokemon
*/
UPDATE animals
SET species_id=2
WHERE name LIKE '%mon';

UPDATE animals
SET species_id=1
WHERE species_id IS NULL;

/*
Modify your inserted animals to include owner information (owner_id):
Sam Smith owns Agumon.
Jennifer Orwell owns Gabumon and Pikachu.
Bob owns Devimon and Plantmon.
Melody Pond owns Charmander, Squirtle, and Blossom.
Dean Winchester owns Angemon and Boarmon.
*/
UPDATE animals
SET owner_id=1
WHERE name='Agumon';

UPDATE animals
SET owner_id=2
WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
SET owner_id=3
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id=4
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id=5
WHERE name IN ('Angemon', 'Boarmon');