USE Proyecto_Guarderia1;
go

-----------------------------------------------------------------------------------------------
--                              PROCEDIMIENTOS ALMACENADOS
-----------------------------------------------------------------------------------------------

--************************************PROCEDIMIENTO********************************************

--Mostrar los ninios que estan dentro del grupo ingresado

drop procedure if exists AlumonsPorGrupo;
go

create procedure AlumonsPorGrupo
(@NumGrupo int)
as
if (@NumGrupo <1) or  (@NumGrupo >10) 
begin
print '***Aula no existente***' 
end

else

begin
select N.NDI,N.Nombre,N.Apellido,N.evaluacion from Grupo as G join Ninio as N on G.codigoGrupo=N.codG
where G.codigoGrupo=@NumGrupo
order by N.Apellido asc
end
go

--************************************PROCEDIMIENTO********************************************
--Matricular a un ninio

drop procedure if exists Matricula;
go

create procedure Matricula
(  --Datos del Ninio 
    @Nombre varchar(15),
    @Apellido varchar(15),
    @fec_nac date,
    @genero varchar(1),
	@codG int,

   --Datos de Representante
    @repID varchar(10),
    @NombreR varchar(15),
    @ApellidoR varchar(15),

   --Direccion
	@localizacion nvarchar(50),

   --Antecedentes
    @grupoSanguineo varchar(3),

   --Alergias
    @nombreAl varchar(30) = 'Sin alergia', 
    @tipoAl varchar(20) = 'NA',
	
   --Discapacidad 
    @porcentaje int = 0,
    @nombreDis varchar(20)= 'NA'

)
as
begin
SET NOCOUNT ON; 

insert into Discapacidad
values (@porcentaje,@nombreDis);

if (@porcentaje > 30) and (@porcentaje <= 49) and ((@codG <> 4) and (@codG <> 9))
   begin
   rollback transaction
   print 'Grupo sugerido. Aula 4 (mañana) o Aula 9 (tarde)'
   return
   end 

else 

if (@porcentaje >49) and (@porcentaje<=74) and ((@codG <> 5) and (@codG <> 10))
   begin
   rollback transaction
   print 'Grupo sugerido. Aula 5 (mañana) o Aula 10 (tarde)'
   return
   end 

else

if not exists (select * from Representante where cedulaR=@repID)
begin
insert into Representante 
values (@repID,@NombreR,@ApellidoR);
end

insert into Ninio 
(Nombre,Apellido,fec_nac,genero,repID,codG)
values (
    @Nombre,     @Apellido,
    @fec_nac,    @genero,
    @repID,      @codG);

declare @aux int
select  @aux=NDI from Ninio
where   Nombre = @Nombre and Apellido=@Apellido and repID=@repID;

declare @aux1 int
select  @aux1=codDis from Discapacidad
where   porcentaje=@porcentaje and nombreDis=@nombreDis

insert into Antecedentes 
values (@aux,@grupoSanguineo)

insert into ContieneII 
values (@aux,@aux1)

insert into Direccion 
values (@localizacion);

insert into Alergia
values (@nombreAl,@tipoAl)

end
go

-----------------------------------------------------
----   Ingreso de numeros de telefono
-----------------------------------------------------

drop procedure if exists IngresoTelefonos; 
go

create procedure IngresoTelefonos
(   --Telefonos
    @telefono varchar(50),
	@numTelefonos int,
    @repID varchar(10))
as
begin 

declare @aux varchar (10)
declare @aux1 int
declare @aux2 int
declare @aux3 int
declare @aux4 int
set  @aux1 = len(replace(@telefono,' ',''))
set @aux2=1
set @aux3=1

if (@aux1 % @numTelefonos != 0)
begin
   select 'Los numeros ingresados son incorrectos' 
   return
end

else 

if  (@aux1=10) and (@numTelefonos =1)
begin
   insert into Telefono values (@telefono);
   select @aux4 = idTel from Telefono where telefono like @telefono;
   insert into PoseeII values (@repID,@aux4)
   Print 'Telefono ingresado correctamente.'+convert(varchar,@telefono)
   return
end

else

if (@aux1%@numTelefonos = 0) and (@numTelefonos > 1)
begin
  while @aux2<=@numTelefonos
  begin
    set @aux = SUBSTRING(replace(@telefono,' ',''),@aux3,@aux3+9)
    insert into Telefono values (@aux);
	select @aux4 = idTel from Telefono where  telefono like @aux;
    insert into PoseeII values (@repID,@aux4);
    set @aux2=@aux2+1
    set @aux3=@aux3+10
  end
  Print 'Telefonos ingresados correctamente. Numeros ingresados = '+ convert(varchar,@numTelefonos)
end
end
go

--************************************PROCEDIMIENTO********************************************

--Mostrar los ninio/os con su respectivo representante

drop procedure if exists RepresentPorCodNinio;
go

create procedure RepresentPorCodNinio
@NumNinio int null
as
BEGIN
if (@NumNinio is not null)
begin
--En caso de que si se inserte un numero solo se mostrara 
--ese ninio con su representante
 select RE.ApellidoR ,Re.NombreR,Re.cedulaR,N.Apellido as ApellidoNinio,
 N.Nombre as NombreNinio,N.NDI as Codigo,N.codG as Aula
 from  Representante as Re join Ninio as N on Re.cedulaR=N.repID
 where N.NDI=@NumNinio
 return 0
end

