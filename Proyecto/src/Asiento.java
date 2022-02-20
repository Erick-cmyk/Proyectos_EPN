/**
 * 
 */

/**
 * @author hp
 *
 */
public class Asiento implements Comparable<Asiento>{

	
	// Atributos
	private Localidad localidad;
	private final String numAsiento;
	private boolean disponibilidad;
	private static int n = 1; 

	// Constructor
	public Asiento() {
		this.localidad = new Localidad();
		this.numAsiento = "A"+n;
		this.disponibilidad = true;
		n++;
	}
	
	public Asiento(Localidad vLocalidad) {
		this.localidad = vLocalidad;
		this.numAsiento = "A"+n;
		this.disponibilidad = true;
		n++;
	}
	
	public Asiento(String vNombre, float vPrecio) {
		this.localidad.setNombre(vNombre);
		this.localidad.setPrecio(vPrecio);
		this.numAsiento = "A"+n;
		this.disponibilidad = true;
		n++;
	}

	// Propiedades
	public Localidad getLocalidad() {
		return localidad;
	}


	public String getNumAsiento() {
		return numAsiento;
	}


	public boolean isDisponibilidad() {
		return disponibilidad;
	}


	// Metodos del objeto
	public void updtDisponibilidad() {
		if(this.disponibilidad == true) {
			this.disponibilidad = false;
		}else {
			System.out.println("Asiento ocupado");
		}
	}

	
	// Metodos Object
	
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (!(obj instanceof Asiento))
			return false;
		Asiento other = (Asiento) obj;
		if (numAsiento == null) {
			if (other.numAsiento != null)
				return false;
		} else if (!numAsiento.equals(other.numAsiento))
			return false;
		return true;
	}
	
	
	// Metodos Interfaz Comparable
	@Override
	public int compareTo(Asiento asientoAux) {
		if(this.numAsiento == null) {
			return (asientoAux.getNumAsiento() == null) ? 0:1;
		}
		if(asientoAux.getNumAsiento() == null) {
			return 1;
		}
		return this.numAsiento.compareToIgnoreCase(asientoAux.getNumAsiento());
	}


}
