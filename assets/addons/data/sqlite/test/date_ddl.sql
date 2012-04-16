-- This script creates the Supplier, Parts, Projects database
-- from the Date text.

-- Dropping tables S, P, SP, J and SPJ 

-- begin transaction;
-- drop table S; drop table P; drop table SP; 
-- drop table J; drop table SPJ;
-- commit;

-- Create the new tables

create table S (
	SID    char(5)     not null,
	SNAME  char(20)    not null,
	STATUS integer     not null,
	CITY   varchar(15) not null,
	unique (SID) );

create table P (
	PID    char(5)     not null,
	PNAME  char(20)    not null,
	COLOR  char(6)     not null,
	WEIGHT integer     not null,
	CITY   varchar(15) not null,
	unique (PID) );

create table SP (
	SID char(5) not null,
	PID char(5) not null,
	QTY integer not null,
	unique (SID, PID),
	foreign key (SID) references S (SID),
	foreign key (PID) references P (PID) );

create table J (
	JID   char(5) not null primary key,
	JNAME char(15),
	CITY  char(10) );

create table SPJ (
	SID char(5) not null references S(SID) on delete restrict,
	PID char(5) not null references P(PID) on delete restrict,
	JID char(5) not null references J(JID) on delete cascade,
	QTY int default 1,
	primary key (SID, PID, JID) );

create table PIC (
	PICNAME varchar(128) not null primary key,
	PICVAL  blob );

create table WORDS (
	WID  integer not null primary key,
	WVAL varchar(128) );
