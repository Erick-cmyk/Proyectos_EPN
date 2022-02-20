USE Proyecto_Guarderia1;

-- ---------------------------------------------------------------------------------------------
--                              PROCEDIMIENTOS ALMACENADOS
-- ---------------------------------------------------------------------------------------------

-- ************************************PROCEDIMIENTO********************************************

-- Mostrar los ninios que estan dentro del grupo ingresado


DROP PROCEDURE IF EXISTS AlumnosPorGrupo;

DELIMITER //

CREATE PROCEDURE AlumnosPorGrupo(IN NumGrupo int)

BEGIN
	IF NumGrupo < 0 then select '***Aula Inexistente***';
    ELSEIF NumGrupo > 10 then select '***Aula Inexistente***';
		ELSE
		select N.NDI,N.Nombre,N.Apellido,N.evaluacion from Grupo as G join Ninio as N on G.codigoGrupo=N.codG
		where G.codigoGrupo=@NumGrupo
		order by N.Apellido asc;
	END	IF;
END//

DELIMITER ;


-- ************************************PROCEDIMIENTO********************************************
-- Matricular a un ninio


DROP PROCEDURE IF EXISTS Matricula;

DELIMITER //

CREATE PROCEDURE Matricula(
-- Datos de Ninio
IN NinNom VARCHAR(15),
IN NinAp VARCHAR(15),
IN fecNac DATE,
IN Ngenero VARCHAR(1),
IN codG INT,
-- Datos del representante
IN IDR VARCHAR(10),
IN NombreR VARCHAR(15),
IN ApellidoR VARCHAR(15),
-- Direccion
IN Loc VARCHAR(200),
-- Antecedentes
IN GrupoS VARCHAR(3),
-- Alergias
INOUT alNom VARCHAR(20),
INOUT alTipo VARCHAR(20),
-- Discapacidad
IN porcent INT,
IN disNom VARCHAR(20)
)

BEGIN
	DECLARE aux int;
    DECLARE aux1 int;
    DECLARE EXIT HANDLER FOR 45000 BEGIN /* El parámetro es incorrecto. */ END;
    
	IF porcent is null
	THEN
	SET porcent = 0;
	SET disNom = 'NA';
	INSERT INTO Discapacidad VALUES(porcent, disNom);
	ELSEIF porcent > 30 AND porcent <= 49 AND codG <> 4 AND codG <> 9
		THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Grupo sugerido en horario diurno: 4 o, 9 en el vespertino';
		ELSEIF porcent > 49 AND porcent <= 74 AND codG <> 5 AND codG <> 10
			THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Grupo sugerido en horario diurno: 5 o, 10 en el vespertino';
            ELSE 
			INSERT INTO Discapacidad VALUES(porcent, disNom);
	END IF;

    
    IF NOT EXISTS(SELECT * FROM Representante WHERE cedulaR = IDR)
		THEN INSERT INTO Representante VALUES(IDR,Nombre);
    END IF;
    
    INSERT INTO Ninio (Nombre,Apellido,fec_nac,genero,repID,codG) VALUES
    (NinNom, NinAp, fecNac, Ngenero, codG);
    
    SELECT  aux = NDI 
    FROM Ninio
	WHERE Nombre = NinNom and Apellido=NinAp and repID=IDR;
    
    SELECT  aux1 = codDis 
    FROM Discapacidad
	WHERE porcentaje = porcent and nombreDis = disNom;
    
    INSERT INTO Antecedentes VALUES(aux, GrupoS);
    
    INSERT INTO ContieneII VALUES(aux, aux1);
    
    INSERT INTO Direccion (localizacion) VALUES(Loc);
    
    IF alNom is null
    THEN
    SET alNom = 'Sin alergia';
	SET alTipo = 'NA';
    INSERT INTO Alergia VALUES(alNom,alTipo);
    ELSE 
    INSERT INTO Alergia VALUES(alNom, alTipo);
    END IF;
    
END//

DELIMITER ;


-- ---------------------------------------------------
-- --   Ingreso de numeros de telefono
-- ---------------------------------------------------

DROP PROCEDURE IF EXISTS IngresoTelefonos; 

DELIMITER //

CREATE PROCEDURE IngresoTelefonos(
-- Telefonos
IN cel VARCHAR(10),
IN numT INT,
IDR VARCHAR(10)
)
BEGIN
 DECLARE aux VARCHAR(10);
 DECLARE aux1 INT;
 DECLARE aux2 INT;
 DECLARE aux3 INT;
 DECLARE aux4 INT;
 DECLARE EXIT HANDLER FOR 45000 BEGIN /* Número de parámetros incorrecto. */ END;
 
 SET aux1 = length(replace(cel, ' ', ''));
 SET aux2 = 1;
 SET aux3 = 1;
 
 IF aux1 % numT != 0
	THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cantidad de digitos incorrecta';
	ELSEIF aux1 = 10 and numT = 1
		THEN INSERT INTO Telefono (telefono) VALUES (cel);
		SELECT aux4 = idTel FROM Telefono WHERE telefono like cel;
		INSERT INTO PoseeII VALUES (IDR,aux4);
		SELECT 'Telefono Ingresado correctamente';
        ELSEIF aux1 % numT = 0 and numT > 1
			THEN WHILE aux2 < numT
				DO SET aux = SUBSTRING(replace(cel,' ',''),aux3,aux3+9);
				insert into Telefono values (aux);
				select aux4 = idTel from Telefono where  telefono like aux;
				insert into PoseeII values (IDR,aux4);
				set aux2 = aux2+1;
				set aux3 = aux3+10;
			END WHILE;
			SELECT 'Telefonos Ingresados correctamente';
 END IF; 
