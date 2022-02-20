/**
 * 
 */

/**
 * @author hp
 *
 */
import java.time.LocalDate;
import java.time.LocalTime;
public class Principal {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		LocalDate date1 = LocalDate.of(1998,03,01);
		LocalDate date2 = LocalDate.of(1975,03,01);
		Tarjeta tar1 = new Tarjeta("1023225",date1,"Chris Herondale");
		ListaTarjeta listT1 = new ListaTarjeta();
		listT1.agregarTarjeta(tar1);
		Cliente c1 = new Cliente("Christopher","Herondale", "1750151332", date1, 
		"Pichincha", "0978321456", "adfs@correo.ec", "cnjdfhs4", listT1);
		//Cliente c2 = new Cliente("Rosemary", "Herondale", "0912220217", date2, 
		//"Guayas", "0823169638", "lkjh@correo.ec", "87iuj35");
		
		//ListaCliente listaC = new ListaCliente();
		//listaC.agregarCliente(c1);
		//listaC.agregarCliente(c2);
		
		//System.out.println(listaC.eliminarCliente("1750151332"));
		
		//listaC.proyectar();

				
		Artista art1 = new Artista("Don Medardo");
		Artista art2 = new Artista("Don Medardo1");
		Artista art3 = new Artista("Don Medardo2");
		ListaArtista L1 = new ListaArtista();
		L1.AgregarArtista(art1);
		L1.AgregarArtista(art2);
		L1.AgregarArtista(art3);

		
		LocalDate date = LocalDate.of(2019,8,17);
		LocalTime time = LocalTime.of(19,00,00);
		LocalTime time2 = LocalTime.of(20,00,00);
		Cronograma C1 =new Cronograma(date, time, time2);
		
		LocalDate date25 = LocalDate.of(2019,10,4);
		LocalTime time3 = LocalTime.of(19,00,00);
		LocalTime time4 = LocalTime.of(22,00,00);
		Cronograma C2 =new Cronograma(date1, time3, time4);
		
		ListaCronograma listC = new ListaCronograma();
		
		listC.AgregarCronograma(C1);
		listC.AgregarCronograma(C2);
		
		Lugar lu1 = new Lugar("Pichincha", "Quito", "Estadio Atahualpa",
				"Naciones Unidas", 10,10, 4); //Capacidad de 35746
		Localidad l1 = new Localidad("Golden Box", 250);
		Localidad l2 = new Localidad("Preferencial", 100);
		Localidad l3 = new Localidad("General", 50);
		Localidad l4 = new Localidad();
		
		Concierto Con1 = new Concierto("Don Medardo y sus Players", lu1,"TOP Shows",
				L1, C2);
		try {
			c1.getListaTarjeta().buscarTarjeta("1023225").compraTicket(Con1, l4, 10);
			Con1.getLugar().getListR().mostrarAsientos();
			tar1.getCompra().getBoleto().proyectarTicketsinfo();
		}catch(NullPointerException e){
			System.out.println(e.getMessage());
		}
	}

}
