GO
USE master;
DROP DATABASE Proyecto_Guarderia;
GO

GO
CREATE DATABASE Proyecto_Guarderia;
GO

GO
USE Proyecto_Guarderia;

-- Tabla Representantes (2 nombres, 2 apellidos)

CREATE TABLE Representante (
    cedulaR varchar(10),
    NombreR varchar(15) not null,
    ApellidoR varchar(15) not null,
    CONSTRAINT PK_Representante PRIMARY KEY(cedulaR)
); 

CREATE TABLE Personal (
    NDIP int identity (1,1),
    cedulaP varchar(10),
    NombreP varchar(15) not null,
    ApellidoP varchar(15) not null,
    edad int not null,
    genero varchar(10),
    cargo varchar(10) not null,
    sueldo money default 0,
    CONSTRAINT PK_Personal PRIMARY KEY(NDIP),
    CONSTRAINT UQ_Personal UNIQUE (cedulaP)
);

CREATE TABLE Receso(
    IDreceso int identity(1,1),
    inicio time(0) not null,
    final time(0) not null,
    CONSTRAINT PK_Receso PRIMARY KEY(IDreceso)
);

CREATE TABLE Menu(
    IDmenu int identity(1,1),
    liquido nvarchar(30),
    platoFuerte nvarchar(30),
    CONSTRAINT PK_Menu PRIMARY KEY(IDmenu)
);

CREATE TABLE Hay(
    IDreceso int,
    IDmenu int,
    CONSTRAINT PK_Hay PRIMARY KEY(IDreceso),
    CONSTRAINT FK_Hay0 FOREIGN KEY(IDreceso) REFERENCES Receso(IDreceso),
    CONSTRAINT FK_Hay1 FOREIGN KEY(IDmenu) REFERENCES Menu(IDmenu)
);

CREATE TABLE Grupo(
    codigoGrupo int identity(1,1),
    IDreceso int,
    Tutor int, 
    horario varchar(10) not null,
    rangoEdad varchar(3) not null,
    aula int,
    CONSTRAINT PK_Grupo PRIMARY KEY(codigoGrupo),
    CONSTRAINT UQ_Grupo UNIQUE (Tutor),
    CONSTRAINT FK_Grupo0 FOREIGN KEY(IDreceso) REFERENCES Receso(IDreceso),
    CONSTRAINT FK_Grupo1 FOREIGN KEY(Tutor) REFERENCES Personal(NDIP),
);

CREATE TABLE Actividad(
    actC int,
    docente int,
    tipoA nvarchar(20),
    inicio time(0) not null,
    final time(0) not null,
    CONSTRAINT PK_Actividad PRIMARY KEY(actC),
    CONSTRAINT FK_Actividad FOREIGN KEY(docente) REFERENCES Personal(NDIP)
);

CREATE TABLE Tiene(
    grupo int,
    actividad int,
    CONSTRAINT PK_Tiene PRIMARY KEY(grupo),
    CONSTRAINT FK_Tiene0 FOREIGN KEY(grupo) REFERENCES Grupo(codigoGrupo),
    CONSTRAINT FK_Tiene1 FOREIGN KEY(actividad) REFERENCES Actividad(actC)
);

CREATE TABLE Titulo (
    numTitulo int IDENTITY (1,1),
    NDIP int,
    nombreGrado varchar(30) not null,
    CONSTRAINT PK_Titulo PRIMARY KEY(numTitulo),
    CONSTRAINT FK_Titulo0 FOREIGN KEY (NDIP) REFERENCES Personal(NDIP)
);

CREATE TABLE Antecedentes (
    numHistoria int identity (1,1),
    grupoSanguineo varchar(2),
    CONSTRAINT PK_Antecedentes PRIMARY KEY (numHistoria) 
);

CREATE TABLE Alergia(
    codAl int identity (1,1),
    nombreAl varchar(30), -- Alergia al polen, Dermatitis atopica, rinitis alergica, etc.
    tipoAl varchar(20), -- se refiere a si es de piel, alimenticia, respiratoria, etc.
    CONSTRAINT PK_Alergia PRIMARY KEY(codAl)
);

CREATE TABLE Discapacidad(
    codDis int identity (1,1),
    porcentaje float,
    nombreDis varchar(20),
    CONSTRAINT PK_Discapacidad PRIMARY KEY(codDis)
);

