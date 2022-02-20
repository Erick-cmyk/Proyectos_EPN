DROP DATABASE IF EXISTS Proyecto_Guarderia1;
CREATE DATABASE IF NOT EXISTS Proyecto_Guarderia1;

USE Proyecto_Guarderia1;

-- Tabla Representantes (2 nombres, 2 apellidos)
CREATE TABLE IF NOT EXISTS Representante (
    cedulaR varchar(10),
    NombreR varchar(15) not null,
    ApellidoR varchar(15) not null,
    CONSTRAINT PK_Representante PRIMARY KEY(cedulaR)
); 


CREATE TABLE IF NOT EXISTS Personal (
    NDIP int auto_increment,
    cedulaP varchar(10),
    NombreP varchar(15) not null,
    ApellidoP varchar(15) not null,
    FechaNacimiento date  not null,
    genero varchar(10),
    cargo varchar(20) not null,
    sueldo decimal(10,2) default 0,
    CONSTRAINT PK_Personal PRIMARY KEY(NDIP),
    CONSTRAINT UQ_Personal UNIQUE (cedulaP)
);


CREATE TABLE IF NOT EXISTS Receso(
    IDreceso int auto_increment,
	Horario varchar(10),
    inicio time(0) not null,
    final time(0) not null,
    CONSTRAINT PK_Receso PRIMARY KEY(IDreceso)
);



