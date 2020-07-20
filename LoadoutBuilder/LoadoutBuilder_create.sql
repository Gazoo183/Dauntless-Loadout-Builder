
--------------------------------
-- Functions
--------------------------------

-- Comparing types of cells and sockets on Armour
go
create function ArmourSocketCellTypeCheck (@armour nvarchar(25), @cell nvarchar(25))
returns bit as
begin
if ((select type from Socket where id=(select socket from Armour where name=@armour))=(select type from Cell where name=@cell))
begin
return 1;
end;
return 0;
end;
go

-- Comparing types of cells and sockets on Lantern
create function LanternSocketCellTypeCheck (@lantern nvarchar(25), @cell nvarchar(25))
returns bit as
begin
if ((select type from Socket where id=(select socket from Lantern where name=@lantern))=(select type from Cell where name=@cell))
begin
return 1;
end;
return 0;
end;
go

-- Comparing types of cells and sockets on Weapon
create function WeaponSocketCellTypeCheck (@weaponcellid int, @cell nvarchar(25))
returns bit as
begin
if((select count(*) from SW inner join Socket on SW.socket=Socket.id where weapon=(select weapon from WeaponCell where id=@weaponcellid) AND Socket.type=(select type from Cell where name=@cell))>0)
begin
	if((select (select count(*) from SW inner join Socket on SW.socket=Socket.id where weapon=(select weapon from WeaponCell where id=@weaponcellid) AND Socket.type=(select type from Cell where name=@cell))-(select count(*) from ManyToMany inner join Cell on ManyToMany.cell=Cell.name where weapon=@weaponcellid and Cell.type=(select type from Cell where name=@cell)))>-1)
begin
return 1;
end;
end;

return 0;
end;
go

--------------------------------
-- Tables
--------------------------------

-- Armour
create table Armour (
    name nvarchar(25)  NOT NULL,
    socket int  NOT NULL,
    type nvarchar(25)  NOT NULL,
    element nvarchar(10)  NOT NULL,
    innateCell nvarchar(25)  NULL,
    constraint Armour_pk primary key  (name)
);

-- ArmourCell
create table ArmourCell (
    id int  NOT NULL identity,
    armour nvarchar(25)  NOT NULL,
    cell nvarchar(25)  NOT NULL,
    Loadout_id int  NOT NULL,
    constraint ASCCheck check (dbo.ArmourSocketCellTypeCheck(armour, cell)=1),
    constraint ArmourCell_pk primary key  (id)
);

-- Cell
create table Cell (
    name nvarchar(25)  NOT NULL,
    type nvarchar(25)  NOT NULL,
    perk nvarchar(max)  NOT NULL,
    constraint Cell_pk primary key  (name)
);

-- Element
create table Element (
    name nvarchar(10)  NOT NULL,
    strongAgainst nvarchar(10)  NULL,
    constraint Element_pk primary key  (name)
);

-- Lantern
create table Lantern (
    name nvarchar(25)  NOT NULL,
    socket int  NOT NULL,
    tap nvarchar(max)  NOT NULL,
    hold nvarchar(max)  NOT NULL,
    constraint Lantern_pk primary key  (name)
);

-- LanternCell
create table LanternCell (
    id int  NOT NULL identity,
    lantern nvarchar(25)  NOT NULL,
    cell nvarchar(25)  NULL,
    Loadout_id int  NOT NULL,
    constraint LSCCheck check (dbo.LanternSocketCellTypeCheck(lantern, cell)=1),
    constraint LanternCell_pk primary key  (id)
);

-- Loadout
create table Loadout (
    id int  NOT NULL identity,
    constraint Loadout_pk primary key  (id)
);

-- ManyToMany
create table ManyToMany (
    id int  NOT NULL identity,
    cell nvarchar(25)  NOT NULL,
    weapon int  NOT NULL,
    constraint WSCCheck check (dbo.WeaponSocketCellTypeCheck(weapon, cell)=1),
    constraint ManyToMany_pk primary key  (id)
);

