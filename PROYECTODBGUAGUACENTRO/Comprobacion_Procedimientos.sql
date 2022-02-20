USE Proyecto_Guarderia1;
go

-----------------------------------------------------------------------------------------------
--                              PROCEDIMIENTOS ALMACENADOS
-----------------------------------------------------------------------------------------------
--************************************(AlumonsPorGrupo)********************************************
--La cantidad de Ninios por aula es de 10.

execute AlumonsPorGrupo '1';

--************************************(BorrarRegistro)********************************************

--creacion de la vista
drop view if exists ComprobarBorrado;
go

create view ComprobarBorrado
as
select N.NDI as CodigoNinio ,R.cedulaR as CedulaRepresentante,T.telefono as TelefonoRegistrado
from Ninio as N join Representante as R on N.repID=R.cedulaR
join PoseeII as P on P.cedR=R.cedulaR 
join Telefono as T on T.idTel=P.idTel;
go

--ver la informacion del ninio einvolucrados antes de ser borrada
select * from  ComprobarBorrado where CodigoNinio=2 ;

execute BorrarRegistro 2;

--verificar que la informacion si se realizo correctamente 
select * from  ComprobarBorrado where CodigoNinio=2 ;

--*******************************(Matricula)(IngresoTelefonos)*************************************

--Ingreso de datos del Ninio, representante 
execute Matricula 'Bryan','Asimbaya','12/07/2016','M',1,'1715418313',
'Fernando','Asimbaya','AV. Pinar alto, Osorio','O+',default,default,0,'lkj';

select * from Representante where cedulaR like '1715418313'
--Ingreso de los numeros de telefono,especificando el numero de telefonos 
--y la cedula del representante al que pertencen los numeros
execute IngresoTelefonos '0995183491 0995379099',2,'1715418313';

--Creacion de la vista donde podremos ver los datos del ninio registrado

drop view if exists Matriculacion
go

--Necesario haber ejecutado la funcion (CalculoEdad)
create view Matriculacion
as
select N.NDI as Codigo,N.Nombre AS Nombre_Ninio,N.Apellido as Apellido_Ninio, dbo.CalculoEdad(n.NDI) as Edad,
N.repID as CedulaRepresentante, N.codG as Aula, P.NombreP as Nombre_Tutor, P.ApellidoP as Apellido_Turor
from Ninio as N join Representante as R on N.repID=R.cedulaR
join ResideII as Re on Re.NDI=N.NDI
join Direccion as Dir on Dir.numDir=Re.numDir
join ContieneII as Ant on Ant.numHistoria=N.NDI
join Discapacidad as Dis on Dis.codDis=Ant.codDis
join Grupo as G on G.codigoGrupo=N.codG
join Personal as P on G.Tutor=P.NDIP;
go

--ejecucion de la vista
select * from Matriculacion where CedulaRepresentante = '1715418313';



--************************************(RepresentPorCodNinio)********************************************

--Se puede ingresar un numero (NDI) del ninio a buscar o no ingresar datos 
--mostrando todos los ninios

declare @return int
execute @return  = RepresentPorCodNinio 98
if @return = 1 select 'Lista de representantes con sus repectivos niños.' 


--************************************(Ninios_Especiales)********************************************

execute Ninios_Especiales;

--************************************(InformacionAula)********************************************

execute InformacionAula 1;