CREATE TABLE IF NOT EXISTS Menu(
    IDmenu int auto_increment ,
	receso int ,
    liquido varchar(30),
    platoFuerte varchar(30),
	CONSTRAINT PK_Menu PRIMARY KEY(IDmenu),
	CONSTRAINT FK_Menu FOREIGN KEY(receso) references Receso(IDreceso)
    ON DELETE CASCADE    
    ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS Grupo(
    codigoGrupo int auto_increment,
    IDreceso int,
    Tutor int, 
    horario varchar(10) not null,
    CONSTRAINT PK_Grupo PRIMARY KEY(codigoGrupo),
    CONSTRAINT UQ_Grupo UNIQUE (Tutor),
    CONSTRAINT FK_Grupo0 FOREIGN KEY(IDreceso) REFERENCES Receso(IDreceso),
    CONSTRAINT FK_Grupo1 FOREIGN KEY(Tutor) REFERENCES Personal(NDIP)
    ON DELETE CASCADE    
    ON UPDATE CASCADE
);


-- GRUPO (IDreceso,Tutor,horario,aula)
CREATE TABLE IF NOT EXISTS Actividad(
    actC int auto_increment,
    docente int,
    tipoA varchar(20),
    inicio time(0) not null,
    final time(0) not null,
    CONSTRAINT PK_Actividad PRIMARY KEY(actC),
    CONSTRAINT FK_Actividad FOREIGN KEY(docente) REFERENCES Personal(NDIP)
    ON DELETE CASCADE    
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Tiene(
    grupo int,
    actividad int,
    CONSTRAINT PK_Tiene PRIMARY KEY(actividad,grupo),
    CONSTRAINT FK_Tiene0 FOREIGN KEY(grupo) REFERENCES Grupo(codigoGrupo)
    ON DELETE CASCADE    
    ON UPDATE CASCADE,
    CONSTRAINT FK_Tiene1 FOREIGN KEY(actividad) REFERENCES Actividad(actC)  
);


CREATE TABLE Titulo (
    numTitulo int auto_increment,
    NDIP int,
    nombreGrado varchar(100) not null,
    CONSTRAINT PK_Titulo PRIMARY KEY(numTitulo),
    CONSTRAINT FK_Titulo0 FOREIGN KEY (NDIP) REFERENCES Personal(NDIP)
    ON DELETE CASCADE    
    ON UPDATE CASCADE
);


CREATE TABLE  IF NOT EXISTS Alergia(
    codAl int auto_increment,
    nombreAl varchar(30) default 'Sin alergia', -- Alergia al polen, Dermatitis atopica, rinitis alergica, etc.
    tipoAl varchar(20) default 'Si alergia', -- se refiere a si es de piel, alimenticia, respiratoria, etc.
    CONSTRAINT PK_alergia PRIMARY KEY(codAl)
);


CREATE TABLE IF NOT EXISTS Discapacidad(
    codDis int auto_increment,
    porcentaje int,
    nombreDis varchar(20),
    CONSTRAINT PK_enfermedad PRIMARY KEY(codDis)
);


CREATE TABLE Ninio (
    Nombre varchar(15) not null,
    Apellido varchar(15) not null,
    NDI int auto_increment,
    fec_nac date  not null,
    genero varchar(1) not null,
    evaluacion varchar(2) default null,
    repID varchar(10),
    codG int,
    CONSTRAINT PK_Ninio PRIMARY KEY(NDI),
    CONSTRAINT FK_Ninio0 FOREIGN KEY (repID) REFERENCES Representante(cedulaR)
    ON DELETE CASCADE    
    ON UPDATE CASCADE,
    CONSTRAINT FK_Ninio2 FOREIGN KEY(codG) REFERENCES Grupo(codigoGrupo)
    ON DELETE CASCADE    
    ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS Inscribe (
    numMatricula int,
    certificador int,
    fecha date not null,
    CONSTRAINT PK_Inscripcion PRIMARY KEY(numMatricula,certificador),
	CONSTRAINT FK_Inscripcion1 FOREIGN KEY(numMatricula) REFERENCES Ninio(NDI)
    ON DELETE CASCADE    
    ON UPDATE CASCADE,
    CONSTRAINT UQ_Inscripcion1 UNIQUE(certificador),
    CONSTRAINT FK_Inscripcion2 FOREIGN KEY(certificador) REFERENCES Personal(NDIP)
);


CREATE TABLE Antecedentes (
    numHistoria int,
    grupoSanguineo varchar(3),
    CONSTRAINT PK_Antecedentes PRIMARY KEY (numHistoria),
	CONSTRAINT FK_Antecedentes FOREIGN KEY (numHistoria) REFERENCES Ninio(NDI)
    ON DELETE CASCADE    
    ON UPDATE CASCADE
);


CREATE TABLE ContieneI(
    numHistoria int,
    codAl int,
    CONSTRAINT PK_ContieneI PRIMARY KEY(numHistoria,codAl),
    CONSTRAINT FK_ContieneI0 FOREIGN KEY(numHistoria) REFERENCES Antecedentes(numHistoria)
	ON DELETE CASCADE    
    ON UPDATE CASCADE,
    CONSTRAINT FK_ContieneI1 FOREIGN KEY(codAl) REFERENCES Alergia(codAl)
    ON DELETE CASCADE    
    ON UPDATE CASCADE
);


CREATE TABLE ContieneII(
    numHistoria int,
    codDis int,
    CONSTRAINT PK_ContieneII PRIMARY KEY(numHistoria,codDis),
    CONSTRAINT FK_ContieneII0 FOREIGN KEY(numHistoria) REFERENCES Antecedentes(numHistoria)
	ON DELETE CASCADE    
    ON UPDATE CASCADE,
    CONSTRAINT FK_ContieneII1 FOREIGN KEY(codDis) REFERENCES Discapacidad(codDis)
);


CREATE TABLE IF NOT EXISTS Enfermedad(
    codEnf int auto_increment,
    tipoE varchar(20),
    nombreE varchar(20),
    CONSTRAINT PK_enfermedad1 PRIMARY KEY(codEnf)
);


CREATE TABLE Sintoma(
    idSin int auto_increment,
    descripcion varchar(50),
    CONSTRAINT PK_Sintoma PRIMARY KEY(idSin)
);


CREATE TABLE Presenta(
    codE int,
    idS int,
    CONSTRAINT PK_Presenta PRIMARY KEY(codE,idS),
    CONSTRAINT FK_Presenta0 FOREIGN KEY(codE) REFERENCES Enfermedad(codEnf)
    ON DELETE CASCADE    
    ON UPDATE CASCADE,
    CONSTRAINT FK_Presenta1 FOREIGN KEY(idS) REFERENCES Sintoma(idSin)
    ON DELETE CASCADE    
    ON UPDATE CASCADE
);


CREATE TABLE CitaMedica(
    numCita int auto_increment,
    numHistoria int, 
    enfermedad int, 
    doctor int,
    fechaCita date,
    CONSTRAINT PK_citMedica PRIMARY KEY(numCita),
    CONSTRAINT FK_citaMedica0 FOREIGN KEY(doctor) REFERENCES Personal(NDIP)
    ON DELETE CASCADE    
    ON UPDATE CASCADE,
    CONSTRAINT FK_citaMedica1 FOREIGN KEY(numHistoria) REFERENCES Antecedentes(numHistoria),
    CONSTRAINT FK_citMedica2 FOREIGN KEY(enfermedad) REFERENCES Enfermedad(codEnf)
    ON DELETE CASCADE    
    ON UPDATE CASCADE
);



CREATE TABLE Medicamento(
    codMed int auto_increment,
    tipo varchar (25),
    nombre varchar (25),
    dosis varchar(30), -- se tiene que poner gramos o  mililitros a consumir por eso nvarchar
    CONSTRAINT PK_Medicamento PRIMARY KEY(codMed)
);


CREATE TABLE Receta(
    idReceta int auto_increment,
    numCita int,
    codMed int,
    reposo int, -- numero de dias en reposo
    alimentacion varchar(50), -- alimentos que no puede consumir (asi no se usa muchos caracteres)
    CONSTRAINT PK_Receta PRIMARY KEY(idReceta),
    CONSTRAINT FK_Receta0 FOREIGN KEY(numCita) REFERENCES CitaMedica(numCita)
    ON DELETE CASCADE    
    ON UPDATE CASCADE,
    CONSTRAINT FK_Receta1 FOREIGN KEY(codMed) REFERENCES Medicamento(codMed)
    ON DELETE CASCADE    
    ON UPDATE CASCADE 
);


CREATE TABLE Telefono(
    idTel int auto_increment,
    telefono varchar(10),
    CONSTRAINT PK_Telefono PRIMARY KEY(idTel)
);


CREATE TABLE Direccion(
    numDir int auto_increment,
    localizacion varchar(200),
    CONSTRAINT PK_Direccion PRIMARY KEY(numDir)
);


CREATE TABLE ResideI(
    NDIP int,
    numDir int,
    CONSTRAINT PK_ResideI PRIMARY KEY(NDIP,numDir),
    CONSTRAINT FK_ResideI0 FOREIGN KEY(NDIP) REFERENCES Personal(NDIP)
    ON DELETE CASCADE    
    ON UPDATE CASCADE,
    CONSTRAINT FK_ResideI1 FOREIGN KEY(numDir) REFERENCES Direccion(numDir)
);


CREATE TABLE ResideII(
    NDI int,
    numDir int,
    CONSTRAINT PK_ResideII PRIMARY KEY(NDI,numDir),
    CONSTRAINT FK_ResideII0 FOREIGN KEY(NDI) REFERENCES Ninio(NDI)
    ON DELETE CASCADE    
    ON UPDATE CASCADE,
    CONSTRAINT FK_ResideII1 FOREIGN KEY(numDir) REFERENCES Direccion(numDir)
    ON DELETE CASCADE    
    ON UPDATE CASCADE
);


CREATE TABLE PoseeI(
    NDIP int,
    fono int,
    CONSTRAINT PK_PoseeI PRIMARY KEY(NDIP,fono),
    CONSTRAINT FK_PoseeI0 FOREIGN KEY(NDIP) REFERENCES Personal(NDIP)
    ON DELETE CASCADE    
    ON UPDATE CASCADE,
    CONSTRAINT FK_PoseeI1 FOREIGN KEY(fono) REFERENCES Telefono(idTel)
    ON DELETE CASCADE    
    ON UPDATE CASCADE
);


CREATE TABLE PoseeII(
    cedR varchar(10),
    idTel int,
    CONSTRAINT PK_PoseeII PRIMARY KEY(idTel,cedR),
    CONSTRAINT FK_PoseeeII0 FOREIGN KEY(cedR) REFERENCES Representante (cedulaR)
	ON DELETE CASCADE    
    ON UPDATE CASCADE,
    CONSTRAINT FK_PoseeII1 FOREIGN KEY(idTel) REFERENCES Telefono(idTel)
	ON DELETE CASCADE    
    ON UPDATE CASCADE
);


CREATE TABLE Notifica(
    cedR varchar(10),
    NDIP int,
    tipoNotificacion varchar(20), -- convocatoria, llamado de atencion, felicitacion, emergencia
    detalle varchar(60),
    fecha date,
    CONSTRAINT PK_Notifica PRIMARY KEY(cedR,NDIP),
    CONSTRAINT FK_Notifica0 FOREIGN KEY(cedR) REFERENCES Representante (cedulaR)
    ON DELETE CASCADE    
    ON UPDATE CASCADE,
    CONSTRAINT FK_Notifica1 FOREIGN KEY(NDIP) REFERENCES Personal(NDIP)
    ON DELETE CASCADE    
    ON UPDATE CASCADE
);

-- DATOS REPRESENTANTES
insert into Representante values (
'1906371599', 'YESSENIA',' MORALES'),(
'0903506798','LAURA','ALARCON '),(
'0916643315','VICTOR','MUÑOZ '),(
'0921527445','JORGE','TOARES' ),(
'1711873362','NUBIA','LOPEZ' ),(
'0920625100','MARIA','LAZO'  ),(
'0907640973','MERCEDES','QUINTUÑA'),( 
'0926016957','JOSE','GOYES'),(
'0920283017','JORGE','ANDRADRE'),(
'0910729953','VERONICA','BELTRAN' ),(
'0912969524','PAQUITA','CHIQUIMARCA'),(
'0908146210','ROSA','ZUNIGA'),(
'0905271680','PEDRO','GUACHO' ),(
'0912485489','YOCONDA','PEÑAFIEL' ),(
'0600739718','DOLORES','KOLER' ),(
'1801285832','JORGE','LAYMAN' ),(
'0907696967','NELSON','CONCHA' ),(
'0900965534','ROSA','BRAVO '),(
'0903710994','MARCOS','PESANTES'),(
'0913473153','LUIS','CAYAMBE '),(
'0900457474','STEFANIA','ULLAURAY'),(
'0911335180','NANCY','MOSQUERA' ),(
'0914541107','MELIDA','AUCAPIÑA' ),(
'0902150291','CARLOS','ASTUDILLO' ),(
'0915611057','TERESA','ZAMBRANO'),(
'0903714483','ALEX','CHICAIZA' ),(
'0909386427','FERMIN','RONQUILLO'),(
'0905796231','MONICA','MINCHALA' ),(
'0906078738','FERNANDO','VACA' ),(
'0916086945','GLORIA','CEDEN'),(
'0902168616','MANUEL','PARRALES' ),(
'0905612693','JENNIFER','GORDILLO'),(
'0910278480','TERESA','FLORES'),(
'0800094708','PETRA','YANEZ' ),(
'0101632578','SABRINA','GALLEGOS' ),(
'0917936668','EULOGIO','DUQUE' ),(
'0906401591','MONICA','DUQUE' ),(
'0902413251','HUGO','SAGUAY'),(
'0902158971','LUZ','JACOME'),(
'0914921135','LUIS','MERA' ),(
'0909762759','MARIA','MOROCHO' ),(
'0902670983','DANNY','VALAREZO'),(
'0601942097','ARMIDA','CABEZAS' ),(
'1303728073','MARIA','ROSALES'),(
'0909180309','LUCIA','LOPEZ'),(
'0908660558','SONIA','GANAZMAPA' ),(
'0902999176','CARLOS','CARDENAS' ),(
'0700841950','MONICA','ONOFRE'),(
'1000124424','ROSA','YUQUILEMA '),(
'0914216833','MATILDE','AGUILERA' ),(
'0915170518','WENDY','LOLIM VELEZ'),(
'0902671049','NESTOR','RODRIGUEZ'),(
'0919257071','CINTIA','ORTEGA '),(
'0912837184','CRISTHIAN','VANEGAS'),( 
'0903559656','RITA','CAIZA'),(
'0600338529','MERY','GARCIA' ),(
'0603192121','ROSA','MEDINA' ),(
'1303597031','ARME','TORRES' ),(
'0600665087','EDITH','FENIN '),(
'0926748774','MANUEL','VALLE'),(
'0912329559','JOSE','ALVAREZ' ),(
'0924918101','LUIS','PAZMIÑO' ),(
'0908969579','MAYRA','PACCHA' ),(
'0909802860','JOSE','ARJEMICO' ),(
'0924949431','MARIO','CARTAGENA'),( 
'1304958752','OLGA ','YUNGA' ),(
'0911103457','ESTELA','SUAREZ' ),(
'0601047475','TERESA','BUSTAMANTE' ),(
'0900250184','SILVIA','CARDOSO' ),(
'0916540222','LAURA','MARTINEZ' ),(
'1312404369','ALICIA','MACIAS' ),(
'0913052676','ROCIO','MOSQUERA'),(
'1000208627','MARY','ARREGUI'),(
'0600350565','NORMA','RAMIREZ'),(
'0701389637','CARMEN','YAQUILEMA'),( 
'0903510246','JUAN','CORTEZ' ),(
'0910790146','JOSE','CHAMBA' ),(
'0910513134','JORGE','VASQUEZ'),(
'0916509839','MARTHA','MIRANDA' ),(
'0900113382','DOLORES','CARRASCO'),( 
'0902159946','JOSE','COCHA'),(
'0600349583','MANUEL','MARIN' ),(
'1708912074','DORA','LOZA' ),(
'0914466855','CRUZ','CASANOVA' ),(
'0907538155','INES','QUEZADA' ),(
'1307018562','ROMULO','ESPINOZA' ),(
'0901438366','JAIME','URGILES'),( 
'1303997066','MARIA','LEMA'),(
'0902217330','ARELIZA','FERNANDEZ'),( 
'0902472794','AMADA','RIVAS'),(
'0904406303','ARACELI','SOSA' ),(
'0908926249','BETSABE','LOPEZ '),(
'0602000076','JUDITH','BARRAGAN' ),(
'0912487352','SEGUNDO','CURAY' ),(
'1704995099','OLGA','VICUNA '),(
'0911206944','MARIA','MUÑOZ'),(
'0902171073','ROSARIO','MOSQUERA' ),(
'0907149245','PADRE','MACANCELA'),( 
'0600275895','HELA','ESPINOZA'),(
'0707066892','KATTY','FIGUEROA');

Select*
from Representante;


-- DATOS PERSONAL
Insert into Personal (cedulaP,NombreP,ApellidoP,FechaNacimiento,genero,cargo,sueldo) values(
'0603207457','MANUEL',' MOROCHO','64/03/20','M','TUTOR',1500),(
'0906853247','LUIS' ,'MENDIETA',	'65/12/13',	'M',	'TUTOR'	,1100),(
'1302601115','NORMA' ,'RODRIGUEZ'	,	'69/07/20'	,'F'	,'TUTOR'	,1500),(
'1803567419','GLENDA' ,'PINCAY'	,	'65/07/23',	'F'	,'TUTOR',	1900),(
'0909801846'	,'LUCIA' ,'MORA'	,'64/10/16',	'F'	,'TUTOR',	1100),(
'1201673413','LOURDES' ,'GUAMAN','58/11/16',	'F'	,'TUTOR',	1300),(
'0602304446','HUGO' ,'VELEZ' ,	'67/03/25',	'M'	,'TUTOR',	1500),(
'0908156839','JOSE'  ,'LEMA'	,'66/09/17','M'	,'TUTOR',	1200),(
'1200997136'	,'MARIO' ,'ROJAS'	,'67/10/10',	'M'	,'TUTOR',	1200),(
'0702197476'	,'MARTHA' ,'MORALES'	,'60/05/29',	'F'	,'TUTOR',	1200),(
'0914377817','MARGARITA' ,'URIBE' ,		'68/03/11',	'F'	,'Administrador',	2800),(
'0900197179','SILVIA' ,'GALLARDO' ,		'64/09/14',	'F',	'Secretaria',	500),(
'0905797270','ILEANA',' ALBAN'	,	'66/01/08',	'F'	,'Secretaria',	500),(
'0992444002','JULIA',' ROMERO '	,	'57/09/15',	'F'	,'Medico' 	,3100),(
'0913162798'	,'JUSTO',' ORELLANA'	,'68/07/10',	'M'	,'Medico' 	,3000),(
'0300549672'	,'GEMA',' RECALDE' 	,'69/01/30',	'F'	,'Cocinero'	,900),(
'0607432134','ALEXANDRA',' BRITO' ,	'67/04/02',	'F',	'Cocinero',	900),(
'0904889110','LUIS',' PEREZ' 	,	'58/09/03',	'M'	,'Cocinero'	,900),(
'0914289028','NICOLAS',' GONZALEZ'	,	'66/05/31',	'M'	,'Supervisor',	2400),(
'0300449923','PAUL' ,' TORRES'	,	'67/09/21',	'M',	'Supervisor'	,2400
);
Select * 
from Personal;


insert into Actividad (docente,tipoA,inicio,final) values
(1,'Motricidad','7:00','8:00'),(1,'Cognitiva','8:00','9:00'),(1,'Receso','9:00','10:00'),
(1,'Ling�istica','10:00','11:00'),(1,'Deportiva','11:00','12:00'),
(2,'Deportiva','7:00','8:00'),(2,'Motricidad','8:00','9:00'),(2,'Receso','9:00','10:00'),
(2,'Cognitiva','10:00','11:00'),(2,'Ling�istica','11:00','12:00'),
(3,'Ling�istica','7:00','8:00'),(3,'Deportiva','8:00','9:00'),(3,'Receso','9:00','10:00'),
(3,'Motricidad','10:00','11:00'),(3,'Cognitiva','11:00','12:00'),
(4,'Cognitiva','7:00','8:00'),(4,'Ling�istica','8:00','9:00'),(4,'Receso','9:00','10:00'),
(4,'Deportiva','10:00','11:00'),(4,'Motricidad','11:00','12:00'),
(5,'Motricidad','7:00','8:00'),(5,'Cognitiva','8:00','9:00'),(5,'Receso','9:00','10:00'),
(5,'Ling�istica','10:00','11:00'),(5,'Deportiva','11:00','12:00'),
(6,'Deportiva','14:00','15:00'),(6,'Motricidad','15:00','16:00'),(6,'Receso','16:00','17:00'),
(6,'Cognitiva','17:00','18:00'),(6,'Ling�istica','18:00','19:00'),
(7,'Ling�istica','14:00','15:00'),(7,'Deportiva','15:00','16:00'),(7,'Receso','16:00','17:00'),
(7,'Motricidad','17:00','18:00'),(7,'Cognitiva','18:00','19:00'),
(8,'Cognitiva','14:00','15:00'),(8,'Ling�istica','15:00','16:00'),(8,'Receso','16:00','17:00'),
(8,'Deportiva','17:00','18:00'),(8,'Motricidad','18:00','19:00'),
(9,'Motricidad','14:00','15:00'),(9,'Cognitiva','15:00','16:00'),(9,'Receso','16:00','17:00'),
(9,'Ling�istica','17:00','18:00'),(9,'Deportiva','18:00','19:00'),
(10,'Deportiva','14:00','15:00'),(10,'Motricidad','15:00','16:00'),(10,'Receso','16:00','17:00'),
(10,'Cognitiva','17:00','18:00'),(10,'Ling�istica','18:00','19:00');

Select *
from Actividad;

-- INGRESO DE DATOS DE RECESO
insert into Receso (Horario,inicio,final) 
values('Ma�ana','9:00','10:00'),('Tarde','15:00','16:00');
Select*
from Receso;

-- INGRESO DATOS DE MENU
	Insert into Menu (receso,liquido,platoFuerte) values
	(1,'Leche con Maicena','Sanduche Caliente de Queso'),
	(1,'Refresco de Arroz de Cebada','Huevo Revuelto'),
	(1,'Leche Pura Caliente','Maduros al Horno'),
	(1,'Leche con Machica ','Galletas de Quinua'),
	(1,'Yogurt','Rosquillas'),
	(1,'Caf� en leche','Empanada y Fruta'),
	(1,'Jugo',' Ensalada de Frutas'),
	(1,'Jugo','Platano con Pan '),
	(1,'Gelatina ',' Galletas de Avena '),
	(1,'Avena  ',' Huevos Revueltos y Fruta'),
	(2,'Leche con Maicena ','Fruta '),
	(2,'Refresco de Arroz de Cebada ',' Fruta '),
	(2,' Avena',' Bizcocho '),
	(2,'Pi�a en almibar ',' fruta'),
	(2,'Colada de Machica ','Galletas de Quinua'),
	(2,'Tapioca de Maracuya ','Rosquitas '),
	(2,'T�','Rosquitas Dulces'),
	(2,'Yogurt ','Ensalada de Frutas '),
	(2,'Yogurt ','Granola '),
	(2,' Gelatina','Galletas de Avena ');

Select Receso.Horario,Menu.*
from Menu,Receso;

-- INGRESO DE DATOS DE GRUPOS
insert into Grupo (IDreceso,Tutor,horario) values
(1,1,'Ma�ana'),(1,2,'Ma�ana'),(1,3,'Ma�ana'),(1,4,'Ma�ana'),(1,5,'Ma�ana'),
(2,6,'Tarde'),(2,7,'Tarde'),(2,8,'Tarde'),(2,9,'Tarde'),(2,10,'Tarde');

-- 4 y 5 discapacidad diurna;
-- 9 y 10 discapacidad vespertina;

Select *
from Grupo;

-- INGRESO DE DATOS EN TABLA INTERMEDIA "TIENE"
insert into Tiene values
(1,1),  (1,2),  (1,3),  (1,4),  (1,5), 
(2,6),	(2,7),  (2,8),  (2,9),  (2,10),
(3,11),	(3,12), (3,13), (3,14), (3,15),
(4,16),	(4,17), (4,18), (4,19), (4,20),
(5,21),	(5,22), (5,23), (5,24), (5,25),
(6,26),	(6,27), (6,28), (6,29), (6,30),
(7,31),	(7,32), (7,33), (7,34), (7,35),
(8,36),	(8,37), (8,38), (8,39), (8,40),
(9,41),	(9,42), (9,43), (9,44), (9,45),
(10,46),(10,47),(10,48),(10,49),(10,50);

select *
from Tiene;



-- INGRESO DE DATOS DE NINIOS
insert into Ninio (Nombre,Apellido,fec_nac,genero,evaluacion,repID,codG) values (
-- GRUPO 1
'MANUEL','MORALES','16/01/01','M','S','1906371599',1),(
'JAIME','ALARCON ','16/02/02','M','R','0903506798',1),(
'CARLA','MU�OZ','15/07/15','F','MB','0916643315',1),(
'CAROLINA','TOARES','15/06/25','F','O','0921527445',1),(
'CARMEN','LOPEZ','15/07/10','F','S','1711873362',1),(
'DANIEL','LAZO','15/02/14','M','B','0920625100',1),(
'STEVEN','QUINTUDA','14/01/12','M','S','0907640973',1),( 
'MARCELO','GOYES','14/02/20','M','MB','0926016957',1),(
'STALIN','ANDRADRE','14/05/23','M','R','0920283017',1),(
'SERGIO','BELTRAN','15/06/25','M','O','0910729953',1),(
-- GRUPO 2
'RICARDO','CHIQUIMARCA','16/05/27','M','R','0912969524',2),(
'STEVEN','ZUNIGA'    ,'15/04/19','M','S','0908146210',2),(
'XAVIER','GUACHO'    ,'15/08/11','M','B','0905271680',2),(
'MILENA','PE�AFIEL'  ,'15/03/23','F','MB','0912485489',2),(
'WENDY','KOLER'     ,'16/07/01','F','S','0600739718',2),(
'ALEXIS','LAYMAN'    ,'15/10/25','M','R','1801285832',2),(
'CARLOS','CONCHA'    ,'15/06/30','M','O','0907696967',2),(
'DIEGO','BRAVO '    ,'14/09/26','M','O','0900965534',2),(
'EMILY','PESANTES'  ,'14/02/18','F','S','0903710994',2),(
'DAYANA','CAYAMBE '  ,'15/04/02','F','B','0913473153',2),(
-- GRUPO 3
'KEVIN','ULLAURAY'  ,'16/01/25','M','R','0900457474',3),(
'SANTIAGO','MOSQUERA'  ,'15/10/15','M','MB','0911335180',3),(
'SEBASTIAN','AUCAPI�A'  ,'15/07/28','M','S','0914541107',3),(
'KERLI','ASTUDILLO' ,'16/05/17','F','O','0902150291',3),(
'PAOLA','ZAMBRANO'  ,'16/02/18','F','R','0915611057',3),(
'SAMUEL','CHICAIZA'  ,'15/10/06','M','B','0903714483',3),(
'ADRIAN','RONQUILLO' ,'15/11/11','M','B','0909386427',3),(
'MICHAEL','MINCHALA'  ,'14/07/08','M','B','0905796231',3),(
'ANDRES','VACA'      ,'15/12/16','M','MB','0906078738',3),(
'JESICA','CEDEN'     ,'15/10/04','F','S','0916086945',3),(
-- GRUPO 4
'ALEJANDRA','PARRALES'  ,'16/01/24','F','S','0902168616',4),(
'MICAELA','GORDILLO'  ,'16/05/13','F','B','0905612693',4),(
'ALAN','FLORES'    ,'15/11/06','M','MB','0910278480',4),(
'AARON','YANEZ'     ,'15/07/15','M','R','0800094708',4),(
'ERICK','GALLEGOS'  ,'16/03/22','M','R','0101632578',4),(
'MATIAS','DUQUE'     ,'14/08/27','M','O','0917936668',4),(
'ALEJANDRO','DUQUE'     ,'15/02/28','M','S','0906401591',4),(
'SAMANTA','SAGUAY'    ,'14/02/15','F','S','0902413251',4),(
'KIMBERLY','JACOME'    ,'15/09/17','F','MB','0902158971',4),(
'EMILY','MERA'      ,'16/05/22','F','B','0914921135',4 ),(
-- GRUPO 5
'DAYANA','MOROCHO'   ,'16/03/28','F','B','0909762759',5),(
'DARIO','VALAREZO'  ,'15/05/19','M','MB','0902670983',5),(
'ENRIQUE','CABEZAS'   ,'14/08/20','M','S','0601942097',5),(
'LEONARDO','ROSALES'   ,'15/09/23','M','R','1303728073',5),(
'JOSUE','LOPEZ'     ,'16/04/12','M','O','0909180309',5),(
'JAZMIN','GANAZMAPA' ,'15/10/17','F','B','0908660558',5),(
'JOSELYN','CARDENAS'  ,'15/11/24','F','O','0902999176',5),(
'ANA','ONOFRE'    ,'16/06/18','F','R','0700841950',5),(
'GABRIEL','YUQUILEMA' ,'14/11/16','M','R','1000124424',5),(
'STEVEN','AGUILERA'  ,'15/07/02','M','S','0914216833',5),(
-- GRUPO 6
'KEVIN','VELEZ'     ,'15/09/03','M','S','0915170518',6),(
'FERNANDO','RODRIGUEZ' ,'16/01/01','M','S','0902671049',6),(
'OMAR','ORTEGA '   ,'15/12/25','M','MB','0919257071',6),(
'MAYTHE','VANEGAS'   ,'15/12/24','F','B','0912837184',6),( 
'SEBASTIAN','CAIZA'     ,'14/11/29','M','B','0903559656',6),(
'ERICK','GARCIA'    ,'16/05/03','M','B','0600338529',6),(
'GOKU','MEDINA'    ,'15/01/04','M','MB','0603192121',6),(
'MARCELO','TORRES'    ,'15/10/10','M','S','1303597031',6),(
'WENDY','FENIN '    ,'15/11/11','F','S','0600665087',6),(
'ISABELLA','VALLE'     ,'14/07/12','F','S','0926748774',6),(
-- GRUPO 7
'IVANA','ALVAREZ'   ,'14/06/13','F','R','0912329559',7),(
'SANTIAGO','PAZMIÑO'   ,'16/03/15','M','O','0924918101',7),(
'MISHELL','PACCHA'    ,'15/09/17','F','MB','0908969579',7),(
'NICOL','ARJEMICO'  ,'15/08/20','F','S','0909802860',7),(
'MAURICIO','CARTAGENA' ,'14/12/14','M','S','0924949431',7),( 
'ALEXIS','YUNGA'     ,'16/03/25','M','B','1304958752',7),(
'RICARDO','SUAREZ'    ,'15/08/28','M','B','0911103457',7),(
'ALEXANDRA','BUSTAMANTE','15/01/27','F','R','0601047475',7),(
'LIZBETH','CARDOSO'   ,'14/07/19','F','O','0900250184',7),(
'STALIN','MARTINEZ'  ,'15/01/11','M','O','0916540222',7),(
-- GRUPO 8
'CRISTIAN','MACIAS'    ,'16/06/04','M','S','1312404369',8),(
'IBETH','MOSQUERA'  ,'15/04/10','F','B','0913052676',8),(
'MARIA','ARREGUI'   ,'15/11/15','F','MB','1000208627',8),(
'CARLOS','RAMIREZ'   ,'15/05/16','M','S','0600350565',8),(
'BRYAN','YAQUILEMA' ,'16/03/30','M','S','0701389637',8),( 
'ESTAFANIA','CORTEZ'    ,'15/02/01','F','O','0903510246',8),(
'VANESA','CHAMBA'    ,'14/01/17','F','O','0910790146',8),(
'ANIBAL','VASQUEZ'   ,'15/05/11','M','S','0910513134',8),(
'ANA','MIRANDA'   ,'15/08/17','F','R','0916509839',8),(
'ESTEBAN','CARRASCO'  ,'16/04/18','M','B','0900113382',8),( 
-- GRUPO 9
'SAMUEL','COCHA'     ,'16/03/20','M','S','0902159946',9),(
'MARIO','MARIN'     ,'16/02/22','M','MB','0600349583',9),(
'SEBASTIAN','LOZA'      ,'15/07/23','M','S','1708912074',9),(
'MILENA','CASANOVA'  ,'15/07/20','F','B','0914466855',9),(
'ANTHONY','QUEZADA'   ,'14/09/15','M','S','0907538155',9),(
'DIEGO','ESPINOZA'  ,'15/10/04','M','O','1307018562',9),(
'MONICA','URGILES'   ,'15/07/07','F','S','0901438366',9),( 
'RASHELL','LEMA'      ,'16/01/10','F','B','1303997066',9),(
'CASANDRA','FERNANDEZ' ,'16/02/09','F','MB','0902217330',9),( 
'ISABEL','RIVAS'     ,'15/01/25','F','R','0902472794',9),(
-- GRUPO 10
'ANDRES','SOSA'      ,'15/03/28','M','S','0904406303',10),(
'DAVID','LOPEZ '    ,'14/09/17','M','R','0908926249',10),(
'FERNANADA','BARRAGAN'  ,'14/11/16','F','S','0602000076',10),(
'DOMENICA','CURAY'     ,'15/12/20','F','B','0912487352',10),(
'FAVIO','VICUNA '   ,'16/03/21','M','S','1704995099',10),(
'FABRICIO','MU�OZ'     ,'15/05/13','M','O','0911206944',10),(
'RICHARD','MOSQUERA'  ,'15/06/18','M','MB','0902171073',10),(
'KEVIN','MACANCELA' ,'14/03/01','M','O','0907149245',10),( 
'JAZMIN','ESPINOZA'  ,'15/01/02','F','S','0600275895',10),(
'STEVEN','FIGUEROA'  ,'15/08/15','M','B','0707066892',10 
);
Select *
from Ninio;

-- INGRESO DE DATOS A LOS ANTECEDENTES
insert into Antecedentes values
(1,'O+'),(2,'O+'),(3,'O-'),(4,'A+'),(5,'B+'),
(6,'O+'),(7,'AB+'),(8,'O-'),(9,'A+'),(10,'A+'),
(11,'B-'),(12,'B-'),(13,'AB-'),(14,'O+'),(15,'O+'),
(16,'O-'),(17,'A+'),(18,'A-'),(19,'O+'),(20,'B+'),
(21,'O-'),(22,'O-'),(23,'AB+'),(24,'A+'),(25,'B-'),
(26,'B+'),(27,'A+'),(28,'A+'),(29,'O+'),(30,'O-'),
(31,'O-'),(32,'AB+'),(33,'O+'),(34,'O-'),(35,'A+'),
(36,'A-'),(37,'B+'),(38,'B+'),(39,'B+'),(40,'O+'),
(41,'O-'),(42,'A-'),(43,'B-'),(44,'O+'),(45,'O-'),
(46,'A-'),(47,'O+'),(48,'B-'),(49,'AB+'),(50,'AB-'),
(51,'O+'),(52,'O+'),(53,'O-'),(54,'A+'),(55,'A-'),
(56,'B+'),(57,'B+'),(58,'B-'),(59,'AB+'),(60,'O-'),
(61,'O-'),(62,'A+'),(63,'A-'),(64,'O+'),(65,'O-'),
(66,'B+'),(67,'O+'),(68,'O+'),(69,'AB+'),(70,'O-'),
(71,'AB-'),(72,'A+'),(73,'B-'),(74,'O-'),(75,'O+'),
(76,'A+'),(77,'B-'),(78,'B-'),(79,'B+'),(80,'A+'),
(81,'AB+'),(82,'O-'),(83,'A+'),(84,'B-'),(85,'B-'),
(86,'B+'),(87,'A+'),(88,'O+'),(89,'O-'),(90,'AB+'),
(91,'O-'),(92,'A+'),(93,'B+'),(94,'O-'),(95,'B-'),
(96,'A-'),(97,'O+'),(98,'O-'),(99,'AB-'),(100,'O+');

select *
from Antecedentes;

-- INGRESO DE DATOS DE DISCAPACIDAD
insert into Discapacidad (porcentaje,nombreDis) values
(0,'Grado 1'),    -- 0%
(24,'Grado 2'),   -- [0% , 24%]
(49,'Grado 3'),   -- ]24% , 49%]
(70,'Grado 4'),   -- ]49% , 70%]
(75,'Grado 5');   -- >70%

