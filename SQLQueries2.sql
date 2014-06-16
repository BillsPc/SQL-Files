#TRAINER ADMINISTRATIVE QUERIES

#Add a pokemon
INSERT INTO Pokemon
VALUES (pokeID, pokeName, dexNo, gender);
INSERT INTO Owns
VALUES (trainerId, pokeId, boxNo);

#Delete a pokemon
DELETE FROM Pokemon
WHERE trainerid=inserted.trainerid AND pokeID = insertedPokeID;

#Change a pokemon box
UPDATE Owns
SET boxNumber = insertedBoxNumber
WHERE pokeID = inserted.PokeID AND trainerID = insertedTrainerID;

#Give pokemon an item
INSERT INTO ItemHeld
VALUES (pokeID, itemID);

#Take an item
DELETE FROM ItemHeld
WHERE owns.trainerID = insertedTrainerID AND owns.pokeID = insertedPokeID AND ItemHeld.pokeID = Owns.pokeID AND itemID = insertedItemID;


#TRAINER POKEMON SEARCHES

#find pokemon using pokeID
SELECT *
FROM Pokemon, Owns
WHERE Pokemon.pokeID = Owns.pokeID AND Owns.trainerID = insertedTrainerID AND Pokemon.pokeID = insertedPokeID;

#find using species
SELECT *
FROM Pokemon, Owns, Pokedex
WHERE Pokemon.pokeID = Owns.pokeID AND Owns.trainerID = insertedTrainerID AND Pokemon.dexNo = Pokedex.dexNo AND Pokedex.species LIKE "%INSERTEDSPECIES%";
#(like? or equal or other?)

#find using level
SELECT *
FROM Pokemon, Owns
WHERE Pokemon.pokeID = Owns.pokeID AND Owns.trainerID = insertedTrainerID AND Pokemon.level = insertedLevel;

#find using level window
SELECT *
FROM Pokemon, Owns
WHERE Pokemon.pokeID = Owns.pokeID AND Owns.trainerID = insertedTrainerID AND Pokemon.level >= insertedLowerLevel AND Pokemon.level <= insertedHigherLevel;

#find using types
SELECT *
FROM Pokemon, Owns, Pokedex
WHERE Pokemon.pokeID = Owns.pokeID AND Owns.trainerID = insertedTrainerID AND Pokemon.dexNo = Pokedex.dexNo AND Pokedex.type LIKE "%InsertedType%";
#(use like because of double types)

#find strongest pokemon level for each type
Select Pokedex.type, Max(level)
FROM Pokemon, Owns, Pokedex
WHERE Pokemon.pokeID = Owns.pokeID AND Owns.TrainerID = insertedTrainerID AND Pokemon.dexNo = Pokdex.dexNo
GROUP BY Pokedex.type;


#PROFESSOR SEARCHES

#Find pokemon using pokeID
SELECT *
FROM Pokemon, Owns
WHERE Pokemon.pokeID = insertedPokeID;

#Find using species
SELECT *
FROM Pokemon, Pokedex
WHERE Pokemon.dexNo = Pokedex.dexNo AND Pokedex.species LIKE "%INSERTEDSPECIES%";
#(like? or equal or other?)

#Find using level
SELECT *
FROM Pokemon
WHERE Pokemon.level = insertedLevel;

#Find using domain
SELECT *
FROM Pokemon
WHERE Pokemon.level >= insertedLowerLevel AND Pokemon.level <= insertedHigherLevel;

#Find using types
SELECT *
FROM Pokemon, Pokedex
WHERE Pokemon.dexNo = Pokedex.dexNo AND Pokedex.type LIKE "%INSERTEDTYPE%";
#(use like because of double types)

#find using trainerID
SELECT *
FROM Pokemon, Owns, Trainers
WHERE Pokemon.dexNo = Owns.dexNo AND Trainers.trainerID = Owns.trainerID AND Trainers.trainerID = insertedTrainerID;

#find using trainerName
SELECT *
FROM Pokemon, Owns, Trainers
WHERE Pokemon.dexNo = Owns.dexNo AND Trainers.trainerID = Owns.trainerID AND Trainers.trainerName LIKE "%insertedname%";

#find strongest pokemon for each trainerID

Select Owns.trainerID, Max(level)
FROM Pokemon, Owns
WHERE Pokemon.pokeID = Owns.pokeID AND Owns.TrainerID = insertedTrainerID
GROUP BY Owns.trainerID;

#PROFESSOR ADMINISTRATIVE QUERIES

#change a pokemon box
UPDATE Owns
SET boxNumber = insertedBoxNumber
WHERE pokeID = inserted.PokeID;

#change a box name
UPDATE Box 
SET boxName = insertBoxName
WHERE boxNumber = insertedBoxNumber;

#change a box wallpaper
UPDATE Box 
SET boxWallpaper = insertBoxWallpaper
WHERE boxNumber = insertedBoxNumber;



#FRIENDSHIP IS MAGIC -TRAINERS 


#show friends
SELECT *
FROM Trainers, Friends
WHERE Friends.trainerID1 = insertedTrainerID AND Friends.trainerID2 = Trainers.trainerID;

# add friends
INSERT INTO Friends
VALUES (insertedTrainerID, friendID);

# search for trainers using hometown
SELECT *
FROM Trainers
WHERE Trainers.townName = insertedTownName;

#search for trainers using ID
SELECT *
FROM Trainers
WHERE Trainers.trainerID = insertedID;

#search for trainers using name
SELECT *
FROM Trainers
WHERE Trainers.trainerName LIKE "%insertedName%";

#FRIEND STATISTICS

CREATE VIEW friendsPokemon(int trainerID, int pokeID, int pokeType, int level) AS
SELECT o.trainerID, o.pokeID, p.type, p.level
FROM Owns o, Friends f, Pokemon p
WHERE f.trainerID1 = insertedTrainerID AND f.trainerID2 = o.trainerID AND o.pokeID = p.pokeID;

#show friend stats (number of pokemon, average level, strongest pokemon)
SELECT trainerID, COUNT(pokeID), AVG(level), MAX(level)
FROM friendsPokemon
GROUP BY trainerID;
