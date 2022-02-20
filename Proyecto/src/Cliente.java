import java.time.LocalDate;

/**
 * 
 */

/**
 * @author DELL
 *
 */
public class Cliente {
	
	// Atributos
	
	private String nombre;
	private String apellido;
	private final String id;
	private LocalDate fechaNac;
	private String provincia;
	private String celular;
	private String email;
	private String clave;
	private ListaTarjeta tarjeta;
	
	// Constructor
	public Cliente(String vNombre, String vApellido, String vId, LocalDate date1, 
			String vProvincia, String vCelular, String vEmail, String vClave, ListaTarjeta vTarjeta) {
		this.nombre=vNombre;
		this.apellido=vApellido;
		this.id=vId;
		this.fechaNac=date1;
		this.provincia=vProvincia;
		this.celular=vCelular;
		this.email=vEmail;
		this.clave=vClave;
		this.tarjeta = vTarjeta;
	}
	
	// Propiedades
	public ListaTarjeta getListaTarjeta() {
		return tarjeta;
	}
	
	public void setTarjeta(ListaTarjeta vTarjeta) {
		this.tarjeta = vTarjeta;
	}

	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getApellido() {
		return apellido;
	}
	public void setApellido(String apellido) {
		this.apellido = apellido;
	}
	public String getId() {
		return id;
	}
	
	
	public LocalDate getFechaNac() {
		return fechaNac;
	}
	public void setFechaNac(LocalDate vFechaNac) {
		this.fechaNac = vFechaNac;
	}
	public String getProvincia() {
		return provincia;
	}
	public void setProvincia(String provincia) {
		this.provincia = provincia;
	}
	public String getCelular() {
		return celular;
	}
	public void setCelular(String celular) {
		this.celular = celular;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getClave() {
		return clave;
	}
	public void setClave(String clave) {
		this.clave = clave;
	}

	
	// Metodos Object
	
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (!(obj instanceof Cliente))
			return false;
		Cliente other = (Cliente) obj;
		if (apellido == null) {
			if (other.apellido != null)
				return false;
		} else if (!apellido.equals(other.apellido))
			return false;
		if (clave == null) {
			if (other.clave != null)
				return false;
		} else if (!clave.equals(other.clave))
			return false;
		if (email == null) {
			if (other.email != null)
				return false;
		} else if (!email.equals(other.email))
			return false;
		if (fechaNac == null) {
			if (other.fechaNac != null)
				return false;
		} else if (!fechaNac.equals(other.fechaNac))
			return false;
		if (nombre == null) {
			if (other.nombre != null)
				return false;
		} else if (!nombre.equals(other.nombre))
			return false;
		return true;
	}
	
	
	

}