select *
from Discapacidad;

-- INGRESO DE DATOS EN LA TABLA INTERMEDIA "CONTIENE II"
insert into ContieneII values
(1,1),(2,1),(3,2),(4,1),(5,1),(6,2),(7,1),(8,1),(9,1),(10,1),            -- GRUPO 1
(11,1),(12,1),(13,1),(14,1),(15,1),(16,1),(17,1),(18,2),(19,2),(20,1),   -- GRUPO 2
(21,1),(22,1),(23,2),(24,1),(25,1),(26,2),(27,1),(28,1),(29,2),(30,2),	 -- GRUPO 3
(31,5),(32,5),(33,5),(34,5),(35,5),(36,5),(37,5),(38,5),(39,5),(40,5),	 -- GRUPO 4
(41,3),(42,4),(43,4),(44,3),(45,3),(46,3),(47,4),(48,3),(49,3),(50,3),	 -- GRUPO 5
(51,1),(52,2),(53,1),(54,1),(55,1),(56,1),(57,1),(58,1),(59,2),(60,1),	 -- GRUPO 6
(61,1),(62,1),(63,1),(64,1),(65,1),(66,1),(67,1),(68,1),(69,2),(70,1),	 -- GRUPO 7
(71,1),(72,2),(73,2),(74,1),(75,1),(76,1),(77,1),(78,1),(79,2),(80,1),	 -- GRUPO 8
(81,5),(82,5),(83,5),(84,5),(85,5),(86,5),(87,5),(88,5),(89,5),(90,5),	 -- GRUPO 9
(91,3),(92,3),(93,3),(94,4),(95,4),(96,4),(97,4),(98,3),(99,3),(100,4);  -- GRUPO 10