END//

DELIMITER ;

-- ************************************PROCEDIMIENTO********************************************

-- Mostrar los ninio/os con su respectivo representante

drop procedure if exists RepresentPorCodNinio;

DELIMITER //

CREATE PROCEDURE RepresentPorCodNinio(numNinio int)
BEGIN
if numNinio is not null
then
-- En caso de que si se inserte un numero solo se mostrara 
-- ese ninio con su representante
select RE.ApellidoR ,Re.NombreR,Re.cedulaR,N.Apellido as ApellidoNinio,
N.Nombre as NombreNinio,N.NDI as Codigo,N.codG as Aula
from  Representante as Re join Ninio as N on Re.cedulaR=N.repID
where N.NDI = numNinio;
elseif numNinio is null
	then
	-- en caso de no insertar un numero, se mostraran todos los ninios con 
	-- sus representantes.
	select RE.ApellidoR,Re.NombreR,Re.cedulaR as Cedula,
	N.Apellido as ApellidoNinio,N.Nombre as NombreNinio,N.NDI as Codigo,N.codG as Aula
	from  Representante as Re join Ninio as N on Re.cedulaR=N.repID
	order by Re.ApellidoR asc 
	limit 120;
	end if;
	END//

DELIMITER ;

-- ************************************PROCEDIMIENTO********************************************

-- Mostrar los Ninios con discapacidad con sus respectivas aulas 

drop procedure if exists Ninios_Especiales;

DELIMITER //

CREATE PROCEDURE Ninios_Especiales()
BEGIN
select N.Apellido,N.Nombre,D.porcentaje as 'Porcent. de discapacidad',N.codG as Aula  
from Ninio as N join Antecedentes as A on N.NDI=A.numHistoria 
join ContieneII as C on C.numHistoria=A.numHistoria
join Discapacidad as D on D.codDis=C.codDis
where D.porcentaje>30;
END//

DELIMITER ;


-- ************************************PROCEDIMIENTO********************************************
-- Informacion acerca del aula 

drop procedure if exists InformacionAula;


DELIMITER //

CREATE PROCEDURE InformacionAula(numGrupo int)
BEGIN
select G.codigoGrupo as Aula,P.NombreP Tutor,P.ApellidoP as Tutor ,A.tipoA as Actividad
from Grupo as G join Tiene as T on G.codigoGrupo=T.grupo
join Actividad as A on A.actC=T.actividad 
join Personal as P on P.NDIP=A.docente
where G.codigoGrupo=numGrupo;
END//

DELIMITER ;

-- ************************************PROCEDIMIENTO********************************************
-- Borrar registros de un Ninio

drop procedure if exists BorrarRegistro;
go

-- Necesario tambien ejecutar el triger (BorrarRepresentante)
DELIMITER //

CREATE PROCEDURE BorrarRegistro(numNinio int)
BEGIN
delete from Ninio where NDI = numNinio;
SELECT 'Registro borrado exitosamente.';
END//

DELIMITER ;

-- ---------------------------------------------------------------------------------------------
--                                     FUNCIONES
-- ---------------------------------------------------------------------------------------------

-- **************************************FUNCION************************************************
-- Calculo de la edad del Ninio

drop function if exists CalculoEdad;
DELIMITER //

CREATE FUNCTION dbo.CalculoEdad(numNinio int)
RETURNS INT
BEGIN
declare edad int;
declare fecha_actual date;
SET fecha_actual = GETDATE();
select edad = datediff(fec_nac,fecha_actual) from Ninio where NDI = numNinio;
return edad;
END//

DELIMITER ;


-- ---------------------------------------------------------------------------------------------
--                                     TRIGGERS
-- ---------------------------------------------------------------------------------------------



-- *************************************TRIGGER*************************************************
 -- Verificar el grado de discapacidad registrado

drop trigger if exists GradoDiscforInsertion;
DELIMITER //

create trigger GradoDiscforInsertion before insert 
on Discapacidad FOR EACH ROW
begin
	declare discapacidad1 int;
    DECLARE EXIT HANDLER FOR 45000 BEGIN /* El parámetro es incorrecto. */ END;
    
	select discapacidad1 = D.porcentaje 
    from inserted as I join Discapacidad as D 
    on I.codDis = D.codDis;
    
	if discapacidad1 > 74 then
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Discapacidad fuera del rango de la politica establecida por el establecimiento.';
	end if;
end //

DELIMITER ;


drop trigger if exists GradoDiscforUpdate;
DELIMITER //

