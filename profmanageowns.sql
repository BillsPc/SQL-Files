INSERT INTO ProfManageOwning (profName, trainerID, pokeID, boxNumber)
SELECT pb.profName, o.trainerID, o.pokeID, o.boxNumber
FROM ProfManageBox pb, Owns o
WHERE pb.boxNumber = o.boxNumber;