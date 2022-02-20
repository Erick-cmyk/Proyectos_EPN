
public class Artista {
	
	// Atributos
	private String nombre;
	
	
	//COnstructor
	
	public Artista() {
		this.nombre=null;
	}
	public Artista(String vnombre) {
		
		this.nombre = vnombre;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	
	// Metodos Object
	
	@Override
	public String toString() {
		return  nombre;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((nombre == null) ? 0 : nombre.hashCode());
		return result;
	}
	
}
