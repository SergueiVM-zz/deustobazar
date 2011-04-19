drop table pujas;
drop table subasta;
drop table estado;
drop table preferencias;
drop table opinion;
drop table categoria;
drop table usuario;
drop table email;

create table estado(
	id number(1) primary key,
	descripcion varchar2(20)
);



CREATE TABLE usuario (
	id NUMBER(5) primary key,
	nombre VARCHAR2(20),
	apellidos VARCHAR2(20),
	direccion VARCHAR2(40),
	ciudad VARCHAR2(10),
	email VARCHAR2(30),
	nick VARCHAR2(8) NOT NULL,
	passwd VARCHAR2(8) NOT NULL
);


create table categoria (
	id Number(5) primary key,
	descripcion varchar2(50),
	cat_padre number(5) references categoria(id)
);

create table opinion(
	id number(5) primary key,
	ofertante number(5) references usuario(id),
	pujador number(5) references usuario(id),
	fecha date,
	comentario varchar2(25)
);

create table subasta(
	id number(6) primary key,
	titulo varchar2(20) not null,
	categoria number(5) references categoria(id),
	estado number(1) references estado(id),
	foto varchar2(200),
	observaciones varchar2(500),
	precio_salida number(10),
	fechafin date not null,
	ofertante number(5) references usuario(id)
);

create table preferencias(
	usuario number(5) references usuario(id),
	categoria number(5) references categoria(id),
        PRIMARY KEY (usuario,categoria)
);

create table puja(
	id number(5) primary key,
	producto number(5) references subasta(id),
	usuario number(5) references usuario(id),
	fecha date,
	hora number(4),
	importe number(10)
);



create table email(
	id number(5) primary key,
	destino varchar2(40),
	remite varchar2(40),
	subject varchar2(40),
	texto varchar2(4000)
);