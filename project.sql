#1st gen
#TODO: Population Pokedex = Cass
#TODO: Population rest = Josh
#TODO: Population itemdex = Henry

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS profmanagebox;
DROP TABLE IF EXISTS profmanageowning;
DROP TABLE IF EXISTS owns;
DROP TABLE IF EXISTS box;
DROP TABLE IF EXISTS pokemon;
DROP TABLE IF EXISTS trainers;
DROP TABLE IF EXISTS professors;
DROP TABLE IF EXISTS towns;
DROP TABLE IF EXISTS itemheld;
DROP TABLE IF EXISTS pokedex;
DROP TABLE IF EXISTS itemdex;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE Box (
boxNumber INT NOT NULL PRIMARY KEY,
boxName CHAR(15) NULL,
boxWallpaper CHAR(15) NULL
);

CREATE TABLE Pokedex (
dexNo INT NOT NULL PRIMARY KEY,
species CHAR(15) NOT NULL,
type CHAR(15) NULL,
gender CHAR(2) NOT NULL CHECK (gender IN ('M', 'F', 'MF', 'U'))
);

CREATE TABLE Pokemon (
pokeID INT NOT NULL PRIMARY KEY,
pokeName CHAR(15) NOT NULL,
dexNo INT NOT NULL,
level INT NOT NULL,
gender CHAR(1) NOT NULL, CHECK (gender LIKE (SELECT gender FROM Pokedex WHERE Pokedex.dexNo = Pokemon.dexNo LIMIT 1)),
FOREIGN KEY (dexNo) REFERENCES Pokedex(dexNo)
);

CREATE TABLE Towns(
townName CHAR(15) NOT NULL PRIMARY KEY,
region CHAR(15) NULL
);

CREATE TABLE Trainers(
trainerID INT NOT NULL PRIMARY KEY,
trainerName CHAR(15) NOT NULL,
townName CHAR(15) NOT NULL, FOREIGN KEY (townName) REFERENCES Towns (townName)
);

CREATE TABLE Professors(
profName CHAR(15) NOT NULL PRIMARY KEY,
townName CHAR(15) NOT NULL, FOREIGN KEY (townName) REFERENCES Towns (townName)
);

CREATE TABLE ItemDex(
itemName CHAR(15) NOT NULL PRIMARY KEY,
description CHAR(40) NULL
);

CREATE TABLE ItemHeld(
pokeID INT NOT NULL PRIMARY KEY,
itemName CHAR(15) NOT NULL,
FOREIGN KEY (pokeID) REFERENCES Pokemon (pokeID), FOREIGN KEY (itemName) REFERENCES ItemDex(itemName)
);

CREATE TABLE Owns (
trainerID INT NOT NULL,
pokeID INT NOT NULL,
boxNumber INT NULL, PRIMARY KEY (trainerID, pokeID), FOREIGN KEY (trainerID) REFERENCES Trainers(trainerID), FOREIGN KEY (pokeID) REFERENCES Pokemon(pokeID), FOREIGN KEY (boxNumber) REFERENCES Box(boxNumber)
);

CREATE TABLE ProfManageBox (
profName CHAR(15) NOT NULL,
boxNumber INT NOT NULL, PRIMARY KEY (profName, boxNumber), FOREIGN KEY (profName) REFERENCES Professors(profName), FOREIGN KEY (boxNumber) REFERENCES Box(boxNumber)
);

CREATE TABLE ProfManageOwning (
profName CHAR(15) NOT NULL,
trainerID INT NOT NULL,
pokeID INT NOT NULL,
boxNumber INT NOT NULL, PRIMARY KEY (profName, trainerID, pokeID), FOREIGN KEY (profName) REFERENCES Professors(profName), FOREIGN KEY (trainerID) REFERENCES Trainers(trainerID), FOREIGN KEY (pokeID) REFERENCES Pokemon(pokeID), FOREIGN KEY (boxNumber) REFERENCES Box(boxNumber)
);