CREATE TABLE ContieneI(
    numHistoria int,
    codAl int,
    CONSTRAINT PK_ContieneI PRIMARY KEY(numHistoria),
    CONSTRAINT FK_ContieneI0 FOREIGN KEY(numHistoria) REFERENCES Antecedentes(numHistoria),
    CONSTRAINT FK_ContieneI1 FOREIGN KEY(codAl) REFERENCES Alergia(codAl)
);

CREATE TABLE ContieneII(
    numHistoria int,
    codDis int,
    CONSTRAINT PK_ContieneII PRIMARY KEY(numHistoria),
    CONSTRAINT FK_ContieneII0 FOREIGN KEY(numHistoria) REFERENCES Antecedentes(numHistoria),
    CONSTRAINT FK_ContieneII1 FOREIGN KEY(codDis) REFERENCES Discapacidad(codDis)
);

CREATE TABLE Inscripcion (
    numMatricula int identity (1,1),
    numHistoria int, 
    certificador int,
    fecha date not null,
    CONSTRAINT PK_Inscripcion PRIMARY KEY(numMatricula),
    CONSTRAINT UQ_Inscripcion0 UNIQUE(numHistoria),
    CONSTRAINT UQ_Inscripcion1 UNIQUE(certificador),
    CONSTRAINT FK_Inscripcion0 FOREIGN KEY(numHistoria) REFERENCES Antecedentes(numHistoria),
    CONSTRAINT FK_Inscripcion1 FOREIGN KEY(certificador) REFERENCES Personal(NDIP),
);

CREATE TABLE Ninio (
    PNombre varchar(15) not null,
    SNombre varchar(15) null,
    PApellido varchar(15) not null,
    SApellido varchar(15) null,
    NDI int identity (1,1),
    edad int not null,
    genero varchar(1) not null,
    evaluacion varchar(2) not null,
    repID varchar(10),
    numMat int,
    codG int,
    numHC int,
    CONSTRAINT PK_Ninio PRIMARY KEY(NDI),
    CONSTRAINT UQ_Ninio0 UNIQUE(numHC),
    CONSTRAINT FK_Ninio0 FOREIGN KEY (repID) REFERENCES Representante(cedulaR),
    CONSTRAINT FK_Ninio1 FOREIGN KEY(numMat) REFERENCES Inscripcion(numMatricula),
    CONSTRAINT FK_Ninio2 FOREIGN KEY(codG) REFERENCES Grupo(codigoGrupo),
    CONSTRAINT FK_Ninio3 FOREIGN KEY(numHC) REFERENCES Antecedentes(numHistoria)
);

CREATE TABLE Enfermedad(
    codEnf int identity (1,1),
    tipoE varchar(20),
    nombreE varchar(20),
    CONSTRAINT PK_Enfermedad PRIMARY KEY(codEnf)
);

CREATE TABLE Sintoma(
    idSin int identity (1,1),
    descripcion nvarchar(50),
    CONSTRAINT PK_Sintoma PRIMARY KEY(idSin)
);

CREATE TABLE Presenta(
    codE int,
    idS int,
    CONSTRAINT PK_Presenta PRIMARY KEY(codE),
    CONSTRAINT FK_Presenta0 FOREIGN KEY(codE) REFERENCES Enfermedad(codEnf),
    CONSTRAINT FK_Presenta1 FOREIGN KEY(idS) REFERENCES Sintoma(idSin)
);

CREATE TABLE CitaMedica(
    numCita int,
    numHistoria int, 
    enfermedad int, 
    doctor int,
    fechaCita date,
    CONSTRAINT PK_citMedica PRIMARY KEY(numCita),
    CONSTRAINT UQ_citaMedica UNIQUE (doctor),
    CONSTRAINT FK_citaMedica0 FOREIGN KEY(doctor) REFERENCES Personal(NDIP),
    CONSTRAINT FK_citaMedica1 FOREIGN KEY(numHistoria) REFERENCES Antecedentes(numHistoria),
    CONSTRAINT FK_citMedica2 FOREIGN KEY(enfermedad) REFERENCES Enfermedad(codEnf)
);

CREATE TABLE Receta(
    idReceta int identity (1,1),
    numCita int,
    reposo int, -- numero de dias en reposo
    alimentacion nvarchar(50), -- alimentos que no puede consumir (asi no se usa muchos caracteres)
    CONSTRAINT PK_Receta PRIMARY KEY(idReceta),
    CONSTRAINT FK_Receta0 FOREIGN KEY(numCita) REFERENCES CitaMedica(numCita) 
);

