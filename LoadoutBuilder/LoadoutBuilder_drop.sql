
ALTER TABLE ArmourCell DROP CONSTRAINT ArmourCell_Armour;

ALTER TABLE ArmourCell DROP CONSTRAINT ArmourCell_Cell;

ALTER TABLE ArmourCell DROP CONSTRAINT ArmourCell_Loadout;

ALTER TABLE Armour DROP CONSTRAINT Armour_Cell;

ALTER TABLE Armour DROP CONSTRAINT Armour_Element;

ALTER TABLE Armour DROP CONSTRAINT Armour_Socket;

ALTER TABLE Armour DROP CONSTRAINT Armour_Type;

ALTER TABLE Cell DROP CONSTRAINT Cell_Type;

ALTER TABLE Element DROP CONSTRAINT Element_Element;

ALTER TABLE LanternCell DROP CONSTRAINT LanternCell_Cell;

ALTER TABLE LanternCell DROP CONSTRAINT LanternCell_Lantern;

ALTER TABLE LanternCell DROP CONSTRAINT LanternCell_Loadout;

ALTER TABLE Lantern DROP CONSTRAINT Lantern_Socket;

ALTER TABLE ManyToMany DROP CONSTRAINT ManyToMany_Cell;

ALTER TABLE ManyToMany DROP CONSTRAINT ManyToMany_WeaponCell;

ALTER TABLE SW DROP CONSTRAINT SW_Socket;

ALTER TABLE SW DROP CONSTRAINT SW_Weapon;

ALTER TABLE Socket DROP CONSTRAINT Socket_Type;

ALTER TABLE WeaponCell DROP CONSTRAINT WeaponCell_Loadout;

ALTER TABLE WeaponCell DROP CONSTRAINT WeaponCell_Weapon;

ALTER TABLE Weapon DROP CONSTRAINT Weapon_Cell;

ALTER TABLE Weapon DROP CONSTRAINT Weapon_Element;

ALTER TABLE Weapon DROP CONSTRAINT Weapon_Type;

DROP TABLE Armour;

DROP TABLE ArmourCell;

DROP TABLE Cell;

DROP TABLE Element;

DROP TABLE Lantern;

DROP TABLE LanternCell;

DROP TABLE Loadout;

DROP TABLE ManyToMany;

DROP TABLE SW;

DROP TABLE Socket;

DROP TABLE Type;

DROP TABLE Weapon;

DROP TABLE WeaponCell;

DROP FUNCTION ArmourSocketCellTypeCheck;

DROP FUNCTION LanternSocketCellTypeCheck;

DROP FUNCTION WeaponSocketCellTypeCheck;

DROP PROCEDURE AddWeapon;

DROP PROCEDURE CreateWeapon;

DROP PROCEDURE ShowLoadout;

