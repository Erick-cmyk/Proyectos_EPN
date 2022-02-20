/**
 * 
 */

/**
 * @author DELL
 *
 */
public class Administrador {
	
	private int id;
	private String clave;
	
	public Administrador() {
		this.id=0;
		this.clave=null;
	}
	
	public Administrador(int vid, String vclave) {
		this.id=vid;
		this.clave=vclave;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getClave() {
		return clave;
	}

	public void setClave(String clave) {
		this.clave = clave;
	}

}