select * 
from ContieneII;

-- INGRESO DE DATOS DE ALERGIAS
insert into Alergia (nombreAl,tipoAl) values
(default,default),
('Polen','Respitaroria'),
('Hongos','Alimenticia'),
('Rinitis','Respiratoria'),
('Asma','Respiratoria'),
('Dermatitis atopica','Dermica'),
('Animales','Respiratoria'),
('Penicilina','Farmacologica');

select *
from Alergia;

-- INGRESO DE DATOS EN LA TABLA INTERMEDIA "CONTIENE I"
insert into ContieneI values
(1,1),(2,1),(3,1),(4,1),(5,2),(6,3),(7,1),(8,1),(9,5),(10,4), 
(11,8),(12,7),(13,1),(14,1),(15,1),(16,6),(17,1),(18,1),(19,2),(20,1),
(21,1),(22,1),(23,1),(24,1),(25,6),(26,5),(27,8),(28,6),(29,2),(30,1),
(31,2),(32,1),(33,3),(34,4),(35,1),(36,1),(37,1),(38,1),(39,8),(40,2),
(41,1),(42,1),(43,5),(44,4),(45,1),(46,3),(47,2),(48,1),(49,1),(50,1),
(51,8),(52,1),(53,1),(54,7),(55,6),(56,1),(57,1),(58,1),(59,2),(60,3),
(61,1),(62,5),(63,1),(64,1),(65,4),(66,1),(67,1),(68,1),(69,3),(70,2),
(71,1),(72,2),(73,8),(74,7),(75,3),(76,1),(77,2),(78,3),(79,1),(80,1),
(81,3),(82,2),(83,2),(84,1),(85,1),(86,1),(87,5),(88,8),(89,2),(90,1),
(91,1),(92,1),(93,2),(94,1),(95,1),(96,3),(97,4),(98,3),(99,1),(100,1);

