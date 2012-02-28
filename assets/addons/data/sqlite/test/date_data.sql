-- This script populates the Supplier, Parts, Projects database
-- from the Date text.

-- Populate the tables with the data from the Date text.
-- Populating all tables

begin transaction;

insert into S (SID, SNAME, STATUS, CITY) values ('S1', 'Smith', 20, 'London');
insert into S (SID, SNAME, STATUS, CITY) values ('S2', 'Jones', 10, 'Paris');
insert into S (SID, SNAME, STATUS, CITY) values ('S3', 'Blake', 30, 'Paris');
insert into S (SID, SNAME, STATUS, CITY) values ('S4', 'Clark', 20, 'London');
insert into S (SID, SNAME, STATUS, CITY) values ('S5', 'Adams', 30, 'Athens');

insert into P values ('P1', 'Nut', 'Red', 12.0, 'London');
insert into P values ('P2', 'Bolt', 'Green', 17.0, 'Paris');
insert into P values ('P3', 'Screw', 'Blue', 17.0, 'Oslo');
insert into P values ('P4', 'Screw', 'Red', 14.0, 'London');
insert into P values ('P5', 'Cam', 'Blue', 12.0, 'Paris');
insert into P values ('P6', 'Cog', 'Red', 19.0, 'London');

insert into SP values ('S1', 'P1', 300);
insert into SP values ('S1', 'P2', 200);
insert into SP values ('S1', 'P3', 400);
insert into SP values ('S1', 'P4', 200);
insert into SP values ('S1', 'P5', 100);
insert into SP values ('S1', 'P6', 100);
insert into SP values ('S2', 'P1', 300);
insert into SP values ('S2', 'P2', 400);
insert into SP values ('S3', 'P2', 200);
insert into SP values ('S4', 'P2', 200);
insert into SP values ('S4', 'P4', 300);
insert into SP values ('S4', 'P5', 400);

insert into J values ('J1', 'Sorter', 'Paris');
insert into J values ('J2', 'Display', 'Rome');
insert into J values ('J3', 'OCR', 'Athens');
insert into J values ('J4', 'Console', 'Athens');
insert into J values ('J5', 'RAID', 'London');
insert into J values ('J6', 'EDS', 'Oslo');
insert into J values ('J7', 'Tape', 'London');

insert into SPJ values ('S1', 'P1', 'J1', 200);
insert into SPJ values ('S1', 'P1', 'J4', 700);
insert into SPJ values ('S2', 'P3', 'J1', 400);
insert into SPJ values ('S2', 'P3', 'J2', 200);
insert into SPJ values ('S2', 'P3', 'J3', 200);
insert into SPJ values ('S2', 'P3', 'J4', 500);
insert into SPJ values ('S2', 'P3', 'J5', 600);
insert into SPJ values ('S2', 'P3', 'J6', 400);
insert into SPJ values ('S2', 'P3', 'J7', 800);
insert into SPJ values ('S2', 'P5', 'J2', 100);
insert into SPJ values ('S3', 'P3', 'J1', 200);
insert into SPJ values ('S3', 'P4', 'J2', 500);
insert into SPJ values ('S4', 'P6', 'J3', 300);
insert into SPJ values ('S4', 'P6', 'J7', 300);
insert into SPJ values ('S5', 'P2', 'J2', 200);
insert into SPJ values ('S5', 'P2', 'J4', 100);
insert into SPJ values ('S5', 'P5', 'J5', 500);
insert into SPJ values ('S5', 'P5', 'J7', 100);
insert into SPJ values ('S5', 'P6', 'J2', 200);
insert into SPJ values ('S5', 'P1', 'J4', 100);
insert into SPJ values ('S5', 'P3', 'J4', 200);
insert into SPJ values ('S5', 'P4', 'J4', 800);
insert into SPJ values ('S5', 'P5', 'J4', 400);
insert into SPJ values ('S5', 'P6', 'J4', 500);

insert into WORDS values (1, 'one');
insert into WORDS values (2, 'two');
insert into WORDS values (3, 'three');
insert into WORDS values (4, 'four');

commit;