create trigger GradoDiscforUpdate before update 
on Discapacidad FOR EACH ROW
begin
	declare discapacidad1 int;
    DECLARE EXIT HANDLER FOR 45000 BEGIN /* El parámetro es incorrecto. */ END;
    
	select discapacidad1 = D.porcentaje 
    from inserted as I join Discapacidad as D 
    on I.codDis = D.codDis;
    
	if discapacidad1 > 74 then
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Discapacidad fuera del rango de la politica establecida por el establecimiento.';
	end if;
end //

DELIMITER ;



-- *************************************TRIGGER*************************************************

-- Verificar que el numero de alumnos por aula no exceda de 10.

drop trigger if exists numAlumnosforInsertion;

DELIMITER //

create trigger numAlumnosforInsertion before insert 
on Ninio FOR EACH ROW
begin
	declare NumNinios int; 
	declare NumG int; 
	DECLARE EXIT HANDLER FOR 45000 BEGIN /* El parámetro es incorrecto. */ END;
    select NumG = codG from inserted;
    
    select NumNinios = count(*) from Ninio join Grupo 
	on Ninio.codG = Grupo.codigoGrupo 
    where Ninio.codG = NumG;

	if NumNinios > 10
	then
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se pueden ingresar mas de 10 alumnos por grupo.';
    end if;
end //

DELIMITER ;

drop trigger if exists numAlumnosforUpdate;

DELIMITER //

create trigger numAlumnosforUpdate before update
on Ninio FOR EACH ROW
begin
	declare NumNinios int; 
	declare NumG int; 
	DECLARE EXIT HANDLER FOR 45000 BEGIN /* El parámetro es incorrecto. */ END;
    select NumG = codG from inserted;
    
    select NumNinios = count(*) from Ninio join Grupo 
	on Ninio.codG = Grupo.codigoGrupo 
    where Ninio.codG = NumG;

	if NumNinios > 10
	then
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se pueden ingresar mas de 10 alumnos por grupo.';
    end if;
end //

DELIMITER ;

-- *************************************TRIGGER*************************************************

-- Eliminar representante una vez eliminado el registro del Ninio

drop trigger if exists BorrarRepresentante;

DELIMITER //

create trigger BorrarRepresentante after delete
on Ninio FOR EACH ROW
begin
	declare aux int;
	select aux = count(*) from Representante as R join deleted as D
	on R.cedulaR = D.repID;
    
    if aux = 1
	then
	-- Elimina los numeros de telefono del representante 
	delete from Telefono where idTel = 
	(select T.idTel from Telefono as T join PoseeII as P on T.idTel=P.idTel
	join deleted as D on D.repID=P.cedR);

	-- Elimina al representante en caso de tener un solo Ninio en la guarderia
	delete from Representante where cedulaR like (select deleted.repID from deleted);
	end if;
end //

DELIMITER ;


-- *************************************TRIGGER*************************************************

-- No fechas pasadas en las notificaciones
drop trigger if exists dis_fec_pasadasforInsertion;

 
DELIMITER //

create trigger dis_fec_pasadasforInsertion before insert
on Notifica FOR EACH ROW
begin
	DECLARE EXIT HANDLER FOR 45000 BEGIN /* El parámetro es incorrecto. */ END;
	if GETDATE()>(select fecha from inserted)
	then
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha de notificacion es la fecha de la futura reunion.';
	end if;
end //

DELIMITER ;
 
drop trigger if exists dis_fec_pasadasforUpdate;

 
DELIMITER //

create trigger dis_fec_pasadasforUpdate before update
on Notifica FOR EACH ROW
begin
	DECLARE EXIT HANDLER FOR 45000 BEGIN /* El parámetro es incorrecto. */ END;
	if GETDATE()>(select fecha from inserted)
	then
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha de notificacion es la fecha de la futura reunion.';
	end if;
end //

DELIMITER ;

-- *************************************TRIGGER*************************************************

-- No repeticion de telefonos

drop trigger if exists Trigger_TelefonoforInsertion;
DELIMITER //

create trigger Trigger_TelefonoforInsertion before insert
on Telefono FOR EACH ROW
begin
declare aux int;
declare aux1 varchar(10); 
DECLARE EXIT HANDLER FOR 45000 BEGIN /* El parámetro es incorrecto. */ END;

select aux = count(Telefono.telefono) from Telefono join inserted 
on Telefono.telefono=inserted.telefono;

if aux = 2
 then
   select @aux1=telefono from inserted;
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El telefono ya ha sido registrado';
 end if;
 
end//

DELIMITER;


drop trigger if exists Trigger_TelefonoforUpdate;
DELIMITER //

create trigger Trigger_TelefonoforUpdate before update
on Telefono FOR EACH ROW
begin
declare aux int;
declare aux1 varchar(10); 
DECLARE EXIT HANDLER FOR 45000 BEGIN /* El parámetro es incorrecto. */ END;

select aux = count(Telefono.telefono) from Telefono join inserted 
on Telefono.telefono=inserted.telefono;

if aux = 2
 then
   select @aux1=telefono from inserted;
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El telefono ya ha sido registrado';
 end if;
 
end//