select *
from ContieneI;

select *
from Receso inner join
Menu on receso.IDreceso = Menu.receso;

-- INGRESO DE DATOS DE MEDICAMENTOS
insert into Medicamento (tipo, nombre, dosis) values
('Analgésico','Paracetamol ','100mg'),
('Analgésico','Ibuprofeno ','100mg'),
('Antiácidos','Omeprazol 40mg','1 veces'),
('Antiácidos','metronidazol','300mg'),
('Antidiarreicos','Alcazelcer','1 tableta'),
('Antidiarreicos','Sal Andrews','1 tableta'),
('Antidiarreicos','Bactrim ','100mg'),
('Antidiarreicos','Bacterol','125mg'),
('Antitusivos','fluzetrin','200mg'),
('Antipiréticos','Lemonflu','1 sobre'),
('Antibióticos','Aspirina de niño','1 tableta'),
('Antibióticos','Buscapina 100mg','100mg'),
('Antibióticos','Fluimusil 100mg','100mg'),
('Antibióticos','Amoxicilina 250mg','250mg'),
('Antibióticos','Penicilina 125mg','125mg'),
('Precaucion','CURITAS','S/D'),
('Precaucion','Vendas','S/D'),
('GRAVE','HOSPITAL','S/D'),
('S/T','REPOSO','n Días');
select*
from Medicamento;