-- SW
create table SW (
    id int  NOT NULL identity,
    weapon nvarchar(25)  NOT NULL,
    socket int  NOT NULL,
    constraint SW_pk primary key  (id)
);

-- Socket
create table Socket (
    id int  NOT NULL,
    type nvarchar(25)  NOT NULL,
    constraint Socket_pk primary key  (id)
);

-- Type
create table Type (
    name nvarchar(25)  NOT NULL,
    constraint Type_pk primary key  (name)
);

-- Weapon
create table Weapon (
    name nvarchar(25)  NOT NULL,
    special nvarchar(max)  NOT NULL,
    uniqueEffect nvarchar(max)  NOT NULL,
    type nvarchar(25)  NOT NULL,
    element nvarchar(10)  NOT NULL,
    innateCell nvarchar(25)  NULL,
    constraint Weapon_pk primary key  (name)
);

-- WeaponCell
create table WeaponCell (
    id int  NOT NULL identity,
    weapon nvarchar(25)  NOT NULL,
    Loadout_id int  NOT NULL,
    constraint WeaponCell_pk primary key  (id)
);

--------------------------------
-- Foreign Keys
--------------------------------

-- Reference: ArmourCell_Armour (table: ArmourCell)
alter table ArmourCell add constraint ArmourCell_Armour
    foreign key (armour)
    references Armour (name)
    on delete  cascade;

-- Reference: ArmourCell_Cell (table: ArmourCell)
alter table ArmourCell add constraint ArmourCell_Cell
    foreign key (cell)
    references Cell (name);

-- Reference: ArmourCell_Loadout (table: ArmourCell)
alter table ArmourCell add constraint ArmourCell_Loadout
    foreign key (Loadout_id)
    references Loadout (id)
    on delete  cascade;

-- Reference: Armour_Cell (table: Armour)
alter table Armour add constraint Armour_Cell
    foreign key (innateCell)
    references Cell (name);

-- Reference: Armour_Element (table: Armour)
alter table Armour add constraint Armour_Element
    foreign key (element)
    references Element (name);

-- Reference: Armour_Socket (table: Armour)
alter table Armour add constraint Armour_Socket
    foreign key (socket)
    references Socket (id);

-- Reference: Armour_Type (table: Armour)
alter table Armour add constraint Armour_Type
    foreign key (type)
    references Type (name);

-- Reference: Cell_Type (table: Cell)
alter table Cell add constraint Cell_Type
    foreign key (type)
    references Type (name);

-- Reference: Element_Element (table: Element)
alter table Element add constraint Element_Element
    foreign key (strongAgainst)
    references Element (name);

-- Reference: LanternCell_Cell (table: LanternCell)
alter table LanternCell add constraint LanternCell_Cell
    foreign key (cell)
    references Cell (name);

-- Reference: LanternCell_Lantern (table: LanternCell)
alter table LanternCell add constraint LanternCell_Lantern
    foreign key (lantern)
    references Lantern (name)
    on delete  cascade;

-- Reference: LanternCell_Loadout (table: LanternCell)
alter table LanternCell add constraint LanternCell_Loadout
    foreign key (Loadout_id)
    references Loadout (id)
    on delete  cascade;

-- Reference: Lantern_Socket (table: Lantern)
alter table Lantern add constraint Lantern_Socket
    foreign key (socket)
    references Socket (id);

-- Reference: ManyToMany_Cell (table: ManyToMany)
alter table ManyToMany add constraint ManyToMany_Cell
    foreign key (cell)
    references Cell (name);

-- Reference: ManyToMany_WeaponCell (table: ManyToMany)
alter table ManyToMany add constraint ManyToMany_WeaponCell
    foreign key (weapon)
    references WeaponCell (id)
    on delete  cascade;

-- Reference: SW_Socket (table: SW)
alter table SW add constraint SW_Socket
    foreign key (socket)
    references Socket (id);

-- Reference: SW_Weapon (table: SW)
alter table SW add constraint SW_Weapon
    foreign key (weapon)
    references Weapon (name)
    on delete  cascade;

