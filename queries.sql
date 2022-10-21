SELECT * FROM animals WHERE name LIKE '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT * FROM animals WHERE neutered = true AND escape_attempts<3;

SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

SELECT name, escape_attempts FROM animals WHERE weight_kg>10.5;

SELECT * FROM animals WHERE neutered = true;

SELECT * FROM animals WHERE name != 'Gabumon';

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


/*
Inside a transaction:
Update the animals table by setting the species column to unspecified. Verify that change was made.
Then roll back the change and verify that the species columns went back to the state before the transaction.
*/

BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;


/*
Inside a transaction:
Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
Commit the transaction.
Verify that change was made and persists after commit.
*/

BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
SELECT * FROM animals;
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;


/*
Inside a transaction:
Delete all records in the animals table, then roll back the transaction.
After the rollback verify if all records in the animals table still exists.
*/
BEGIN TRANSACTION;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/*
Inside a transaction:
Delete all animals born after Jan 1st, 2022.
Create a savepoint for the transaction.
Update all animals' weight to be their weight multiplied by -1.
Rollback to the savepoint
Update all animals' weights that are negative to be their weight multiplied by -1.
Commit transaction
*/

BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SELECT * FROM animals;
SAVEPOINT delete_20220101_dob;
UPDATE animals SET weight_kg=weight_kg*-1;
SELECT * FROM animals;
ROLLBACK TO delete_20220101_dob;
UPDATE animals SET weight_kg=weight_kg*-1 where weight_kg<0;
SELECT * FROM animals;
COMMIT;


-- How many animals are there?
SELECT COUNT(*) AS TOTAL_ANIMALS FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) AS ZERO_ESCAPE_ATTEMPTS FROM animals WHERE escape_attempts=0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) AS AVG_WEIGHT FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) AS MOST_ESCAPE_ATTEMPTS_GROUP_BY_NEUTERED FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS MIN_WEIGHT, MAX(weight_kg) AS MAX_WEIGHT FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS AVG_ESCAPE_ATTEMPTS FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species ;


-- day 5
SELECT name FROM animals INNER JOIN owners ON animals.owner_id=owners.id WHERE owner.full_name='Melody Pond';

/* List of all animals that are pokemon (their type is Pokemon).*/
SELECT * FROM animals LEFT JOIN species ON animal.species_id=species.id WHERE species.name='Pokemon';

/* List all owners and their animals, remember to include those that don't own any animal.*/
SELECT * FROM owners LEFT JOIN animals ON owners.id=animals.owner_id;

/* How many animals are there per species?*/
SELECT COUNT(a.species_id) AS COUNT_SPECIES, s.name FROM animals a JOIN species s ON a.species_id=s.id GROUP BY s.name, a.species_id;

/* List all Digimon owned by Jennifer Orwell.*/
SELECT * FROM animals a JOIN owners o ON a.owner_id=o.id JOIN species s ON a.species_id=s.id WHERE o.full_name='Jennifer Orwell' AND s.name='Digimon';

/* List all animals owned by Dean Winchester that haven't tried to escape.*/
SELECT * FROM animals a JOIN owners o ON a.owner_id=o.id JOIN species s ON a.species_id=s.id WHERE o.full_name='Jennifer Orwell' AND s.name='Digimon';

/* Who owns the most animals?*/
SELECT COUNT(*) AS COUNT_OWN, o.full_name FROM animals a JOIN owners o ON o.id=a.owner_id GROUP BY o.full_name ORDER BY COUNT_OWN DESC LIMIT 1;


-- DAY 4

SELECT animals.name, visit_date
FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visit_date DESC LIMIT 1;


SELECT COUNT(DISTINCT animal_id)
FROM visits
JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'Stephanie Mendez';

SELECT DISTINCT vets.name
FROM specializations
RIGHT JOIN vets ON specializations.vets_id = vets.id;

SELECT animals.name, visit_date
FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'Stephanie Mendez' AND
visits.visit_date BETWEEN '2020-04-01' and '2020-08-30'


SELECT count(animal_id) as amount_of_visits, animals.name
FROM visits
JOIN animals
ON animals.id = visits.animal_id
GROUP BY animal_id, animals.name
ORDER BY COUNT(animal_id) DESC LIMIT 1;

SELECT animals.name, visit_date
FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visit_date LIMIT 1;

SELECT animals.id as animal_id,
animals.name as animal_name,
vets.id as vet_id,
vets.name as vet_name, visit_date
FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON visits.vets_id = vets.id
ORDER BY visit_date LIMIT 1;

SELECT count(animals.name)
FROM visits
JOIN animals 
ON animals.id = visits.animal_id
JOIN specializations
ON specializations.vets_id = visits.vets_id
where animals.species_id <> specializations.species_id;

SELECT species.name 
FROM visits 
JOIN vets 
ON visits.vets_id = vets.id
join animals on animals.id = visits.animal_id
join species on species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY animal_id, species.name
ORDER BY COUNT(animal_id) DESC LIMIT 1;