-- SE SUBDIVIDEN EN ENFERMEDADES L)LEVE , M)NIVEL MEDIO, G)GRAVE
insert into Enfermedad (tipoE,nombreE) values
('L','Hepatitis B'),
('L','Resfriado/Gripe'),
('L','Cefalea'),
('M','Migraña'),
('L','Golpes'),
('L','Dolor Muscular'),
('L','Corte/Herida'),
('M','Bronquitis'),
('L','Varicela'),
('L','Dolor de Estómago'),
('L','Infeccion'),
('L','Sarampion'),
('L','Mareo y Nausea'),
('G','Neumonia'),
('G','Accidente');

Select *
from Enfermedad;

-- INGRESO DE DATOS DE LAS CITAS MEDICAS 
INSERT INTO CitaMedica (numHistoria,enfermedad,doctor,fechaCita) VALUES
(3,9,13,'19/06/03'), -- Mujer
(14,10,13,'19/06/04'),
(24,11,13,'19/06/05'),
(47,13,14,'19/06/06'), -- Hombre
(8,12,14,'19/06/10'),
(4,7,13,'19/06/11'),
(2,5,14,'19/06/13'),
(5,6,13,'19/06/17'),
(15,3,13,'19/06/20'),
(11,2,14,'19/06/21'),
(6,1,14,'19/06/24'),
(25,15,13,'19/06/27'),
(13,13,14,'19/06/28'),
(46,4,14,'19/07/01'),
(30,14,13,'19/07/01'),
(49,5,13,'19/07/02'),
(12,8,14,'19/07/04'),
(31,11,13,'19/07/04'),
(48,2,13,'19/07/08'),
(46,4,14,'19/07/10'),
(88,3,13,'19/07/11'),
(7,9,14,'19/07/15'),
(94,1,13,'19/07/15'),
(10,7,14,'19/07/16'),
(72,2,13,'19/07/18'),
(73,8,13,'19/07/19');

SELECT *
FROM CitaMedica;

INSERT INTO Receta (numCita,codMed,reposo,alimentacion) VALUES
(1,5,1,'Consuma guayaba y bebidas hidratantes'),
(2,3,1,'Consumo de te manzanilla'),
(3,15,1,'No alimentos inconosos, mani ni cerdo'),
(4,4,1,'Consumo de te de menta y limon'),
(5,3,1,'Consumo de te de oregano y ruda'),
(6,16,1,'No alimentos inconosos, mani ni cerdo'),
(7,1,1,'Sin indicaciones'),
(8,2,1,'Sin indicaciones'),
(9,2,1,'Sin indicaciones'),
(10,9,1,'Consumo de vitamina C'),
(11,14,1,'Consumo de vitamina C'),
(12,18,7,'No grasas, ni comida inconosa'),
(13,3,1,'Consumo de te de menta y limon'),
(14,1,3,'Sin contraindicaciones'),
(15,18,7,'No consumir alimentos frios'),
(16,2,1,'Sin indicaciones'),
(17,11,3,'No alimentos inconosos, mani ni cerdo'),
(18,13,1,'No alimentos inconosos, mani ni cerdo'),
(19,9,1,'Consumo de vitamina C'),
(20,1,3,'Sin indicaciones'),
(21,2,1,'Sin indicaciones'),
(22,8,1,'Guayaba y bebidas hidratantes'),
(23,11,1,'Consumo de vitamina C'),
(24,16,1,'No alimentos inconosos, mani ni cerdo'),
(25,9,1,'Consumo de vitamina C'),
(26,17,3,'No alimentos inconosos, mani ni cerdo');

SELECT * 
FROM Receta;

-- INGRESO DE DATOS DE TELEFONOS
insert into Telefono (telefono) values
('0933829670'),('0922248708'),('0912263395'),('0953829670'),('0992248708'),('0972263395'),
('0993829670'),('0983301837'),('0973301125'),('0963829670'),('0943301837'),('0963301125'),
('0953829670'),('0972248708'),('0932263395'),('0913829670'),('0922248708'),('0932263395'),
('0942551735'),('0953829670'),('0963301837'),('0983301125'),('0992520641'),('0993015023'),
('0982606757'),('0972835988'),('0962828241'),('0952572022'),('0943829670'),('0932248708'),
('0922263395'),('0916299196'),('0903829670'),('0903301837'),('0913301125'),('0923829670'),
('0983301837'),('0973301125'),('0963829670'),('0953301837'),('0943301125'),('0932886815'),
('0993829670'),('0992248708'),('0982263395'),('0972835988'),('0962828241'),('0952244853'),
('0902760260'),('0903829670'),('0912248708'),('0922263395'),('0932954488'),('0942572022'),
('0913829670'),('0922248708'),('0932263395'),('0943829670'),('0952248708'),('0962263395'),
('0973829670'),('0982248708'),('0992263395'),('0902886015'),('0992835988'),('0982828241'),
('0943829670'),('0953301837'),('0963301125'),('0973829670'),('0983303431'),('0973829670'),
('0933301837'),('0923301125'),('0912934366'),('0902606757'),('0903829670'),('0913303431'),
('0922326306'),('0932515031'),('0942327026'),('0952326687'),('0962326506'),('0973829670'),
('0983301837'),('0993301125'),('0902702077'),('0902572022'),('0992551735'),('0983829670'),
('0972248708'),('0962263395'),('0953829670'),('0943301837'),('0933301125'),('0923829670'),
('0913303431'),('0923829670'),('0912248708'),('0902263395'),('0902326306'),('0912515031'),
('0902327026'),('0902326687'),('0912326506'),('0922421788'),('0962822753'),('0943829670'),
('0983303431'),('0913829670'),('0923303431'),('0972626722'),('0963829670'),('0943248708'),
('0992263395'),('0943829670'),('0963301837'),('0913301125'),('0953829670'),('0983301837');

Select*
from Telefono;

insert into PoseeII values('1906371599', 1),(
'0903506798',2),('0916643315',3),(
'0921527445',4),('1711873362',5 ),(
'0920625100',6 ),('0907640973',7),( 
'0926016957',8),('0920283017',9),(
'0910729953',10),('0912969524',11),(
'0908146210',12),('0905271680',13),(
'0912485489', 14),('0600739718',15),(
'1801285832', 16),('0907696967', 17),(
'0900965534',18),('0903710994',19),(
'0913473153',20),('0900457474',21),(
'0911335180',22),('0914541107', 23),(
'0902150291', 24),('0915611057',25),(
'0903714483', 26),('0909386427',27),(
'0905796231',28),('0906078738',29),(
'0916086945',30),('0902168616',31 ),(
'0905612693',32),('0910278480',33),(
'0800094708', 34),('0101632578',35 ),(
'0917936668',36),('0906401591',38),(
'0902413251',37),('0902158971',39),(
'0914921135',40),('0909762759', 41),(
'0902670983',42),('0601942097',43),(
'1303728073',44),('0909180309',45),(
'0908660558', 46),('0902999176', 47),(
'0700841950',48),('1000124424',49),(
'0914216833',50 ),('0915170518',51),(
'0902671049',52),('0919257071',53),(
'0912837184',54),('0903559656',55),(
'0600338529',56),('0603192121', 57),(
'1303597031', 58),('0600665087',59),(
'0926748774',60),('0912329559', 61),(
'0924918101',62),('0908969579',63 ),(
'0909802860',64),('0924949431',65),( 
'1304958752', 66),('0911103457', 67),(
'0601047475',68),('0900250184', 69),(
'0916540222', 70),('1312404369', 71),(
'0913052676',72),('1000208627',73),(
'0600350565',74),('0701389637',75),( 
'0903510246',76),('0910790146', 77),(
'0910513134',78),('0916509839',79),(
'0900113382',80),('0902159946',81),(
'0600349583',82),('1708912074', 83),(
'0914466855',84),('0907538155',85 ),(
'1307018562', 86),('0901438366',87),( 
'1303997066',88),('0902217330',89),( 
'0902472794',90),('0904406303', 91),(
'0908926249',92),('0602000076', 93),(
'0912487352', 94),('1704995099',95),(
'0911206944',96),('0902171073', 97),(
'0907149245',98),('0600275895',99)
,('0707066892',100);
Select*from PoseeII;


