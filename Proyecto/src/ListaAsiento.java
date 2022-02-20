import java.util.*;

public class ListaAsiento {
	 
	// Atributos
	ArrayList<List<Asiento>> ListRows;
	private final int numfila; //numero de sublistas filas
	private final int numcolumna; // numero de elementos de las sublistas (asientos por fila)
	private final int capacidad;

	
	// Constructor
	public ListaAsiento(int vFila, int vColumna) {
		ListRows = new ArrayList<List<Asiento>>();
		this.numfila = vFila; 
		this.numcolumna = vColumna; 
		this.agregarFilas();
		this.agregarAsientos();
		this.capacidad = this.numfila * this.numcolumna;
	}
	

	//Propiedades
	public ArrayList<List<Asiento>> getListRows() {
		return ListRows;
	}

	public List<Asiento> getListA(int vNum){
		return ListRows.get(vNum);
	}
	public int getCapacidad() {
		return capacidad;
	}
	
	public int getNumfila() {
		return numfila;
	}
	
	public int getNumcolumna() {
		return numcolumna;
	}

	
	//Metodos de objeto	
	private void agregarFilas() {
		for(int i = 0; i < this.numfila; i++) {
			ListRows.add(new ArrayList<Asiento>());
		}
	}
	
	private void agregarAsientos() {
		for(int i = 0; i < this.numfila; i++) {
			for(int j = 0; j < this.numcolumna; j++) {
				ListRows.get(i).add(new Asiento());
			}
		}
	}
	

	public Asiento buscarAsiento(String numAux) {
		for(List<Asiento> listA : ListRows) {
			for(Asiento a: listA) {
				if(numAux.equals(a.getNumAsiento())) {
					return a;
				}
			}
		}
		return null;
	}
	
	public void proyectarinfoAsientos() {
		System.out.printf("%-20s%-10s%-10s\n", "Localidad Precio", "Fila", "Asiento");
		for(List<Asiento> listA : ListRows) {
			for(Asiento a: listA) {
				System.out.printf("%-20s%-10s%-10s\n", a.getLocalidad(), ListRows.indexOf(listA), a.getNumAsiento());
			}
		}
	}
	
	public int getVendidos() {
		int cuenta = 0;
		for(List<Asiento> listA : ListRows) {
			for(Asiento a: listA) {
				if(a.isDisponibilidad() == false) {
					cuenta++;
				}
			}
		}
		return cuenta;
	}
	

	public void ordenListS(int index) {
	
		Collections.sort(ListRows.get(index));
	}
	
	public void mostrarAsientos() {
		
		for(List<Asiento> listA : ListRows) {
			for(Asiento a: listA) {
				if(!(a.isDisponibilidad())) {
					System.out.print("o ");
				}else {
					System.out.print("d ");
				}
			}
			System.out.println();
		}
	}
	
	public int asientosxLocalidad(Localidad laux) {
		int i = 0;
		for(List<Asiento> listA : ListRows) {
			for(Asiento a: listA) {
				if(a.getLocalidad().equals(laux)) {
					i++;
				}
			}
		}
		return i;
	}
	
}
