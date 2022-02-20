
public class Localidad {
	
	// Atributos
	private String nombre;
	private float precio;
	
	// Constructores
	public Localidad() {
		this.nombre = null;
		this.precio = 0;
	}
	
	public Localidad(String nombre, float precio) {
		
		this.nombre = nombre;
		this.precio = precio;
	}
	
	// Propiedades
	public String getNombre() {
		return nombre;
	}
	
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public float getPrecio() {
		return precio;
	}
	public void setPrecio(float precio) {
		this.precio = precio;
	}
	
	// Metodo Object
	@Override
	public String toString() {
		return nombre + "\t" + precio;
	}


	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (!(obj instanceof Localidad))
			return false;
		Localidad other = (Localidad) obj;
		if (nombre == null) {
			if (other.nombre != null)
				return false;
		} else if (!nombre.equals(other.nombre))
			return false;
		if (Float.floatToIntBits(precio) != Float.floatToIntBits(other.precio))
			return false;
		return true;
	}
	
	
}