insert into PoseeI values
(1,101),(2,102),(3,103),(4,104),(5,105),
(6,106),(7,107),(8,108),(9,109),(10,110),
(11,111),(12,112),(13,113),(14,114),(15,115),
(16,116),(17,117),(18,118),(19,119),(20,120);

select *
from PoseeI;

-- INGRESO DE DIRECCIONES 
insert into Direccion (localizacion) values 
('9 de Octubre 219 y Pedro Carbo, Guayaquil'),('
Castillo 458 entre  Sucre y Bolivar, Ambato'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Vía San Mateo Manzana 17 Lote 17 Urb. Manta 2000 Ruta Spondylus, Manta'),('
Av de los Shyris N37-254 y La Tierra'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Calle Benigno Malo y Av. Monseñor Alberto Zambrano (Junto a las oficinas de la Policía Judicial de Pastaza) Puyo'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Av de los Shyris N37-254 y La Tierra'),('
Antonio José de Sucre 8-40 y Pedro Moncayo, Ibarra'),('
Av de los Shyris N37-254 y La Tierra'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Av. Cristóbal Colón y via Milagro Km. 26 Edf. Centro de Atención Ciudadana, Bloque B. Piso 2, Milagro'),('
Calle Bolívar entre Junín y Ayacucho, Tulcán'),('
Av de los Shyris N37-254 y La Tierra'),('
Rocafuerte 1-14 entre Bolívar y Malecón, Esmeraldas'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Av de los Shyris N37-254 y La Tierra'),('
Av. De los Shyris y La Tierra Ed. Zambrano, Quito'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Guayas 1545 entre Boyacá y Pasaje, Machala.'),('
Av de los Shyris N37-254 y La Tierra'),('
Calle Sucre y Jhonson City diagonal al Parque Montúfar Guaranda'),('
Av de los Shyris N37-254 y La Tierra'),('
Av. Universitaria vía cantón Montalvo, entre Calle C y D, diagonal al colegio Anexo, Babahoyo'),('
Calle Quito y Marquez de Maenza, edif. Centro de Atención Ciudadana Latacunga'),('
Antonio José de Sucre 8-40 y Pedro Moncayo, Ibarra'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
9 de Octubre 219 y Pedro Carbo, Guayaquil'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Av de los Shyris N37-254 y La Tierra'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Castillo 458 entre  Sucre y Bolívar, Ambato'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Av de los Shyris N37-254 y La Tierra'),('
Av de los Shyris N37-254 y La Tierra'),('
Av de los Shyris N37-254 y La Tierra'),('
Av. Universitaria vía cantón Montalvo, entre Calle C y D, diagonal al colegio Anexo, Babahoyo'),('
Av de los Shyris N37-254 y La Tierra'),('
Av de los Shyris N37-254 y La Tierra'),('
Av. Clemencia de Mora y Río Tiputini, Santo Domingo'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Av. Clemencia de Mora y Río Tiputini, Santo Domingo'),('
9 de Octubre 219 y Pedro Carbo, Guayaquil'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Calle Benigno Malo y Av. Monseñor Alberto Zambrano (Junto a las oficinas de la Policía Judicial de Pastaza) Puyo'),('
Av de los Shyris N37-254 y La Tierra'),('
Av. Luis cordero 377 y General Enriquez, CC River Mall, Oficina, 3 Frente a Mis Cines, Sangolqui.'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Calle Quito y Marquez de Maenza, edif. Centro de Atención Ciudadana Latacunga'),('
España y 10 de Agosto, 2do. Piso, Riobamba'),('
Av. Mariscal Sucre S23 -94 y Portovelo, Quito'),('
Av. Luis cordero 377 y General Enriquez, CC River Mall, Oficina,  3 Frente a Mis Cines, Sangolqui.'),('
Calle Benigno Malo y Av. Monseñor Alberto Zambrano (Junto a las oficinas de la Policía Judicial de Pastaza) Puyo'),('
Castillo 458 entre  Sucre y Bolívar, Ambato'),('
Calle Aguarico y Quito Esquina-Barrio 20 de Mayo, Puerto Francisco de Orellana'),('
Calle Benigno Malo y Av. Monseñor Alberto Zambrano (Junto a las oficinas de la Policía Judicial de Pastaza) Puyo'),('
Av. Clemencia de Mora y R�o Tiputini, Santo Domingo'),('
Av. De los Shyris y La Tierra Ed. Zambrano, Quito'),('
Calle Chile No. 842 entre C�sar Ch�vez y Constantino Mendoza Portoviejo'),('
Av. Orillas del Zamora 03 - 80 y Bracamoros esquina. Loja'),('
Av. Gran Colombia 22-192 y Unidad Nacional Edificio Cordero 2do piso, Cuenca'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Av de los Shyris N37-254 y La Tierra'),('
Av. De los Shyris y La Tierra Ed. Zambrano, Quito'),('
Luis Cordero entre Tenemaza y Gral. Enríquez, Azogues'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Av. Luis cordero 377 y General Enriquez, CC River Mall, Oficina,  3 Frente a Mis Cines, Sangolqui.'),('
Rocafuerte 1-14 entre Bol�var y Malec�n, Esmeraldas'),('
Antonio Jos� de Sucre 8-40 y Pedro Moncayo, Ibarra'),('
Av de los Shyris N37-254 y La Tierra'),('
Av. Mariscal Sucre S23 -94 y Portovelo, Quito'),('
9 de Octubre 219 y Pedro Carbo, Guayaquil'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Centro de Atención Ciudadana Av. Carlos Alberto Larrea entre calle Quinta y Sexta'),('
9 de Octubre 219 y Pedro Carbo, Guayaquil'),('
9 de Octubre 219 y Pedro Carbo, Guayaquil'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Primavera I Mz. Villa 13 Edf. Vargas Dur�n'),('
Av. Mariscal Sucre S23 -94 y Portovelo, Quito'),('
Calle Chile No. 842 entre C�sar Ch�vez y Constantino Mendoza Portoviejo'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Av. De los Shyris y La Tierra Ed. Zambrano, Quito'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
9 de Octubre 219 y Pedro Carbo, Guayaquil'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
9 de Octubre 219 y Pedro Carbo, Guayaquil'),('
España y 10 de Agosto, 2do. Piso, Riobamba'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Calle Chile No. 842 entre C�sar Ch�vez y Constantino Mendoza Portoviejo'),('
V�a San Mateo Manzana 17 Lote 17 Urb. Manta 2000 Ruta Spondylus, Manta'),('
Calle Aguarico y Quito Esquina-Barrio 20 de Mayo,Puerto Francisco de Orellana'),('
9 de Octubre 219 y Pedro Carbo, Guayaquil'),('
Av de los Shyris N37-254 y La Tierra'),('
Av de los Shyris N37-254 y La Tierra'),('
Calle Chile No. 842 entre C�sar Ch�vez y Constantino Mendoza Portoviejo'),('
Centro de Atención Ciudadana Av. Carlos Alberto Larrea entre calle Quinta y Sexta'),('
Calle Chile No. 842 entre C�sar Ch�vez y Constantino Mendoza Portoviejo'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Av. Crist�bal Col�n y via Milagro Km. 26 Edf. Centro de Atención Ciudadana, Bloque B. Piso 2, Milagro'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Calle Sucre y Jhonson City diagonal al Parque Mont�far Guaranda'),('
Guayas 1545 entre Boyac� y Pasaje, Machala.'),('
Calle Quito y Marquez de Maenza, edif. Centro de Atención Ciudadana Latacunga'),('
Av de los Shyris N37-254 y La Tierra'),('
Av. Circunvalaci�n y Av. R�o Aguarico, Nueva Loja (Lago Agrio)'),('
Calle Aguarico y Quito Esquina-Barrio 20 de Mayo,Puerto Francisco de Orellana'),('
9 de Octubre 219 y Pedro Carbo, Guayaquil'),('
9 de Octubre 219 y Pedro Carbo, Guayaquil'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'),('
Castillo 458 entre  Sucre y Bol�var, Ambato'),('
Av. De la Prensa N54-97 y Jorge Piedra, Quito'
);