else 
--en caso de no insertar un numero, se mostraran todos los ninios con 
--sus representantes
 select top 120 RE.ApellidoR,Re.NombreR,Re.cedulaR as Cedula,
 N.Apellido as ApellidoNinio,N.Nombre as NombreNinio,N.NDI as Codigo,N.codG as Aula
 from  Representante as Re join Ninio as N on Re.cedulaR=N.repID
 order by Re.ApellidoR asc
 return 1
end
go

--************************************PROCEDIMIENTO********************************************

--Mostrar los Ninios con discapacidad con sus respectivas aulas 

drop procedure if exists Ninios_Especiales;
go

create procedure Ninios_Especiales
as 
select N.Apellido,N.Nombre,D.porcentaje as 'Porcent. de discapacidad',N.codG as Aula  
from Ninio as N join Antecedentes as A on N.NDI=A.numHistoria 
join ContieneII as C on C.numHistoria=A.numHistoria
join Discapacidad as D on D.codDis=C.codDis
where D.porcentaje>30;
go

--************************************PROCEDIMIENTO********************************************
--Informacion acerca del aula 

drop procedure if exists InformacionAula
go

create procedure InformacionAula
(@numGrupo int)
as
begin
select G.codigoGrupo as Aula,P.NombreP Tutor,P.ApellidoP as Tutor ,A.tipoA as Actividad
from Grupo as G join Tiene as T on G.codigoGrupo=T.grupo
join Actividad as A on A.actC=T.actividad 
join Personal as P on P.NDIP=A.docente
where G.codigoGrupo=@numGrupo
end
go


--************************************PROCEDIMIENTO********************************************
--Borrar registros de un Ninio

drop procedure if exists BorrarRegistro
go

--Necesario tambien ejecutar el triger (BorrarRepresentante)
create procedure BorrarRegistro
(@numNinio int)
as
begin
set nocount on
delete from Ninio where NDI=@numNinio
print 'Registro borrado exitosamente.'
end
go

-----------------------------------------------------------------------------------------------
--                                     FUNCIONES
-----------------------------------------------------------------------------------------------

--**************************************FUNCION************************************************
--Calculo de la edad del Ninio

drop function if exists CalculoEdad;
go

create function dbo.CalculoEdad
(@NDI int)
returns int
as
begin
declare @edad int
select @edad=datediff(year,fec_nac,GETDATE()) from Ninio where NDI=@NDI
return @edad
end;
go

-----------------------------------------------------------------------------------------------
--                                     TRIGGERS
-----------------------------------------------------------------------------------------------



--*************************************TRIGGER*************************************************
 --Verificar el grado de discapacidad registrado

drop trigger if exists GradoDisc
go

create trigger GradoDisc 
on Discapacidad
for insert, update 
as
begin
declare @discapacidad1 int
select @discapacidad1=D.porcentaje from inserted as I join Discapacidad as D on I.codDis=D.codDis
 if @discapacidad1 > 74
 begin
 set nocount on;
 rollback transaction
 print 'Discapacidad fuera del rango de la politica establecida por el establecimiento.'
end
end
go

--*************************************TRIGGER*************************************************

--Verificar que el numero de alumnos por aula no exceda de 10.

drop trigger if exists numAlumnos;
go

create trigger numAlumnos
on Ninio 
for insert,update
as 
begin
set nocount on
declare @NumNinios int 

declare @NumG int 
select @NumG=codG from inserted

select @NumNinios=count(*) from Ninio join Grupo 
on Ninio.codG=Grupo.codigoGrupo where Ninio.codG=@NumG

if @NumNinios > 10
begin
print 'No se pueden ingresar mas de 10 alumnos por grupo.'
rollback transaction
end
end;
go

---*************************************TRIGGER*************************************************

--No repeticio de telefonos

drop trigger if exists Trigger_Telefono;
go

create trigger Trigger_Telefono
on Telefono
for insert,update
as
begin
declare @aux int

select @aux=count(Telefono.telefono) from Telefono join inserted 
on Telefono.telefono=inserted.telefono

if @aux=2
 begin
   declare @aux1 varchar(10) 
   select @aux1=telefono from inserted
   print  'Telefono ('+ convert(varchar,@aux1)+') ya registrado.'
   rollback tran
 end
end
go

--*************************************TRIGGER*************************************************

--Eliminar representante una vez eliminado el registro del Ninio

drop trigger if exists BorrarRepresentante;
go

create trigger BorrarRepresentante
on Ninio
after delete
as
begin
declare @aux int
select @aux=count(*) from Representante as R join deleted as D
on R.cedulaR=D.repID 

if @aux = 1
begin
--Elimia los numeros de telefono del representante 
delete from Telefono where idTel = 
(select T.idTel from Telefono as T join PoseeII as P on T.idTel=P.idTel
join deleted as D on D.repID=P.cedR)

--Elimina al representante en caso de tener un solo Ninio en la guarderia
delete from Representante where cedulaR like (select deleted.repID from deleted)
end
end 
go

--*************************************TRIGGER*************************************************

--No fechas pasadas en las notificaciones
if OBJECT_ID('dis_fec_pasadas') is not null
 drop trigger dis_fec_pasadas;

 go
 create trigger dis_fec_pasadas
 on Notifica
 for insert
 as
 if GETDATE()>(select fecha from inserted)
 begin
 raiserror('La fecha debe ser futura',16,1)
 rollback transaction
 end;
 go
