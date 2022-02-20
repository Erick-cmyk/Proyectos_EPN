import java.util.*;
public class ListaTicket {
	
	// Atributos
	ArrayList<Ticket> ListaT;
	
	public  ListaTicket() {
		ListaT = new ArrayList<Ticket>();
	}
		

	// Propiedades
	public ArrayList<Ticket> getListaT() {
	
		return ListaT;
	}
	
	// Metodos del objeto
	public void agregarCompra(Ticket vTicket) {
		ListaT.add(vTicket);
	}
	
		public void proyectarTicketsinfo() {
				for(Ticket t: ListaT) {
					System.out.println(t);
				}
		}
}
