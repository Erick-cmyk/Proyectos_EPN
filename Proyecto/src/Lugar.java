
public class Lugar {
	
	// Atributos
	private String provincia;
	private String cuidad;
	private String nombre;
	private String direccion;
	private ListaAsiento ListR;
	private int numPuertas;
	
	// Constructor
	public Lugar(String provincia, String cuidad, String nombre, String direccion, int numFila, int numColumna,	int numPuertas) {
		
		this.provincia = provincia;
		this.cuidad = cuidad;
		this.nombre = nombre;
		this.direccion = direccion;
		ListR = new ListaAsiento(numFila, numColumna);
		this.numPuertas = numPuertas;
	}
	
	// Propiedades
	public String getProvincia() {
		return provincia;
	}
	public void setProvincia(String provincia) {
		this.provincia = provincia;
	}
	public String getCuidad() {
		return cuidad;
	}
	public void setCuidad(String cuidad) {
		this.cuidad = cuidad;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getDireccion() {
		return direccion;
	}
	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}

	public ListaAsiento getListR() {
		return ListR;
	}
	public int getNumPuertas() {
		return numPuertas;
	}
	public void setNumPuertas(int numPuertas) {
		this.numPuertas = numPuertas;
	}
	
	// Metodos Object
	
	@Override
	public String toString() {
		return  provincia + "\t" + cuidad + "\t" + nombre + "\t"
				+ direccion +  "\t" + ListR.getCapacidad() + "\t" + numPuertas;
	}

	

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (!(obj instanceof Lugar))
			return false;
		Lugar other = (Lugar) obj;
		if (cuidad == null) {
			if (other.cuidad != null)
				return false;
		} else if (!cuidad.equals(other.cuidad))
			return false;
		if (direccion == null) {
			if (other.direccion != null)
				return false;
		} else if (!direccion.equals(other.direccion))
			return false;
		if (nombre == null) {
			if (other.nombre != null)
				return false;
		} else if (!nombre.equals(other.nombre))
			return false;
		if (numPuertas != other.numPuertas)
			return false;
		if (provincia == null) {
			if (other.provincia != null)
				return false;
		} else if (!provincia.equals(other.provincia))
			return false;
		return true;
	}
	
	
}
