--------------------------------
-- Types
--------------------------------
insert into Type values('Utility');
insert into Type values('Power');
insert into Type values('Defence');
insert into Type values('Technique');
insert into Type values('Mobility');

insert into Type values('Axe');
insert into Type values('Chain Blades');
insert into Type values('Hammer');
insert into Type values('Sword');
insert into Type values('War Pike');

insert into Type values('Head');
insert into Type values('Torso');
insert into Type values('Arms');
insert into Type values('Legs');

--------------------------------
-- Elements
--------------------------------

insert into Element (name) values('Neutral');
insert into Element (name) values('Blaze');
insert into Element (name) values('Frost');
insert into Element (name) values('Shock');
insert into Element (name) values('Terra');
insert into Element (name) values('Radiant');
insert into Element (name) values('Umbral');

update Element set strongAgainst='Frost' where name='Blaze';
update Element set strongAgainst='Blaze' where name='Frost';
update Element set strongAgainst='Terra' where name='Shock';
update Element set strongAgainst='Shock' where name='Terra';
update Element set strongAgainst='Umbral' where name='Radiant';
update Element set strongAgainst='Radiant' where name='Umbral';

--------------------------------
-- Sockets
--------------------------------

insert into Socket (id, type) values (1, 'Utility');
insert into Socket (id, type) values (2, 'Power');
insert into Socket (id, type) values (3, 'Defence');
insert into Socket (id, type) values (4, 'Technique');
insert into Socket (id, type) values (5, 'Mobility');

--------------------------------
-- Cells
--------------------------------

insert into Cell values ('Energized','Utility','Increase weapon meter gain rate');
insert into Cell values ('Medic','Utility','Improves your ability to revive allies');
insert into Cell values ('Aetheric Attunement','Utility','Percent increase to Lantern Charge gained from attacks');
insert into Cell values ('Knockout King','Power','Percent increase to Stagger damage');
insert into Cell values ('Overpower','Power','Increases damage against staggered Behemoths');
insert into Cell values ('Ragehunter','Power','Increases damage against enraged Behemoths');
insert into Cell values ('Fireproof','Defence','Protects against being set on fire');
insert into Cell values ('Nine Lives','Defence','Grants a chance to reduce damage, and later the ability to cheat death');
insert into Cell values ('Sturdy','Defence','Prevents being staggered on a cooldown');
insert into Cell values ('Acidic','Technique','Increases Wound damage at the cost of Part damage');
insert into Cell values ('Evasive Fury','Technique','Temporarily increases attack speed when dodging through a Behemoths attack');
insert into Cell values ('Weighted Strikes','Technique','Adds a flat amount of Stagger damage on hit, at later ranks allows more weapon attacks to interrupt');
insert into Cell values ('Agility','Mobility','Reduces the stamina cost of dodging');
insert into Cell values ('Conditioning','Mobility','Increases Stamina Regen');
insert into Cell values ('Evasion','Mobility','Increases the time you are invincible when dodging');

insert into Cell values ('Cunning', 'Technique', 'Grants a chance to deal double damage');
--------------------------------
-- Lanterns
--------------------------------
insert into Lantern values ('Drasks Eye',1,'Deal 30% increased damage for 6 seconds','Fires a lightning bolt in a direction that deals 150 Shock damage multiple times as it passes through enemies');
insert into Lantern values ('Embermanes Rapture',1,'Attack 25% faster for 8 seconds','Create a fire ball in front of you that explodes after 5 seconds, dealing 850 Blaze damage to all nearby Behemoths');
insert into Lantern values ('Pangars Shine',1,'Restore 25% of your maximum stamina','Create a frost pillar in front of you that deals 960 Frost damage to nearby enemies over 12 seconds');

--------------------------------
-- Test loadout -lantern
--------------------------------

-- create loadout
insert into Loadout default values 

-- create weapon
exec CreateWeapon @name = 'Eyes of Night', @special = 'Reapers Dance', @uniqueEffect = 'When under 20% health, deal +50% damage', @type = 'Chain Blades', @element = 'Umbral', @innateCell = 'Cunning', @socketOne = 4, @socketTwo = 1;

-- add weapon to loadout
exec AddWeapon @name='Eyes of Night', @loadout=1, @cellOne='Cunning', @cellTwo='Aetheric Attunement';

-- create armour pieces
insert into Armour values ('Hellplate Casque', 4, 'Head', 'Blaze', 'Ragehunter');
insert into Armour values ('Fiery Breastplate', 5, 'Torso', 'Blaze', 'Evasive Fury');
insert into Armour values ('Gnasher Grips', 2, 'Arms', 'Neutral', 'Ragehunter');
insert into Armour values ('Dance of the Swarm', 2, 'Legs', 'Terra', 'Conditioning');

-- add armour pieces to loadout
insert into ArmourCell (armour, cell, Loadout_id) values ('Hellplate Casque', 'Evasive Fury', 1);
insert into ArmourCell (armour, cell, Loadout_id) values ('Fiery Breastplate', 'Conditioning', 1);
insert into ArmourCell (armour, cell, Loadout_id) values ('Gnasher Grips', 'Overpower', 1);
insert into ArmourCell (armour, cell, Loadout_id) values ('Dance of the Swarm', 'Overpower', 1);

-- add lantern to loadout
insert into LanternCell (lantern, cell, Loadout_id) values ('Drasks Eye', 'Aetheric Attunement', 1);
