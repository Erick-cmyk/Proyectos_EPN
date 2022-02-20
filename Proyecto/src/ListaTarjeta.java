import java.util.ArrayList;

public class ListaTarjeta {
	
	// Atributos
	private ArrayList<Tarjeta> ListaT;
	
	// Constructor
	public ListaTarjeta() {
		ListaT = new ArrayList<Tarjeta>();
	}
	
	// Propiedades
	public ArrayList<Tarjeta> getListaT() {
		return ListaT;
	}

	public void setListaT(ArrayList<Tarjeta> listaC) {
		ListaT = listaC;
	}
	
	//Metodos del objeto
	public void agregarTarjeta(Tarjeta t) {
		ListaT.add(t);
	}
	
	public boolean eliminarTarjeta(String vNum) {
		for(Tarjeta t: ListaT) {
			if( t.getNumTarjeta().equals(vNum)) {
				ListaT.remove(t);
				return true;
			}
		}
		return false;
	}
	
	public Tarjeta buscarTarjeta(String vNum) {
		for(Tarjeta t:ListaT) {
			if(t.getNumTarjeta().equals(vNum)) {
				return t;
			}
		}
		return null;
	}
	
	public void proyectarinfoTarjeta() {
		System.out.printf("%-27s%-30s%-30s%-15s\n", "Numero de Tarjeta", "Fecha de vencimiento", "Nombre", "Total cargado");
		for (Tarjeta t: ListaT) {
			System.out.printf("%-27s%-30s%-30s%-15f\n",t.getNumTarjeta(), t.getFechVenc(), t.getNombre(), t.getMontoCarga());
		}
	}
}