CREATE TABLE Medicamento(
    codMed int identity (1,1),
    tipo varchar (15),
    nombre varchar (15),
    dosis nvarchar(30), -- se tiene que poner gramos o  mililitros a consumir por eso nvarchar
    CONSTRAINT PK_Medicamento PRIMARY KEY(codMed),
);

CREATE TABLE Prescribe(
    idReceta int,
    codMed int,
    CONSTRAINT PK_Prescribe PRIMARY KEY(idReceta),
    CONSTRAINT FK_Prescribe0 FOREIGN KEY(idReceta) REFERENCES Receta(idReceta),
    CONSTRAINT FK_Prescribe1 FOREIGN KEY(codMed) REFERENCES Medicamento(codMed)
);

CREATE TABLE Telefono(
    idTel int IDENTITY (1,1),
    telefono varchar(10),
    CONSTRAINT PK_Telefono PRIMARY KEY(idTel)
);

CREATE TABLE Direccion(
    numDir int IDENTITY(1,1),
    localizacion nvarchar(50),
    CONSTRAINT PK_Direccion PRIMARY KEY(numDir)
);

CREATE TABLE ResideI(
    NDIP int,
    numDir int,
    CONSTRAINT PK_ResideI PRIMARY KEY(NDIP),
    CONSTRAINT FK_ResideI0 FOREIGN KEY(NDIP) REFERENCES Personal(NDIP),
    CONSTRAINT FK_ResideI1 FOREIGN KEY(numDir) REFERENCES Direccion(numDir)
);

CREATE TABLE ResideII(
    NDI int,
    numDir int,
    CONSTRAINT PK_ResideII PRIMARY KEY(NDI),
    CONSTRAINT FK_ResideII0 FOREIGN KEY(NDI) REFERENCES Ninio(NDI),
    CONSTRAINT FK_ResideII1 FOREIGN KEY(numDir) REFERENCES Direccion(numDir)
);

CREATE TABLE PoseeI(
    NDIP int,
    fono int,
    CONSTRAINT PK_PoseeI PRIMARY KEY(NDIP),
    CONSTRAINT FK_PoseeI0 FOREIGN KEY(NDIP) REFERENCES Personal(NDIP),
    CONSTRAINT FK_PoseeI1 FOREIGN KEY(fono) REFERENCES Telefono(idTel)
);

CREATE TABLE PoseeII(
    NDI int,
    fono int,
    CONSTRAINT PK_PoseeII PRIMARY KEY(NDI),
    CONSTRAINT FK_PoseeeII0 FOREIGN KEY(NDI) REFERENCES Ninio(NDI),
    CONSTRAINT FK_PoseeII1 FOREIGN KEY(fono) REFERENCES Telefono(idTel)
);
GO

GO
INSERT INTO Representante VALUES (
'1906371599', 'YESSENIA',' MORALES'),(
'0903506798','LAURA','ALARCON '),(
'0916643315','VICTOR','MU�OZ '),(
'0921527445','JORGE','TOARES' ),(
'1711873362','NUBIA','LOPEZ' ),(
'0920625100','MARIA','LAZO'  ),(
'0907640973','MERCEDES','QUINTU�A'),( 
'0926016957','JOSE','GOYES'),(
'0920283017','JORGE','ANDRADRE'),(
'0910729953','VERONICA','BELTRAN' ),(
'0912969524','PAQUITA','CHIQUIMARCA'),(
'0908146210','ROSA','ZUNIGA'),(
'0905271680','PEDRO','GUACHO' ),(
'0912485489','YOCONDA','PE�AFIEL' ),(
'0600739718','DOLORES','KOLER' ),(
'1801285832','JORGE','LAYMAN' ),(
'0907696967','NELSON','CONCHA' ),(
'0900965534','ROSA','BRAVO '),(
'0903710994','MARCOS','PESANTES'),(
'0913473153','LUIS','CAYAMBE '),(
'0900457474','STEFANIA','ULLAURAY'),(
'0911335180','NANCY','MOSQUERA' ),(
'0914541107','MELIDA','AUCAPI�A' ),(
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
'0924918101','LUIS','PAZMI�O' ),(
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
'0911206944','MARIA','MU�OZ'),(
'0902171073','ROSARIO','MOSQUERA' ),(
'0907149245','PADRE','MACANCELA'),( 
'0600275895','HELA','ESPINOZA')
,('0707066892','KATTY','FIGUEROA' 
);
GO

GO
SELECT *
FROM Representante;
GO