Select * 
from Direccion;

-- INGRESO DE DATOS EN LA TABLA NOTIFICA
INSERT INTO Notifica VALUES
('1906371599',1,'CONVOCATORIA','Trato de temas relacionados a las actividades','10/05/19'),
('0903506798',2,'CONVOCATORIA','Metodos de evaluación','31/05/19'),
('0916643315',4,'CONVOCATORIA','Información sobre futuras mingas','23/05/19'),
('0912487352',2,'CONVOCATORIA','Metodos de evaluación','31/05/19'),
('0926016957',3,'LLAMADA DE ATENCION','Problemas de convivencia','04/06/19'),
('0910729953',5,'CONVOCATORIA','Metodos de evaluación','31/05/19'),
('0914466855',4,'CONVOCATORIA','Información sobre futuras mingas','23/05/19'),
('0905271680',6,'CONVOCATORIA','Capacitación sobre el apoyo en el del niño','14/06/19'),
('0912485489',6,'CONVOCATORIA','Capacitación sobre el apoyo en el del niño','14/06/19'),
('1801285832',9,'CONVOCATORIA','Conversación sobre Lectura temprana','28/06/19'),
('0900965534',10,'CONVOCATORIA','Conversación sobre Lectura temprana','28/06/19'),
('0913473153',3,'LLAMADA DE ATENCION','Problemas de convivencia','04/06/19'),
('0915611057',1,'CONVOCATORIA','Trato de temas relacionados a las actividades','10/05/19'),
('0903714483',4,'CONVOCATORIA','Información sobre futuras mingas','23/05/19'),
('0909386427',5,'CONVOCATORIA','Metodos de evaluación','31/05/19'),
('0905796231',14,'CONSULTA','Realizacion de deportes','10/07/19'),
('0906078738',15,'CONSULTA','Suplementos vitaminicos','18/07/19'),
('0902168616',19,'LLAMADA DE ATENCION','Daño de bien material','15/06/19'),
('0905612693',20,'LLAMADA DE ATENCION','Daño de bien material','01/06/19'),
('0910278480',14,'CONSULTA','Menus para niños','04/07/19'),
('0101632578',15,'CONSULTA','Asuntos relacionados a amigos imaginarios','25/06/19'),
('0917936668',11,'ACTUALIZACION','Ingreso de datos representante','17/06/19'),
('0906401591',1,'CONVOCATORIA','Trato de temas relacionados a las actividades','10/05/19'),
('0902413251',4,'CONVOCATORIA','Información sobre futuras mingas','23/05/19'),
('0909762759',9,'CONVOCATORIA','Conversación sobre Lectura temprana','28/06/19'),
('0907640973',10,'CONVOCATORIA','Conversación sobre Lectura temprana','28/06/19'),
('0926016957',6,'CONVOCATORIA','Capacitación sobre el apoyo en el del niño','14/06/19'),
('0910729953',7,'CONVOCATORIA','Capacitación sobre el apoyo en el del niño','14/06/19'),
('0908146210',4,'CONVOCATORIA','Información sobre futuras mingas','23/05/19'),
('0905271680',9,'CONVOCATORIA','Conversación sobre Lectura temprana','28/06/19'),
('0912485489',5,'CONVOCATORIA','Metodos de evaluación','31/05/19');

SELECT * 
FROM Notifica
ORDER BY fecha;

-- INGRESO DE DATOS EN LA TABLA INTERMEDIA "RESIDE 1"
insert into ResideI values
(1, 5),(2,10),(3,25),(4,80),(5,13),(6,93),(7,12),(8,1),(9,40),(10,56),
(11,90),(12,67),(13,24),(14,43),(15,13),(16,30),(17,50),(18,80),(19,76),(20,81);

select *
from ResideI;

-- INGRESO DE DATOS EN LA TABLA INTERMEDIA "RESIDE 2"

insert into ResideII values
(1, 100),(2,99),(3,98),(4,97),(5,96),(6,95),(7,94),(8,93),(9,92),(10,91),
(11,90),(12,89),(13,88),(14,87),(15,86),(16,85),(17,84),(18,83),(19,82),(20,81),
(21,80),(22,79),(23,78),(24,77),(25,76),(26,75),(27,74),(28,73),(29,72),(30,71),
(31,70),(32,69),(33,68),(34,67),(35,66),(36,65),(37,64),(38,63),(39,62),(40,61),
(41,60),(42,59),(43,58),(44,57),(45,56),(46,55),(47,54),(48,53),(49,52),(50,51),
(51,50),(52,49),(53,48),(54,47),(55,46),(56,45),(57,44),(58,43),(59,42),(60,41),
(61,40),(62,39),(63,38),(64,37),(65,36),(66,35),(67,34),(68,33),(69,32),(70,31),
(71,30),(72,29),(73,28),(74,27),(75,26),(76,25),(77,24),(78,23),(79,22),(80,21),
(81,20),(82,19),(83,18),(84,17),(85,16),(86,15),(87,14),(88,13),(89,12),(90,11),
(91,10),(92,9),(93,8),(94,7),(95,6),(96,5),(97,4),(98,3),(99,2),(100,1);

select *
from ResideII;

-- INGRESO DE DATOS EN LA TABLA Sintoma
INSERT INTO Sintoma (descripcion) VALUES
('Vesiculas'),          -- 1
('Pápulas'),            -- 2
('Tos'),                -- 3
('Fiebre'),             -- 4
('Flema'),              -- 5
('Secreción'),          -- 6
('Estornudos'),         -- 7
('Escalofríos'),        -- 8
('Inflamación'),        -- 9
('Inapitencia'),        -- 10
('Moretones'),          -- 11
('Dolor Abdominal'),    -- 12
('Hinchazón'),          -- 13
('Desvanecimiento'),    -- 14
('Dolor Generalizado'), -- 15
('Eczemas'),            -- 16
('Picazon');             -- 17

SELECT * 
FROM Sintoma;

-- INGRESO DE DATOS EN LA TABLA Presenta
INSERT INTO Presenta VALUES
(1,3),(1,4),(1,6),(1,8),(2,3),(2,4),
(2,5),(2,7),(2,8),(2,15),(4,14),(5,11),
(5,13),(5,9),(6,15),(7,4),(7,16),(7,6),
(8,3),(8,4),(8,5),(8,6),(8,7),(8,8),
(8,14),(9,1),(9,2),(9,4),(9,8),(9,9),
(9,14),(9,17),(10,10),(10,12),(10,13),(11,3),
(11,4),(11,5),(11,8),(12,1),(12,2),(12,3),
(12,16),(12,17),(13,14),(14,3),(14,4),(14,5),
(14,6),(14,7),(14,8),(14,14),(14,15),(15,15),
(15,16),(15,11);

SELECT *
FROM Presenta;

INSERT INTO Titulo (NDIP, nombreGrado) VALUES
(1,'Licenciatura en Pedagogía Infantil'),
(2,'Licenciatura en Ciencias de la Educación, Mención Educación Parvularia'),
(3,'Licenciatura en Pedagogía Infantil'),
(4,'Licenciatura en Ciencias de la Educación, Mención Educación Parvularia'),
(5,'Licenciatura en Pedagogía Infantil'),
(6,'Licenciatura en Ciencias de la Educación, Mención Educación Parvularia'),
(7,'Licenciatura en Pedagogía Infantil'),
(8,'Licenciatura en Ciencias de la Educación, Mención Educación Parvularia'),
(9,'Licenciatura en Pedagogía Infantil'),
(10,'Licenciatura en Ciencias de la Educación, Mención Educación Parvularia'),
(11,'Máster Universitario en Dirección y Gestión para la Calidad de Centros Educativos'),
(12,'Licenciatura en recursos humanos'),
(13,'Licenciatura en Administración Financiera y Sistemas'),
(14,'Medicina General, Especialización en Pediatría'),
(14,'Licenciatura en Psicología Infantil'),
(15,'Medicina General, Especialización en Pediatría'),
(16,'Licenciatura en Nutrición y Dietética'),
(17,'Licenciatura en Nutrición y Dietética'),
(18,'Licenciatura en Nutrición y Dietética'),
(19,'Licenciatura en Ciencias de la Educación, Mención Educación Parvularia'),
(20,'Licenciatura en Ciencias de la Educación, Mención Educación Parvularia');

SELECT *
FROM Titulo;