-- Reference: Socket_Type (table: Socket)
alter table Socket add constraint Socket_Type
    foreign key (type)
    references Type (name);

-- Reference: WeaponCell_Loadout (table: WeaponCell)
alter table WeaponCell add constraint WeaponCell_Loadout
    foreign key (Loadout_id)
    references Loadout (id)
    on delete  cascade;

-- Reference: WeaponCell_Weapon (table: WeaponCell)
alter table WeaponCell add constraint WeaponCell_Weapon
    foreign key (weapon)
    references Weapon (name)
    on delete  cascade;

-- Reference: Weapon_Cell (table: Weapon)
alter table Weapon add constraint Weapon_Cell
    foreign key (innateCell)
    references Cell (name);

-- Reference: Weapon_Element (table: Weapon)
alter table Weapon add constraint Weapon_Element
    foreign key (element)
    references Element (name);

-- Reference: Weapon_Type (table: Weapon)
alter table Weapon add constraint Weapon_Type
    foreign key (type)
    references Type (name);

--------------------------------
-- Procedures
--------------------------------

-- Creating weapon with specific sockets
go
create procedure CreateWeapon @name nvarchar(25), @special nvarchar(max), @uniqueEffect nvarchar(max), @type nvarchar(max), @element nvarchar(10), @innateCell nvarchar(max), @socketOne int, @socketTwo int
as begin
begin tran t1;
insert into Weapon values (@name, @special, @uniqueEffect, @type, @element, @innateCell);
if (@socketOne is not null)
begin
insert into SW (weapon, socket) values (@name, @socketOne);
end;
if (@socketTwo is not null)
begin
insert into SW (weapon, socket) values (@name, @socketTwo);
end;
commit tran t1;
end;
go

-- Adding weapon to loadout
create procedure AddWeapon @name nvarchar(25), @loadout int, @cellOne nvarchar(25), @cellTwo nvarchar(25)
as begin
begin try
begin tran t2;
insert into WeaponCell (weapon, Loadout_id) values (@name, @loadout)
if(@cellOne is not null) begin
insert into ManyToMany (cell, weapon) values (@cellOne, (select id from WeaponCell where Loadout_id=@loadout))
end
if(@cellTwo is not null) begin
insert into ManyToMany (cell, weapon) values (@cellTwo, (select id from WeaponCell where Loadout_id=@loadout))
end
commit tran t2;
end try
begin catch
if @@TRANCOUNT > 0
rollback tran t2;
end catch
end;
go

-- Showing loadout
create procedure ShowLoadout @loadout int
as begin
select Loadout_id, WeaponCell.weapon as gear, (stuff((select ', ' + cell from  WeaponCell inner join ManyToMany on WeaponCell.id=ManyToMany.weapon where Loadout_id=@loadout for xml path('')), 1, 2, '')) as cell from WeaponCell inner join ManyToMany on WeaponCell.id=ManyToMany.weapon where Loadout_id=@loadout group by Loadout_id, WeaponCell.weapon
union
select Loadout_id, armour as gear, cell from ArmourCell where Loadout_id=@loadout
union
select Loadout_id, lantern as gear, cell from LanternCell where Loadout_id=@loadout
end;
go

--------------------------------
-- Triggers
--------------------------------

-- Allows adding to loadout only one piece of armour of each type (head, torso, arms, legs)
create trigger ArmourTypeCheck on ArmourCell after insert
as begin
declare @tmp int;

declare ArmourTypeChechCursor cursor fast_forward for
select Loadout_id from inserted;

open ArmourTypeChechCursor;
fetch next from ArmourTypeChechCursor into @tmp;

while @@FETCH_STATUS = 0
begin
if ((select max(A.types) from (select count(Armour.type) as types from ArmourCell inner join Armour on ArmourCell.armour=Armour.name where ArmourCell.Loadout_id=@tmp group by Armour.type) as A)>1)
begin
rollback transaction;
end;
fetch next from ArmourTypeChechCursor into @tmp;
end;

close ArmourTypeChechCursor
deallocate ArmourTypeChechCursor

end;
go